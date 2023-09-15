CREATE DATABASE Suwapiyasa;
USE Suwapiyasa;

/*creating tables of the database*/
CREATE TABLE Staff(
emp_num INT PRIMARY KEY UNIQUE,
name VARCHAR(100),
gender VARCHAR(10),
address VARCHAR(100),
telephone_num VARCHAR(100)
);

SELECT * FROM Staff;

CREATE TABLE Doctor(
doc_id INT PRIMARY KEY UNIQUE,
speciality VARCHAR(100),
HD_num INT,
salary DECIMAL(10,2),
FOREIGN KEY (doc_id) REFERENCES Staff(emp_num),
FOREIGN KEY (HD_num) REFERENCES Doctor(doc_id) /*recursive relationship of the head doctor to doctor*/
);

CREATE TABLE Nurse(
nurse_id INT PRIMARY KEY UNIQUE,
year_of_experience INT,
grade VARCHAR(10),
surgery_skill_type VARCHAR(50),
salary DECIMAL (10,2),
FOREIGN KEY (nurse_id) REFERENCES Staff(emp_num)
);

CREATE TABLE Surgeon(
surgeon_id INT PRIMARY KEY UNIQUE,
speciality VARCHAR(100),
type_of_contract VARCHAR(100),
length_of_contract INT,
FOREIGN KEY (surgeon_id) REFERENCES Staff(emp_num)
);

CREATE TABLE Patient(
patient_id INT PRIMARY KEY UNIQUE,
surname VARCHAR(100),
initials VARCHAR(100),
age INT,
address VARCHAR(100),
telephone_num VARCHAR(50),
allergies VARCHAR(100),
blood_type VARCHAR(10),
doc_id INT,
FOREIGN KEY (doc_id) REFERENCES Doctor(doc_id)
);

SELECT * FROM Patient;

