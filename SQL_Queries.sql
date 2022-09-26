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

SELECT *
FROM STUDENTS
WHERE CITY = 'Киев' 
      AND COURSE IN (1, 3, 5, 7, 9)


-- 12. Упростите выражение фильтрации (избавтесь от NOT) и дайте логическую формулировку запроса?
-- SELECT * FROM STUDENTS WHERE (STIPEND < 500 OR NOT (BIRTHDAY >= '1993-01-01' AND ID > 9))
-- Подсказка: после упрощения, запрос должен возвращать ту же выборку, что и оригинальный

SELECT * FROM STUDENTS 
WHERE STIPEND < 500 OR BIRTHDAY < '1993-01-01' OR ID <= 9


-- 13. Упростите выражение фильтрации (избавтесь от NOT) и дайте логическую формулировку запроса?
-- SELECT * FROM STUDENTS WHERE NOT ((BIRTHDAY = '1993-06-07' OR STIPEND > 500) AND ID >= 9)
-- Подсказка: после упрощения, запрос должен возвращать ту же выборку, что и оригинальный
-- AND ID >= 9 - це теж треба інвертувати, тому що NOT () відноситься до всіх умов - подивитись на дужки.

SELECT * FROM STUDENTS 
WHERE  BIRTHDAY <> '1993-06-07' AND STIPEND <= 500 OR ID < 9 


-- 14. Составьте запрос для таблицы STUDENT таким образом, чтобы выходная таблица 
--    содержала один столбец типа varchar, содержащий последовательность разделенных 
--    символом ';' (точка с запятой) значений столбцов этой таблицы, и при этом 
--    текстовые значения должны отображаться прописными символами (верхний регистр), 
--    то есть быть представленными в следующем виде: 
--    1;КАБАНОВ;ВИТАЛИЙ;M;550;4;ХАРЬКОВ;01/12/1990;2.
--    ...
--    примечание: в выборку должны попасть студенты из любого города из 5 букв

select upper(concat(ID, ';', (SURNAME), ';', (NAME), ';',
              (GENDER), ';', cast(STIPEND as float), ';', COURSE,
			  ';', (CITY), ';', format(BIRTHDAY, 'dd/MM/yyyy'), ';', UNIV_ID)
			  ) as INFO
 from STUDENTS
       where len(city) = 5 

	  
-- 15. Составьте запрос для таблицы STUDENT таким образом, чтобы выходная таблица 
--    содержала всего один столбец в следующем виде: 
--    В.КАБАНОВ;местожительства-ХАРЬКОВ;родился-01.12.90
--    ...
--    примечание: в выборку должны попасть студенты, фамилия которых содержит вторую
--    букву 'е' и предпоследнюю букву 'и', либо же фамилия заканчивается на 'ц'

select left(NAME, 1) + '.' + upper(SURNAME) + ';' + 'местожительства-' + upper (CITY) 
            + ';' + 'родился-' + isnull(format(BIRTHDAY, 'dd.MM.yy'), 'unknown')
			as INFO
from STUDENTS
     where surname like '_е%и_' or surname like '%ц'


-- 16. Составьте запрос для таблицы STUDENT таким образом, чтобы выходная таблица 
--    содержала всего один столбец в следующем виде:
--    т.цилюрик;местожительства-Херсон; учится на IV курсе
--    ...
--    примечание: курс указать римскими цифрами (воспользуйтесь CASE), 
--    отобрать студентов, стипендия которых кратна 200

select concat(lower(left(NAME, 1)), '.', lower (SURNAME), ';', 'местожительства-', CITY, 
              ';', ' учится на '
			  , case COURSE
			  when 1 then 'I'
			  when 2 then 'II'
			  when 3 then 'III'
			  when 4 then 'IV'
			  when 5 then 'V'
			  end, ' курсе')
from STUDENTS
where STIPEND%200 = 0 


-- 17. Составьте запрос для таблицы STUDENT таким образом, чтобы выборка 
--    содержала столбец в следующего вида:
--     Нина Федосеева из г.Днепропетровск родилась в 1992 году
--     ...
--     Дмитрий Коваленко из г.Хмельницкий родился в 1993 году
--     ...
--     примечание: для всех городов, в которых более 8 букв

select NAME + ' ' + SURNAME + ' из г. ' + CITY + 
       case GENDER 
	   when 'f' then ' родилась в '
	   when 'm' then ' родился в '
	   end 
	   + isnull(format(BIRTHDAY, 'yyyy'), 'unknown') 
	   + ' году'
