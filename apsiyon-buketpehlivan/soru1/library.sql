-------t-sql ile 4 adet join sorgusu teslim ediniz. Her sorgu 2 farklý tablo ile baðlantýyý çözümlemesi gerekmektedir.---------
---------------------------------------------------------------------------------------------------------------------------
use library

--1 -Dýþarýdan parametre olarak verilen yazara ait kitaplarý listelemek için gerekli yordamý oluþturunuz.

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

--2 -Teslim tarihi geçmiþ kitaplardan ,sayfa sayýsý girilen rakamdan büyük olan kitaplarý listeleyen fonksiyonu yazýnýz.

create function book_find(@totalpage int)
returns table
as
return 
(
select Book.Book_Name 
from Book inner join deposit on Book.Isbn=deposit.ýsbn  
where deposit.Delivery_Date<(select GETDATE()) and Book.Total_Pages> @totalpage
)
go
select*from dbo.book_find(5)

--3 -Ýsminin içerisinde y bulunan üyelerin, emanet aldýðý kitaplarýn ýsbn numarasýný listeleyen t-sql'i yazýnýz.

if EXISTS(select deposit.Isbn from deposit inner join member on deposit.Member_Id=member.Member_Id where member.FirstName like '%y%')
PRINT 'Ýsminin içerisinde y harfi geçen kullanýcý bulunmaktadýr.'
else
PRINT 'Ýsminin içerisinde y harfi geçen kullanýcý bulunmamaktadýr!'
go

--4 -25 liranýn üzerinde olan kitaplarý kategorisine göre artan sýralamada kitaplarýn ismi ve  fiyatýný listeleyiniz.

create procedure book_list 
as
select Book.Book_Name,Book.Price 
from Book inner join Book_Categoriy on Book.Isbn=Book_Categoriy.Isbn 
inner join Category on Book_Categoriy.Category_Id=Category.Category_Id order by Category.Category_Name
go

-------------8 tablonun iliþkisini bir join sorgusuyla yazýnýz.-----------------------------------------------------------
--Adý buket olan ve yalovada oturan üyenin aldýðý kitaplarýn ýsbn,adý,sayfa sayýsý,
----kitabýn yazarý ve kategori adýný kategori adýna göre artan sýrada listele
select Category.Category_Name,Book.Book_Name,Book.Total_Pages,Author.FirstName,Author.LastName 
from 
Book inner join deposit on Book.Isbn=deposit.Isbn inner join member on deposit.Member_Id=member.Member_Id 
inner join Adress on Adress.Adres_Id=member.Member_Id inner join Book_Author on Book.Isbn=Book_Author.Isbn
inner join Author on Book_Author.Author_Id=Author.Author_Id inner join Book_Categoriy on Book.Isbn=Book_Categoriy.Isbn
inner join Category on Book_Categoriy.Category_Id=Category.Category_Id 
where member.FirstName='Buket' and Adress.City='Yalova'
order by Category.Category_Name 


----------------------4 tablolu alt sorgu yazýnýz-------------------------------------------------------------------------------------
--Ýsmi a ile baþlayan yazarlarýn kitaplarý arasýndan þuan emanet alýnan kitaplarý listeleyiniz.

 select Book.Book_Name from Book_Author,Book,deposit where Book_Author.Isbn=Book.Isbn and Book.Isbn=deposit.Isbn and 
 deposit.Delivery_Date>(select GETDATE()) and
  Book_Author.Author_Id=(select Author.Author_Id from Author where Author.FirstName like '%a%')

