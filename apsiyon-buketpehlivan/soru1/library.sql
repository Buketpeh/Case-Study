-------t-sql ile 4 adet join sorgusu teslim ediniz. Her sorgu 2 farkl� tablo ile ba�lant�y� ��z�mlemesi gerekmektedir.---------
---------------------------------------------------------------------------------------------------------------------------
use library

--1 -D��ar�dan parametre olarak verilen yazara ait kitaplar� listelemek i�in gerekli yordam� olu�turunuz.

create procedure author_books (@author_firstname varchar(30)=null,@author_lastname varchar(30)=null)
as
set nocount on
Select Author.FirstName,Author.LastName, Book.Book_Name 
from 
Book_Author inner join Book on Book_Author.Isbn=Book.Isbn 
inner join Author on Book_Author.Author_Id=Author.Author_Id
 where (Author.FirstName=@author_firstname) and (Author.LastName=@author_lastname)
go
exec author_books 'b','b'

--2 -Teslim tarihi ge�mi� kitaplardan ,sayfa say�s� girilen rakamdan b�y�k olan kitaplar� listeleyen fonksiyonu yaz�n�z.

create function book_find(@totalpage int)
returns table
as
return 
(
select Book.Book_Name 
from Book inner join deposit on Book.Isbn=deposit.�sbn  
where deposit.Delivery_Date<(select GETDATE()) and Book.Total_Pages> @totalpage
)
go
select*from dbo.book_find(5)

--3 -�sminin i�erisinde y bulunan �yelerin, emanet ald��� kitaplar�n �sbn numaras�n� listeleyen t-sql'i yaz�n�z.

if EXISTS(select deposit.Isbn from deposit inner join member on deposit.Member_Id=member.Member_Id where member.FirstName like '%y%')
PRINT '�sminin i�erisinde y harfi ge�en kullan�c� bulunmaktad�r.'
else
PRINT '�sminin i�erisinde y harfi ge�en kullan�c� bulunmamaktad�r!'
go

--4 -25 liran�n �zerinde olan kitaplar� kategorisine g�re artan s�ralamada kitaplar�n ismi ve  fiyat�n� listeleyiniz.

create procedure book_list 
as
select Book.Book_Name,Book.Price 
from Book inner join Book_Categoriy on Book.Isbn=Book_Categoriy.Isbn 
inner join Category on Book_Categoriy.Category_Id=Category.Category_Id order by Category.Category_Name
go

-------------8 tablonun ili�kisini bir join sorgusuyla yaz�n�z.-----------------------------------------------------------
--Ad� buket olan ve yalovada oturan �yenin ald��� kitaplar�n �sbn,ad�,sayfa say�s�,
----kitab�n yazar� ve kategori ad�n� kategori ad�na g�re artan s�rada listele
select Category.Category_Name,Book.Book_Name,Book.Total_Pages,Author.FirstName,Author.LastName 
from 
Book inner join deposit on Book.Isbn=deposit.Isbn inner join member on deposit.Member_Id=member.Member_Id 
inner join Adress on Adress.Adres_Id=member.Member_Id inner join Book_Author on Book.Isbn=Book_Author.Isbn
inner join Author on Book_Author.Author_Id=Author.Author_Id inner join Book_Categoriy on Book.Isbn=Book_Categoriy.Isbn
inner join Category on Book_Categoriy.Category_Id=Category.Category_Id 
where member.FirstName='Buket' and Adress.City='Yalova'
order by Category.Category_Name 


----------------------4 tablolu alt sorgu yaz�n�z-------------------------------------------------------------------------------------
--�smi a ile ba�layan yazarlar�n kitaplar� aras�ndan �uan emanet al�nan kitaplar� listeleyiniz.

 select Book.Book_Name from Book_Author,Book,deposit where Book_Author.Isbn=Book.Isbn and Book.Isbn=deposit.Isbn and 
 deposit.Delivery_Date>(select GETDATE()) and
  Book_Author.Author_Id=(select Author.Author_Id from Author where Author.FirstName like '%a%')

