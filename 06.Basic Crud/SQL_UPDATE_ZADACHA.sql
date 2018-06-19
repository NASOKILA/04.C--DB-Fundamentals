

--Shte rabotim vurhu tablicata Project V bazata SoftUni
--Trqbva da setnem EndData na segashnata data, v momenta e NULL
UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL
--s GETDATE() vzimame segashnata data