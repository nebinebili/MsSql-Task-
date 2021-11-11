--8. Kitabxananın bütün ziyarətçilərini və onların götürdüyü kitabları çıxarın.

SELECT Students.FirstName,Students.LastName,Books.Name  FROM Libs INNER JOIN S_Cards
ON Libs.Id=S_Cards.Id_Lib INNER JOIN Students
ON Id_Student=Students.Id INNER JOIN Books
ON Id_Book=Books.Id
GROUP BY Students.FirstName,Students.LastName,Books.Name
UNION ALL
SELECT Teachers.FirstName,Teachers.LastName,Books.Name  FROM Libs INNER JOIN T_Cards
ON Libs.Id=T_Cards.Id_Lib INNER JOIN Teachers
ON Id_Teacher=Teachers.Id INNER JOIN Books
ON Id_Book=Books.Id
GROUP BY Teachers.FirstName,Teachers.LastName,Books.Name

--9. Studentlər arasında ən məşhur author(lar) və onun(ların) götürülmüş kitablarının sayını çıxarın.
SELECT TOP(1) WITH TIES Authors.FirstName,COUNT(Authors.FirstName) AS Popular,Books.Name AS BookName
FROM Students INNER JOIN S_Cards
ON Students.Id=S_Cards.Id_Student INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id
GROUP BY Authors.FirstName,Books.Name
ORDER BY Popular DESC

--10.Muellimler arasında ən məşhur author(lar) və onun(ların) götürülmüş kitablarının sayını çıxarın.

SELECT TOP(1) WITH TIES Authors.FirstName,COUNT(Authors.FirstName) AS Popular,Books.Name AS BookName
FROM Teachers INNER JOIN T_Cards
ON Teachers.Id=T_Cards.Id_Teacher INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id
GROUP BY Authors.FirstName,Books.Name
ORDER BY Popular DESC

--11. Student və Teacherlər arasında ən məşhur mövzunu(ları) çıxarın.

SELECT TOP(1) WITH TIES Authors.FirstName,COUNT(Authors.FirstName) Popular,Themes.Name AS ThemesName
FROM Students INNER JOIN S_Cards
ON Students.Id=S_Cards.Id_Student INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id INNER JOIN Themes
ON Themes.Id=Books.Id_Themes
GROUP BY Authors.FirstName,Themes.Name
ORDER BY Popular DESC
GO
SELECT TOP(1) WITH TIES Authors.FirstName,COUNT(Authors.FirstName) Popular,Themes.Name AS ThemesName
FROM Teachers INNER JOIN T_Cards
ON Teachers.Id=T_Cards.Id_Teacher INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id INNER JOIN Themes
ON Themes.Id=Books.Id_Themes
GROUP BY Authors.FirstName,Themes.Name
ORDER BY Popular DESC

--12. Kitabxanaya neçə tələbə və neçə müəllim gəldiyini ekrana çıxarın.

SELECT  COUNT(DISTINCT Students.Id) AS StudentCount,(SELECT COUNT(DISTINCT Teachers.Id)
FROM Libs INNER JOIN T_Cards ON Libs.Id=T_Cards.Id_Lib INNER JOIN Teachers ON Id_Teacher=Teachers.Id) AS TeacherCount 
FROM Libs INNER JOIN S_Cards ON Libs.Id=S_Cards.Id_Lib INNER JOIN Students ON Id_Student=Students.Id 

--13.Əgər bütün kitabların sayını 100% qəbul etsək, siz hər fakultənin neçə faiz kitab götürdüyünü hesablamalısınız.
SELECT Faculties.Name,COUNT(Faculties.Name)*100/14 FROM Faculties INNER JOIN Groups
ON Groups.Id_Faculty=Faculties.Id INNER JOIN Students
ON Groups.Id=Students.Id_Group INNER JOIN S_Cards
ON S_Cards.Id_Student=Students.Id INNER JOIN Books
ON Books.Id=S_Cards.Id_Book 
GROUP BY Faculties.Name

--14. Ən çox oxunulan fakultə və dekanatlığı ekrana çıxarın
SELECT TOP(1) Faculties.Name AS FacultyName,
(SELECT TOP(1) Departments.Name AS DepartmentName
FROM Departments INNER JOIN Teachers
ON Departments.Id=Teachers.Id_Dep
GROUP BY Departments.Name
ORDER BY COUNT(Departments.Name) DESC) AS DepartmentName
FROM Faculties INNER JOIN Groups
ON Faculties.Id=Groups.Id_Faculty INNER JOIN Students
ON Students.Id_Group=Groups.Id
GROUP BY Faculties.Name
ORDER BY COUNT(Faculties.Name) DESC

