
-- Task 11. To deduce the most popular subjects (and) among students and teachers.

SELECT Themes.[Name] AS Subject, COUNT(*) AS Popularity
FROM T_Cards
JOIN Themes ON T_Cards.Id_Book = Themes.Id
GROUP BY Themes.[Name]





-- Task 12. Display the number of teachers and students who visited the library.

SELECT 'Teachers' AS Category, COUNT(*) AS Count
FROM T_Cards
UNION
SELECT 'Students' AS Category, COUNT(*) AS Count
FROM S_Cards;





-- Task 13. If you count the total number of books in the library for 100%, 
--then you need to calculate how many books (in percentage terms) each faculty took.

SELECT Faculties.[Name] AS Faculty, 
       COUNT(*) * 100.0 / 
       (SELECT COUNT(*) FROM Books) AS [Amount]
FROM Books
JOIN Groups ON Books.Id = Groups.Id_Faculty
JOIN Faculties ON Groups.Id_Faculty = Faculties.Id
GROUP BY Faculties.[Name];





-- Task 15. Show the author (s) of the most popular books among teachers and students.

SELECT Authors.FirstName, Authors.LastName, COUNT(*) AS BooksRead
FROM (
    SELECT T_Cards.Id_Book
    FROM T_Cards
    UNION ALL
    SELECT S_Cards.Id_Book
    FROM S_Cards
) AS CombinedCards
JOIN Books ON CombinedCards.Id_Book = Books.Id
JOIN Authors ON Books.Id_Author = Authors.Id
GROUP BY Authors.FirstName, Authors.LastName




-- Task 16. Display the names of the most popular books among teachers and students.

SELECT Books.[Name], COUNT(*) AS BooksRead
FROM (
    SELECT T_Cards.Id_Book
    FROM T_Cards
    UNION ALL
    SELECT S_Cards.Id_Book
    FROM S_Cards
) AS CombinedCards
JOIN Books ON CombinedCards.Id_Book = Books.Id
GROUP BY Books.[Name]





-- Task 17. Show all students and teachers of designers.

SELECT Students.FirstName AS FirstName, Students.LastName AS LastName, 
       Groups.[Name] AS GroupAndJob, 'Student' AS UserType
FROM Students
JOIN Groups ON Students.Id_Group = Groups.Id
UNION ALL
SELECT Teachers.FirstName, Teachers.LastName, 
       Departments.[Name] AS TeacherDepartment, 'Teacher' AS UserType
FROM Teachers
JOIN Departments ON Teachers.Id_Dep = Departments.Id;





-- Task 18. Show all information about students and teachers who have taken books.

SELECT Students.Id, Students.FirstName, Students.LastName, 
Groups.[Name], S_Cards.DateOut, S_Cards.DateIn, Books.[Name]
FROM Students
JOIN S_Cards ON Students.Id = S_Cards.Id_Student
JOIN Books ON S_Cards.Id_Book = Books.Id
JOIN Groups ON Students.Id_Group = Groups.Id
UNION ALL
SELECT Teachers.Id, Teachers.FirstName, Teachers.LastName, 
Departments.[Name], T_Cards.DateOut, T_Cards.DateIn, Books.[Name]
FROM Teachers
JOIN T_Cards ON Teachers.Id = T_Cards.Id_Teacher
JOIN Books ON T_Cards.Id_Book = Books.Id
JOIN Departments ON Teachers.Id_Dep = Departments.Id;




-- Task 19. Show books that were taken by both teachers and students.

SELECT Books.[Name], COUNT(DISTINCT S_Cards.Id_Student) AS StudentsCount,
COUNT(DISTINCT T_Cards.Id_Teacher) AS TeachersCount
FROM Books
LEFT JOIN S_Cards ON Books.Id = S_Cards.Id_Book
LEFT JOIN T_Cards ON Books.Id = T_Cards.Id_Book
GROUP BY Books.[Name]




-- Task 20. Show how many books each librarian issued.

SELECT Libs.FirstName, Libs.LastName, COUNT(*) AS Issue
FROM Libs
JOIN S_Cards ON Libs.Id = S_Cards.Id_Lib
GROUP BY Libs.FirstName, Libs.LastName;


