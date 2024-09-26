CREATE DATABASE QUANLYDIEMTHI;
USE QUANLYDIEMTHI;
CREATE TABLE Student(
studentId VARCHAR(4) PRIMARY KEY NOT NULL,
studentName VARCHAR(100) NOT NULL,
birthday DATE NOT NULL,
gender BIT(1) NOT NULL,
address TEXT NOT NULL,
phoneNumber VARCHAR(45)
);
INSERT INTO Student VALUES 
('S001','Nguyễn Thế Anh','1999-01-11',1,'Hà Nội','0984678082'),
('S002','Đặng Bảo Trân','1998-12-22',0,'Lào Cai','0904982654'),
('S003','Trần Hà Phương','2000-05-05',0,'Nghệ An','0947645363'),
('S004','Đỗ Tiến Mạnh','1999-03-26',1,'Hà Nội','0983665353'),
('S005','Phạm Duy Nhất','1998-10-04',1,'Tuyên Quang','0987242678'),
('S006','Mai Văn Thái','2002-06-22',1,'Nam Định','0982654268'),
('S007','Giang Gia Hân','1996-11-10',0,'Phú Thọ','0982364753'),
('S008','Nguyễn Ngọc Bảo My','1999-01-22',0,'Hà Nam','0927867453'),
('S009','Nguyễn Tiến Đạt','1998-08-07',1,'Tuyên Quang','0989274673'),
('S010','Nguyễn Thiều Quang','2000-09-18',1,'Hà Nội','0984378291');

CREATE TABLE Subject(
subjectId VARCHAR(4) PRIMARY KEY NOT NULL,
subjectName VARCHAR(45) NOT NULL,
priority INT NOT NULL
);
INSERT INTO Subject VALUES
('MH01','Toán',2),
('MH02','Vật lý',2),
('MH03','Hoá học',1),
('MH04','Ngữ văn',1),
('MH05','Tiếng Anh',2);
CREATE TABLE Mark(
subjectId VARCHAR(4) NOT NULL REFERENCES Subject(subjectId) ,
studentId VARCHAR(4) NOT NULL REFERENCES Student(studentId),
point DOUBLE  NOT NULL,
PRIMARY KEY (subjectId,studentId)
);

INSERT INTO Mark() VALUES
('MH01','S001',8.5),
('MH01','S002',9),
('MH01','S003',7.5),
('MH01','S004',6),
('MH01','S005',5.5),
('MH01','S006',8),
('MH01','S007',9.5),
('MH01','S008',10),
('MH01','S009',7.5),
('MH01','S010',6.5),

('MH02','S001',7),
('MH02','S002',8),
('MH02','S003',6.5),
('MH02','S004',7),
('MH02','S005',8),
('MH02','S006',10),
('MH02','S007',9),
('MH02','S008',8.5),
('MH02','S009',7),
('MH02','S010',8),

('MH03','S001',9),
('MH03','S002',6.5),
('MH03','S003',8),
('MH03','S004',5),
('MH03','S005',7.5),
('MH03','S006',9),
('MH03','S007',6),
('MH03','S008',8.5),
('MH03','S009',9),
('MH03','S010',5.5),

('MH04','S001',9),
('MH04','S002',8),
('MH04','S003',7),
('MH04','S004',6.5),
('MH04','S005',8.5),
('MH04','S006',7.5),
('MH04','S007',9),
('MH04','S008',6),
('MH04','S009',5),
('MH04','S010',4),

('MH05','S001',5),
('MH05','S002',6),
('MH05','S003',7),
('MH05','S004',8),
('MH05','S005',9),
('MH05','S006',6.5),
('MH05','S007',4),
('MH05','S008',9.5),
('MH05','S009',10),
('MH05','S010',7);

