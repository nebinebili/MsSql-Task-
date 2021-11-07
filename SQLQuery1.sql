--1. Hər Publisherin ən az səhifəli kitabını ekrana çıxarın

SELECT Press.Name,Books.Pages,Books.Name FROM Press INNER JOIN Books
ON Books.Id_Press=Press.Id
WHERE Pages<=ALL(SELECT  Pages FROM Books WHERE Books.Id_Press=Press.Id)

--2. Publisherin ümumi çap etdiyi kitabların orta səhifəsi 100dən yuxarıdırsa, o Publisherləri ekrana çıxarın.

SELECT AVG(Books.Pages) AS [Average Books Page],Press.Name FROM Press INNER JOIN Books
ON Books.Id_Press=Press.Id
GROUP BY Press.Name
HAVING AVG(Books.Pages)>100

--3.BHV və BİNOM Publisherlərinin kitabların bütün cəmi səhifəsini ekrana çıxarın

SELECT SUM(Books.Pages) AS [Sum Pages Books],Press.Name FROM Press INNER JOIN Books
ON Press.Id=Books.Id_Press
WHERE Press.Name='BHV' OR Press.Name='BINOM'
GROUP BY Press.Name

--4.Yanvarın 1-i 2001ci il və bu gün arasında kitabxanadan kitab götürən bütün tələbələrin adlarını ekrana çıxarın

SELECT * FROM Libs INNER JOIN S_Cards
ON Libs.Id=S_Cards.Id_Lib INNER JOIN Students
ON Id_Student=Students.Id
WHERE S_Cards.DateOut>'2001.01.1' AND S_Cards.DateOut<GETDATE()

--5. Olga Kokorevanın  "Windows 2000 Registry" kitabı üzərində işləyən tələbələri tapın
SELECT Students.* FROM S_Cards INNER JOIN Books
ON S_Cards.Id_Book=Books.Id INNER JOIN Students
ON Id_Student=Students.Id
WHERE Books.Name='Windows 2000 Registry'

--6. Yazdığı bütün kitabları nəzərə aldıqda, orta səhifə sayı 600dən çox olan Yazıçılar haqqında məlumat çıxarın.
SELECT Authors.Id,Authors.FirstName,Authors.LastName FROM Authors INNER JOIN Books
ON Books.Id_Author=Authors.Id
GROUP BY Authors.Id,Authors.FirstName,Authors.LastName
HAVING AVG(Books.Pages)>600

--7. Çap etdiyi bütün kitabların cəmi səhifə sayı 700dən çox olan Publisherlər haqqında ekrana məlumat çıxarın

SELECT Press.Name,Press.Id FROM Press INNER JOIN Books
ON Books.Id_Press=Press.Id
GROUP BY Press.Name,Press.Id
HAVING SUM(Books.Pages)>700