-- 1. �������� ���� ������ � �������������� ����������� ��� ������ � ����������� �����,
--    ���������� ��� ��������� ���������� ������� (CITY) �� ������
--    STUDENTS, LECTURERS � UNIVERSITIES
--    ������ �� ������ �����������, ��������� � ������ ������ ���������� ����� �������
--    ��������: ���������, ��� ������ ������� ������� ����� ���� ���������� ���

SELECT DISTINCT ST.CITY AS S_CI
   , LE.CITY AS L_CI
   , UN.CITY AS U_CI
FROM STUDENTS AS ST, LECTURERS AS LE, UNIVERSITIES AS UN


-- 2. �������� ������ ��� ������ ����� � �������� �������: �������, � ������� ��
--    ��������, �������������� (������ ID) �������� ��������, ��� ������������ �
--    ���������� ��������� �� ���� ������� ����� ��� ���� ����� ������� SUBJECTS

SELECT SEMESTER, ID, NAME, HOURS
FROM SUBJECTS
 

-- 3. �������� ��� ������ ������� EXAM_MARKS, � ������� ������� �������� SUBJ_ID ����� 4

SELECT * FROM EXAM_MARKS
WHERE SUBJ_ID = 4


-- 4. ���������� �������� ��� ������, � ��������� �������
--    ���������, ����, �������, ���  �� ������� STUDENTS, ������ ����������
--    ��������, ���������� ����� '1993-07-21'

SELECT STIPEND, COURSE, SURNAME, NAME FROM STUDENTS
WHERE BIRTHDAY > '1993-07-21'
ORDER BY STIPEND, COURSE, SURNAME, NAME


-- 5. ������� �� ����� ��� ��������: �� ������������ � ���-�� ����� ��� ������� �� ���
--    � 1-� �������� � ��� ���� ���-�� ����� �� ������ ��������� 41

SELECT NAME, HOURS 
FROM SUBJECTS
WHERE SEMESTER = 1 AND HOURS <= 41


-- 6. �������� ������, ����������� ������� �� ������� EXAM_MARKS ����������
--    �������� ��������������� ������, ������� ���� �������� '2012-06-12'

SELECT DISTINCT MARK
FROM EXAM_MARKS
WHERE EXAM_DATE IN ('2012-06-12')


-- 7. �������� ������ ������� ���������, ����������� �� ������� � �����������
--    ������ � ��� ���� ����������� �� � �����, �� �������� � �� ������.

SELECT SURNAME
FROM STUDENTS
WHERE COURSE >= 3 
AND CITY NOT IN ('����, �������, �����')


-- 8. �������� ������ � �������, ����� � ������ ����� ��� ���������,
--    ���������� ��������� � ��������� �� 450 �� 650, �� �������
--    ��� ��������� �����. ��������� ��������� ��������� ������� ���� ������.

SELECT SURNAME, NAME, COURSE
FROM STUDENTS
WHERE STIPEND > 450 AND STIPEND < 650

SELECT SURNAME, NAME, COURSE
FROM STUDENTS
WHERE STIPEND BETWEEN 450 AND 650 
      AND STIPEND NOT IN (450, 650)


-- 9. �������� ������, ����������� ������� �� ������� LECTURERS ���� �������
--    ��������������, ����������� �� ������, ���� �� ����������� � ������������
--    � ��������������� 14

SELECT SURNAME
FROM LECTURERS
WHERE CITY = '�����' OR UNIV_ID = 14


-- 10. �������� � ����� ������� (��������) ����������� ������������,
--     ������� ������� ��������� � ��������� 528 +/- 47 ������.

SELECT CITY
FROM UNIVERSITIES
WHERE RATING BETWEEN 528 - 47 AND 528 + 47


-- 11. �������� ������ ������� �������� ���������, �� ���� � ��� ��������
--     ��� ���� �������� ������.

SELECT *
FROM STUDENTS
WHERE CITY = '����' 
      AND COURSE IN (1, 3, 5, 7, 9)