-- ---------------------
DROP VIEW IF EXISTS STUDENT_;
CREATE VIEW STUDENT_ AS
SELECT 
studentId AS 'Mã Sinh Viên',
studentName AS 'Tên Sinh Viên',
birthday  AS 'Ngày Sinh',
CASE 
	WHEN gender = 0 THEN 'Nữ'
	WHEN gender = 1 THEN 'Nam'
END AS 'Giới Tính',
address AS 'Quê Quán',
phoneNumber AS 'Số Điện Thoại'
FROM Student;


SELECT * FROM STUDENT_;
-- ---------------------
DROP VIEW IF EXISTS SUBJECT_;
CREATE VIEW SUBJECT_ AS
SELECT 
subjectId AS 'Mã môn học',
subjectName AS 'Tên môn học',
priority AS 'Hệ số'
FROM Subject;

SELECT * FROM SUBJECT_;
-- ---------------------
DROP VIEW IF EXISTS MARK_;
CREATE VIEW MARK_ AS
SELECT 
    studentId AS ID,
    studentName AS 'Học Sinh',
    MAX(CASE WHEN Mark.subjectId = 'MH01' THEN point END) AS 'Điểm Toán',
    MAX(CASE WHEN Mark.subjectId = 'MH02' THEN point END) AS 'Điểm Lý',
    MAX(CASE WHEN Mark.subjectId = 'MH03' THEN point END) AS 'Điểm Hoá',
    MAX(CASE WHEN Mark.subjectId = 'MH04' THEN point END) AS 'Điểm Ngữ Văn',
    MAX(CASE WHEN Mark.subjectId = 'MH05' THEN point END) AS 'Điểm Tiếng Anh',
    SUM(point) AS 'Tổng Điểm',
    AVG(point) AS AVG
FROM Mark
LEFT JOIN Student USING (studentId) 
GROUP BY studentId;

SELECT * FROM MARK_;
-- ---------------------
-- 2. Cập nhật dữ liệu [10 điểm]:
-- Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.
UPDATE Student
SET studentName = 'Đỗ Đức Mạnh'
WHERE studentId = 'S004';
SELECT * FROM Student;
-- Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
UPDATE Subject
SET subjectName = 'Ngoại Ngữ',priority = 1
WHERE subjectId = 'MH05';
SELECT * FROM Subject;
-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05: 9).
UPDATE Mark SET point= 8.5 WHERE studentId = 'S009' AND subjectId = 'MH01';
UPDATE Mark SET point= 7 WHERE studentId = 'S009' AND subjectId = 'MH02';
UPDATE Mark SET point= 5.5 WHERE studentId = 'S009' AND subjectId = 'MH03';
UPDATE Mark SET point= 6 WHERE studentId = 'S009' AND subjectId = 'MH04';
UPDATE Mark SET point= 9 WHERE studentId = 'S009' AND subjectId = 'MH05';
SELECT * FROM Mark;
SELECT * FROM MARK_;

-- 3. Xoá dữ liệu[10 điểm]:
-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
DELETE FROM Mark WHERE studentId = 'S010';
SELECT * FROM Mark;

DELETE FROM Student WHERE studentId = 'S010';
SELECT * FROM Student;

SELECT * FROM MARK_;

-- Bài 3: Truy vấn dữ liệu [25 điểm]:
-- 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student . [4 điểm]
SELECT * FROM Student;

-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1. [4 điểm]
SELECT subjectId,subjectName FROM Subject
WHERE priority= 1;

-- 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
-- năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh. [4 điểm]
SELECT studentId, studentName, 2024 - YEAR(birthday) AS Age, 
CASE
WHEN gender = 0 THEN 'Nữ'
WHEN gender = 1 THEN 'Nam'
END AS gender,
address
FROM Student;

-- 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
-- Toán và sắp xếp theo điểm giảm dần. [4 điểm]
select * from Mark;

