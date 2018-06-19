
--Suzdavame view
  CREATE VIEW v_SomeProjects AS
  SELECT * FROM Projects
  WHERE ProjectID >= 1 AND ProjectID <= 10
  
  --Slagame GO za da razdelim zaqvkata
  GO

  --Selectirame tova koeto iskame ot tova view koeto suzdadohme
  SELECT Name, EndDate FROM v_SomeProjects

  /*
VAJNO !!! : DUMICHKATA 'GO' OZN DA IZPULNIM VSICHKI ZAQVKI PREDI DUMICHKATA 'GO' !!!
Primerno ako imame VIEW obekt i sled tova iskame da selektirame v nego TOVA 
NQMA KAK DA STANE V EDNA ZAQVKA ZASHTOTO VIEW OBEKTA NE SUSHTESTVUVA V MOMENTA 
NA IZPULNQVANETO ZA ZAQVKATA 'SELEKT'. ZATOVA SE SLAGE 'GO' MEJDU SUZDAVANETO 
NA VIEW OBEKTA I SELEKTIRANETO.
*/