from STUDENTS
     where len(CITY) > 8


-- 18. Вывести фамилии, имена студентов и величину получаемых ими стипендий, 
--    при этом значения стипендий первокурсников должны быть увеличены на 17.5%

select SURNAME, NAME,
       case COURSE 
	   when 1 then STIPEND + STIPEND*0.175
	   else STIPEND
	   end as NEW_STIPEND
from STUDENTS


-- 19. Вывести наименования всех учебных заведений и их расстояния 
--    (придумать/нагуглить/взять на глаз) до Киева.

select Name
   , case NAME 
       when 'ЛПУ' then '553 км от Киева'
	   when 'ЛГУ' then '556 км от Киева'
	   when 'ХАИ' then '497 км от Киева'
	   when 'ДПИ' then '741 км от Киева'
	   when 'ДНТУ' then '741 км от Киева'
	   when 'ХНАДУ' then '481 км от Киева'
	   when 'ОНПУ' then '478 км от Киева'
	   when 'ТНТУ' then '472 км от Киева'
	   when 'ЗДИА' then '550 км от Киева'
	   when 'БНАУ' then '87 км от Киева'
	   when 'ХСХА' then '490 км от Киева'
	   else 'месторасположение в Киеве'
	 end as DISTANCE
from UNIVERSITIES


-- 20. Вывести все учебные заведения и их две последние цифры рейтинга.

select NAME, right(RATING, 2)
from UNIVERSITIES


-- 21. Составьте запрос для таблицы UNIVERSITY таким образом, чтобы выходная таблица 
--    содержала всего один столбец в следующем виде:
--    Код-1;КПИ-г.Киев;рейтинг относительно ДНТУ(501) +756
--    ...
--    Код-11;КНУСА-г.Киев;рейтинг относительно ДНТУ(501) -18
--    ...
--    примечание: рейтинг вычислить относительно ДНТУшного, а также должен 
--    присутствовать знак (+/-), рейтинг ДНТУ заранее известен = 501

select concat('Код-', ID, ';', NAME, '-г.', CITY, ';', ' рейтинг относительно ДНТУ(501) ',   
              case
			    when RATING > 501 then ' +'
			  end,
			  case 
			    when RATING > 501 then + (RATING - 501)
			    when RATING < 501 then - (501 - RATING)
			  end
			  )
	from UNIVERSITIES


-- 22. Составьте запрос для таблицы UNIVERSITY таким образом, чтобы выходная таблица 
--    содержала всего один столбец в следующем виде:
--    Код-1;КПИ-г.Киев;рейтинг состоит из 12 сотен
--    Код-2;КНУ-г.Киев;рейтинг состоит из 6 сотен
--    ...
--    примечание: в рейтинге необходимо указать кол-во сотен

select concat('Код-', ID, ';', NAME, '-г.'
             , CITY, ';', 'рейтинг состоит из '
			 , floor(RATING/100), ' сотен')
from UNIVERSITIES
-- 0. Отобразите для каждого из курсов количество парней и девушек.

select COURSE
       , count(case GENDER when 'f' then 1 end) CNT_F
	   , count(case GENDER when 'm' then 1 end) CNT_M
   from STUDENTS
group by COURSE


-- 23. Напишите запрос для таблицы EXAM_MARKS, выбирающий даты, для которых средний балл
--    находиться в диапазоне от 4.22 до 4.77. Формат даты для вывода на экран:
--    день месяц, например, 05 Jun

select format(EXAM_DATE, 'dd MMM') EXAM_DATE
       , avg(MARK) AVG_M
    from EXAM_MARKS
  group by EXAM_DATE 
having avg(MARK)  > 4.22  and avg(MARK)  < 4.77 


-- 24. Напишите запрос, выбирающий из таблицы EXAM_MARKS следующую информацию по каждому ИД студента:
--    - кол-во календарных дней, потраченных студентом на сессию.
--        Например, если первый экзамен был сдан 01.06, а последний 10.06, то потрачено 10 дней
--    - кол-во попыток сдачи экзаменов
--    - максимальную и минимальную оценки.
--    Примечание: функция DAY() для решения не подходит!

select STUDENT_ID, datediff(day, min(EXAM_DATE), max(EXAM_DATE)) + 1 as DAYS
	 , count(*) CNT_ATTEMPT 
	 , max(MARK) MAX_MARK,
	   min(MARK) MIN_MARK
  from EXAM_MARKS