select Student.studentName, Subject.subjectName, Mark.point FROM Mark
LEFT JOIN Student USING(studentId) 
LEFT JOIN Subject USING(subjectId)
WHERE Subject.subjectName = 'Toán'
ORDER BY point DESC;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng). [4 điểm]
SELECT 
CASE 
	WHEN gender = 0 THEN 'Nữ'
	WHEN gender = 1 THEN 'Nam'
END AS Gender,
COUNT(studentId) AS Total
FROM Student
GROUP BY gender;

-- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
-- để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình. [5 điểm]
DROP VIEW IF EXISTS MARK_;
CREATE VIEW MARK_ AS
SELECT 
    studentId AS ID,
    studentName AS Student,
    gender,
    address,
    MAX(CASE WHEN Mark.subjectId = 'MH01' THEN point END) AS 'Điểm Toán',
    MAX(CASE WHEN Mark.subjectId = 'MH02' THEN point END) AS 'Điểm Lý',
    MAX(CASE WHEN Mark.subjectId = 'MH03' THEN point END) AS 'Điểm Hoá',
    MAX(CASE WHEN Mark.subjectId = 'MH04' THEN point END) AS 'Điểm Ngữ Văn',
    MAX(CASE WHEN Mark.subjectId = 'MH05' THEN point END) AS 'Điểm Tiếng Anh',
    SUM(point) AS SUM,
    AVG(point) AS AVG
FROM Mark
LEFT JOIN Student USING (studentId) 
GROUP BY studentId;

SELECT * FROM MARK_;

SELECT ID,Student,SUM,AVG FROM MARK_;

-- Bài 4: Tạo View, Index, Procedure [20 điểm]:
-- 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán . [3 điểm]
DROP VIEW IF EXISTS STUDENT_VIEW;
CREATE VIEW STUDENT_VIEW AS
SELECT Student.studentId,Student.studentName,
CASE
WHEN gender = 0 THEN 'Nữ'
WHEN gender = 1 THEN 'Nam'
END AS Gender,
address
FROM Student;

SELECT * FROM STUDENT_VIEW;

-- 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
-- điểm trung bình các môn học . [3 điểm]
SELECT * FROM MARK_;
DROP VIEW IF EXISTS AVERAGE_MARK_VIEW;
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT ID,Student,AVG 
FROM MARK_;

SELECT * FROM AVERAGE_MARK_VIEW;

-- 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT. [2 điểm]
CREATE INDEX idx_student_phone ON Student (phoneNumber);

-- 4. Tạo các PROCEDURE sau:
-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông
-- tin học sinh đó. [3 điểm]
DELIMITER $$
CREATE PROCEDURE PROC_INSERTSTUDENT(
IN studentId_new varchar(4), 
IN studentName_new varchar(100), 
IN birthday_new date,
IN gender_new bit(1),
IN address_new text,
IN phoneNumber_new varchar(45)
)
BEGIN
   INSERT INTO Student VALUES
   (studentId_new,studentName_new,birthday_new,gender_new,address_new,phoneNumber_new);
END $$
DELIMITER ;

CALL PROC_INSERTSTUDENT ('S010','Nguyễn Thiều Quang','2000-09-18',1,'Hà Nội','0984378291');

SELECT * FROM Student;
-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học. [3điểm]
DELIMITER $$
CREATE PROCEDURE PROC_UPDATESUBJECT(IN id_subject varchar(4),IN subjectName_new varchar(45))
BEGIN
   UPDATE Subject
   SET subjectName = subjectName_new
   WHERE subjectId = id_subject;
END $$
DELIMITER ;

SELECT * FROM Subject;
CALL PROC_UPDATESUBJECT('MH05', 'Tiếng Anh')

-- Tạo PROC_DEL dùng để xoá toàn bộ điểm các môn học theo mã học sinh.
DELIMITER $$
CREATE PROCEDURE PROC_DEL(IN id_student varchar(4) )
BEGIN
   DELETE FROM Mark WHERE studentId = id_student;
END $$
DELIMITER ;

CALL PROC_DEL('S010');
SELECT * FROM Mark;
