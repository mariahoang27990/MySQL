DROP DATABASE IF EXISTS java_exam;
CREATE DATABASE java_exam;
USE java_exam;

DROP TABLE IF EXISTS User;
CREATE TABLE `User`(
	Id 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	FullName 	VARCHAR(50) NOT NULL,
    Email 		VARCHAR(50) UNIQUE KEY NOT NULL,
    Password	VARCHAR(12) DEFAULT '123456',
    ExpInYear	TINYINT UNSIGNED ,
    ProjectId	SMALLINT UNSIGNED ,
    ProSkill	VARCHAR(50),
    Role		ENUM('MANAGER', 'EMPLOYEE', 'ADMIN') DEFAULT 'EMPLOYEE'
);



INSERT INTO User 	(FullName				, Email							, Password				, ExpInYear			, ProSkill			, ProjectId			, Role) 
VALUES 				
-- Insert Manager
					('Lê Thị Mầu'			,'lethimau@vti.com.vn'			, 'maulethi'			, '5'				, NULL				, '2'				, 'MANAGER'),
                    ('Tô Văn Khiêm'			,'tovankhiem@vti.com.vn'		, 'khiemtovan'			, '10'				, NULL				, '1'				, 'MANAGER'),
                    ('Hồ Tùng Mậu'			,'hotungmau@vti.com.vn'			, 'mauhotung'			, '7'				, NULL				, '3'				, 'MANAGER'),
                    
-- Insert employees                    
                    ('Võ Kim Ngân	'		,'vokimngan@vti.com.vn'			, 'nganvokim'			, NULL				, 'test'			, '1'				, 'EMPLOYEE'),
                    ('Lương Định Của'		,'luongdinhcua@vti.com.vn'		, 'cualuongdinh'		, NULL				, 'dev'				, '2'				, 'EMPLOYEE'),
                    ('Trần Mã Não'			,'tranmanao@vti.com.vn'			, 'naotranma'			, NULL				, 'test'			, '2'				, 'EMPLOYEE'),
                    ('Cao An Phú'			,'caoanphu@vti.com.vn'			, 'phucaoan'			, NULL				, 'csharp'			, '3'				, 'EMPLOYEE'),
                    ('Hồ Xuân Hương'		,'hoxuanhuong@vti.com.vn'		, 'huonghoxuan'			, NULL				, 'html'			, '3'				, 'EMPLOYEE'),
                    ('Cao Văn Lầu'			,'caovanlau@vti.com.vn'			, 'laucaovan'			, NULL				, 'css'				, '2'				, 'EMPLOYEE'),
					('Nguyễn Ái Linh'		,'nguyenailinh@vti.com.vn'		, 'linhnguyenai'		, NULL				, 'dev'				, '1'				, 'EMPLOYEE'),
					('Hoàng Hoa Thám'		,'hoanghoatham@vti.com.vn'		, 'thamhoanghoa'		, NULL				, 'csharp'			, '1'				, 'EMPLOYEE'),
                    ('Trương Lâm'			,'truonglam@vti.com.vn'			, 'lamtruong'			, NULL				, 'dev'				, '3'				, 'EMPLOYEE');