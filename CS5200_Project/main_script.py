from database_operations import *
import re
import getpass
import pandas as pd
import matplotlib.pyplot as plt

def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return re.match(email_regex, email) is not None

def is_valid_date(date_string):
    date_regex = r'^(?:\d{4})-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])$'
    return re.match(date_regex, date_string) is not None

def is_valid_phone_number(phone_number):
    phone_regex = r'^\+?1?\s*[-.\s]?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$'
    return re.match(phone_regex, phone_number) is not None

def volunteer_management(db_connection, shelter_name):
    while True:
        print(f"\nManage Volunteers of {shelter_name}")
        print("\n1. View volunteers")
        print("2. Add a volunteer")
        print("3. Opt a volunteer out (Delete record)")
        v_choice = input("\nEnter your choice: ")
        if v_choice == "1":
            call_view_shelter_volunteers_procedure(db_connection, shelter_name)
        elif v_choice == "2":
            first_name = input("Enter first name of the volunteer: ")
            last_name = input("Enter last name of the volunteer: ")
            phone_no = input("Enter phone number of the volunteer: ")
            call_insert_volunteer_procedure(db_connection, first_name, last_name, phone_no, shelter_name)
        elif v_choice == "3":
            volunteer_id = int(input("Enter volunteer's ID to delete their record (ensure to view them first): "))
            call_delete_volunteer_procedure(db_connection, volunteer_id, shelter_name)

def donation_management(db_connection, shelter_name):
    while True:
        print(f"\nManage Donations of {shelter_name}")
        print("\n1. View donations")
        print("2. Add a donation")
        d_choice = input("\nEnter your choice: ")
        if d_choice == "1":
            call_view_shelter_donations_procedure(db_connection, shelter_name)
        elif d_choice == "2":
            first_name = input("Enter first name of the donor: ")
            last_name = input("Enter last name of the donor: ")
            donation_date = input("Enter donation date (YYYY-MM-DD): ")
            donation_description = input("Enter donation description: ")
            call_add_donation_to_shelter_procedure(db_connection, first_name, last_name, donation_date, donation_description, shelter_name)

def submenu(db_connection, shelter_name):
    while True:
        choice = input("\nSelect whether you want to manage residents or volunteers or donations. \nFor residents simply type 'residents', for volunteers type 'volunteers', for donations type 'donations': ").lower()
        if choice == "residents":
            resident_manipulation(db_connection, shelter_name)
        elif choice == "volunteers":
            volunteer_management(db_connection, shelter_name)
        elif choice == "donations":
            donation_management(db_connection, shelter_name)
        else:
            print("\nInvalid choice.")
def resident_employment(db_connection, shelter_name):
    print("\nAdd the resident's employment records")
    emp_status = input("Is the resident employed? (Enter 'yes' or 'no'): ").lower() == 'yes'

    if emp_status:
        employment_status = True
        employer_name = input("Enter employer name: ")
        job_title = input("Enter job title: ")
        employment_begin_date = input("Enter employment begin date (YYYY-MM-DD): ")
        employment_end_date = input("Enter employment end date (YYYY-MM-DD): ")
        if employment_end_date =="":
            employment_end_date=None
    else:
        employment_status = False
        employer_name = job_title = employment_begin_date = employment_end_date = None
    add_resident_employment_record_procedure(db_connection, shelter_name, employment_status, employer_name, job_title, employment_begin_date, employment_end_date)

def resident_health(db_connection, shelter_name):
    print("\nAdd the resident's health records")
    while True:
        health_report_details = input("Enter resident's health report details: ")
        if health_report_details.strip():
            break
        else:
            print("Health report details cannot be empty. Please enter valid information.")
    resident_conditions = input("Enter resident's conditions: ")
    resident_allergies = input("Enter resident's allergies: ")
    resident_medication = input("Enter resident's medication prescription: ")

    add_health_report_procedure(db_connection, shelter_name, health_report_details, resident_conditions, resident_allergies, resident_medication)
    resident_employment(db_connection, shelter_name)

