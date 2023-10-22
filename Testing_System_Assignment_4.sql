-- Cấu trúc của Select
--  select
-- from t1
-- join t2 on( )
-- where
-- group by
-- order by 
-- having  

-- Question 1:

select * 
from `account` ac inner join department dp on (dp.DepartmentID = ac.DepartmentID);

-- Question 2:
select *
from account where createddate > '2010-12-20';

-- Question 3:
select *
from account ac join position po on (ac.positionID = po.positionID)
where positionName = "Dev1" or positionName = "Dev2";

-- Cách làm khác
select *
from account ac join position po on (ac.positionID = po.positionID)
where positionName in ("Dev1","Dev2");
-- Cách làm khác
select *
from account ac join position po on (ac.positionID = po.positionID)
where positionName like "Dev%";

-- Question 4:
Select dp.departmentID, dp.departmentName,count(*)
from department dp join account ac on (dp.departmentID = ac.departmentID)
group by dp.departmentID
having count(*) > 3;

-- Question 5:
select qu.questionID, qu.*, count(*) 
from Question qu
join categoryquestion ca on(qu.CategoryID=ca.CategoryID)
join Exam ex on (ca.CategoryID = ex.CategoryID)
group by qu.questionID;





 
select qu.questionID, qu.*, count(*) 
from Question qu
join categoryquestion ca on(qu.CategoryID=ca.CategoryID)
join Exam ex on (ca.CategoryID = ex.CategoryID)
group by qu.questionID 
having count(*) = (select max(tem.co)
						from 
						(select ex.CategoryID, count(*) co
						from exam ex 
						group by ex.CategoryID 
						) tem
					);

-- Question 6:
select ca.CategoryID, ca.*, count(*)
from categoryQuestion ca
join Question qu on (ca.CategoryID = qu.CategoryID)
group by ca.CategoryID;

select qu.*
from question qu

-- Question 7:
select qu.questionID, qu.*, count(*) 
from Question qu
join categoryquestion ca on(qu.CategoryID=ca.CategoryID)
join Exam ex on (ca.CategoryID = ex.CategoryID)
group by qu.questionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select qu.questionID, qu.*, count(*)
from question qu join answer an on (qu.questionID = an.questionID)
group by qu.questionID;


select max(tem.co)
from 
(select qu.questionID, qu.content, count(*) co
from question qu join answer an on (qu.questionID = an.questionID)
group by qu.questionID 
) tem;

 
select qu.questionID, qu.*, count(*)
from question qu join answer an on (qu.questionID = an.questionID)
group by qu.questionID 
having count(*) = (select max(tem.co)
						from 
						(select an.questionID, count(*) co
						from answer an 
						group by an.questionID 
						) tem
					);
                    
-- Question 9: Thống kê số lượng account trong mỗi group


select gr.groupID, gr.groupname, count(ac.accountID)
from account ac 
	join groupaccount gra on (ac.AccountID = gra.AccountID)
	join testing_system.group gr on (gra.GroupID = gr.GroupID)
group by gr.groupID;



select gr.groupID, gr.groupname, count(ac.accountID)
from account ac
	, groupaccount gra
    , testing_system.group gr
where ac.AccountID = gra.AccountID
	and gra.GroupID = gr.GroupID
group by gr.groupID;

-- Question 10 : Tìm chức vụ có ít người nhất
select po.positionID, po.positionName, count(*)
from position po
join account ac on (ac.positionID = po.positionID)
Group by po.positionID 
Having count(*) = (select min(tabtem.cnv)
					from (select po.positionID, po.positionName, count(*) cnv
						from position po
						join account ac on (ac.positionID = po.positionID)
						Group by po.positionID
					) tabtem
                    );

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
select *
select dp.departmentID, dp.departmentName, po.positionID, po.positionName,count(po.positionName)
from `account` ac
	join position po on (ac.positionID = po.positionID)
	join department dp on (ac.departmentID = dp.departmentID)
    group by po.positionID, dp.departmentID
    order by dp.departmentID
