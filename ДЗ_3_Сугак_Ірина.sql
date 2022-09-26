--  !!! В выходной выборке должны присутствовать только запрашиваемые в условии поля.

-- 1. Напишите один запрос с использованием псевдонимов для таблиц и псевдонимов полей,
--    выбирающий все возможные комбинации городов (CITY) из таблиц
--    STUDENTS, LECTURERS и UNIVERSITIES
--    строки не должны повторяться, убедитесь в выводе только уникальных троек городов
--    Внимание: убедитесь, что каждая колонка выборки имеет свое уникальное имя

SELECT DISTINCT ST.CITY AS S_CI
   , LE.CITY AS L_CI
   , UN.CITY AS U_CI
FROM STUDENTS AS ST, LECTURERS AS LE, UNIVERSITIES AS UN

-- 2. Напишите запрос для вывода полей в следущем порядке: семестр, в котором он
--    читается, идентификатора (номера ID) предмета обучения, его наименования и
--    количества отводимых на этот предмет часов для всех строк таблицы SUBJECTS

-- ORDER BY задає сортування рядків, а в умові сказано про порядок стовпців. Його не можна зробити за допомогою ORDER BY.
-- Просто в SELECT не зірочку, а перераховуєш стовці через кому у необхідному порядку

SELECT SEMESTER, ID, NAME, HOURS
FROM SUBJECTS
 

-- 3. Выведите все строки таблицы EXAM_MARKS, в которых предмет обучения SUBJ_ID равен 4

SELECT * FROM EXAM_MARKS
WHERE SUBJ_ID = 4

-- 4. Необходимо выбирать все данные, в следующем порядке
--    Стипендия, Курс, Фамилия, Имя  из таблицы STUDENTS, причем интересуют
--    студенты, родившиеся после '1993-07-21'

SELECT STIPEND, COURSE, SURNAME, NAME FROM STUDENTS
WHERE BIRTHDAY > '1993-07-21'
ORDER BY STIPEND, COURSE, SURNAME, NAME

-- 5. Вывести на экран все предметы: их наименования и кол-во часов для каждого из них
--    в 1-м семестре и при этом кол-во часов не должно превышать 41

SELECT NAME, HOURS 
FROM SUBJECTS
WHERE SEMESTER = 1 AND HOURS <= 41


-- 6. Напишите запрос, позволяющий вывести из таблицы EXAM_MARKS уникальные
--    значения экзаменационных оценок, которые были получены '2012-06-12'

SELECT DISTINCT MARK
FROM EXAM_MARKS
WHERE EXAM_DATE IN ('2012-06-12')

-- 7. Выведите список фамилий студентов, обучающихся на третьем и последующих
--    курсах и при этом проживающих не в Киеве, не Харькове и не Львове.

SELECT SURNAME
FROM STUDENTS
WHERE COURSE >= 3 
AND CITY NOT IN ('Киев, Харьков, Львов')



-- 8. Покажите данные о фамилии, имени и номере курса для студентов,
--    получающих стипендию в диапазоне от 450 до 650, не включая
--    эти граничные суммы. Приведите несколько вариантов решения этой задачи.

SELECT SURNAME, NAME, COURSE
FROM STUDENTS
WHERE STIPEND > 450 AND STIPEND < 650

-- Варіант 2 - ні, в тебе попадають 450 та 650 у результат, а не мають

SELECT SURNAME, NAME, COURSE
FROM STUDENTS
WHERE STIPEND BETWEEN 450 AND 650 
      AND STIPEND NOT IN (450, 650)

-- 9. Напишите запрос, выполняющий выборку из таблицы LECTURERS всех фамилий
--    преподавателей, проживающих во Львове, либо же преподающих в университете
--    с идентификатором 14

SELECT SURNAME
FROM LECTURERS
WHERE CITY = 'Львов' OR UNIV_ID = 14

-- 10. Выясните в каких городах (названия) расположены университеты,
--     рейтинг которых находится в диапазоне 528 +/- 47 баллов.

SELECT CITY
FROM UNIVERSITIES
WHERE RATING BETWEEN 528 - 47 AND 528 + 47

-- 11. Отобрать список фамилий киевских студентов, их имен и дат рождений
--     для всех нечетных курсов.

-- like не рекомендовано застосовувати до чисел, будемо вивчати. Краще просто перерахувати в IN(

SELECT *
FROM STUDENTS
WHERE CITY = 'Киев' 
      AND COURSE IN (1, 3, 5, 7, 9)

-- 12. Упростите выражение фильтрации (избавтесь от NOT) и дайте логическую формулировку запроса?
-- SELECT * FROM STUDENTS WHERE (STIPEND < 500 OR NOT (BIRTHDAY >= '1993-01-01' AND ID > 9))
-- Подсказка: после упрощения, запрос должен возвращать ту же выборку, что и оригинальный

-- не зовсім вірно. 
--      Все, що знаходиться у дужках з NOT() має підлягати інверсії. Інверсія це зміна знаків на протилежні, а також AND на OR та навпаки.
--      > змінюємо на <= та навпаки
--      < змінюємо на  >= та навпаки
-- Ще треба надати логічне формулювання, тобто словами описати що саме вибирає запит

SELECT * FROM STUDENTS 
WHERE STIPEND < 500 OR BIRTHDAY < '1993-01-01' OR ID <= 9

-- Обрати із таблиці STUDENTS записи студентів, у яких стипендія менше 500 або ж дата народження передує '1993-01-01' або ж ID не перевищує 9


-- 13. Упростите выражение фильтрации (избавтесь от NOT) и дайте логическую формулировку запроса?
-- SELECT * FROM STUDENTS WHERE NOT ((BIRTHDAY = '1993-06-07' OR STIPEND > 500) AND ID >= 9)
-- Подсказка: после упрощения, запрос должен возвращать ту же выборку, что и оригинальный
-- AND ID >= 9 - це теж треба інвертувати, тому що NOT () відноситься до всіх умов - подивитись на дужки.

SELECT * FROM STUDENTS 
WHERE  BIRTHDAY <> '1993-06-07' AND STIPEND <= 500 OR ID < 9 

--  Обрати із таблиці STUDENTS записи студентів, які народились не '1993-01-01', і в яких стипендія не перевищує 500, а також ID менше 9.