group by STUDENT_ID 


-- 25. Покажите список идентификаторов студентов, которые имеют пересдачи.
--    Примечание: под пересдачей понимается ситуация, когда у одного и того же студента
--    по одному и тому же предмету есть более одной оценки

select STUDENT_ID
       , count(MARK) as ONCE_AGAIN
from EXAM_MARKS
group by STUDENT_ID, SUBJ_ID
having count(MARK) > 1


-- 26. Напишите запрос, отображающий список предметов обучения, вычитываемых за самый короткий
--    промежуток времени, отсортированный в порядке убывания семестров. Поле семестра в
--    выходных данных должно быть первым, за ним должны следовать наименование и
--    идент ификатор предмета обучения.

select SEMESTER, NAME, ID
   from SUBJECTS
  where HOURS = (select min(HOURS) from SUBJECTS)
order by SEMESTER desc


-- 27. Напишите запрос с подзапросом для получения данных обо всех положительных оценках(4, 5) Марины
--    Шуст (предположим, что ее персональный номер неизвестен), идентификаторов предметов и дат
--    их сдачи.

select MARK, SUBJ_ID, EXAM_DATE 
from EXAM_MARKS
where STUDENT_ID in (select ID 
                     from STUDENTS 
					where NAME = 'Марина' 
					and SURNAME = 'Шуст'
                    and  MARK >= 4
					)


-- 28. Покажите сумму баллов для каждой даты сдачи экзаменов, когда средний балл не равен
--    среднему арифметическому между максимальной и минимальной оценкой. Данные расчитать только
--    для студенток. Результат выведите в порядке убывания сумм баллов, а дату в формате dd/mm/yyyy.

select format(EXAM_DATE, 'dd/MM/yyyy') EXAM_DATE
     , sum(MARK) SUM_MARK
   from EXAM_MARKS
where STUDENT_ID in (select ID 
                     from STUDENTS 
					 where GENDER = 'f'
					)
     group by EXAM_DATE 
  having avg(MARK) <> (max(MARK) + min(MARK))/2
order by SUM_MARK desc


-- 29. Покажите имена и фамилии всех студентов, у которых средний балл по предметам
--    с идентификаторами 1 и 2 превышает средний балл этого же студента
--    по всем остальным предметам. Используйте конструкцию AVG(case...), либо коррелирующий подзапрос.
--    Примечание: может так оказаться, что по "остальным" предметам (не 1ый и не 2ой) не было
--    получено ни одной оценки, в таком случае принять средний бал за 0 - для этого можно
--    использовать функцию ISNULL().

select NAME, SURNAME
   from STUDENTS
      where ID in (select STUDENT_ID
                     from EXAM_MARKS
                   group by STUDENT_ID
having avg(case when SUBJ_ID in (1, 2) then MARK end) > isnull(avg(case when SUBJ_ID not in (1, 2) then MARK end), 0))


-- 30. Напишите запрос, выполняющий вывод общего суммарного и среднего баллов каждого
--    экзаменованого второкурсника, его идентификатор и кол-во полученных оценок при условии,
--    что он успешно сдал 3 и более предметов.

select STUDENT_ID, sum(MARK) SUM_M, avg(MARK) AVG_M, count(MARK) CNT_M
from EXAM_MARKS
     where STUDENT_ID in (select ID 
	                        from STUDENTS
						  where COURSE = 2)
    group by STUDENT_ID
having count(distinct case when MARK > 2 
             then SUBJ_ID
			 end) >= 3 
             
             
-- 31. Вывести названия всех предметов, средний балл которых превышает средний балл, полученный
--    студентами, обучающимися в университетах г. Днепр
--    Примечание: Используйте вложенные подзапросы.

select NAME from SUBJECTS
where ID in ( select SUBJ_ID from EXAM_MARKS
              group by SUBJ_ID
              having avg(MARK) > (select avg(MARK) 
     from EXAM_MARKS
 where STUDENT_ID in (select ID from STUDENTS
       where UNIV_ID in (select ID from UNIVERSITIES
		                 where CITY = 'Днепр'
			            ))))


-- 32. Напишите запрос с EXISTS, позволяющий вывести данные обо всех студентах, 
--    обучающихся в вузах с рейтингом не попадающим в диапазон от 488 до 571

select *
   from STUDENTS as s
 where exists (select * 
                     from UNIVERSITIES un
				    where RATING not between 488 and 571
					   and s.UNIV_ID = un.id
					)

					
