from database_operations import *
import re
import getpass

def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return re.match(email_regex, email) is not None

def is_valid_date(date_string):
    date_regex = r'^(?:\d{4})-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])$'
    return re.match(date_regex, date_string) is not None

def is_valid_phone_number(phone_number):
    phone_regex = r'^\+?1?\s*[-.\s]?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$'
    return re.match(phone_regex, phone_number) is not None

def resident_manipulation(db_connection, shelter_name):
    while True:
        print(f"\nManage residents of {shelter_name}")
        print("1. View current residents")
        print("2. View past residents")
        print("3. Add new resident record")
        print("4. Update current resident leave date to indicate they have left the shelter (view current residents first to know their IDs)")
        print("5. Delete current resident record (view current residents first to know their IDs)")

        choice = input("\nEnter your choice (1/2/3/4): ")

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
        print("4. Exit")

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
                        resident_manipulation(db_connection, shelter_name)

                    
                    elif shelter_initials == "bs":
                        shelter_name = "Brigham Shelter"
                        call_get_shelter_statistics_procedure(db_connection, shelter_name)
                        resident_manipulation(db_connection, shelter_name)


                    elif shelter_initials == "hhs":
                        shelter_name = "Holy Hearts Shelter"
                        call_get_shelter_statistics_procedure(db_connection, shelter_name)
                        resident_manipulation(db_connection, shelter_name)
                    
                    else:
                        print("\n Invalid choice. Please enter a valid option: bcs/bs/hhs") 


            else:
                print("Invalid admin credentials. Please try again.")


        elif choice == '3':
            
            print("\nDetails of all admins: ")
            call_get_all_admins_procedure(db_connection)

        elif choice == '4':
            break

        else:
            print("\nInvalid choice. Please enter a valid option (1/2/3/4).")

    # Close the connection when done
    close_connection(db_connection)

if __name__ == "__main__":
    main()
