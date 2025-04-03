import mysql.connector
import bcrypt
from datetime import datetime

from dotenv import load_dotenv
import os
import mysql.connector

load_dotenv() 

def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password= os.getenv("DB_PASSWORD"),  
        database="dental_clinic"
    )

def admin_login():
    print("=== Admin Login ===")
    username = input("Username: ").strip()
    password = input("Password: ").strip()

    db = connect_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT * FROM User
        WHERE Username = %s AND Role_ID = 'R000' AND Is_Active = TRUE
    """, (username,))
    admin = cursor.fetchone()
    cursor.close()
    db.close()

    if admin and bcrypt.checkpw(password.encode('utf-8'), admin["Password"].encode('utf-8')):
        print(f"\n✅ Welcome, {admin['Username']}! Access granted.\n")
        return admin["User_ID"]
    else:
        print("\n❌ Access denied. Invalid credentials or not an administrator.\n")
        return None

def view_roles():
    db = connect_db()
    cursor = db.cursor()
    cursor.execute("SELECT Role_ID, Role_Name FROM Role")
    roles = cursor.fetchall()
    print("\nAvailable Roles:")
    for role in roles:
        print(f"- {role[0]}: {role[1]}")
    cursor.close()
    db.close()

def view_users():
    db = connect_db()
    cursor = db.cursor()
    cursor.execute("SELECT User_ID, Username, Role_ID, Is_Active FROM User")
    users = cursor.fetchall()
    print("\nExisting Users:")
    for u in users:
        print(f"- {u[0]} | {u[1]} | {u[2]} | {'Active' if u[3] else 'Inactive'}")
    cursor.close()
    db.close()

def register_user(admin_id):
    print("\n=== Register New User ===")
    user_id = input("Enter new User ID: ").strip()
    username = input("Enter Username: ").strip()
    password = input("Enter Password: ").strip()
    role_id = input("Enter Role ID to assign: ").strip()

    hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    db = connect_db()
    cursor = db.cursor()

    try:
        cursor.execute("""
            INSERT INTO User (User_ID, Username, Password, Role_ID, Is_Active)
            VALUES (%s, %s, %s, %s, TRUE)
        """, (user_id, username, hashed.decode('utf-8'), role_id))
        
        cursor.execute("""
            INSERT INTO Registration_Log (Registered_By, Registered_User, Role_ID, Action)
            VALUES (%s, %s, %s, 'ADD')
        """, (admin_id, user_id, role_id))

        db.commit()
        print(f"✅ User '{username}' registered successfully.")

    except mysql.connector.Error as err:
        print(f"❌ Error: {err}")
    finally:
        cursor.close()
        db.close()

def update_user(admin_id):
    print("\n=== Update User Role or Status ===")
    user_id = input("Enter User ID to update: ").strip()
    new_role = input("Enter new Role ID (or press Enter to skip): ").strip()
    new_status = input("Set active? (yes/no/skip): ").strip().lower()

    db = connect_db()
    cursor = db.cursor()

    if new_role:
        cursor.execute("UPDATE User SET Role_ID = %s WHERE User_ID = %s", (new_role, user_id))
        cursor.execute("INSERT INTO Registration_Log (Registered_By, Registered_User, Role_ID, Action) VALUES (%s, %s, %s, 'UPDATE')", (admin_id, user_id, new_role))

    if new_status == "yes":
        cursor.execute("UPDATE User SET Is_Active = TRUE WHERE User_ID = %s", (user_id,))
    elif new_status == "no":
        cursor.execute("UPDATE User SET Is_Active = FALSE WHERE User_ID = %s", (user_id,))

    db.commit()
    print("✅ User updated.")
    cursor.close()
    db.close()

def delete_user(admin_id):
    print("\n=== Delete User ===")
    user_id = input("Enter User ID to delete: ").strip()

    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("SELECT Role_ID FROM User WHERE User_ID = %s", (user_id,))
        role_id = cursor.fetchone()[0]

        cursor.execute("DELETE FROM User WHERE User_ID = %s", (user_id,))
        cursor.execute("""
            INSERT INTO Registration_Log (Registered_By, Registered_User, Role_ID, Action)
            VALUES (%s, %s, %s, 'DELETE')
        """, (admin_id, user_id, role_id))
        db.commit()
        print("✅ User deleted.")
    except Exception as e:
        print(f"❌ Error: {e}")
    finally:
        cursor.close()
        db.close()

def view_logs():
    db = connect_db()
    cursor = db.cursor()
    cursor.execute("""
        SELECT Log_ID, Registered_By, Registered_User, Role_ID, Action, Timestamp 
        FROM Registration_Log ORDER BY Timestamp DESC
    """)
    logs = cursor.fetchall()
    print("\n=== Registration Logs ===")
    for log in logs:
        print(f"[{log[5]}] {log[3]} user '{log[2]}' was {log[4]} by admin '{log[1]}'")
    cursor.close()
    db.close()

def admin_console(admin_id):
    while True:
        print("""
=== Admin Console ===
1. View Available Role IDs
2. View Existing User IDs
3. Register New User
4. Update Existing User
5. Delete User
6. View Registration Logs
7. Exit
""")
        choice = input("Select an option: ").strip()

        if choice == '1':
            view_roles()
        elif choice == '2':
            view_users()
        elif choice == '3':
            register_user(admin_id)
        elif choice == '4':
            update_user(admin_id)
        elif choice == '5':
            delete_user(admin_id)
        elif choice == '6':
            view_logs()
        elif choice == '7':
            print("👋 Exiting admin console.")
            break
        else:
            print("❌ Invalid option. Please try again.")

# Start the tool
if __name__ == "__main__":
    admin_id = admin_login()
    if admin_id:
        admin_console(admin_id)