-- 33. Напишите запрос с EXISTS, выбирающий всех студентов, для которых в том же городе, 
--    где живет и учится студент, существуют другие университеты, в которых он не учится.

select *
   from STUDENTS as stud
 where exists (select *
                  from UNIVERSITIES as un
			    where stud.CITY = un.CITY
				    and un.ID <> stud.UNIV_ID
				)
    and exists (select *
                  from UNIVERSITIES as un
			    where  un.ID = stud.UNIV_ID
				and stud.CITY = un.CITY
			    )

				
-- 34. Напишите запрос, выбирающий из таблицы SUBJECTS данные о названиях предметов обучения, 
--    экзамены по которым были хоть как-то сданы более чем 12 студентами, за первые 10 дней сессии. 
--    Используйте EXISTS. 
--    Примечание: при подсчете студент должен быть посчитан по каждому предмету только один раз

select Name 
   from SUBJECTS as sub
 where exists (select SUBJ_ID
				  from EXAM_MARKS as ex
				  where EXAM_DATE between (select min(exam_date)
				                       from EXAM_MARKS) and (select min(exam_date) + 9
				                                               from EXAM_MARKS)
				    and sub.ID = ex.SUBJ_ID
				  group by SUBJ_ID
				  having count(distinct student_id) > 12
				  )
 

-- 35. Напишите запрос EXISTS, выбирающий фамилии всех лекторов, преподающих в университетах
--    с рейтингом, превосходящим рейтинг всех харьковских университетов.

select *
   from LECTURERS as lec
where exists (select *
                  from UNIVERSITIES as uni
				where RATING > (select max(rating)
				                       from UNIVERSITIES
									 where CITY = 'Харьков'
				       and lec.UNIV_ID = uni.ID))
			
			
-- 36. Напишите 2 запроса, использующий ANY и ALL, выполняющий выборку данных о студентах, 
--    у которых в городе их постоянного местожительства нет университета.

select * 
   from STUDENTS
 where not CITY  = any (select CITY 
                     from UNIVERSITIES)

select * 
   from STUDENTS
 where CITY  <> all (select CITY 
                     from UNIVERSITIES)


-- 37. Напишите запрос выдающий имена и фамилии студентов, которые получили
--    максимальные оценки в первый или последний день сессии.
--    Подсказка: выборка должна содержать по крайне мере 2х студентов.

select NAME, SURNAME 
  from STUDENTS
 where id in (select max(MARK) 
                  from EXAM_MARKS
				where EXAM_DATE = (select min(exam_date) 
				                     from EXAM_MARKS)
		      )
  union 
select NAME, SURNAME 
  from STUDENTS
 where id in (select max(MARK) 
                  from EXAM_MARKS
				where EXAM_DATE = (select max(exam_date) 
				                     from EXAM_MARKS)
		       )
	

-- 38. Напишите запрос EXISTS, выводящий кол-во студентов каждого курса, которые успешно 
--    сдали экзамены, и при этом не получивших ни одной двойки.

select course, count(*) as cnt_stud
    from STUDENTS as stud
 where exists (select *
                   from EXAM_MARKS as em
				where MARK > 2
				  and stud.id = em.student_id)
 and not exists (select *
                   from EXAM_MARKS as em
				where MARK = 2
				  and stud.id = em.student_id)
group by COURSE


-- 39. Напишите запрос EXISTS на выдачу названий предметов обучения, 
--    по которым было получено максимальное кол-во оценок.

select NAME
   from SUBJECTS as sub
 where exists (select count(MARK)
                   from EXAM_MARKS as ex
				   where sub.id = ex.subj_id
				 group by SUBJ_ID
				having count(MARK) = (select top 1 count(MARK) as cnt_m
                                          from EXAM_MARKS 
			                            group by SUBJ_ID
				                      order by cnt_m desc))
				

-- 40. Напишите команду, которая выдает список фамилий студентов по алфавиту, 
--    с колонкой комментарием: 'успевает' у студентов , имеющих все положительные оценки, 
--    'не успевает' для сдававших экзамены, но имеющих хотя бы одну 
--    неудовлетворительную оценку, и комментарием 'не сдавал' – для всех остальных.
--    Примечание: по возможности воспользуйтесь операторами ALL и ANY.

