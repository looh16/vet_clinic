/* Populate database with sample data. */

--Insert data in table animals
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Agumon', '2020-02-03',0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Gabumon', '2018-11-15',2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Pikachu', '2021-01-07',1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Devimon', '2017-05-12',5, true, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Charmander', '2020-02-08',0, false, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Plantmon', '2021-11-15',2, true, 5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Squirtle', '1993-04-02',3, false, 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Angemon', '2005-06-12',1, true, 45);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Boarmon', '2005-06-07',7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Blossom', '1998-10-13',3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Ditto', '2022-05-14',4, true, 22);


--Insert data in table owners
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);


--Insert data in table species
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

--Modify your inserted animals so it includes the species_id value:
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

--Modify your inserted animals to include owner information (owner_id):
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name in ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name in ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name in ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name in ('Angemon', 'Boarmon');

--Insert data in table vets
INSERT INTO vets (name, date_of_graduation, age) VALUES ('William Tatcher', '2000-04-23', 45);
INSERT INTO vets (name, date_of_graduation, age) VALUES ('Maisy Smith', '2019-01-17', 26);
INSERT INTO vets (name, date_of_graduation, age) VALUES ('Stephanie Mendez', '1981-05-04', 64);
INSERT INTO vets (name, date_of_graduation, age) VALUES ('Jack Harkness', '2008-06-08', 38);


--Insert data in table specializations
INSERT INTO specializations (species_id, vet_id) VALUES (1,1);
INSERT INTO specializations (species_id, vet_id) VALUES (1,3);
INSERT INTO specializations (species_id, vet_id) VALUES (2,3);
INSERT INTO specializations (species_id, vet_id) VALUES (2,4);

--Insert data in table visits
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (3, 2, '2020-05-08');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (10, 3, '2020-05-24');
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES (10, 1, '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';