-- 12. ��������� ��������� ���������� (��������� �� NOT) � ����� ���������� ������������ �������?
-- SELECT * FROM STUDENTS WHERE (STIPEND < 500 OR NOT (BIRTHDAY >= '1993-01-01' AND ID > 9))
-- ���������: ����� ���������, ������ ������ ���������� �� �� �������, ��� � ������������

SELECT * FROM STUDENTS 
WHERE STIPEND < 500 OR BIRTHDAY < '1993-01-01' OR ID <= 9


-- 13. ��������� ��������� ���������� (��������� �� NOT) � ����� ���������� ������������ �������?
-- SELECT * FROM STUDENTS WHERE NOT ((BIRTHDAY = '1993-06-07' OR STIPEND > 500) AND ID >= 9)
-- ���������: ����� ���������, ������ ������ ���������� �� �� �������, ��� � ������������
-- AND ID >= 9 - �� ��� ����� �����������, ���� �� NOT () ���������� �� ��� ���� - ���������� �� �����.

SELECT * FROM STUDENTS 
WHERE  BIRTHDAY <> '1993-06-07' AND STIPEND <= 500 OR ID < 9 


-- 14. ��������� ������ ��� ������� STUDENT ����� �������, ����� �������� ������� 
--    ��������� ���� ������� ���� varchar, ���������� ������������������ ����������� 
--    �������� ';' (����� � �������) �������� �������� ���� �������, � ��� ���� 
--    ��������� �������� ������ ������������ ���������� ��������� (������� �������), 
--    �� ���� ���� ��������������� � ��������� ����: 
--    1;�������;�������;M;550;4;�������;01/12/1990;2.
--    ...
--    ����������: � ������� ������ ������� �������� �� ������ ������ �� 5 ����

select upper(concat(ID, ';', (SURNAME), ';', (NAME), ';',
              (GENDER), ';', cast(STIPEND as float), ';', COURSE,
			  ';', (CITY), ';', format(BIRTHDAY, 'dd/MM/yyyy'), ';', UNIV_ID)
			  ) as INFO
 from STUDENTS
       where len(city) = 5 

	  
-- 15. ��������� ������ ��� ������� STUDENT ����� �������, ����� �������� ������� 
--    ��������� ����� ���� ������� � ��������� ����: 
--    �.�������;���������������-�������;�������-01.12.90
--    ...
--    ����������: � ������� ������ ������� ��������, ������� ������� �������� ������
--    ����� '�' � ������������� ����� '�', ���� �� ������� ������������� �� '�'

select left(NAME, 1) + '.' + upper(SURNAME) + ';' + '���������������-' + upper (CITY) 
            + ';' + '�������-' + isnull(format(BIRTHDAY, 'dd.MM.yy'), 'unknown')
			as INFO
from STUDENTS
     where surname like '_�%�_' or surname like '%�'


-- 16. ��������� ������ ��� ������� STUDENT ����� �������, ����� �������� ������� 
--    ��������� ����� ���� ������� � ��������� ����:
--    �.�������;���������������-������; ������ �� IV �����
--    ...
--    ����������: ���� ������� �������� ������� (�������������� CASE), 
--    �������� ���������, ��������� ������� ������ 200

select concat(lower(left(NAME, 1)), '.', lower (SURNAME), ';', '���������������-', CITY, 
              ';', ' ������ �� '
			  , case COURSE
			  when 1 then 'I'
			  when 2 then 'II'
			  when 3 then 'III'
			  when 4 then 'IV'
			  when 5 then 'V'
			  end, ' �����')
from STUDENTS
where STIPEND%200 = 0 


-- 17. ��������� ������ ��� ������� STUDENT ����� �������, ����� ������� 
--    ��������� ������� � ���������� ����:
--     ���� ��������� �� �.�������������� �������� � 1992 ����
--     ...
--     ������� ��������� �� �.����������� ������� � 1993 ����
--     ...
--     ����������: ��� ���� �������, � ������� ����� 8 ����

select NAME + ' ' + SURNAME + ' �� �. ' + CITY + 
       case GENDER 
	   when 'f' then ' �������� � '
	   when 'm' then ' ������� � '
	   end 
	   + isnull(format(BIRTHDAY, 'yyyy'), 'unknown') 
	   + ' ����'
