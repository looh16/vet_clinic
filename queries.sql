/*Queries that provide answers to the questions FROM all projects.*/

--Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name like '%mon';

--List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-31-12';

--List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals  WHERE neutered = 't' AND escape_attempts < 3;

--List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name='Pikachu';

--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--Find all animals that are neutered
SELECT * FROM animals WHERE neutered = 't';

--Find all animals not named Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


--Setting the species column to unspecified and roll back the changes 
BEGIN;
    UPDATE animals
    SET species = 'unspecified';
ROLLBACK;

--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
Begin; 
    UPDATE animals SET species = 'digimon' WHERE name like '%mon';
commit;

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set
Begin; 
    UPDATE animals SET species = 'pokemon' WHERE species IS NULL; 
commit;

--Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction
BEGIN;
    DELETE FROM animals;
ROLLBACK;

/**
Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction
*/
BEGIN;
    DELETE FROM animals WHERE date_of_birth > '01-01-2022';
    SAVEPOINT sp1;
    UPDATE animals set weight_kg = weight_kg * -1;
    ROLLBACK TO sp1;
    UPDATE animals set weight_kg = weight_kg *-1 WHERE weight_kg < 0;
COMMIT;

--How many animals are there?
SELECT COUNT(*) FROM animals;

--How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

--What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, max(escape_attempts) FROM animals GROUP BY neutered;

--What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, avg(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '12-31-2000' GROUP BY species;

--What animals belong to Melody Pond?
SELECT an.name as animal_name, ow.full_name as owner 
FROM animals an 
INNER JOIN owners ow on (an.owner_id = ow.id)
where ow.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals an
INNER JOIN species sp on (an.species_id = sp.id)
where sp.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM animals an
left JOIN owners ow on (an.owner_id = ow.id);

--How many animals are there per species?
SELECT sp.name as specie_name, count(*) as total FROM animals an
INNER JOIN species sp on (an.species_id = sp.id)
GROUP BY sp.name;

--List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals an
INNER JOIN owners ow on (an.owner_id = ow.id)
where ow.full_name='Jennifer Orwell' and an.name like '%mon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals an
INNER JOIN owners ow on (an.owner_id = ow.id)
where ow.full_name='Dean Winchester' and an.escape_attempts = 0;

--Who owns the most animals?
SELECT ow.full_name as owner_name, count(*) as total 
FROM animals an
INNER JOIN owners ow on (an.owner_id = ow.id) 
group by ow.full_name 
order by total desc ;

--Who was the last animal seen by William Tatcher?
SELECT vt.name, an.name , vs1.date_of_visit FROM visits vs1
inner join vets vt on (vs1.vet_id = vt.id)
inner join animals an on (vs1.animals_id = an.id)
where vs1.date_of_visit = (
    SELECT max(vs2.date_of_visit) from  visits vs2
    inner join vets vt2 on (vs2.vet_id = vt2.id)
    where vt2.name='William Tatcher'
);

--How many different animals did Stephanie Mendez see?
SELECT DISTINCT COUNT(*) FROM visits vs
inner join vets vt on (vs.vet_id = vt.id)
inner join animals an on (vs.animals_id = an.id)
where vt.name = 'Stephanie Mendez';


--List all vets and their specialties, including vets with no specialties.
select vts.name, sp.name as specialties from vets vts
LEFT JOIN specializations s ON s.vet_id = vts.id 
LEFT JOIN species sp ON sp.id = S.species_id ;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT * FROM animals an
inner JOIN visits v ON v.animals_id = an.id 
inner JOIN vets vts ON v.vet_id = vts.id 
WHERE vts.name = 'Stephanie Mendez' 
AND v.date_of_visit BETWEEN '04-01-2020' AND '08-30-2020';


--What animal has the most visits to vets?
SELECT an.name as visited_animal, count(*) as total_visits FROM animals an 
INNER JOIN visits v ON v.animals_id = an.id 
INNER JOIN vets vt ON vt.id = v.vet_id 
GROUP BY an.name order by total_visits desc;


--Who was Maisy Smith's first visit?
SELECT an.name as animal_name, vs1.date_of_visit FROM visits vs1
inner join vets vt on (vs1.vet_id = vt.id)
inner join animals an on (vs1.animals_id = an.id)
where vs1.date_of_visit = (
    SELECT min(vs2.date_of_visit) from  visits vs2
    inner join vets vt2 on (vs2.vet_id = vt2.id)
    where vt2.name='Maisy Smith'
);

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT  an.name as animal_name, an.date_of_birth, an.escape_attempts, an.neutered, an.weight_kg, vt.name as vet_name, vt.date_of_graduation, vt.age, v.date_of_visit FROM visits v 
INNER JOIN animals an ON v.animals_id = an.id 
Inner JOIN vets vt ON v.vet_id = vt.id
where v.date_of_visit = (
    select max(v1.date_of_visit)
    from visits v1
);


--How many visits were with a vet that did not specialize in that animal's species?
SELECT count(*) FROM vets vt
LEFT JOIN visits vs ON vs.vet_id = vt.id 
LEFT JOIN animals an ON vs.animals_id = an.id 
LEFT JOIN specializations sp ON sp.vet_id = vt.id 
LEFT JOIN species spc ON sp.species_id = spc.id 
WHERE vt.id not in (select vet_id from specializations);


--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT spc.name, count(*) as total_gets FROM visits vst 
INNER JOIN animals an ON vst.animals_id = an.id 
INNER JOIN vets vt ON vst.vet_id = vt.id 
INNER JOIN species spc ON an.species_id = spc.id
WHERE vt.name = 'Maisy Smith'
group by an.species_id, spc.name;

--performance audit
SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';







