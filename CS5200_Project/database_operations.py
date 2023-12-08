import pymysql
from tabulate import tabulate
from pymysql.err import OperationalError

def connect_to_database(host, user, password, database):
    try:
        connection = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            cursorclass=pymysql.cursors.DictCursor
        )
        print("\nConnected to the database!")
        return connection
    except OperationalError as e:
        error_code = e.args[0]
        if error_code == 2059:
            print("\nError: The 'cryptography' package is required for secure connections.")
            print("Please install it using 'pip install cryptography' and try again.")
        else:
            print(f"\nError connecting to the database: {e}")
            print("Above error message means that you have entered invalid credentials for the Database username and password.")
        return None
    except RuntimeError as e:
        if "cryptography' package is required" in str(e):
            print("\nError: The 'cryptography' package is required for secure connections.")
            print("Please install it using 'pip install cryptography' and try again.")
        else:
            print(f"Error connecting to the database: {e}")
        return None

def close_connection(connection):
    if connection:
        connection.close()
        print("\nConnection closed. Thank you for using Project Roofs!")

def print_table(result):
    if not result:
        print("No records found.")
        return
    headers = result[0].keys()
    table_data = [[row[col] for col in headers] for row in result]
    table = tabulate(table_data, headers=headers, tablefmt="pretty")
    print(table)

def add_new_admin(connection, email, username, password):
    try:
        if connection:
            call_insert_new_admin_procedure(connection, email, username, password)
            return True
        else:
            print("\nError: Database connection is not established.")
            return False
    except pymysql.Error as e:
        print(f"Error: {e}")
        return False

def call_insert_new_admin_procedure(connection, email, username, password):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('InsertNewAdmin', (email, username, password))
            result = cursor.fetchone()
            print(result['status'])
            connection.commit()
    except pymysql.Error as e:
        print(f"Error: {e}")

def admin_login(connection, username, password):
    try:
        if connection:
            query = "SELECT * FROM pr_admin WHERE username = %s AND CAST(AES_DECRYPT(admin_password,'CS5200') AS CHAR) = %s"
            with connection.cursor() as cursor:
                cursor.execute(query, (username, password))
                result = cursor.fetchone()
                if result:
                    return True
                else:
                    return False
        else:
            print("Error: Database connection is not established.")
            return False
    except pymysql.Error as e:
        print(f"Error: {e}")
        return False

def call_get_all_admins_procedure(connection):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('GetAllAdmins')
            result = cursor.fetchall()
            print_table(result)

    except pymysql.Error as e:
        print(f"Error: {e}")

def call_get_all_shelters_procedure(connection):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('GetAllShelters')
            result = cursor.fetchall()
            print_table(result)

    except pymysql.Error as e:
        print(f"Error: {e}")

def call_get_shelter_statistics_procedure(connection, shelter_name):
    try:
        with connection.cursor() as cursor:
            # Call the stored procedure with shelter_name as input
            cursor.callproc('GetShelterStatistics', [shelter_name])

            # Fetch the result
            result = cursor.fetchone()

            # Print the statistics
            print("\nShelter Statistics:")
            print(f"Number of Residents: {result['Number of Residents']}")
            print(f"Number of Donations: {result['Number of Donations']}")
            print(f"Number of Volunteers: {result['Number of Volunteers']}")
            print(f"Number of Meals Provided: {result['Number of Meals Provided']}")
            print(f"Services Provided: {result['Services Provided']}\n")

    except pymysql.Error as e:
        print(f"Error: {e}")

def call_get_all_residents_procedure(connection, shelter_name):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('ViewResidentsInShelter', [shelter_name])
            result = cursor.fetchall()
            print_table(result)

    except pymysql.Error as e:
        print(f"Error: {e}")


def call_get_all_past_residents_procedure(connection, shelter_name):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('ViewPastResidentsInShelter', [shelter_name])
            result = cursor.fetchall()
            print_table(result)

    except pymysql.Error as e:
        print(f"Error: {e}")

def call_insert_new_resident_procedure(db_connection, first_name, last_name, shelter_name, gender, dob, phone, join_date):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('InsertNewResident', (first_name, last_name, shelter_name, gender, dob, phone, join_date))
            db_connection.commit()
            print("\nNew resident added successfully!")
    except pymysql.Error as e:
        print(f"Error: {e}")

def remove_resident_procedure(db_connection, resident_id, shelter_name):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('RemoveResident', [resident_id, shelter_name])
            result = cursor.fetchone()
            print(result['status'])
            db_connection.commit()

    except pymysql.Error as e:
        print(f"Error: {e}")

def update_leave_date_procedure(db_connection, resident_id, shelter_name, leave_date):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('UpdateLeaveDate', (resident_id, shelter_name, leave_date))
            result = cursor.fetchone()
            if result:
                print(result['status'])
                db_connection.commit()
            else:
                print("Error: Unable to fetch the result.")
    except OperationalError as e:
        print(f"Error calling the stored procedure: {e}")

def add_health_report_procedure(db_connection, shelter_name, health_report_details, resident_conditions, resident_allergies, resident_medication):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('AddHealthReport', (shelter_name, health_report_details, resident_conditions, resident_allergies, resident_medication))
            result = cursor.fetchone()
            print(result['status'])
            db_connection.commit()
    except pymysql.Error as e:
        print(f"Error calling AddHealthReport procedure: {e}")