from STUDENTS
     where len(CITY) > 8


-- 18. ������� �������, ����� ��������� � �������� ���������� ��� ���������, 
--    ��� ���� �������� ��������� �������������� ������ ���� ��������� �� 17.5%

select SURNAME, NAME,
       case COURSE 
	   when 1 then STIPEND + STIPEND*0.175
	   else STIPEND
	   end as NEW_STIPEND
from STUDENTS


-- 19. ������� ������������ ���� ������� ��������� � �� ���������� 
--    (���������/���������/����� �� ����) �� �����.

select Name
   , case NAME 
       when '���' then '553 �� �� �����'
	   when '���' then '556 �� �� �����'
	   when '���' then '497 �� �� �����'
	   when '���' then '741 �� �� �����'
	   when '����' then '741 �� �� �����'
	   when '�����' then '481 �� �� �����'
	   when '����' then '478 �� �� �����'
	   when '����' then '472 �� �� �����'
	   when '����' then '550 �� �� �����'
	   when '����' then '87 �� �� �����'
	   when '����' then '490 �� �� �����'
	   else '����������������� � �����'
	 end as DISTANCE
from UNIVERSITIES


-- 20. ������� ��� ������� ��������� � �� ��� ��������� ����� ��������.

select NAME, right(RATING, 2)
from UNIVERSITIES


-- 21. ��������� ������ ��� ������� UNIVERSITY ����� �������, ����� �������� ������� 
--    ��������� ����� ���� ������� � ��������� ����:
--    ���-1;���-�.����;������� ������������ ����(501) +756
--    ...
--    ���-11;�����-�.����;������� ������������ ����(501) -18
--    ...
--    ����������: ������� ��������� ������������ ���������, � ����� ������ 
--    �������������� ���� (+/-), ������� ���� ������� �������� = 501

select concat('���-', ID, ';', NAME, '-�.', CITY, ';', ' ������� ������������ ����(501) ',   
              case
			    when RATING > 501 then ' +'
			  end,
			  case 
			    when RATING > 501 then + (RATING - 501)
			    when RATING < 501 then - (501 - RATING)
			  end
			  )
	from UNIVERSITIES


-- 22. ��������� ������ ��� ������� UNIVERSITY ����� �������, ����� �������� ������� 
--    ��������� ����� ���� ������� � ��������� ����:
--    ���-1;���-�.����;������� ������� �� 12 �����
--    ���-2;���-�.����;������� ������� �� 6 �����
--    ...
--    ����������: � �������� ���������� ������� ���-�� �����

select concat('���-', ID, ';', NAME, '-�.'
             , CITY, ';', '������� ������� �� '
			 , floor(RATING/100), ' �����')
from UNIVERSITIES
-- 0. ���������� ��� ������� �� ������ ���������� ������ � �������.

select COURSE
       , count(case GENDER when 'f' then 1 end) CNT_F
	   , count(case GENDER when 'm' then 1 end) CNT_M
   from STUDENTS
group by COURSE


-- 23. �������� ������ ��� ������� EXAM_MARKS, ���������� ����, ��� ������� ������� ����
--    ���������� � ��������� �� 4.22 �� 4.77. ������ ���� ��� ������ �� �����:
--    ���� �����, ��������, 05 Jun

select format(EXAM_DATE, 'dd MMM') EXAM_DATE
       , avg(MARK) AVG_M
    from EXAM_MARKS
  group by EXAM_DATE 
having avg(MARK)  > 4.22  and avg(MARK)  < 4.77 


-- 24. �������� ������, ���������� �� ������� EXAM_MARKS ��������� ���������� �� ������� �� ��������:
--    - ���-�� ����������� ����, ����������� ��������� �� ������.
--        ��������, ���� ������ ������� ��� ���� 01.06, � ��������� 10.06, �� ��������� 10 ����
--    - ���-�� ������� ����� ���������
--    - ������������ � ����������� ������.
--    ����������: ������� DAY() ��� ������� �� ��������!

