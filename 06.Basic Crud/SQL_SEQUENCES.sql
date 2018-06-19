
--1.Suzdavame si tablica Cars, Id-to nqma IDENTITY
CREATE TABLE Cars(
Id INT PRIMARY KEY NOT NULL,
Model varchar(25),
SeatsNumber INT
)


--2.Pravim si SEQUENCE
CREATE SEQUENCE seq_CarId
AS INT
START WITH 1
INCREMENT BY 1

--3.Selektvame si za da vidim dali raboti
SELECT NEXT VALUE FOR seq_CarId
--I da se diskonektnem ot vsichko posle pak kato vleznem si produljava


--4.Trqbva da go zakachim za tablicata Cars, shte trqbva da go zakachame vseki put ruchno !!!
INSERT INTO Cars(Id, Model, SeatsNumber)
VALUES
(NEXT VALUE FOR seq_CarId, 'Megane',5),
(NEXT VALUE FOR seq_CarId, '307',3),
(NEXT VALUE FOR seq_CarId, 'Astra',3)
--Prosto go slagame na id-to kato stoinost

--Mojem da go vkarvame i v drugi tablici

--TOVA KOETO NAPRAVIHME SE NARICHA SUBQUERY KOETO OZN DA IZVIKAME DADENO QUERI V DRUGO QUERY
