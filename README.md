# 🦷 Dental Clinical Management System

An **SQL-based secure and scalable system** for managing the operations of a dental clinic. This project covers key aspects such as patient management, appointments, treatments, billing, X-ray records, prescriptions, insurance, and **role-based staff access with admin-controlled user approval**.

---

## ✅ Features

- Patient Management  
- Appointment Scheduling  
- Treatment Records  
- Secure Prescription & Billing  
- X-ray Image Recording  
- Insurance Details Management  
- Role-based Access Control  
- Data Encryption  
- Administrator-Only User Approvals  
- Analytical SQL Queries  

---

## 🧰 Tech Stack

| Component      | Tool                        |
|----------------|-----------------------------|
| Database       | MySQL                       |
| SQL IDE        | VS Code + SQLTools Plugin   |
| Diagramming    | Lucidchart                  |

---

## 📐 Database Design

### ER Diagram  
![ER Diagram](diagrams/ER_Diagram.jpeg)

---

## ⚙️ Installation

### 1. Install MySQL
- Create an Oracle account
- Download and install **MySQL Community Server**
- Start the MySQL server
- Open terminal and login:
```bash
/usr/local/mysql/bin/mysql -u root -p
```
> Enter your configured password.

### 2. VS Code Setup
- Install the following extensions:
  - **SQLTools**
  - **SQLTools MySQL/MariaDB Driver**

### 3. Connect VS Code to MySQL
- Click the **SQLTools** icon in the sidebar
- Create a new connection with the following:
  - **Connection Name:** DentalDB  
  - **Server/Host:** localhost  
  - **User:** root  
  - **Password:** your_password  
  - **Database:** dental_clinic  

---

## ▶️ Running the Project

### Step 1: Create the Database
In MySQL terminal or SQLTools:
```sql
CREATE DATABASE dental_clinic;
USE dental_clinic;
```

### Step 2: Load the Schema
- Open `schema.sql` in VS Code  
- Run the script to create all necessary tables

### Step 3: Insert Sample Data
- Open `sampledata.sql`  
- Run the script to insert sample entries

---

## 🧠 Sample Query Scenarios

### 1. Total Revenue Generated in April 2025
```sql
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Bill
WHERE Date BETWEEN '2025-04-01' AND '2025-04-30';
```

### 2. Patients with Appointments for Dr. John
```sql
SELECT P.First_Name, P.Last_Name, A.Date, A.Time
FROM Appointment A
JOIN Patient P ON A.Patient_ID = P.Patient_ID
WHERE A.Dentist_ID = 'U001';
```

### 3. Treatments Performed on Each Patient
```sql
SELECT P.First_Name, P.Last_Name, T.Treatment_Name, PR.Tooth_No, PR.Notes
FROM Procedure_Record PR
JOIN Patient P ON PR.Patient_ID = P.Patient_ID
JOIN Treatment T ON PR.Treatment_ID = T.Treatment_ID;
```

### 4. Patients Prescribed ‘Ibuprofen’
```sql
SELECT DISTINCT P.First_Name, P.Last_Name
FROM Prescription PR
JOIN Prescription_Medicine PM ON PR.Prescription_ID = PM.Prescription_ID
JOIN Medicine M ON PM.Medicine_ID = M.Medicine_ID
JOIN Patient P ON PR.Patient_ID = P.Patient_ID
WHERE M.Name = 'Ibuprofen';
```

### 5. Unpaid Bills and Corresponding Patients
```sql
SELECT P.First_Name, P.Last_Name, B.Total_Amount, B.Date
FROM Bill B
JOIN Patient P ON B.Patient_ID = P.Patient_ID
WHERE B.Paid = FALSE;
```

### 6. Prescription Details for Patient 'Bob Johnson'
```sql
SELECT M.Name AS Medicine, PM.Dosage
FROM Prescription PR
JOIN Prescription_Medicine PM ON PR.Prescription_ID = PM.Prescription_ID
JOIN Medicine M ON PM.Medicine_ID = M.Medicine_ID
WHERE PR.Patient_ID = 'P002';
```

### 7. All Procedures Performed by Dr. John
```sql
SELECT T.Treatment_Name, PR.Tooth_No, P.First_Name AS Patient, A.Date
FROM Procedure_Record PR
JOIN Treatment T ON PR.Treatment_ID = T.Treatment_ID
JOIN Appointment A ON PR.Appointment_ID = A.Appt_ID
JOIN Patient P ON PR.Patient_ID = P.Patient_ID
WHERE A.Dentist_ID = 'U001';
```

### 8. All X-ray Records with Notes
```sql
SELECT P.First_Name, P.Last_Name, XR.Tooth_No, XR.Image_Path, XR.Notes, XR.Date_Taken
FROM Xray_Record XR
JOIN Patient P ON XR.Patient_ID = P.Patient_ID;
```

### 9. Patients with Active Insurance Policies
```sql
SELECT P.First_Name, P.Last_Name, I.Provider, I.Policy_No, I.Expiry_Date
FROM Insurance I
JOIN Patient P ON I.Patient_ID = P.Patient_ID
WHERE I.Expiry_Date > CURDATE();
```

### 10. List All Users and Their Roles
```sql
SELECT U.Username, R.Role_Name
FROM User U
JOIN Role R ON U.Role_ID = R.Role_ID;
```

---

## 🔐 Security

### 🔑 User Approval Workflow
- Only two admin users can approve or reject registration requests.
- Logs every registration attempt.
- Role is assigned only after approval.

### 🔐 Data Security
- Role-based access enforced at DB level.
- Passwords and sensitive data encrypted using SQL functions and views.
- Encrypted storage of X-ray file paths and patient metadata (planned).

---

## 🚀 Future Enhancements

- Frontend UI using Flask or Django  
- Visual Dashboards with Power BI/Tableau  
- Full encryption of X-ray files and patient data  
- Audit Trail Logging for all actions  
- Appointment Reminders via SMS/Email  

---


## 👨‍⚕️ Author

**Eswar Prabhath Kamisetti**  
📧 ekamiset@gmail.com

---

> *Feel free to fork this repo, contribute, or connect if you'd like to collaborate!*
