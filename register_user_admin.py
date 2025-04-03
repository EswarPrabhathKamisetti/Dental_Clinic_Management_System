import mysql.connector
import bcrypt


# register_user_admin.py

from dotenv import load_dotenv
import os
import mysql.connector
import bcrypt

# Load environment variables from .env file
load_dotenv()

def register_user():
    print("\n=== Dental Clinic User Registration ===")
    
    user_id = input("Enter new User ID (e.g., U004): ").strip()
    username = input("Enter username: ").strip()
    password = input("Enter password: ").strip()
    role_id = input("Enter role ID (e.g., R001 for Dentist): ").strip()
    
    # Hash the password
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    try:
        # Connect to MySQL database
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password= os.getenv("DB_PASSWORD"),  # Change this to your actual password
            database="dental_clinic"
        )
        cursor = db.cursor()

        # Insert user with hashed password
        sql = """
        INSERT INTO User (User_ID, Username, Password, Role_ID, Is_Active)
        VALUES (%s, %s, %s, %s, TRUE)
        """
        values = (user_id, username, hashed_password.decode('utf-8'), role_id)
        cursor.execute(sql, values)
        db.commit()
        print(f"✅ User '{username}' registered successfully!")

    except mysql.connector.Error as err:
        print(f"❌ Database Error: {err}")
    finally:
        if db.is_connected():
            cursor.close()
            db.close()

# Run it
register_user()