select SURNAME, 'успевает' as STATE
    from STUDENTS as stud
 where exists (select *
                   from EXAM_MARKS as em
				where MARK > 2
				  and stud.id = em.student_id)
 and not exists (select *
                   from EXAM_MARKS as em
				where MARK = 2
				  and stud.id = em.student_id)
union all
select SURNAME, 'не успевает'
    from STUDENTS as stud
 where exists (select *
                   from EXAM_MARKS as em
				where MARK = 2
				  and stud.id = em.student_id)
union all
select SURNAME, 'не сдавал'
    from STUDENTS 
 where not id = any (select STUDENT_ID
                   from EXAM_MARKS)
order by SURNAME


-- 41. Создайте объединение двух запросов, которые выдают значения полей 
--     NAME, CITY, RATING для всех университетов. Те из них, у которых рейтинг 
--     равен или выше 500, должны иметь комментарий 'Высокий', все остальные – 'Низкий'.

select NAME, CITY, RATING, 'Высокий' as Comments
      from UNIVERSITIES
   where RATING >= 500
union all
 select NAME, CITY, RATING, 'Низкий' 
   from UNIVERSITIES
 where RATING < 500

-- 42. Напишите UNION запрос на выдачу списка фамилий студентов 4-5 курсов в виде 3х полей выборки:
--     SURNAME, 'студент <значение поля COURSE> курса', STIPEND
--     включив в список преподавателей в виде
--     SURNAME, 'преподаватель из <значение поля CITY>', <значение зарплаты в зависимости от города проживания (придумать самим)>
--     отсортировать по фамилии
--     Примечание: достаточно учесть 4-5 городов.

 select SURNAME, concat('студент ', COURSE, ' курса') as info, cast(STIPEND as varchar) as income
    from STUDENTS
  where COURSE in (4, 5)
union all
  select SURNAME, concat('преподаватель из ', CITY) 
                       , case 
					   when CITY = 'Киев' then '25 000' 
					   when CITY = 'Днепр' then '22 000' 
					   when CITY = 'Харьков' then '23 000'
					   when CITY = 'Херсон' then '20 000'
					   when CITY = 'Львов' then '24 000'
					   else '19 000'
                      end as Salary
 from LECTURERS
order by SURNAME


-- 43. Напишите запрос, выдающий список фамилий преподавателей английского
--    языка с названиями университетов, в которых они преподают.
--    Отсортируйте запрос по городу, где расположен университ, а
--    затем по фамилии лектора.

select lec.SURNAME, un.NAME UNIV_NAME
  from LECTURERS lec
  join SUBJ_LECT sublec on lec.ID = sublec.LECTURER_ID
  join UNIVERSITIES un on lec.UNIV_ID = un.ID
  join SUBJECTS sub on sublec.SUBJ_ID = sub.ID
 where sub.NAME = 'Английский'
order by un.CITY, lec.SURNAME


-- 44. Напишите запрос, который выполняет вывод данных о фамилиях, сдававших экзамены 
--    студентов, учащихся в Б.Церкви, вместе с наименованием каждого сданного ими предмета, 
--    оценкой и датой сдачи.

select s.SURNAME, sub.NAME, em.MARK, em.EXAM_DATE
  from STUDENTS s
  join UNIVERSITIES un on s.UNIV_ID = un.ID
  join EXAM_MARKS em on s.ID = em.STUDENT_ID
  join SUBJECTS sub on em.SUBJ_ID = sub.ID
where un.CITY = 'Белая Церковь'


-- 45. Используя оператор JOIN, выведите объединенный список городов с указанием количества 
--    учащихся в них студентов и преподающих там же преподавателей.

select un.CITY, count(distinct s.ID) as cnt_s, count(distinct l.ID) as cnt_l
  from UNIVERSITIES un
  left join STUDENTS s on un.ID = s.UNIV_ID
  left join LECTURERS l on un.ID = l.UNIV_ID
 group by un.CITY


-- 46. Напишите запрос который выдает фамилии всех преподавателей и наименование предметов,
--    которые они читают в КПИ

select lec.SURNAME, sub.NAME
  from LECTURERS lec
  join SUBJ_LECT sl on lec.ID = sl.LECTURER_ID
  join SUBJECTS sub on sub.ID = sl.SUBJ_ID
  join UNIVERSITIES un on lec.UNIV_ID = un.ID
where un.NAME = 'КПИ'


