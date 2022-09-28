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
