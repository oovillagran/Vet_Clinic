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


-- What animals belong to Melody Pond?

SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT full_name, name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?

SELECT species.name, COUNT(*) AS species_count FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT * FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?

SELECT owners.full_name, COUNT(*) AS owners_count FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY owners_count DESC;


-- MILESTONE 4TH

-- Who was the last animal seen by William Tatcher?

SELECT a.name, v.date_of_visit
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY v.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT a.id) AS total_animals_seen
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT v.name, 
       s.name AS specialty
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vets_id
LEFT JOIN species s ON sp.species_id = s.id
UNION
SELECT v.name, 'No specialty' AS specialty
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vets_id
RIGHT JOIN species s ON sp.species_id = s.id
WHERE s.name IS NULL;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT a.name, date_of_birth, escape_attempts, neutered, weight_kg, date_of_visit
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND (date_of_visit > '2020-04-01' AND date_of_visit < '2020-08-30');

-- What animal has the most visits to vets?

SELECT a.name, COUNT (date_of_visit) AS total_visits
FROM animals a
JOIN visits v ON a.id = v.animals_id
GROUP BY a.name
ORDER BY total_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT a.name, v.date_of_visit
FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT a.id, a.name, date_of_birth, escape_attempts, neutered, weight_kg, vt.name, age, date_of_visit
FROM animals a
JOIN visits v ON v.animals_id = a.id
JOIN vets vt ON v.vets_id = vt.id
ORDER BY v.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) AS num_visits_no_specialization
FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets vt ON v.vets_id = vt.id
LEFT JOIN specializations s ON vt.id = s.vets_id AND a.species_id = s.species_id
WHERE s.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT vt.name, species.name, COUNT(*) AS num_visits_no_specialization
FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets vt ON v.vets_id = vt.id
LEFT JOIN specializations s ON vt.id = s.vets_id AND a.species_id = s.species_id
JOIN species ON a.species_id = species.id
WHERE (s.species_id IS NULL OR s.species_id IS NULL) AND vt.name = 'Maisy Smith'
GROUP BY vt.name, species.name;

explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;
explain analyze SELECT * FROM visits where vets_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