-- 47. Покажите всех студентов-двоешников, кто получил только неудовлетворительные оценки (2) 
--    и по каким предметам, а также тех кто не сдал ни одного экзамена. 
--    В выходных данных должны быть приведены фамилии студентов, названия предметов и 
--    оценка, если оценки нет, заменить ее на прочерк.

select  s.SURNAME, s.NAME
        , isnull(sub.NAME, '--') SUBJECT
		, isnull(cast(em.MARK as varchar), '--') MARK
  from STUDENTS s
   left join EXAM_MARKS em on s.ID = em.STUDENT_ID
   left join SUBJECTS sub on em.SUBJ_ID = sub.ID
   left join EXAM_MARKS em1 on s.ID = em1.STUDENT_ID and em1.MARK > 2 
where em1.MARK is null


-- 48. Напишите запрос, который выполняет вывод списка университетов с рейтингом, 
--    превышающим 490, вместе со значением максимального размера стипендии, 
--    получаемой студентами в этих университетах.

select un.NAME, max(stud.stipend) max_stipend
  from UNIVERSITIES un
  left join STUDENTS stud on un.ID = stud.UNIV_ID
      where un.RATING > 490
 group by un.NAME
 

-- 49. Расчитать средний бал по оценкам студентов для каждого университета, 
--    умноженный на 100, округленный до целого, и вычислить разницу с текущим значением
--    рейтинга университета.

select un.name, round(avg(em.MARK) * 100, 0)  as avg_mark
      , round(avg(em.MARK) * 100, 0) - un.RATING as difference
  from UNIVERSITIES un
  left join STUDENTS stud on un.ID = stud.UNIV_ID
  left join EXAM_MARKS em on stud.ID = em.STUDENT_ID
 group by un.id, un.name, un.RATING


-- 50. Написать запрос, выдающий список всех фамилий лекторов из Киева попарно. 
--    При этом не включать в список комбинации фамилий самих с собой,
--    то есть комбинацию типа "Коцюба-Коцюба", а также комбинации фамилий, 
--    отличающиеся порядком следования, включать лишь одну из двух 
--    комбинаций типа "Хижна-Коцюба" или "Коцюба-Хижна".

select concat(lec1.SURNAME, '-', lec2.SURNAME) LEC_PAIR
  from LECTURERS lec1
  left join LECTURERS lec2 
    on lec1.ID <> lec2.ID and lec1.id > lec2.id  
 where lec1.CITY = 'Киев' and lec2.CITY = 'Киев'
  order by lec1.id
 
 
-- 51. Выдать информацию о всех университетах, всех предметах и фамилиях преподавателей, 
--    если в университете для конкретного предмета преподаватель отсутствует, то его фамилию
--    вывести на экран как прочерк '-' (воспользуйтесь ф-ей isnull)

select un.id, un.NAME, un.RATING, sub.NAME, isnull(ls.SURNAME, '--') as LECT_SURNAME
  from UNIVERSITIES un
  cross join SUBJECTS sub 
   left join (select lec.SURNAME, lec.UNIV_ID, sublec.SUBJ_ID 
                from LECTURERS lec
			    join  subj_lect sublec on sublec.LECTURER_ID = lec.id) as ls
			  on un.ID = ls.UNIV_ID and sub.ID = ls.SUBJ_ID
order by un.NAME


-- 52. Кто из преподавателей и сколько поставил пятерок за свой предмет?

select lec.SURNAME, count(em.MARK) cnt_5
  from EXAM_MARKS em
  join SUBJ_LECT sublec on em.SUBJ_ID = sublec.SUBJ_ID
  join LECTURERS lec on sublec.LECTURER_ID = lec.ID
  join STUDENTS stud on em.STUDENT_ID = stud.ID 
  where em.MARK = 5 and lec.UNIV_ID = stud.UNIV_ID
group by lec.SURNAME


-- 53. Добавка для уверенных в себе студентов: показать кому из студентов какие экзамены
--     еще досдать.

select s.SURNAME, s.NAME, sub.NAME
  from STUDENTS s
  cross join SUBJECTS sub
  left join EXAM_MARKS em on s.ID = em.STUDENT_ID and em.SUBJ_ID = sub.ID and em.MARK > 2
  where em.mark is null
  order by s.SURNAME


-- 54. Необходимо добавить двух новых студентов для нового учебного 
--    заведения "Винницкий Медицинский Университет".

