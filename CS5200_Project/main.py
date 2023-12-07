import pymysql
import getpass

def connect_to_database(host, user, password, database):
    try:
        connection = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            cursorclass=pymysql.cursors.DictCursor
        )
        print("Connected to the database!")
        return connection
    except pymysql.Error as e:
        print(f"Error: Unable to connect to the database. {e}")
        return None

def close_connection(connection):
    if connection:
        connection.close()
        print("Connection closed.")

def add_new_admin(connection, username, password):
    try:
        if connection:
            query = "INSERT INTO pr_admin (username, admin_password) VALUES (%s, AES_ENCRYPT(%s, 'CS5200'))"
            with connection.cursor() as cursor:
                cursor.execute(query, (username, password))
                connection.commit()
                print("New admin added successfully!")
                return True
        else:
            print("Error: Database connection is not established.")
            return False
    except pymysql.Error as e:
        print(f"Error: {e}")
        return False

def admin_login(connection, username, password):
    try:
        if connection:
            query = "SELECT * FROM pr_admin WHERE username = %s AND CAST(AES_DECRYPT(admin_password,'CS5200') AS CHAR) = %s"
            with connection.cursor() as cursor:
                cursor.execute(query, (username, password))
                result = cursor.fetchone()
                if result:
                    print("Login successful. Welcome, Admin!")
                    return True
                else:
                    print("Invalid credentials. Login failed.")
                    return False
        else:
            print("Error: Database connection is not established.")
            return False
    except pymysql.Error as e:
        print(f"Error: {e}")
        return False

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
        else:
            print("Invalid database credentials. Please try again.")

    while True:
        choice = input("Do you want to add a new admin? (y/n): ").lower()

        if choice == 'y':
            admin_username = input("Enter new admin username: ")
            admin_password = getpass.getpass("Enter new admin password: ")

            if add_new_admin(db_connection, admin_username, admin_password):
                break
            else:
                print("Failed to add a new admin. Please try again.")
        elif choice == 'n':
            break
        else:
            print("Invalid choice. Please enter 'y' or 'n'.")

    while True:
        admin_username = input("Enter admin username: ")
        admin_password = getpass.getpass("Enter admin password: ")

        if admin_login(db_connection, admin_username, admin_password):
            break
        else:
            print("Invalid admin credentials. Please try again.")

    # Close the connection when done
    close_connection(db_connection)

if __name__ == "__main__":
    main()