select STUDENT_ID, datediff(day, min(EXAM_DATE), max(EXAM_DATE)) + 1 as DAYS
	 , count(*) CNT_ATTEMPT 
	 , max(MARK) MAX_MARK,
	   min(MARK) MIN_MARK
  from EXAM_MARKS
group by STUDENT_ID 


-- 25. �������� ������ ��������������� ���������, ������� ����� ���������.
--    ����������: ��� ���������� ���������� ��������, ����� � ������ � ���� �� ��������
--    �� ������ � ���� �� �������� ���� ����� ����� ������

select STUDENT_ID
       , count(MARK) as ONCE_AGAIN
from EXAM_MARKS
group by STUDENT_ID, SUBJ_ID
having count(MARK) > 1


-- 26. �������� ������, ������������ ������ ��������� ��������, ������������ �� ����� ��������
--    ���������� �������, ��������������� � ������� �������� ���������. ���� �������� �
--    �������� ������ ������ ���� ������, �� ��� ������ ��������� ������������ �
--    ����� �������� �������� ��������.

select SEMESTER, NAME, ID
   from SUBJECTS
  where HOURS = (select min(HOURS) from SUBJECTS)
order by SEMESTER desc


-- 27. �������� ������ � ����������� ��� ��������� ������ ��� ���� ������������� �������(4, 5) ������
--    ���� (�����������, ��� �� ������������ ����� ����������), ��������������� ��������� � ���
--    �� �����.

select MARK, SUBJ_ID, EXAM_DATE 
from EXAM_MARKS
where STUDENT_ID in (select ID 
                     from STUDENTS 
					where NAME = '������' 
					and SURNAME = '����'
                    and  MARK >= 4
					)


-- 28. �������� ����� ������ ��� ������ ���� ����� ���������, ����� ������� ���� �� �����
--    �������� ��������������� ����� ������������ � ����������� �������. ������ ��������� ������
--    ��� ���������. ��������� �������� � ������� �������� ���� ������, � ���� � ������� dd/mm/yyyy.

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


-- 29. �������� ����� � ������� ���� ���������, � ������� ������� ���� �� ���������
--    � ���������������� 1 � 2 ��������� ������� ���� ����� �� ��������
--    �� ���� ��������� ���������. ����������� ����������� AVG(case...), ���� ������������� ���������.
--    ����������: ����� ��� ���������, ��� �� "���������" ��������� (�� 1�� � �� 2��) �� ����
--    �������� �� ����� ������, � ����� ������ ������� ������� ��� �� 0 - ��� ����� �����
--    ������������ ������� ISNULL().

select NAME, SURNAME
   from STUDENTS
      where ID in (select STUDENT_ID
                     from EXAM_MARKS
                   group by STUDENT_ID
having avg(case when SUBJ_ID in (1, 2) then MARK end) > isnull(avg(case when SUBJ_ID not in (1, 2) then MARK end), 0))


-- 30. �������� ������, ����������� ����� ������ ���������� � �������� ������ �������
--    �������������� �������������, ��� ������������� � ���-�� ���������� ������ ��� �������,
--    ��� �� ������� ���� 3 � ����� ���������.

select STUDENT_ID, sum(MARK) SUM_M, avg(MARK) AVG_M, count(MARK) CNT_M
from EXAM_MARKS
     where STUDENT_ID in (select ID 
	                        from STUDENTS
						  where COURSE = 2)
    group by STUDENT_ID
having count(distinct case when MARK > 2 
             then SUBJ_ID
			 end) >= 3 
             
             
-- 31. ������� �������� ���� ���������, ������� ���� ������� ��������� ������� ����, ����������
--    ����������, ������������ � ������������� �. �����
--    ����������: ����������� ��������� ����������.

select NAME from SUBJECTS
where ID in ( select SUBJ_ID from EXAM_MARKS
              group by SUBJ_ID
              having avg(MARK) > (select avg(MARK) 
     from EXAM_MARKS
 where STUDENT_ID in (select ID from STUDENTS
       where UNIV_ID in (select ID from UNIVERSITIES
		                 where CITY = '�����'
			            ))))