-- cách làm khác hiển thị cả những chức vụ không có nhân viên
select 
	d.DepartmentID, 
    d.DepartmentName,
	(select count(*) from position p left join account a on a.PositionID = p.PositionID where a.DepartmentID = d.DepartmentID and p.PositionID = 1) as SoNV_Dev, 
	(select count(*) from position p left join account a on a.PositionID = p.PositionID where a.DepartmentID = d.DepartmentID and p.PositionID = 2) as SoNV_test, 
	(select count(*) from position p left join account a on a.PositionID = p.PositionID where a.DepartmentID = d.DepartmentID and p.PositionID = 3) as SoNV_SM, 
	(select count(*) from position p left join account a on a.PositionID = p.PositionID where a.DepartmentID = d.DepartmentID and p.PositionID = 4) as SoNV_PM
from department d;    
    
-- Question 12: 
-- Lấy ra thông tin tất cả nhân viên thuộc phòng Tester



WITH Account_CTE AS(
SELECT ac.DepartmentID, ac.AccountID, ac.Fullname, ac.Email, dp.DepartmentName
FROM `account` ac
JOIN department dp ON dp.DepartmentID = ac.DepartmentID
)SELECT Fullname, Email, DepartmentName FROM Account_CTE;
    
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
select qu.questionID, ac.FullName, qu.content, ty.TypeName, qu.CreatorID, an.content
from question qu
join TypeQuestion ty on (qu.TypeID = Ty.TypeID)
join Answer an on (qu.questionID = an.questionID) AND isCorrect = "true"
join Account ac on (qu.creatorID = ac.accountID);

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select ty.TypeName, count(*)
from question qu
join TypeQuestion ty on (qu.TypeID = ty.TypeID)
group by ty.TypeName;


-- Question 14: Lấy ra group không có account nào
select * 
from `group` gr
left join `groupaccount` ga on (gr.GroupID = ga.GroupID)
where ga.accountID is null;


-- Question 15: Lấy ra question không có answer nào
select * 
from answer an 
right join question qu on (an.questionID = qu.questionID)
where an.answerID is null;

-- Excersise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
select *
from `account` ac
join groupaccount ga on (ac.accountID = ga.accountID)
where ga.groupID = "1";
-- b) Lấy các account thuộc nhóm thứ 2
select *
from `account` ac
join groupaccount ga on (ac.accountID = ga.accountID)
where ga.groupID = "2";
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select *
from `account` ac
join groupaccount ga on (ac.accountID = ga.accountID)
where ga.groupID = "1"
union
select *
from `account` ac
join groupaccount ga on (ac.accountID = ga.accountID)
where ga.groupID = "2";
-- Cách làm khác sử dụng "OR" lồng vào điều kiện
select *
from `account` ac
join groupaccount ga on (ac.accountID = ga.accountID)
where ga.groupID = "2" or ga.groupID = "1"	

-- Question 18:
-- a) Lấy các group có lớn hơn 2 thành viên
Select gr.groupID, count(ga.accountID)
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) > 2; 


-- b) Lấy các group có nhỏ hơn 4 thành viên
Select gr.groupID, count(ga.accountID)
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) < 4;
-- c) Ghép 2 kết quả từ câu a) và câu b)	
Select gr.groupID, count(ga.accountID)
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) > 2
union
Select gr.groupID, count(ga.accountID)
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) < 4;
-- Để lấy những kết quả >2 và <4
Select gr.groupID, count(ga.accountID)
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) < 4 AND count(ga.accountID) > 2;

Select temp.groupID, SL
from 
(Select gr.groupID, count(ga.accountID) as SL
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) > 2
union all
Select gr.groupID, count(ga.accountID)
from `group` gr
join groupaccount ga on (gr.groupID = ga.groupID)
group by gr.groupID
having count(ga.accountID) < 4) as temp
group by temp.groupID, SL
having count(temp.groupID) = 2;
