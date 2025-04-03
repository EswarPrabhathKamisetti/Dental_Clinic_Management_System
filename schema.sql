USE dental_clinic;
CREATE TABLE Role (
    Role_ID VARCHAR(50) PRIMARY KEY,
    Role_Name VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE User (
    User_ID VARCHAR(50) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role_ID VARCHAR(50) NOT NULL,
    FOREIGN KEY (Role_ID) REFERENCES Role(Role_ID)
);
CREATE TABLE Patient (
    Patient_ID VARCHAR(50) PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    DOB DATE,
    Gender VARCHAR(10)
);
CREATE TABLE Insurance (
    Insurance_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Provider VARCHAR(50),
    Plan VARCHAR(50),
    Policy_No VARCHAR(50),
    Expiry_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Treatment (
    Treatment_ID VARCHAR(50) PRIMARY KEY,
    Treatment_Name VARCHAR(100),
    Description TEXT,
    Cost FLOAT
);
CREATE TABLE Medicine (
    Medicine_ID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100),
    Quantity INT,
    Cost FLOAT
);
CREATE TABLE Appointment (
    Appt_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Dentist_ID VARCHAR(50) NOT NULL,
    Date DATE,
    Time TIME,
    Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Dentist_ID) REFERENCES User(User_ID)
);
CREATE TABLE Procedure_Record (
    Record_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Appointment_ID VARCHAR(50) NOT NULL,
    Tooth_No VARCHAR(10),
    Treatment_ID VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appt_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES Treatment(Treatment_ID)
);
CREATE TABLE Diagnosis_Record (
    Record_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Appointment_ID VARCHAR(50),
    Tooth_No VARCHAR(10),
    Diagnosis_ID VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appt_ID)
);
CREATE TABLE Prescription (
    Prescription_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Dentist_ID VARCHAR(50) NOT NULL,
    Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Dentist_ID) REFERENCES User(User_ID)
);
CREATE TABLE Prescription_Medicine (
    Prescription_ID VARCHAR(50),
    Medicine_ID VARCHAR(50),
    Dosage VARCHAR(100),
    PRIMARY KEY (Prescription_ID, Medicine_ID),
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID)
);
CREATE TABLE Xray_Record (
    Xray_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Dentist_ID VARCHAR(50) NOT NULL,
    Image_Path VARCHAR(255),
    Date_Taken DATETIME,
    Tooth_No VARCHAR(10),
    Notes TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Dentist_ID) REFERENCES User(User_ID)
);
CREATE TABLE Bill (
    Bill_ID VARCHAR(50) PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Total_Amount FLOAT,
    Paid BOOLEAN,
    Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Registration_Log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Registered_By VARCHAR(10),       -- Admin who performed the action
    Registered_User VARCHAR(10),     -- The user being added/updated/deleted
    Role_ID VARCHAR(10),             -- Role assigned to the user
    Action ENUM('ADD', 'UPDATE', 'DELETE') NOT NULL,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (Registered_By) REFERENCES User(User_ID),
    FOREIGN KEY (Registered_User) REFERENCES User(User_ID),
    FOREIGN KEY (Role_ID) REFERENCES Role(Role_ID)
);