begin transaction
 
 select * from STUDENTS
   insert into UNIVERSITIES (ID, NAME, RATING, CITY)
   values (16, 'Винницкий Медицинский Университет', 760, 'Винница')
    insert into STUDENTS (ID, SURNAME, NAME, GENDER, STIPEND, COURSE, CITY, BIRTHDAY, UNIV_ID)
	values (46, 'Новак', 'Мария', 'f', 600, 2, 'Львов', '1992-06-21 00:00:00.000', 16),
	       (47, 'Коваль', 'Иван', 'm', 600, 2, 'Полтава', '1994-08-02 00:00:00.000', 16)
 select * from STUDENTS
 where UNIV_ID = 16

rollback


-- 55. Добавить еще один институт для города Ивано-Франковск, 
--    1-2 преподавателей, преподающих в нем, 1-2 студента,
--    а так же внести новые данные в экзаменационную таблицу.

begin transaction

select * from UNIVERSITIES
 insert into UNIVERSITIES (ID, NAME, RATING, CITY)
 values (16, 'ІФНМУ', 570, 'Ивано-Франковск')
 select * from UNIVERSITIES
 where ID = 16
      select * from LECTURERS
      insert into LECTURERS (ID, SURNAME, NAME, CITY, UNIV_ID)
      values (26, 'Степчук', 'ВМ', 'Ивано-Франковск', 16)
	       , (27, 'Марков', 'НА', 'Ивано-Франковск', 16)
	   select * from LECTURERS
	    where UNIV_ID = 16
   select * from STUDENTS
   insert into STUDENTS (ID, SURNAME, NAME, GENDER, STIPEND, COURSE, CITY, BIRTHDAY, UNIV_ID)
   values (46, 'Новак', 'Мария', 'f', 600, 2, 'Львов', '1992-06-21 00:00:00.000', 16)
        , (47, 'Коваль', 'Иван', 'm', 600, 2, 'Полтава', '1994-08-02 00:00:00.000', 16)
   select * from STUDENTS
    where UNIV_ID = 16
     select * from EXAM_MARKS
     insert into EXAM_MARKS (STUDENT_ID, SUBJ_ID, MARK, EXAM_DATE)
     values (46, 4, 4.000, '2012-06-25 00:00:00.000')
       , (46, 2, 3.000, '2012-06-03 00:00:00.000')
	   , (46, 7, 4.000, '2012-06-29 00:00:00.000')
	   , (47, 5, 5.000, '2012-06-08 00:00:00.000')
	   , (47, 3, 5.000, '2012-06-18 00:00:00.000')
  select * from EXAM_MARKS as em
  where em.STUDENT_ID = 46 or em.STUDENT_ID = 47
 
 rollback


-- 56. Известно, что студенты Павленко и Пименчук перевелись в ОНПУ. 
--    Модифицируйте соответствующие таблицы и поля.

begin transaction 

select * from STUDENTS
where SURNAME = 'Павленко' or SURNAME = 'Пименчук'

update STUDENTS
   set UNIV_ID = (select ID
                    from UNIVERSITIES
		           where Name = 'ОНПУ')
 where SURNAME = 'Павленко' or SURNAME = 'Пименчук'

 select * from STUDENTS
where SURNAME = 'Павленко' or SURNAME = 'Пименчук'

rollback


-- 57. В учебных заведениях Украины проведена реформа и все студенты, 
--    у которых средний бал не превышает 3.5 балла - отчислены из институтов. 
--    Сделайте все необходимые удаления из БД.
--    Примечание: предварительно "отчисляемых" сохранить в архивационной таблице

begin transaction 

select * from STUDENTS

insert into STUDENTS_ARCHIVE
select * from STUDENTS
        where exists (select STUDENT_ID
                        from EXAM_MARKS em
			           where  STUDENTS.ID = em.STUDENT_ID
		            group by STUDENT_ID
		              having avg(mark) <= 3.5
			          )
delete from EXAM_MARKS
      where STUDENT_ID in (select STUDENT_ID
                             from EXAM_MARKS
				         group by STUDENT_ID
				           having avg(mark) <= 3.5
						   )
delete from STUDENTS
      where exists (select id
                      from STUDENTS_ARCHIVE as sa
				     where STUDENTS.id = sa.ID
			       )
select * from STUDENTS

rollback


-- 58. Студентам со средним балом 4.75 начислить 12.5% к стипендии,
--    со средним балом 5 добавить 200 грн.
--    Выполните соответствующие изменения в БД.

begin transaction

select avg(mark), student_ID
                  from EXAM_MARKS em
				 group by student_ID