-- 32. �������� ������ � EXISTS, ����������� ������� ������ ��� ���� ���������, 
--    ����������� � ����� � ��������� �� ���������� � �������� �� 488 �� 571

select *
   from STUDENTS as s
 where exists (select * 
                     from UNIVERSITIES un
				    where RATING not between 488 and 571
					   and s.UNIV_ID = un.id
					)

					
-- 33. �������� ������ � EXISTS, ���������� ���� ���������, ��� ������� � ��� �� ������, 
--    ��� ����� � ������ �������, ���������� ������ ������������, � ������� �� �� ������.

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

				
-- 34. �������� ������, ���������� �� ������� SUBJECTS ������ � ��������� ��������� ��������, 
--    �������� �� ������� ���� ���� ���-�� ����� ����� ��� 12 ����������, �� ������ 10 ���� ������. 
--    ����������� EXISTS. 
--    ����������: ��� �������� ������� ������ ���� �������� �� ������� �������� ������ ���� ���

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
 

-- 35. �������� ������ EXISTS, ���������� ������� ���� ��������, ����������� � �������������
--    � ���������, ������������� ������� ���� ����������� �������������.

select *
   from LECTURERS as lec
where exists (select *
                  from UNIVERSITIES as uni
				where RATING > (select max(rating)
				                       from UNIVERSITIES
									 where CITY = '�������'
				       and lec.UNIV_ID = uni.ID))
			
			
-- 36. �������� 2 �������, ������������ ANY � ALL, ����������� ������� ������ � ���������, 
--    � ������� � ������ �� ����������� ��������������� ��� ������������.

select * 
   from STUDENTS
 where not CITY  = any (select CITY 
                     from UNIVERSITIES)

select * 
   from STUDENTS
 where CITY  <> all (select CITY 
                     from UNIVERSITIES)


-- 37. �������� ������ �������� ����� � ������� ���������, ������� ��������
--    ������������ ������ � ������ ��� ��������� ���� ������.
--    ���������: ������� ������ ��������� �� ������ ���� 2� ���������.

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
	

-- 38. �������� ������ EXISTS, ��������� ���-�� ��������� ������� �����, ������� ������� 
--    ����� ��������, � ��� ���� �� ���������� �� ����� ������.

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


-- 39. �������� ������ EXISTS �� ������ �������� ��������� ��������, 
--    �� ������� ���� �������� ������������ ���-�� ������.

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
				

-- 40. �������� �������, ������� ������ ������ ������� ��������� �� ��������, 
--    � �������� ������������: '��������' � ��������� , ������� ��� ������������� ������, 
--    '�� ��������' ��� ��������� ��������, �� ������� ���� �� ���� 
--    �������������������� ������, � ������������ '�� ������' � ��� ���� ���������.
--    ����������: �� ����������� �������������� ����������� ALL � ANY.

select SURNAME, '��������' as STATE
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
select SURNAME, '�� ��������'
    from STUDENTS as stud
 where exists (select *
                   from EXAM_MARKS as em
				where MARK = 2
				  and stud.id = em.student_id)
union all
select SURNAME, '�� ������'
    from STUDENTS 
 where not id = any (select STUDENT_ID
                   from EXAM_MARKS)
order by SURNAME


-- 41. �������� ����������� ���� ��������, ������� ������ �������� ����� 
--     NAME, CITY, RATING ��� ���� �������������. �� �� ���, � ������� ������� 
--     ����� ��� ���� 500, ������ ����� ����������� '�������', ��� ��������� � '������'.

select NAME, CITY, RATING, '�������' as Comments
      from UNIVERSITIES
   where RATING >= 500
union all
 select NAME, CITY, RATING, '������' 
   from UNIVERSITIES
 where RATING < 500

-- 42. �������� UNION ������ �� ������ ������ ������� ��������� 4-5 ������ � ���� 3� ����� �������:
--     SURNAME, '������� <�������� ���� COURSE> �����', STIPEND
--     ������� � ������ �������������� � ����
--     SURNAME, '������������� �� <�������� ���� CITY>', <�������� �������� � ����������� �� ������ ���������� (��������� �����)>
--     ������������� �� �������
--     ����������: ���������� ������ 4-5 �������.

 select SURNAME, concat('������� ', COURSE, ' �����') as info, cast(STIPEND as varchar) as income
    from STUDENTS
  where COURSE in (4, 5)
