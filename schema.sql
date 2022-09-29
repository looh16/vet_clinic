/* Database schema to keep the structure of entire database. */

--create database vet_clinic
CREATE DATABASE vet_clinic;

--create table animals
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg decimal,
    PRIMARY KEY(id)
);

--Add column species in animals table
ALTER TABLE animals ADD species varchar(100);

--create table owners
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100),
    age INT,
    PRIMARY KEY(id)
);

--create table species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    PRIMARY KEY(id)
);

--Remove column species
ALTER TABLE animals DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table
--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
  ADD species_id INT REFERENCES species(id),
  ADD owner_id INT REFERENCES owners(id);

  --create table vets
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_graduation date,
    age INT,
    PRIMARY KEY(id)
);

/*There is a many-to-many relationship between the tables species and vets: 
a vet can specialize in multiple species, 
and a species can have multiple vets specialized in it. Create a "join table" called 
specializations to handle this relationship.*/

--create join table specializations
CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    species_id INT,
    vet_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(species_id) REFERENCES species(id),
    FOREIGN KEY(vet_id) REFERENCES vets(id)
);

/*There is a many-to-many relationship between the tables animals and vets:  an animal can visit multiple 
vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, 
it should also keep track of the date of the visit.*/

-- Create join table visits
CREATE TABLE visits (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    animals_id INT,
    vet_id INT,
    date_of_visit DATE NOT NULL,
    FOREIGN KEY(animals_id) REFERENCES animals(id),
    FOREIGN KEY(vet_id) REFERENCES vets(id) 
);


