-- Create the Hospital Database
CREATE DATABASE HospitalManagementSystem;
GO

-- Use the Hospital Database
USE HospitalManagementSystem;
GO

-- Create Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    PhoneNumber NVARCHAR(15),
    Email NVARCHAR(100),
    Address NVARCHAR(255)
);
GO

-- Create Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Specialization NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Email NVARCHAR(100),
    JoinDate DATE NOT NULL
);
GO

-- Create Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Scheduled', -- Status: Scheduled, Completed, Cancelled
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
GO

-- Create MedicalRecords Table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Diagnosis NVARCHAR(255) NOT NULL,
    Treatment NVARCHAR(255),
    Prescription NVARCHAR(255),
    RecordDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
GO

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);
GO

-- Create DoctorDepartment Table (Many-to-Many Relationship between Doctors and Departments)
CREATE TABLE DoctorDepartment (
    DoctorID INT NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY (DoctorID, DepartmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- Create Rooms Table
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    RoomNumber NVARCHAR(10) NOT NULL,
    RoomType NVARCHAR(50) NOT NULL, -- e.g., General Ward, ICU, Operation Theater
    Status NVARCHAR(20) NOT NULL DEFAULT 'Available' -- Status: Available, Occupied
);
GO

-- Create Admissions Table
CREATE TABLE Admissions (
    AdmissionID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    RoomID INT NOT NULL,
    AdmissionDate DATE NOT NULL,
    DischargeDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);
GO

-- Create Billing Table
CREATE TABLE Billing (
    BillID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    AdmissionID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaymentStatus NVARCHAR(20) NOT NULL DEFAULT 'Pending', -- Status: Pending, Paid
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AdmissionID) REFERENCES Admissions(AdmissionID)
);
GO