def add_resident_employment_record_procedure(db_connection, shelter_name, employment_status, employer_name, job_title, employment_begin_date, employment_end_date):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('AddResidentEmploymentRecord', (shelter_name, employment_status, employer_name, job_title, employment_begin_date, employment_end_date))
            result = cursor.fetchone()
            print(result['status'])
            db_connection.commit()
    except pymysql.MySQLError as e:
        print(f"Error calling AddResidentEmploymentRecord procedure: {e}")

def call_view_health_records_procedure(db_connection, resident_id, shelter_name):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('ViewHealthRecords', [resident_id, shelter_name])
            result = cursor.fetchall()
            if result and 'status' in result [0]:
                print(result[0]['status'])
            else:
                print_table(result)

    except pymysql.Error as e:
        print(f"Error: {e}")

def call_view_employment_records_procedure(db_connection, resident_id, shelter_name):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('ViewEmploymentRecords', [resident_id, shelter_name])
            result = cursor.fetchall()
            if result and 'status' in result [0]:
                print(result[0]['status'])
            else:
                print_table(result)

    except pymysql.Error as e:
        print(f"Error: {e}")

def call_view_shelter_volunteers_procedure(db_connection, shelter_name):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('ViewShelterVolunteers', (shelter_name,))
            result = cursor.fetchall()
            print_table(result)
    except pymysql.MySQLError as e:
        print(f"Error calling ViewShelterVolunteers procedure: {e}")

def call_view_shelter_donations_procedure(db_connection, shelter_name):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('ViewShelterDonations', (shelter_name,))
            result = cursor.fetchall()
            print_table(result)
    except pymysql.MySQLError as e:
        print(f"Error calling ViewShelterDonations procedure: {e}")

def call_add_donation_to_shelter_procedure(db_connection, first_name, last_name, donation_date, donation_description, shelter_name):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc('AddDonationToShelter', (first_name, last_name, donation_date, donation_description, shelter_name))
            result = cursor.fetchone()
            print(result['status'])
    except pymysql.MySQLError as e:
        print(f"Error calling AddDonationToShelter procedure: {e}")

def call_insert_volunteer_procedure(db_connection, first_name, last_name, phone_no, shelter_name):
    try:
        cursor = db_connection.cursor()
        cursor.callproc('InsertVolunteer', (first_name, last_name, phone_no, shelter_name))
        db_connection.commit()
        results = cursor.fetchone()
        print(results['status'])
    except Exception as e:
        print(f"Error calling InsertVolunteer procedure: {e}")

def call_delete_volunteer_procedure(db_connection, volunteer_id, shelter_name):
    try:
        cursor = db_connection.cursor()
        cursor.callproc('DeleteVolunteer', (volunteer_id, shelter_name))
        db_connection.commit()
        results = cursor.fetchone()
        print(results['status'])
    except Exception as e:
        print(f"Error calling DeleteVolunteer procedure: {e}")

import pymysql

def call_add_resident_health_record_procedure(
    db_connection, resident_id, shelter_name, health_report_date,
    health_report_details, resident_conditions, resident_allergies, resident_medication
):
    try:
        cursor = db_connection.cursor()
        cursor.callproc(
            'AddResidentHealthRecord',
            (resident_id, shelter_name, health_report_date,
             health_report_details, resident_conditions, resident_allergies, resident_medication)
        )
        db_connection.commit()
        result = cursor.fetchone()
        print(result['status'])
    except pymysql.Error as e:
        print(f"Error calling AddResidentHealthRecord procedure: {e}")

def update_resident_employment_record(db_connection, resident_id, shelter_name, employment_status, employer_name, job_title, employment_begin_date, employment_end_date):
    try:
        with db_connection.cursor() as cursor:
            cursor.callproc(
                'UpdateResidentEmploymentRecord',
                (resident_id, shelter_name, employment_status, employer_name, job_title, employment_begin_date, employment_end_date)
            )
            db_connection.commit()
            result = cursor.fetchone()
            print(result['status'])
    except pymysql.MySQLError as e:
        print(f"Error calling UpdateResidentEmploymentRecord procedure: {e}")

import pymysql
import pandas as pd
import matplotlib.pyplot as plt

def call_and_plot_stored_procedure(connection, procedure_name, plot_kind='pie', y_column=None, x_column=None,bins=None, labels_column=None, autopct='%1.1f%%', startangle=90, title=None, xlabel='', ylabel='', edgecolor=None):
    # Create a cursor
    cursor = connection.cursor()

    try:
        # Call the stored procedure
        cursor.callproc(procedure_name)

        # Fetch the results from the stored procedure
        results = cursor.fetchall()

        # Create a DataFrame from the results
        columns = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns=columns)

        # Plot the data
        if plot_kind == 'pie':
            df.plot(kind=plot_kind, y=y_column, labels=df[labels_column], autopct=autopct, startangle=startangle)
        else:
            df.plot(kind=plot_kind, x=labels_column, y=y_column, color='skyblue')

        plt.title(title)
        plt.ylabel(ylabel)
        plt.show()

    finally:
        # Close the cursor
        cursor.close()

def visualize_resident_count_by_shelter(connection):
    try:
        query = "CALL GetResidentCountByShelter();"
        df = pd.read_sql(query, connection)

        # Plot the data
        df.plot(kind='bar', x='shelter_name', y='resident_count', color='skyblue')
        plt.title('Number of Residents in Each Shelter')
        plt.xlabel('Shelter Name')
        plt.ylabel('Count')
        plt.show()

    except Exception as e:
        print(f"Error: {e}")



