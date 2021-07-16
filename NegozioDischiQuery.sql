-- Scrivere una query che restituisca i titoli degli album di Franco Battiato;

select titoloalbum , count(titoloalbum) as [Versioni Disponibili]
from (
	select Nome , Id
	from Band
	where Nome = 'Franco Battiato') b
inner join album a
on a.bandID = b.ID
group by TitoloAlbum

-- Selezionare tutti gli album editi dalla casa discografica nell’anno specificato;

Select *
from Album
where casadiscografica = 'EMI' and AnnoUscita = 1979

--Scrivere una query che restituisca tutti i titoli delle canzoni 
--degli U2 appartenenti ad album pubblicati prima del 1990;

select TitoloBrano
from (
	select TitoloBrano, bandid, annouscita
		from album
		inner join branoalbum
		on branoalbum.albumid = album.id
			inner join brano
			on branoalbum.branoid = brano.id
			) tab
inner join band
on band.id = tab.bandid
where annouscita < 1990

-- Individuare tutti gli album in cui è contenuta la canzone “Imagine”;

select TitoloAlbum
from album
inner join branoalbum
on branoalbum.albumid = album.id
		inner join brano
		on branoalbum.branoid = brano.id
where TitoloBrano = 'Imagine'

-- Restituire il numero totale di canzoni eseguite dai Pooh

select	count (*) as [Numero di Canzoni]
from band b
 inner join album a
 on b.id = a.bandid
	inner join branoalbum ba
	on a.id = ba.albumid
		inner join	brano 
		on brano.id = ba.branoid
where  brano.titolobrano = 'Pooh'

-- Contare per ogni album, la somma dei minuti dei brani contenuti

select  TitoloAlbum
		,sum(durata) as [Totale Minuti]
from album a
inner join BranoAlbum ba
on a.id = ba.AlbumID
	inner join brano b
	on b.id = branoid
group by TitoloAlbum

--Una delle query deve essere realizzata come Stored Procedure con parametri.

EXEC NumeroCanzoniPerBand @NomeBand=Pooh

--Scrivere una funzione utente che calcoli per ogni genere musicale quanti album sono inseriti in catalogo.

-- questa è la query che ho messo nella funzione
select genere, count(*) as [Numero Album in Catalogo]
from album a
inner join genere g
on a.genereid = g.id
group by genere
-- questa è la funzione
select *
from udfalbumpergenere()

--Creare una view che mostri i dati completi dell’album, della band e dei brani contenuti in esso.
-- Questa mi sa che è sbagliata
		select Nome, TitoloAlbum, TitoloBrano
		from (
			select Bandid, TitoloAlbum, album.id
			from album
			inner join branoalbum
			on album.id = branoalbum.albumid
			) tab
		inner join band
		on band.id = tab.bandid
		inner join (
				select TitoloBrano, albumid
				from brano
				inner join branoalbum
				on brano.id = branoalbum.branoid) tab2
		on tab.id = tab2.AlbumID
		