CREATE DATABASE IF NOT EXISTS Testing_system;
USE testing_system;

/*
Create table department
*/
DROP TABLE IF EXISTS department;
CREATE TABLE department (
DepartmentID TINYINT PRIMARY KEY AUTO_INCREMENT,
DepartmentName VARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE `position`(
PositionID SMALLINT PRIMARY KEY AUTO_INCREMENT,
PositionName VARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE `account`(
AccountID SMALLINT PRIMARY KEY AUTO_INCREMENT,
Email VARCHAR(50) NOT NULL UNIQUE,
Username VARCHAR(50) NOT NULL UNIQUE, 
FullName VARCHAR(50) NOT NULL,
DepartmentID TINYINT,
PositionID SMALLINT,
CreateDate DATE NOT NULL,
foreign key (departmentid) references department(departmentid),
foreign key (PositionID) references `position`(PositionID)

);


CREATE TABLE `group`(
GroupID TINYINT PRIMARY KEY AUTO_INCREMENT,
GroupName VARCHAR(50) NOT NULL UNIQUE,
CreatorID SMALLINT,
 FOREIGN KEY (CreatorID) REFERENCES `account`(AccountID),
CreateDate DATE NOT NULL
);

CREATE TABLE `groupaccount`(
GroupID TINYINT,
 FOREIGN KEY(GroupID) REFERENCES `group`(GroupID),
AccountID SMALLINT, 
 FOREIGN KEY (AccountID) REFERENCES `account`(AccountID),
JointDate DATE NOT NULL
);

CREATE TABLE `TypeQuestion`(
TypeID TINYINT AUTO_INCREMENT PRIMARY KEY,
TypeName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `CategoryQuestion`(
CategoryID TINYINT PRIMARY KEY AUTO_INCREMENT,
CategoryName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `Question`(
QuestionID TINYINT PRIMARY KEY AUTO_INCREMENT,
Content TEXT NOT NULL,
CategoryID TINYINT,
 FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
TypeID TINYINT,
FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID),
CreatorID SMALLINT,
FOREIGN KEY(CreatorID) REFERENCES `account`(AccountID),
CreateDate DATE NOT NULL
);

CREATE TABLE `Answer`(
AnswerID SMALLINT PRIMARY KEY AUTO_INCREMENT,
Content TEXT NOT NULL,
QuestionID TINYINT,
 FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID),
isCorrect BOOLEAN NOT NULL
);

CREATE TABLE `Exam`(
ExamID SMALLINT PRIMARY KEY AUTO_INCREMENT,
`Code` VARCHAR(30),
Title VARCHAR (50) NOT NULL,
CategoryID TINYINT,
FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
Duration TINYINT NOT NULL,
CreatorID SMALLINT,
 FOREIGN KEY (CreatorID) REFERENCES `account`(AccountID),
CreateDate DATE NOT NULL
);

CREATE TABLE `examquestion`(
ExamID SMALLINT,
 FOREIGN KEY (ExamID) REFERENCES `exam`(ExamID),
QuestionID TINYINT,
 FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);