def resident_manipulation(db_connection, shelter_name):
    while True:
        print("\nNote: View the IDs of current residents first to proceed with operations 5-7")
        print(f"\nManage residents of {shelter_name}")
        print("1. View current residents")
        print("2. View past residents")
        print("3. Add new resident record")
        print("4. Update current resident leave date to indicate they have left the shelter")
        print("5. Delete current resident record")
        print("6. View current resident's health records")
        print("7. View current resident's employment records")
        print("8. Add new current resident's health record")
        choice = input("\nEnter your choice (1/2/3/4/5/6/7): ")

        if choice == "1":
            call_get_all_residents_procedure(db_connection, shelter_name)

        if choice == "2":
            call_get_all_past_residents_procedure(db_connection, shelter_name)
        
        if choice == "3":
            while True:
                first_name = input("Enter first name: ")
                last_name = input("Enter last name: ")
                gender = input("Enter gender: ")
                dob = input("Enter date of birth (YYYY-MM-DD): ")
                phone = input("Enter phone number: ")

                if any(not value.strip() for value in [first_name, last_name, gender, dob, phone]):
                    print("Invalid input. Please provide all required information.")
                    continue

                if not is_valid_phone_number(phone):
                    print("Invalid phone number. Please enter a valid US phone number.")
                    continue

                join_date = input("Enter join date (YYYY-MM-DD): ")

                if not (is_valid_date(dob) and is_valid_date(join_date)):
                    print("Invalid date format. Please use YYYY-MM-DD.")
                    continue

                break

            call_insert_new_resident_procedure(db_connection, first_name, last_name, shelter_name, gender, dob, phone, join_date)
            resident_health(db_connection, shelter_name)

        if choice == "4":
            while True:
                try:
                    resident_id = int(input("Enter the ID of resident whose records you want to update: "))

                    if resident_id < 0:
                        print("Invalid resident ID. Please enter a non-negative integer.")
                        continue

                    leave_date = input("Enter the date on which they left the shelter (YYYY-MM-DD): ")

                    if not is_valid_date(leave_date):
                        print("Invalid date format. Please use YYYY-MM-DD.")
                        continue

                    update_leave_date_procedure(db_connection, resident_id, shelter_name, leave_date)
                    break

                except ValueError:
                    print("Invalid input. Please enter a valid resident ID.")

        if choice == "5":
            while True:
                try:
                    resident_id = int(input("Enter the ID of resident whose records you want to delete: "))
                    if resident_id <= 0:
                        raise ValueError("Resident ID must be a positive integer.")
                    break 
                except ValueError:
                    print(f"Error: Enter an integer value for ID")
            remove_resident_procedure(db_connection, resident_id, shelter_name)

        if choice == "6":
            while True:
                try:
                    resident_id = int(input("Enter the ID of resident whose health records you want to view: "))
                    if resident_id <= 0:
                        raise ValueError("Resident ID must be a positive integer.")
                    break 
                except ValueError:
                    print(f"Error: Enter an integer value for ID")
            call_view_health_records_procedure(db_connection, resident_id, shelter_name)

        if choice == "7":
            while True:
                try:
                    resident_id = int(input("Enter the ID of resident whose employment records you want to view: "))
                    if resident_id <= 0:
                        raise ValueError("Resident ID must be a positive integer.")
                    break 
                except ValueError:
                    print(f"Error: Enter an integer value for ID")
            call_view_employment_records_procedure(db_connection, resident_id, shelter_name)

        if choice == "8":
                resident_id = int(input("Enter the ID of resident whose new health records you want to insert: "))
                health_report_date = input("Enter date of new resident health record: ")
                health_report_details = input("Enter the description of the new health report: ")
                resident_conditions = input("Enter resident conditions: ")
                resident_allergies = input("Enter resident allergies: ")
                resident_medication = input("Enter resident medication: ")
            
                call_add_resident_health_record_procedure(db_connection, resident_id, shelter_name, health_report_date,
    health_report_details, resident_conditions, resident_allergies, resident_medication)

        if choice == "9":
            resident_id = int(input("Enter the ID of resident whose employment records you want to update: "))
            emp_status = input("Is the resident employed? (Enter 'yes' or 'no'): ").lower() == 'yes'

            if emp_status:
                employment_status = True
                employer_name = input("Enter employer name: ")
                job_title = input("Enter job title: ")
                employment_begin_date = input("Enter employment begin date (YYYY-MM-DD): ")
                employment_end_date = input("Enter employment end date (YYYY-MM-DD): ")
                if employment_end_date =="":
                    employment_end_date=None
            else:
                employment_status = False
                employer_name = job_title = employment_begin_date = employment_end_date = None
            
            update_resident_employment_record(db_connection, resident_id, shelter_name, employment_status, employer_name, job_title, employment_begin_date, employment_end_date)
            
    