update STUDENTS
   set STIPEND = STIPEND +
                    (select case
				            when avg(mark) = 5 then 200
							when avg(mark) =  4.75 then stipend * 0.125
							end
					 from EXAM_MARKS em
					where em.STUDENT_ID = STUDENTS.ID
					)
  where exists (select *
                  from EXAM_MARKS em
				 where em.STUDENT_ID = STUDENTS.ID
				having avg(mark) >= 4.75)	
 
 select * from STUDENTS
  where exists (select *
                  from EXAM_MARKS em
				 where em.STUDENT_ID = STUDENTS.ID
				 having avg(mark) >= 4.75)
 rollback


-- 59. Необходимо удалить все предметы, по котором не было получено ни одной оценки.
--    Если таковые отсутствуют, попробуйте смоделировать данную ситуацию.

begin transaction

delete from EXAM_MARKS
 where SUBJ_ID = 1

delete from SUBJ_LECT
 where not exists (select * 
                      from EXAM_MARKS as em
					 where SUBJ_LECT.SUBJ_ID = em.SUBJ_ID)
 
 delete from SUBJECTS
  where not exists (select * 
                      from EXAM_MARKS as em
					 where SUBJECTS.ID = em.SUBJ_ID)
  
  select * from SUBJECTS

rollback


-- 60. Лектор 3 ушел на пенсию, необходимо корректно удалить о нем данные.

begin transaction
  
  select * from LECTURERS
	delete from SUBJ_LECT
     where LECTURER_ID = 3
  delete from LECTURERS
   where ID = 3
select * from LECTURERS
 where ID = 3

rollback


-- 61. Создайте модифицируемое представление для получения сведений обо всех студентах, 
--    круглых отличниках. Используя это представление, напишите запрос обновления, 
--    "расжалующий" их в троечников.

begin transaction

create view v_students_elite
as
select s.ID, s.SURNAME, s.NAME, s.STIPEND
       , s.COURSE, s.UNIV_ID, em.SUBJ_ID, em.MARK
  from STUDENTS s
  join Exam_Marks em on em.STUDENT_ID = s.ID
 where not exists (select *
                     from EXAM_MARKS em
				    where em.STUDENT_ID = s.ID
				      and em.MARK < 5)

update v_students_elite
   set MARK = 3 

rollback


-- 62. Создайте представление для получения сведений о количестве студентов 
--    обучающихся в каждом городе.

begin transaction

create view v_cnt_Students
as
select un.CITY, count(*) as cnt_Students
  from STUDENTS s
  join UNIVERSITIES un on s.UNIV_ID = un.ID
group by un.CITY

select * from cnt_Students

rollback


-- 63. Создайте представление для получения сведений по каждому студенту: 
--    его ID, фамилию, имя, средний и общий баллы.

begin transaction

create view v_stud_info
as
select s.ID, s.SURNAME, avg(mark) as avg_mark, sum(mark) as total
  from STUDENTS s
  join EXAM_MARKS em on s.ID = em.STUDENT_ID
  group by s.ID, s.SURNAME

rollback


-- 64. Создайте представление для получения сведений о студенте фамилия, 
--    имя, а также количестве экзаменов, которые он сдал успешно, и количество,
--    которое ему еще нужно досдать (с учетом пересдач двоек).

begin transaction

create view stud_info
as
select s.SURNAME, s.NAME, count(*) passed_exams
  from STUDENTS s
  cross join SUBJECTS sb 
  join EXAM_MARKS em on s.ID = em.STUDENT_ID and sb.ID = em.SUBJ_ID and em.MARK > 2
--group by s.SURNAME, s.NAME								 
left join 
	(select s1.SURNAME, s1.NAME, count(*)
              from STUDENTS s1
              cross join SUBJECTS sb1 
                    left join EXAM_MARKS em1 on s1.ID = em1.STUDENT_ID 
					                        and sb1.ID = em1.SUBJ_ID and em1.MARK > 2 
                                     where em1.ID is null
			                         group by s1.SURNAME, s1.NAME) to_do 
									 on s.ID = 
rollback


-- 65. Создайте представление таблицы STUDENTS с именем STIP, включающее поля 
--    STIPEND и ID и позволяющее вводить или изменять значение поля 
--    стипендия, но только в пределах от 100 д о 500.

begin transaction

create view v_STIP
as 
select ID, STIPEND
  from STUDENTS
 where STIPEND between 100 and 500
with check option

rollback