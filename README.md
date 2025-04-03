Dental Clinical Management System

A secure, SQL-based system designed to manage and streamline dental clinic operations, including patient management, appointments, procedures, prescriptions, billing, radiographs, and insurance. This system integrates role-based access control and lays the groundwork for data encryption to protect sensitive health data.

📌 Project Objectives

Build a relational database system for a dental clinic.
Support end-to-end clinical and administrative tasks:
Patient registration
Appointment scheduling
Procedure documentation
Prescription & medicine tracking
Billing & insurance handling
Radiograph (X-ray) record management
Enforce role-based user access
Support data encryption readiness for secure storage
🛠️ Tools & Technologies

Component	Tool
Database	MySQL / PostgreSQL
Schema Design	dbdiagram.io, Lucidchart
IDE & Terminal	VS Code + SQLTools Extension
SQL Driver	SQLTools MySQL Driver
OS & CLI	macOS/Linux Terminal
🧠 System Overview

✅ Core Features
Patient Management: Personal and contact details
Appointments: Schedule, assign, and track appointments
Treatments & Procedures: Document per-tooth treatment history
Billing: Track costs, paid status, and dates
Prescriptions & Medicines: Dosages, medicine inventory, and associations
Insurance: Track plans, providers, and expiry dates
Radiographs: Store image path, date, and notes
Security: Role-based access with password encryption readiness
📘 Database Design

🗂️ Entities & Attributes
Patient(Patient_ID, First_Name, Last_Name, Phone, Email, DOB, Gender)
User(User_ID, Username, Password [Encrypted], Role_ID)
Role(Role_ID, Role_Name)
Appointment(App_ID, Patient_ID, Dentist_ID, Date, Time, Status)
Treatment(Treatment_ID, Name, Description, Cost)
Procedure_Record(Record_ID, Patient_ID, Appointment_ID, Tooth_No, Treatment_ID, Notes)
Prescription(Prescription_ID, Patient_ID, Dentist_ID, Date)
Medicine(Medicine_ID, Name, Quantity, Cost)
Prescription_Medicine(Prescription_ID, Medicine_ID, Dosage)
Xray_Record(Xray_ID, Patient_ID, Dentist_ID, Image_Path, Date_Taken, Tooth_No, Notes)
Insurance(Insurance_ID, Patient_ID, Provider, Plan, Policy_No, Expiry_Date)
Bill(Bill_ID, Patient_ID, Total_Amount, Paid, Date)
🔗 Relationships
A patient can have multiple appointments, bills, X-rays, and prescriptions.
One appointment is handled by one dentist.
One user has one role (admin, receptionist, dentist, etc.).
Each procedure is linked to a treatment and an appointment.
One prescription can contain multiple medicines.
🧱 Schema Implementation

The schema is defined in schema.sql, including all constraints, data types, and foreign key relationships. Run the file using:

/usr/local/mysql/bin/mysql -u root -p
# Enter password when prompted (Esw@r1999)
Or use VS Code with SQLTools:

Click on SQLTools icon → Add Connection
Choose MySQL → Enter connection details → Connect
Open schema.sql → Run Query
🧪 Sample Data

Stored in sampledata.sql, includes:

Roles: Dentist, Receptionist, Manager, Dental Assistant, Consultant, Administrator
Users: Dentist (dr.john), Receptionist (alex), Manager (sara)
Patients: Alice Smith, Bob Johnson
Appointments, Treatments, Procedures, Prescriptions
Medicines: Amoxicillin, Ibuprofen
Bills and Insurance entries
X-ray records
🔍 Sample Query Scenarios

1. Total Revenue Generated in April 2025
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Bill
WHERE Date BETWEEN '2025-04-01' AND '2025-04-30';
2. List of Patients Who Have Appointments with Dr. John
SELECT P.First_Name, P.Last_Name, A.Date, A.Time
FROM Appointment A
JOIN Patient P ON A.Patient_ID = P.Patient_ID
WHERE A.Dentist_ID = 'U001';
3. Treatments Performed on Each Patient
SELECT P.First_Name, P.Last_Name, T.Treatment_Name, PR.Tooth_No, PR.Notes
FROM Procedure_Record PR
JOIN Patient P ON PR.Patient_ID = P.Patient_ID
JOIN Treatment T ON PR.Treatment_ID = T.Treatment_ID;
4. List of Patients Prescribed ‘Ibuprofen’
SELECT DISTINCT P.First_Name, P.Last_Name
FROM Prescription PR
JOIN Prescription_Medicine PM ON PR.Prescription_ID = PM.Prescription_ID
JOIN Medicine M ON PM.Medicine_ID = M.Medicine_ID
JOIN Patient P ON PR.Patient_ID = P.Patient_ID
WHERE M.Name = 'Ibuprofen';
5. Unpaid Bills and Corresponding Patients
SELECT P.First_Name, P.Last_Name, B.Total_Amount, B.Date
FROM Bill B
JOIN Patient P ON B.Patient_ID = P.Patient_ID
WHERE B.Paid = FALSE;
6. Prescription Details for a Given Patient (e.g., Bob Johnson)
SELECT M.Name AS Medicine, PM.Dosage
FROM Prescription PR
JOIN Prescription_Medicine PM ON PR.Prescription_ID = PM.Prescription_ID
JOIN Medicine M ON PM.Medicine_ID = M.Medicine_ID
WHERE PR.Patient_ID = 'P002';
7. All Procedures Performed by a Particular Dentist
SELECT T.Treatment_Name, PR.Tooth_No, P.First_Name AS Patient, A.Date
FROM Procedure_Record PR
JOIN Treatment T ON PR.Treatment_ID = T.Treatment_ID
JOIN Appointment A ON PR.Appointment_ID = A.Appt_ID
JOIN Patient P ON PR.Patient_ID = P.Patient_ID
WHERE A.Dentist_ID = 'U001';
8. X-ray Records with Notes for All Patients
SELECT P.First_Name, P.Last_Name, XR.Tooth_No, XR.Image_Path, XR.Notes, XR.Date_Taken
FROM Xray_Record XR
JOIN Patient P ON XR.Patient_ID = P.Patient_ID;
9. Patients with Active Insurance Policies
SELECT P.First_Name, P.Last_Name, I.Provider, I.Policy_No, I.Expiry_Date
FROM Insurance I
JOIN Patient P ON I.Patient_ID = P.Patient_ID
WHERE I.Expiry_Date > CURDATE();
10. List All Users and Their Roles
SELECT U.Username, R.Role_Name
FROM User U
JOIN Role R ON U.Role_ID = R.Role_ID;
🔐 Security Module

Role-Based Access Control: Implemented through User and Role tables.
Planned Encryption: Passwords to be encrypted (e.g., using bcrypt or SHA-256).
User Approval Workflow:
Only two admin users can approve or reject registration requests.
Log all registration attempts.
Roles assigned upon approval.
🔮 Future Enhancements

Frontend UI using Flask or Django
Visual Dashboards for revenue, treatment trends (Power BI/Tableau)
Encryption of X-ray files and patient data
Activity Logging and Audit Trail System
SMS/Email Reminders for Appointments
📁 Repository Structure

📁 dental-clinic-management/
├── schema.sql              # Full table structure
├── sampledata.sql          # Sample INSERT statements
├── README.md               # This documentation
└── /diagrams               # (Optional) EER or schema diagrams
👨‍⚕️ Author

Eswar Prabhath
📧 dreswarprabhath@gmail.com