def main():
    host = "localhost"
    database = "project_roofs"

    while True:
        user = input("Enter user for the database to access Project Roofs: ")
        password = getpass.getpass("Enter password for the database to access Project Roofs: ")

        db_connection = connect_to_database(host, user, password, database)

        if db_connection:
            break

    while True:
        print("\nSelect an option:")
        print("1. Add a new admin")
        print("2. Login as admin")
        print("3. View details of all admins (for the sake of evaluation)")
        print("4. Interesting visualizations to look for")
        print("5. Exit")

        choice = input("\nEnter your choice (1/2/3/4): ")

        if choice == '1':
            admin_email = input("\nEnter new admin email: ")
            if not is_valid_email(admin_email):
                print("Invalid email format. Please enter a valid email.")
                continue
            admin_username = input("Enter new admin username: ")
            admin_password = getpass.getpass("Enter new admin password: ")

            add_new_admin(db_connection, admin_email, admin_username, admin_password)


        elif choice == '2':
            admin_username = input("\nEnter admin username: ")
            admin_password = getpass.getpass("Enter admin password: ")

            if admin_login(db_connection, admin_username, admin_password):
                print("\nLogin successful. Welcome, Admin!")
                print("Below are the shelters you can manage.\n")
                call_get_all_shelters_procedure(db_connection)
                while True:
                    shelter_initials = input("\nEnter the initials of the shelter you want to manage: \nExample Usage: Type 'bcs' for Boston Community Shelter or 'bs' for Brigham Shelter or 'hhs' for Holy Hearts Shelter\n")
                    if shelter_initials == "bcs":
                        shelter_name = "Boston Community Shelter"
                        call_get_shelter_statistics_procedure(db_connection, shelter_name)
                        submenu(db_connection, shelter_name)
                        #resident_manipulation(db_connection, shelter_name)

                    
                    elif shelter_initials == "bs":
                        shelter_name = "Brigham Shelter"
                        call_get_shelter_statistics_procedure(db_connection, shelter_name)
                        submenu(db_connection, shelter_name)
                        # resident_manipulation(db_connection, shelter_name)


                    elif shelter_initials == "hhs":
                        shelter_name = "Holy Hearts Shelter"
                        call_get_shelter_statistics_procedure(db_connection, shelter_name)
                        submenu(db_connection, shelter_name)
                        # resident_manipulation(db_connection, shelter_name)
                    
                    else:
                        print("\n Invalid choice. Please enter a valid option: bcs/bs/hhs") 


            else:
                print("Invalid admin credentials. Please try again.")


        elif choice == '3':
            
            print("\nDetails of all admins: ")
            call_get_all_admins_procedure(db_connection)

        elif choice == '4':
            
            call_and_plot_stored_procedure(db_connection, "GetGenderDistribution", plot_kind='pie', y_column='gender_count', labels_column='gender', title='Gender Distribution of Residents', ylabel='')
            call_and_plot_stored_procedure(db_connection,"GetResidentCountByShelter",plot_kind='bar',y_column='resident_count',title='Resident Count by Shelter',xlabel='Shelter Name',ylabel='Resident Count')
            call_and_plot_stored_procedure(db_connection, "GetJoinCountByDate", plot_kind='hist', x_column='join_date', y_column='join_count', bins=20, edgecolor='black', title='Join Date Distribution of Residents', xlabel='Join Date', ylabel='Count')

        elif choice == '5':
            break

        else:
            print("\nInvalid choice. Please enter a valid option (1/2/3/4/5).")

    close_connection(db_connection)

if __name__ == "__main__":
    main()
