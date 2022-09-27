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