CREATE TABLE Surgery(
patient_id INT UNIQUE,
surgery_name VARCHAR(100),
date DATE,
time TIME,
special_needs VARCHAR(100),
catogery VARCHAR (100), 
theater INT,
surgeon_id INT,
nurse_id INT,
PRIMARY KEY (patient_id, surgery_name),/*has a composite primary key*/
FOREIGN KEY (surgeon_id) REFERENCES Surgeon(surgeon_id),
FOREIGN KEY (nurse_id) REFERENCES Nurse (nurse_id),
FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Medication(
code INT PRIMARY KEY UNIQUE ,
name VARCHAR(100),
quantity_on_hand INT,
quantity_ordered INT,
cost DECIMAL(10,2),
exp_date DATE
);

CREATE TABLE Patient_Medication(
code INT UNIQUE,
patient_id INT,
severity_interacrion VARCHAR(100),
FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY (code) REFERENCES Medication(code)
);

CREATE TABLE Location(
bed_num INT,
room_num INT,
nursing_unit INT,
patient_id INT,
PRIMARY KEY( bed_num, room_num),
FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

/*populating the tables*/
INSERT INTO Staff (emp_num, name, gender, address, telephone_num)
VALUES
(1, 'Samantha Perera', 'Male', '123 Galle Road, Colombo', '071 123 4567'),
(2, 'Kumari Silva', 'Female', '456 Kandy Road, Kandy', '071 987 6543'),
(3, 'Ravi Fernando', 'Male', '789 Negombo Road, Negombo', '077 555 7890'),
(4, 'Nilanka Rajapaksa', 'Male', '987 Anuradhapura Road, Anuradhapura', '077 666 4444'),
(5, 'Shanika Gunawardana', 'Female', '54 Colombo Road, Gampaha', '071 555 2222'),
(6, 'Chamara Rathnayake', 'Male', '745 Kandy Road, Galle', '077 666 3333'),
(7, 'Nayomi Senanayake', 'Female', '111 Matara Road, Matara', '076 777 4444'),
(8, 'Asanka Perera', 'Male', '678 Kurunegala Road, Kurunegala', '072 666 7777'),
(9, 'Aruni De Silva', 'Female', '987 Batticaloa Road, Batticaloa', '077 555 3333'),
(10, 'Ramesh Ranasinghe', 'Male', '555 Trincomalee Road, Trincomalee', '070 777 2222');

SELECT * FROM Staff;

INSERT INTO Doctor (doc_id,speciality, HD_num, salary)/*troublr*/
VALUES
( 3,'Cardiology', 3, 200000),
( 8,'Neurology', 3, 150000),
( 9,'Oncology', 3,250000);
SELECT * FROM Doctor;

INSERT INTO Nurse (nurse_id,year_of_experience, grade, surgery_skill_type,salary )
VALUES
(5, 2,'Junior', 'General Surgery', 100000),
(3, 5,'Senior' ,'Cardiac Surgery', 120000),
(2, 7,'Senior' ,'Orthopedic Surgery',90000);

SELECT * FROM Nurse;

INSERT INTO Surgeon (surgeon_id, speciality, type_of_contract, length_of_contract)
VALUES
(4, 'Cardiothoracic Surgery', 'Full-time', 3),
(10, 'Cardiac Surgery', 'Part-time', 2);

SELECT * FROM Surgeon;

INSERT INTO Patient (patient_id, surname, initials, age, address, telephone_num, allergies, blood_type, doc_id)
VALUES
(501, 'Silva', 'A. B.', 45, '123 Galle Road, Colombo', '071 123 4567', 'Penicillin', 'O+', 3),
(502, 'Fernando', 'K. L.', 32, '456 Kandy Road, Kandy', '070 987 6543', 'Sulfonamides', 'A-', 8),
(503, 'Perera', 'S. T.', 28, '789 Negombo Road, Negombo', '077 555 7890', 'Aspirin', 'B+', 3),
(504, 'Rajapaksa', 'N. R.', 50, '987 Anuradhapura Road, Anuradhapura', '071 666 4444', 'None', 'AB+', 9),
(505, 'Gunawardana', 'S. D.', 19, '54 Colombo Road, Gampaha', '077 555 2222', 'Pollen', 'A+', 3),
(506, 'Rathnayake', 'C. G.', 38, '745 Kandy Road, Galle', '070 666 3333', 'Dust', 'B-', 9),
(507, 'Senanayake', 'N. R.', 55, '111 Matara Road, Matara', '076 777 4444', 'Latex', 'O-', 8),
(508, 'Perera', 'A. M.', 63, '678 Kurunegala Road, Kurunegala', '078 666 7777', 'Peanuts', 'O+', 3),
(509, 'De Silva', 'A. D.', 41, '987 Batticaloa Road, Batticaloa', '077 555 3333', 'Penicillin', 'AB-', 9),
(510, 'Ranasinghe', 'R. K.', 27, '555 Trincomalee Road, Trincomalee', '071 777 2222', 'None', 'B+', 8);

SELECT * FROM Patient;

INSERT INTO Surgery (patient_id, surgery_name, date, time, special_needs, catogery, theater, surgeon_id,nurse_id) 
VALUES
(501, 'Heart Bypass Surgery', '2023-08-06', '09:30:00', 'None', 'Cardiac Surgery', 1, 4, 5),
(502, 'Appendectomy', '2023-08-08', '14:15:00', 'None', 'General Surgery', 2, 10,3),
(504, 'Gallbladder Removal', '2023-08-09', '11:00:00', 'None', 'General Surgery', 1, 4, 2),
(508, 'Cataract Surgery', '2023-08-18', '08:00:00', 'None', 'Ophthalmic Surgery', 1, 10,5),
(510, 'Appendectomy', '2023-08-20', '09:30:00', 'None', 'General Surgery', 2, 10,2);

SELECT * FROM Surgery;

INSERT INTO Medication (code, name, quantity_on_hand, quantity_ordered, cost, exp_date)
VALUES
(1001, 'Paracetamol', 100, 50, 50, '2024-07-31'),
(1002, 'Amoxicillin', 75, 25, 80, '2023-12-15'),
(1003, 'Aspirin', 200, 100, 20, '2023-09-30'),
(1004, 'Omeprazole', 50, 30, 65, '2023-11-22'),
(1005, 'Ibuprofen', 120, 60, 35, '2024-05-10'),
(1006, 'Cetirizine', 90, 40, 15, '2023-10-18'),
(1007, 'Lisinopril', 30, 10, 40, '2024-03-28'),
(1008, 'Atorvastatin', 80, 35, 70, '2024-08-05'),
(1009, 'Metformin', 60, 25, 25, '2023-09-15'),
(1010, 'Simvastatin', 40, 20, 60, '2024-06-12');

SELECT * FROM Medication;

INSERT INTO Patient_Medication (code, patient_id, severity_interacrion)
VALUES
(1001, 501, 'Low'),
(1003, 503, 'Moderate'),
(1005, 505, 'Low'),
(1006, 506, 'Low'),
(1010, 510, 'Moderate'),
(1004, 504, 'Moderate'),
(1007, 507, 'High');

SELECT * FROM Patient_Medication;
  
INSERT INTO Location (bed_num, room_num, nursing_unit, patient_id)
VALUES
(11, 201, 1, 501),
(12, 201, 1, 502),
(13, 202, 1, 503),
(14, 203, 1, 504),
(15, 203, 1, 505);

SELECT * FROM Location;

/*Q1 – 721426276*/
CREATE VIEW PatientSurgeryInfo
AS SELECT p.patient_id, CONCAT(p.initials," ",p.surname) AS patient_name,
CONCAT(l.bed_num,"-" ,l.room_num) AS location,
s.surgery_name,s.date
FROM
Patient p 
INNER JOIN Surgery s ON p.patient_id = s.patient_id
INNER JOIN Location l ON p.patient_id = l.patient_id;

SELECT * FROM PatientSurgeryInfo;

/*Q2 – 721426276*/
CREATE TABLE MedInfo (
MedName VARCHAR(100) PRIMARY KEY,
QuantityAvailable INT,
ExpirationDate DATE
);


/*Q2.1 – 721426276*/
DELIMITER //
CREATE TRIGGER Insert_Medication
AFTER 
INSERT ON Medication 
FOR EACH ROW
BEGIN
INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
VALUES (NEW.name, NEW.quantity_on_hand, NEW.exp_date);
END;
//
DELIMITER ;

-- checking the functionality of the trigger
INSERT INTO Medication(code, name, quantity_on_hand, quantity_ordered, cost, exp_date)
VALUES
(1011, 'Ibuprofen', 150, 75, 25, '2024-08-15');

SELECT * FROM MedInfo;

/*Q2.2 – 721426276*/
DELIMITER //
CREATE TRIGGER Update_Medication
AFTER UPDATE ON Medication
FOR EACH ROW
BEGIN
UPDATE MedInfo
SET QuantityAvailable = NEW.quantity_on_hand, ExpirationDate = NEW.exp_date
WHERE MedName = NEW.name;
END;
//
DELIMITER ;

-- checking the update_medication trigger
UPDATE Medication
SET quantity_on_hand = 100
WHERE code = 1011;

SELECT * FROM MedInfo;


/*Q2.3 – 721426276*/
DELIMITER //
CREATE TRIGGER Delete_Medication
AFTER 
DELETE ON Medication 
FOR EACH ROW
BEGIN
DELETE FROM MedInfo
WHERE MedName = OLD.name;
END;
//
DELIMITER ;

-- checking the delete medication trigger
DELETE FROM Medication
WHERE code = 1011;

SELECT * FROM MedInfo;

/*Q3 – 721426276*/
DELIMITER //
CREATE PROCEDURE GetMedicationsTaken(IN patient_id INT, INOUT medications_taken INT)
BEGIN
SELECT COUNT(*) INTO medications_taken
FROM Patient_Medication
WHERE patient_id = patient_id;
END;
//
DELIMITER ;

SET @output := 0;
CALL GetMedicationsTaken(501, @output);
SELECT @output AS medications_taken;

/*Q4 – 721426276*/
DELIMITER //
CREATE FUNCTION Remaining_Days(exp_date DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
RETURN DATEDIFF(exp_date, CURDATE());
END;
//
DELIMITER ;

/*to get the medication with 30 days */
SELECT m.code,m.name,m.cost,m.exp_date, Remaining_Days(m.exp_date) AS days_remaining
FROM Medication m
WHERE Remaining_Days(m.exp_date)  <=30;


/*Q5 was written in the mysql commend line and it is included in the report*/










  

  