union all
  select SURNAME, concat('������������� �� ', CITY) 
                       , case 
					   when CITY = '����' then '25 000' 
					   when CITY = '�����' then '22 000' 
					   when CITY = '�������' then '23 000'
					   when CITY = '������' then '20 000'
					   when CITY = '�����' then '24 000'
					   else '19 000'
                      end as Salary
 from LECTURERS
order by SURNAME


-- 43. �������� ������, �������� ������ ������� �������������� �����������
--    ����� � ���������� �������������, � ������� ��� ���������.
--    ������������ ������ �� ������, ��� ���������� ���������, �
--    ����� �� ������� �������.

select lec.SURNAME, un.NAME UNIV_NAME
  from LECTURERS lec
  join SUBJ_LECT sublec on lec.ID = sublec.LECTURER_ID
  join UNIVERSITIES un on lec.UNIV_ID = un.ID
  join SUBJECTS sub on sublec.SUBJ_ID = sub.ID
 where sub.NAME = '����������'
order by un.CITY, lec.SURNAME


-- 44. �������� ������, ������� ��������� ����� ������ � ��������, ��������� �������� 
--    ���������, �������� � �.������, ������ � ������������� ������� �������� ��� ��������, 
--    ������� � ����� �����.

select s.SURNAME, sub.NAME, em.MARK, em.EXAM_DATE
  from STUDENTS s
  join UNIVERSITIES un on s.UNIV_ID = un.ID
  join EXAM_MARKS em on s.ID = em.STUDENT_ID
  join SUBJECTS sub on em.SUBJ_ID = sub.ID
where un.CITY = '����� �������'


-- 45. ��������� �������� JOIN, �������� ������������ ������ ������� � ��������� ���������� 
--    �������� � ��� ��������� � ����������� ��� �� ��������������.

select un.CITY, count(distinct s.ID) as cnt_s, count(distinct l.ID) as cnt_l
  from UNIVERSITIES un
  left join STUDENTS s on un.ID = s.UNIV_ID
  left join LECTURERS l on un.ID = l.UNIV_ID
 group by un.CITY


-- 46. �������� ������ ������� ������ ������� ���� �������������� � ������������ ���������,
--    ������� ��� ������ � ���

select lec.SURNAME, sub.NAME
  from LECTURERS lec
  join SUBJ_LECT sl on lec.ID = sl.LECTURER_ID
  join SUBJECTS sub on sub.ID = sl.SUBJ_ID
  join UNIVERSITIES un on lec.UNIV_ID = un.ID
where un.NAME = '���'


-- 47. �������� ���� ���������-����������, ��� ������� ������ �������������������� ������ (2) 
--    � �� ����� ���������, � ����� ��� ��� �� ���� �� ������ ��������. 
--    � �������� ������ ������ ���� ��������� ������� ���������, �������� ��������� � 
--    ������, ���� ������ ���, �������� �� �� �������.

select  s.SURNAME, s.NAME
        , isnull(sub.NAME, '--') SUBJECT
		, isnull(cast(em.MARK as varchar), '--') MARK
  from STUDENTS s
   left join EXAM_MARKS em on s.ID = em.STUDENT_ID
   left join SUBJECTS sub on em.SUBJ_ID = sub.ID
   left join EXAM_MARKS em1 on s.ID = em1.STUDENT_ID and em1.MARK > 2 
where em1.MARK is null


-- 48. �������� ������, ������� ��������� ����� ������ ������������� � ���������, 
--    ����������� 490, ������ �� ��������� ������������� ������� ���������, 
--    ���������� ���������� � ���� �������������.

select un.NAME, max(stud.stipend) max_stipend
  from UNIVERSITIES un
  left join STUDENTS stud on un.ID = stud.UNIV_ID
      where un.RATING > 490
 group by un.NAME
 

