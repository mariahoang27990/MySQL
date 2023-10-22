--- Create database Testing System 3 ----

CREATE DATABASE IF NOT EXISTS Testing_system2;
USE testing_system2;

/*
Create table department
*/
DROP TABLE IF EXISTS department;
CREATE TABLE department (
DepartmentID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
DepartmentName VARCHAR(50) NOT NULL UNIQUE KEY
);

/*
Create table position
*/
DROP TABLE IF EXISTS position;
CREATE TABLE `position`(
PositionID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
PositionName ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);
ALTER TABLE position MODIFY COLUMN PositionName ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master', 'Tester');

/*
Create table account
*/
DROP TABLE IF EXISTS account;
CREATE TABLE `account`(
AccountID MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Email VARCHAR(50) NOT NULL UNIQUE,
Username VARCHAR(50) NOT NULL UNIQUE, 
FullName VARCHAR(50) NOT NULL,
DepartmentID TINYINT UNSIGNED,
PositionID SMALLINT UNSIGNED ,
CreateDate DATETIME NOT NULL,
CONSTRAINT fk_account_department FOREIGN KEY (DepartmentID) REFERENCES department(DepartmentID),
CONSTRAINT fk_account_position FOREIGN KEY (PositionID) REFERENCES `position`(PositionID)
);

/*
Create table group
*/
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
GroupID MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
GroupName VARCHAR(50) NOT NULL UNIQUE,
CreatorID MEDIUMINT UNSIGNED,
CONSTRAINT fk_group_account FOREIGN KEY (CreatorID) REFERENCES `account`(AccountID),
CreateDate DATETIME NOT NULL
);

/*
Create table groupaccount
*/
DROP TABLE IF EXISTS `groupaccount`;
CREATE TABLE `groupaccount`(
GroupID MEDIUMINT UNSIGNED,
CONSTRAINT fk_groupaccount_group FOREIGN KEY(GroupID) REFERENCES `group`(GroupID),
AccountID MEDIUMINT UNSIGNED, 
CONSTRAINT fK_groupaccount_account FOREIGN KEY (AccountID) REFERENCES `account`(AccountID),
JointDate DATETIME DEFAULT NOW()
);

/*
Create table TypeQuestion
*/
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE `TypeQuestion`(
TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName VARCHAR(50) NOT NULL 
);

/*
Create table CategoryQuestion
*/
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE `CategoryQuestion`(
CategoryID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CategoryName ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS', 'HTML', 'CSS', 'JavaScript')
);

/*
Create table Question
*/
DROP TABLE IF EXISTS Question;
CREATE TABLE `Question`(
QuestionID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Content TEXT NOT NULL,
CategoryID TINYINT UNSIGNED,
CONSTRAINT fk_question_categoryquestion FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
TypeID TINYINT UNSIGNED,
CONSTRAINT fK_question_typequestion FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID),
CreatorID MEDIUMINT UNSIGNED,
CONSTRAINT fK_question_account FOREIGN KEY(CreatorID) REFERENCES `account`(AccountID),
CreateDate DATETIME NOT NULL
);

/*
Create table Answer
*/
DROP TABLE IF EXISTS Answer;
CREATE TABLE `Answer`(
AnswerID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Content TEXT NOT NULL,
QuestionID TINYINT UNSIGNED,
CONSTRAINT fk_answer_question FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID),
isCorrect BOOLEAN NOT NULL
);

/*
Create table Exam
*/
DROP TABLE IF EXISTS Exam;
CREATE TABLE `Exam`(
ExamID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`Code` VARCHAR(30) NOT NULL,
Title VARCHAR (50) NOT NULL,
CategoryID TINYINT UNSIGNED,
CONSTRAINT fk_exam_categoryquestion FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
Duration  TINYINT,
CreatorID MEDIUMINT UNSIGNED,
CONSTRAINT fk_exam_account FOREIGN KEY (CreatorID) REFERENCES `account`(AccountID),
CreateDate DATETIME NOT NULL
);

