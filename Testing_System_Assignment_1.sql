CREATE DATABASE IF NOT EXISTS Testing_system;
USE testing_system;

/*
Create table department
*/
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
CONSTRAINT FOREIGN KEY fk_account_department(DepartmentID) REFERENCES department(DepartmentID),
PositionID TINYINT,
CONSTRAINT FOREIGN KEY fk_account_position(PositionID) REFERENCES `position`(PositionID),
CreateDate DATE NOT NULL
);

CREATE TABLE `group`(
GroupID TINYINT PRIMARY KEY AUTO_INCREMENT,
GroupName VARCHAR(50) NOT NULL UNIQUE,
CreatorID TINYINT,
CONSTRAINT FOREIGN KEY fk_group_account(AccountID) REFERENCES `account`(AccountID),
CreateDate DATE NOT NULL
);

CREATE TABLE `groupaccount`(
GroupID TINYINT,
CONSTRAINT FOREIGN KEY fk_groupaccount_group(GroupID) REFERENCES `group`(GroupID),
AccountID SMALLINT, 
CONSTRAINT FOREIGN KEY fk_groupaccount_account(AccountID) REFERENCES `account`(AccountID),
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
CONSTRAINT FOREIGN KEY fk_question_categoryquestion(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
TypeID TINYINT,
CONSTRAINT FOREIGN KEY fk_question_typequestion(TypeID) REFERENCES `TypeQuestion`(TypeID),
CreatorID TINYINT,
CONSTRAINT FOREIGN KEY fk_question_account(AccountID) REFERENCES `account`(AccountID),
CreateDate DATE NOT NULL
);

CREATE TABLE `Answer`(
AnswerID SMALLINT PRIMARY KEY AUTO_INCREMENT,
Content TEXT NOT NULL,
QuestionID TINYINT,
CONSTRAINT FOREIGN KEY fk_answer_question(QuestionID) REFERENCES `Question`(QuestionID),
isCorrect BOOLEAN NOT NULL
);

CREATE TABLE `Exam`(
ExamID SMALLINT PRIMARY KEY AUTO_INCREMENT,
`Code` VARCHAR(30),
Title VARCHAR (50) NOT NULL,
CategoryID TINYINT,
CONSTRAINT FOREIGN KEY fk_exam_categoryquestion(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
Duration TINYINT NOT NULL,
CreatorID TINYINT,
CONSTRAINT FOREIGN KEY fk_exam_account(AccountID) REFERENCES `account`(AccountID),
CreateDate DATE NOT NULL
);

CREATE TABLE `examquestion`(
ExamID SMALLINT,
CONSTRAINT FOREIGN KEY fk_examquestion_exam(ExamID) REFERENCES `exam`(ExamID),
QuestionID TINYINT,
CONSTRAINT FOREIGN KEY fk_examquestion_question(QuestionID) REFERENCES `Question`(QuestionID)
);