-- 49. ��������� ������� ��� �� ������� ��������� ��� ������� ������������, 
--    ���������� �� 100, ����������� �� ������, � ��������� ������� � ������� ���������
--    �������� ������������.

select un.name, round(avg(em.MARK) * 100, 0)  as avg_mark
      , round(avg(em.MARK) * 100, 0) - un.RATING as difference
  from UNIVERSITIES un
  left join STUDENTS stud on un.ID = stud.UNIV_ID
  left join EXAM_MARKS em on stud.ID = em.STUDENT_ID
 group by un.id, un.name, un.RATING


-- 50. �������� ������, �������� ������ ���� ������� �������� �� ����� �������. 
--    ��� ���� �� �������� � ������ ���������� ������� ����� � �����,
--    �� ���� ���������� ���� "������-������", � ����� ���������� �������, 
--    ������������ �������� ����������, �������� ���� ���� �� ���� 
--    ���������� ���� "�����-������" ��� "������-�����".

select concat(lec1.SURNAME, '-', lec2.SURNAME) LEC_PAIR
  from LECTURERS lec1
  left join LECTURERS lec2 
    on lec1.ID <> lec2.ID and lec1.id > lec2.id  
 where lec1.CITY = '����' and lec2.CITY = '����'
  order by lec1.id
 
 
-- 51. ������ ���������� � ���� �������������, ���� ��������� � �������� ��������������, 
--    ���� � ������������ ��� ����������� �������� ������������� �����������, �� ��� �������
--    ������� �� ����� ��� ������� '-' (�������������� �-�� isnull)

select un.id, un.NAME, un.RATING, sub.NAME, isnull(ls.SURNAME, '--') as LECT_SURNAME
  from UNIVERSITIES un
  cross join SUBJECTS sub 
   left join (select lec.SURNAME, lec.UNIV_ID, sublec.SUBJ_ID 
                from LECTURERS lec
			    join  subj_lect sublec on sublec.LECTURER_ID = lec.id) as ls
			  on un.ID = ls.UNIV_ID and sub.ID = ls.SUBJ_ID
order by un.NAME


-- 52. ��� �� �������������� � ������� �������� ������� �� ���� �������?

select lec.SURNAME, count(em.MARK) cnt_5
  from EXAM_MARKS em
  join SUBJ_LECT sublec on em.SUBJ_ID = sublec.SUBJ_ID
  join LECTURERS lec on sublec.LECTURER_ID = lec.ID
  join STUDENTS stud on em.STUDENT_ID = stud.ID 
  where em.MARK = 5 and lec.UNIV_ID = stud.UNIV_ID
group by lec.SURNAME


-- 53. ������� ��� ��������� � ���� ���������: �������� ���� �� ��������� ����� ��������
--     ��� �������.

select s.SURNAME, s.NAME, sub.NAME
  from STUDENTS s
  cross join SUBJECTS sub
  left join EXAM_MARKS em on s.ID = em.STUDENT_ID and em.SUBJ_ID = sub.ID and em.MARK > 2
  where em.mark is null
  order by s.SURNAME


-- 54. ���������� �������� ���� ����� ��������� ��� ������ �������� 
--    ��������� "��������� ����������� �����������".

begin transaction
 
 select * from STUDENTS
   insert into UNIVERSITIES (ID, NAME, RATING, CITY)
   values (16, '��������� ����������� �����������', 760, '�������')
    insert into STUDENTS (ID, SURNAME, NAME, GENDER, STIPEND, COURSE, CITY, BIRTHDAY, UNIV_ID)
	values (46, '�����', '�����', 'f', 600, 2, '�����', '1992-06-21 00:00:00.000', 16),
	       (47, '������', '����', 'm', 600, 2, '�������', '1994-08-02 00:00:00.000', 16)
 select * from STUDENTS
 where UNIV_ID = 16

rollback


-- 55. �������� ��� ���� �������� ��� ������ �����-���������, 
--    1-2 ��������������, ����������� � ���, 1-2 ��������,
--    � ��� �� ������ ����� ������ � ��������������� �������.

begin transaction