/*
Create table Examquestion
*/
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE `examQuestion`(
ExamID SMALLINT UNSIGNED,
CONSTRAINT fk_examquestion_exam FOREIGN KEY (ExamID) REFERENCES `exam`(ExamID),
QuestionID TINYINT UNSIGNED,
CONSTRAINT fk_examquestion_question FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

--------- INSERT DATA TO DATABASE TESTING SYSTEM ------


-- Table department
INSERT INTO department 	(DepartmentName)
	VALUES 	('Phong Ke Toan'),
			('Phong Ky Thuat'),
			('Phong Dev 1'),
			('Phong Dev 2'),
			('Phong Sale'),
			('Phong Marketing'),
			('Phong Giam Doc'),
			('Phong Tai Chinh')
;
-- Table position
INSERT INTO position (PositionName)
	VALUES	('Dev1'),
			('Dev2'),
			('Tester'),
			('PM'),
			('Leader'),
			('Scrum Master'),
            ('Accountant'),
            ('Marketing Executive')
;
-- Table account
INSERT INTO `account` (Email, Username, Fullname, DepartmentID, PositionID, CreatedDate)
	VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
		   ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
		   ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
		   ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
		   ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
		   ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
		   ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Thất Tùng', 3, 3, '2020-10-01'),
		   ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
		   ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
		   ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
		   ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01'),
           ('vti_account12@vtiacademy.com', 'account_vti2', 'Nguyen Phong Lam', 2, 5, '2021-09-17'),
            ('vti_account13@vtiacademy.com', 'account_vti13', 'Tai khoan 13', NULL, 3, '2020-12-08'),
           ('vti_account14@vtiacademy.com', 'account_vti14', 'Tai khoan 14', NULL, 5, '2021-08-22')
;

-- ALTER TABLE `account` DROP CONSTRAINT fk_account_department;

INSERT INTO `account` (Email, Username, Fullname, DepartmentID, PositionID, CreatedDate)
	VALUES ('vti_account15@vtiacademy.com', 'vti14', 'Nguyen Tan Tai', 5, 2, '2021-2-01'),
		   ('vti_account16@vtiacademy.com', 'vti15', 'Luu Duc Hoa', 6, 1, '2021-07-01')
;

-- group
INSERT INTO `group` (GroupName, CreatorID, CreatedDate)
	VALUES ('Nhom 1', '3', '2021-04-03'),
		   ('Nhom 2', '3', '2019-01-03'),
		   ('Nhom 3', '2', '2020-04-03'),
		   ('Nhom 4', '1', NOW()),
		   ('Nhom 5', '3', '2021-06-03'),
		   ('Nhom 6', '1', '2020-04-03'),
		   ('Nhom 7', '5', '2021-04-03'),
		   ('Nhom 8', '5', '2019-05-03'),
		   ('Nhom 9', '3', '2019-01-03'),
		   ('Nhom 10', '1', NOW())
;

-- groupaccount
INSERT INTO groupaccount (GroupID, AccountID, JoinDate)
	VALUES ('1', '1', '2021-06-01'),
		   ('1', '3', '2020-01-01'),
		   ('1', '2', NOW()),
		   ('1', '4', '2021-06-01'),
		   ('2', '1', '2021-06-01'),
		   ('2', '10', '2019-05-01'),
		   ('5', '1', '2021-06-01'),
		   ('5', '3', '2020-01-01'),
		   ('5', '4', '2021-07-01'),
		   ('3', '1', '2021-06-01'),
		   ('9', '2', '2021-06-01'),
		   ('10', '1', NOW())
;

-- typequestion
INSERT INTO typequestion (TypeName)
VALUES ('Trac nghiem'),
       ('Tu Luan')
;

-- categoryquestion
INSERT INTO CategoryQuestion (CategoryName)
	VALUES ('Java'),
		   ('SQL'),
		   ('HTML'),
		   ('CSS '),
		   ('.NET'),
		   ('Python'),
		   ('Ruby'),
		   ('JavaScript')
;

-- question
INSERT INTO `question` (Content, CategoryID, TypeID, CreatorID, CreatedDate)
	VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
		   ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
		   ('Câu hỏi JAVA 1', 1, 1, 10, '2019-07-01'),
		   ('Câu hỏi JAVA 2', 1, 2, 5, '2018-06-01'),
		   ('Câu hỏi HTML 1', 3, 1, 2, NOW()),
		   ('Câu hỏi HTML 2', 3, 2, 2, NOW())
;

-- exam
INSERT INTO answer (Content, QuestionID, IsCorrect)
	VALUES ('Câu trả lời 1 - question SQL 1', 1, 1),
		   ('Câu trả lời 2 - question SQL 1', 1, 0),
		   ('Câu trả lời 3 - question SQL 1', 1, 0),
		   ('Câu trả lời 4 - question SQL 1', 1, 1),
		   ('Câu trả lời 1 - question SQL 2', 2, 0),
		   ('Câu trả lời 2 - question SQL 2', 2, 0),
		   ('Câu trả lời 3 - question SQL 2', 2, 0),
		   ('Câu trả lời 4 - question SQL 2', 2, 1),
		   ('Câu trả lời 1 - question JAVA 1', 3, 0),
		   ('Câu trả lời 2 - question JAVA 1', 3, 1),
		   ('Câu trả lời 1 - question JAVA 2', 4, 0),
		   ('Câu trả lời 2 - question JAVA 2', 4, 0),
		   ('Câu trả lời 3 - question JAVA 2', 4, 0),
		   ('Câu trả lời 4 - question JAVA 2', 4, 1),
		   ('Câu trả lời 1 - question HTML 1', 5, 1),
		   ('Câu trả lời 2 - question HTML 2', 5, 0)
;

-- exam
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreatedDate)
	VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
		   ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
		   ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
		   ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
		   ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
		   ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
		   ('MS_07', 'De thi 07', 1, 60, 1, NOW())
;

INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreatedDate)
	VALUES ('MS_08', 'De thi 08', 1, 90, 1, '2019-08-30'),
		   ('MS_09', 'De thi 09', 1, 60, 5, '2018-12-25'),
		   ('MS_10', 'De thi 10', 2, 60, 7, '2020-02-05')
;

-- examquestion
	-- Drop constraint foreign key before insert data

ALTER TABLE examquestion DROP FOREIGN KEY fk_examquestion_exam;
ALTER TABLE examquestion DROP FOREIGN KEY fk_examquestion_question;

INSERT INTO examquestion
	VALUES (1, 1),
		   (2, 1),
		   (3, 1),
		   (4, 1),
		   (5, 2),
		   (6, 2),
		   (7, 2),
		   (8, NULL),
		   (9, 3),
		   (10, 3),
		   (11, 4),
		   (12, 4),
		   (NULL, 4),
		   (14, 4),
		   (NULL, 5),
		   (16, 5)
;
