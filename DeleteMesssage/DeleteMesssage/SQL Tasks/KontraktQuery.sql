--������ ������ � �-�� ���������� � ���, ���������� �� ����� 100 ���������� �� ��������� �����.
select Rubric.Name, count(Document_Rubric.ID_Document)
from Rubric inner join Document_Rubric on Rubric.ID = Document_Rubric.ID_Rubric
inner join Document on Document_Rubric.ID_Document = Document.ID
where Document.Date > DATEADD(month, -1, GetDate())
group by Rubric.Name
having count(Document_Rubric.ID_Document) >= 100

--������������� ����� ��������� ������� �� ��� ������� ����� � ������� Document_Rubric, 
--�� Rubric.Name - ��� ��� �������� ����������� ������� �� ����� ���� � ����, �� ������� ������� �����

--���� ����� ��
--Customer (Id, Name)
--Sale (Id, CustomerId, Date, Sum)
--�������� �������:
--1. ������ ���������� �� ��� ����� (��� Customer, � �������� �������� ������ ����� ���� Sum)
select TOP 1 Customer.Name,sum(Sale.Sum) all_summ
from Customer inner join Sale on Customer.Id = Sale.CustomerId
group by Customer.Name
order by all_summ desc

--2. ������ ���������� ��� ������� ������ (�� �� �����, ��� � 1, ������ ��� ������� ������ �������� ����)
WITH Sales(Name, month_sum, SaleMonth)  
AS  
	(select Customer.Name,sum(Sale.Sum), month(Sale.date)
	from Customer inner join Sale on Customer.Id = Sale.CustomerId
	where year(Sale.date) = year(GetDate())										--������� ���
	group by Customer.Name, month(Sale.date))
select Sales.Name, Sales.SaleMonth, Sales.month_sum 
from Sales
inner join
	(select MAX(month_sum) m_sum, SaleMonth 
	 from Sales
	 group by SaleMonth) max_month on Sales.month_sum = max_month.m_sum and Sales.SaleMonth = max_month.SaleMonth
Go

