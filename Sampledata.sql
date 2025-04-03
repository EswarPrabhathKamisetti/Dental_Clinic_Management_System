INSERT INTO Role (Role_ID, Role_Name) VALUES
('R001', 'Dentist'),
('R002', 'Receptionist'),
('R003', 'Manager'),
('R004', 'Dental Assistant'),  
('R005', 'Consultant');

INSERT INTO Role (Role_ID, Role_Name) VALUES
('R000', 'Administrator'),

INSERT INTO User (User_ID, Username, Password, Role_ID) VALUES
('U001', 'dr.john', 'password1', 'R001'),
('U002', 'reception.alex', 'password2', 'R002'),
('U003', 'manager.sara', 'password3', 'R003');

INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Phone, Email, DOB, Gender) VALUES
('P001', 'Alice', 'Smith', '1234567890', 'alice@example.com', '1990-04-10', 'Female'),
('P002', 'Bob', 'Johnson', '9876543210', 'bob@example.com', '1985-11-23', 'Male');

INSERT INTO Treatment (Treatment_ID, Treatment_Name, Description, Cost) VALUES
('T001', 'Tooth Extraction', 'Surgical removal of tooth', 120.00),
('T002', 'Dental Cleaning', 'Scaling and polishing', 80.00);

INSERT INTO Medicine (Medicine_ID, Name, Quantity, Cost) VALUES
('M001', 'Amoxicillin', 100, 10.00),
('M002', 'Ibuprofen', 200, 5.00);

INSERT INTO Appointment (Appt_ID, Patient_ID, Dentist_ID, Date, Time, Status) VALUES
('A001', 'P001', 'U001', '2025-04-02', '10:00:00', 'Scheduled'),
('A002', 'P002', 'U001', '2025-04-03', '11:30:00', 'Completed');

INSERT INTO Procedure_Record (Record_ID, Patient_ID, Appointment_ID, Tooth_No, Treatment_ID, Notes) VALUES
('PR001', 'P001', 'A001', '12', 'T002', 'Routine cleaning'),
('PR002', 'P002', 'A002', '15', 'T001', 'Wisdom tooth extraction');

INSERT INTO Prescription (Prescription_ID, Patient_ID, Dentist_ID, Date) VALUES
('RX001', 'P002', 'U001', '2025-04-03');

INSERT INTO Prescription_Medicine (Prescription_ID, Medicine_ID, Dosage) VALUES
('RX001', 'M001', '500mg twice a day'),
('RX001', 'M002', '400mg once a day');

INSERT INTO Insurance (Insurance_ID, Patient_ID, Provider, Plan, Policy_No, Expiry_Date) VALUES
('INS001', 'P001', 'Delta Dental', 'Gold', 'DD123456', '2026-01-01'),
('INS002', 'P002', 'MetLife', 'Basic', 'ML654321', '2025-10-15');

INSERT INTO Bill (Bill_ID, Patient_ID, Total_Amount, Paid, Date) VALUES
('B001', 'P001', 80.00, TRUE, '2025-04-02'),
('B002', 'P002', 120.00, FALSE, '2025-04-03');

INSERT INTO Xray_Record (Xray_ID, Patient_ID, Dentist_ID, Image_Path, Date_Taken, Tooth_No, Notes) VALUES
('XR001', 'P001', 'U001', 'images/xray1.jpg', '2025-04-02 09:45:00', '12', 'Pre-cleaning check'),
('XR002', 'P002', 'U001', 'images/xray2.jpg', '2025-04-03 11:00:00', '15', 'Impacted molar');