select * from UNIVERSITIES
 insert into UNIVERSITIES (ID, NAME, RATING, CITY)
 values (16, '�����', 570, '�����-���������')
 select * from UNIVERSITIES
 where ID = 16
      select * from LECTURERS
      insert into LECTURERS (ID, SURNAME, NAME, CITY, UNIV_ID)
      values (26, '�������', '��', '�����-���������', 16)
	       , (27, '������', '��', '�����-���������', 16)
	   select * from LECTURERS
	    where UNIV_ID = 16
   select * from STUDENTS
   insert into STUDENTS (ID, SURNAME, NAME, GENDER, STIPEND, COURSE, CITY, BIRTHDAY, UNIV_ID)
   values (46, '�����', '�����', 'f', 600, 2, '�����', '1992-06-21 00:00:00.000', 16)
        , (47, '������', '����', 'm', 600, 2, '�������', '1994-08-02 00:00:00.000', 16)
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


-- 56. ��������, ��� �������� �������� � �������� ���������� � ����. 
--    ������������� ��������������� ������� � ����.

begin transaction 

select * from STUDENTS
where SURNAME = '��������' or SURNAME = '��������'

update STUDENTS
   set UNIV_ID = (select ID
                    from UNIVERSITIES
		           where Name = '����')
 where SURNAME = '��������' or SURNAME = '��������'

 select * from STUDENTS
where SURNAME = '��������' or SURNAME = '��������'

rollback


-- 57. � ������� ���������� ������� ��������� ������� � ��� ��������, 
--    � ������� ������� ��� �� ��������� 3.5 ����� - ��������� �� ����������. 
--    �������� ��� ����������� �������� �� ��.
--    ����������: �������������� "�����������" ��������� � ������������� �������

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


-- 58. ��������� �� ������� ����� 4.75 ��������� 12.5% � ���������,
--    �� ������� ����� 5 �������� 200 ���.
--    ��������� ��������������� ��������� � ��.

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


-- 59. ���������� ������� ��� ��������, �� ������� �� ���� �������� �� ����� ������.
--    ���� ������� �����������, ���������� ������������� ������ ��������.

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


-- 60. ������ 3 ���� �� ������, ���������� ��������� ������� � ��� ������.

begin transaction
  
  select * from LECTURERS
	delete from SUBJ_LECT
     where LECTURER_ID = 3
  delete from LECTURERS
   where ID = 3
select * from LECTURERS
 where ID = 3

rollback


-- 61. �������� �������������� ������������� ��� ��������� �������� ��� ���� ���������, 
--    ������� ����������. ��������� ��� �������������, �������� ������ ����������, 
--    "�����������" �� � ����������.

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


-- 62. �������� ������������� ��� ��������� �������� � ���������� ��������� 
--    ����������� � ������ ������.

begin transaction

create view v_cnt_Students
as
select un.CITY, count(*) as cnt_Students
  from STUDENTS s
  join UNIVERSITIES un on s.UNIV_ID = un.ID
group by un.CITY

select * from cnt_Students

rollback


-- 63. �������� ������������� ��� ��������� �������� �� ������� ��������: 
--    ��� ID, �������, ���, ������� � ����� �����.

begin transaction

create view v_stud_info
as
select s.ID, s.SURNAME, avg(mark) as avg_mark, sum(mark) as total
  from STUDENTS s
  join EXAM_MARKS em on s.ID = em.STUDENT_ID
  group by s.ID, s.SURNAME

rollback


-- 64. �������� ������������� ��� ��������� �������� � �������� �������, 
--    ���, � ����� ���������� ���������, ������� �� ���� �������, � ����������,
--    ������� ��� ��� ����� ������� (� ������ �������� �����).

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


-- 65. �������� ������������� ������� STUDENTS � ������ STIP, ���������� ���� 
--    STIPEND � ID � ����������� ������� ��� �������� �������� ���� 
--    ���������, �� ������ � �������� �� 100 � � 500.

begin transaction

create view v_STIP
as 
select ID, STIPEND
  from STUDENTS
 where STIPEND between 100 and 500
with check option

rollback