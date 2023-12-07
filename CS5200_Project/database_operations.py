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

def add_new_admin(connection, email, username, password):
    try:
        if connection:
            # Call the stored procedure to insert a new admin
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
            # Call the stored procedure
            cursor.callproc('InsertNewAdmin', (email, username, password))
            
            # Fetch the result
            result = cursor.fetchone()
            print(result['status'])
            
            # Commit the changes to the database
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
            # Call the stored procedure
            cursor.callproc('GetAllAdmins')
            
            # Fetch all the results
            result = cursor.fetchall()

           # Check if there are shelters to display
            if not result:
                print("No admins found.")
                return

            # Extract column headers
            headers = result[0].keys()

            # Convert the list of dictionaries into a list of lists
            table_data = [[row[col] for col in headers] for row in result]

            # Use tabulate to format the data as a table
            table = tabulate(table_data, headers=headers, tablefmt="pretty")

            # Print the formatted table
            print(table)
    except pymysql.Error as e:
        print(f"Error: {e}")

def call_get_all_shelters_procedure(connection):
    try:
        with connection.cursor() as cursor:
            # Call the stored procedure
            cursor.callproc('GetAllShelters')

            # Fetch all the results
            result = cursor.fetchall()

            # Check if there are shelters to display
            if not result:
                print("No shelters found.")
                return

            # Extract column headers
            headers = result[0].keys()

            # Convert the list of dictionaries into a list of lists
            table_data = [[row[col] for col in headers] for row in result]

            # Use tabulate to format the data as a table
            table = tabulate(table_data, headers=headers, tablefmt="pretty")

            # Print the formatted table
            print(table)
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
            # Call the stored procedure
            cursor.callproc('ViewResidentsInShelter', [shelter_name])

            # Fetch all the results
            result = cursor.fetchall()

            # Check if there are shelters to display
            if not result:
                print("No residents found.")
                return

            # Extract column headers
            headers = result[0].keys()

            # Convert the list of dictionaries into a list of lists
            table_data = [[row[col] for col in headers] for row in result]

            # Use tabulate to format the data as a table
            table = tabulate(table_data, headers=headers, tablefmt="pretty")

            # Print the formatted table
            print(table)
    except pymysql.Error as e:
        print(f"Error: {e}")


def call_get_all_past_residents_procedure(connection, shelter_name):
    try:
        with connection.cursor() as cursor:
            # Call the stored procedure
            cursor.callproc('ViewPastResidentsInShelter', [shelter_name])

            # Fetch all the results
            result = cursor.fetchall()

            # Check if there are shelters to display
            if not result:
                print("No residents found.")
                return

            # Extract column headers
            headers = result[0].keys()

            # Convert the list of dictionaries into a list of lists
            table_data = [[row[col] for col in headers] for row in result]

            # Use tabulate to format the data as a table
            table = tabulate(table_data, headers=headers, tablefmt="pretty")

            # Print the formatted table
            print(table)
    except pymysql.Error as e:
        print(f"Error: {e}")
