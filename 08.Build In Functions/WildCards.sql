

-- VAJNO !!! : Dumichkata 'GO' Oznachava da izpulni zaqvite do momenta i da produlji kum sledvashtite
-- Mojme da kajem GO[count] koeto shte izpulni zaqvkite do momenta count puti


/*
WildCards

Selection results by partial match.
Primerno vzimame purvite 3 bukvi i ako sa ravni na 'abc'(primerno) da napravim edi kakvo si.
Polzvat se sus WHERE za da filtrirame za suvpadenie i LIKE za da opishem koe suvpadenie tursim.
V LIKE mojem da opisvame WildCard sinvoli kato:
'%' -> Matchva vsqkakuv string,
'_' -> Matchva vsqkakuv charachter ,
[...] -> Matchva vsqkakuv charachter v range,
[^...] -> Matchva vsqkakuv charachter koito ne e v range,

s dumichkata 'ESCAPE' nie eskeipvame specialnite sinvoli i gi tretirame kato normalni.

PODOBNO E KAKTO V REGEXITE
*/


SELECT 
EmployeeID,
FirstName,
LastName
FROM Employees
--WHERE FirstName LIKE('Rob%')  --Tezi koito zapochvat s 'Rob'
--WHERE FirstName LIKE('%ber%')  --Tezi koito sudurjat v tqh 'ber'  procenta e i otpred
WHERE FirstName LIKE('%to')  --Tezi koito zavurshvat na 'to'  procenta e nai otpred

SELECT 
EmployeeID,
FirstName,
LastName
FROM Employees
WHERE FirstName LIKE('Te[tn]%')
-- Tuk kazvame che zapochva s 'Te' i v [] pishem s koi vizmojnosti za posledovatelnost
-- V sluchaq ili produljava s 't' ili s 'n' zatova ni vadi samo dve imena













