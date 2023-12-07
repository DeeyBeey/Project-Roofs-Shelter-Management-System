from database_operations import *
import re
import getpass

def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return re.match(email_regex, email) is not None

def resident_manipulation(db_connection, shelter_name):
    while True:
        print(f"\nManage residents of {shelter_name}")
        print("1. View current residents")
        print("2. View past residents")
        print("2. Update current resident records")
        print("3. Delete current resident records")

        choice = input("\nEnter your choice (1/2/3/4): ")

        if choice == "1":
            call_get_all_residents_procedure(db_connection, shelter_name)

        if choice == "2":
            call_get_all_past_residents_procedure(db_connection, shelter_name)



def main():
    host = "localhost"
    database = "project_roofs"

    while True:
        user = input("Enter user for the database to access Project Roofs: ")
        password = getpass.getpass("Enter password for the database to access Project Roofs: ")

        db_connection = connect_to_database(host, user, password, database)

        # Check if the database connection is successful before proceeding
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