--15. Tələbələr və müəllimlər arasında ən məşhur authoru çıxarın

SELECT TOP(1) Authors.FirstName AS AuthorForStudent,
(SELECT TOP(1) Authors.FirstName
FROM Teachers INNER JOIN T_Cards
ON Teachers.Id=T_Cards.Id_Teacher INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id
GROUP BY Authors.FirstName
ORDER BY COUNT(Authors.FirstName) DESC) AS AuthorForTeacher
FROM Students INNER JOIN S_Cards
ON Students.Id=S_Cards.Id_Student INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id
GROUP BY Authors.FirstName
ORDER BY COUNT(Authors.FirstName) DESC

--16.Müəllim və Tələbələr arasında ən məşhur kitabların adlarını çıxarın.

SELECT TOP(1) Books.Name AS StudentBook,
(SELECT TOP(1) Books.Name
FROM Teachers INNER JOIN T_Cards
ON Teachers.Id=T_Cards.Id_Teacher INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id
GROUP BY Books.Name
ORDER BY COUNT(Books.Name) DESC) AS TeacherBook
FROM Students INNER JOIN S_Cards
ON Students.Id=S_Cards.Id_Student INNER JOIN Books
ON Id_Book=Books.Id INNER JOIN Authors
ON Id_Author=Authors.Id
GROUP BY Books.Name
ORDER BY COUNT(Books.Name) DESC

--17. Dizayn sahəsində olan bütün tələbə və müəllimləri ekrana çıxarın.

SELECT DISTINCT Students.Id,Students.FirstName,Students.LastName FROM Faculties INNER JOIN Groups
ON Faculties.Id=Groups.Id_Faculty INNER JOIN Students
ON Groups.Id=Students.Id_Group INNER JOIN S_Cards
ON Students.Id=S_Cards.Id_Student
WHERE  Faculties.Name='Web Design'
UNION ALL
SELECT DISTINCT Teachers.Id,Teachers.FirstName,Teachers.LastName FROM Departments INNER JOIN Teachers
ON Departments.Id=Teachers.Id_Dep INNER JOIN T_Cards
ON T_Cards.Id_Teacher=Teachers.Id
WHERE Departments.Name='Graphics and Designs'

--18. Kitab götürən tələbə və müəllimlər haqqında informasiya çıxarın

SELECT Students.Id,Students.FirstName,Students.LastName FROM Libs INNER JOIN S_Cards
ON Libs.Id=S_Cards.Id_Lib INNER JOIN Students
ON Id_Student=Students.Id INNER JOIN Books
ON Id_Book=Books.Id
UNION ALL
SELECT Teachers.Id,Teachers.FirstName,Teachers.LastName  FROM Libs INNER JOIN T_Cards
ON Libs.Id=T_Cards.Id_Lib INNER JOIN Teachers
ON Id_Teacher=Teachers.Id INNER JOIN Books
ON Id_Book=Books.Id


--19. Müəllim və şagirdlərin cəmi neçə kitab götürdüyünü ekrana çıxarın.

SELECT  COUNT(*) AS CountStudentsBook,
(SELECT COUNT(*)  FROM Libs INNER JOIN T_Cards
ON Libs.Id=T_Cards.Id_Lib INNER JOIN Teachers
ON Id_Teacher=Teachers.Id INNER JOIN Books
ON Id_Book=Books.Id)AS CountTeachersBook
FROM Libs INNER JOIN S_Cards
ON Libs.Id=S_Cards.Id_Lib INNER JOIN Students
ON Id_Student=Students.Id INNER JOIN Books
ON Id_Book=Books.Id

--20. Hər kitbxanaçının (libs) neçə kitab verdiyini ekrana çıxarın

SELECT Libs.FirstName,
((SELECT COUNT(*) 
FROM S_Cards
WHERE S_Cards.Id_Lib = Libs.Id
GROUP BY S_Cards.Id_Lib) +
(SELECT COUNT(*) 
FROM T_Cards
WHERE T_Cards.Id_Lib = Libs.Id
GROUP BY T_Cards.Id_Lib)) AS Total
FROM Libs