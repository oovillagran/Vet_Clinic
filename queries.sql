/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".

SELECT *
FROM animals
WHERE name LIKE '%mon';


-- List the name of all animals born between 2016 and 2019.

SELECT name
FROM animals
WHERE date_of_birth > '2016-01-01' and date_of_birth < '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name
FROM animals
WHERE neutered = true and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth
FROM animals
WHERE name = 'Agumon' or name ='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT *
FROM animals
WHERE neutered = TRUE;


-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg 
-- (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT *
FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.

BEGIN;
UPDATE ANIMALS SET species = 'unspecified';

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

BEGIN;
UPDATE ANIMALS SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE ANIMALS SET species = 'pokemon' WHERE species is NULL OR species = '';
COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.

BEGIN;
DELETE FROM ANIMALS;
ROLLBACK;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
BEGIN;
    DELETE FROM ANIMALS WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction.
    SAVEPOINT SP1;
-- Update all animals' weight to be their weight multiplied by -1.
    UPDATE ANIMALS SET WEIGHT_KG = WEIGHT_KG * -1;
-- Rollback to the savepoint
    ROLLBACK TO SP1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
    UPDATE ANIMALS SET WEIGHT_KG = WEIGHT_KG * -1 WHERE WEIGHT_KG < 0;
-- Commit transaction
COMMIT;

-- How many animals are there?

SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(id) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?

SELECT AVG(weight_kg) FROM animals;


-- Who escapes the most, neutered or not neutered animals?
SELECT SUM(escape_attempts), neutered FROM animals GROUP BY neutered;


-- What is the minimum and maximum weight of each type of animal?

SELECT MAX(weight_kg), MIN(weight_kg), specieS FROM ANIMALS GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT AVG(escape_attempts), species FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;
