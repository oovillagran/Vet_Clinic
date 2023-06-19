/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '02-03-20', 0, TRUE, 10.23), 
    ('Gabumon', '11-15-18', 2, TRUE, 8), 
    ('Pikachu', '01-07-21', 1, FALSE, 15.04), 
    ('Devimon', '05-12-17', 5, TRUE, 11);

INSERT INTO animals (NAME, DATE_OF_BIRTH, ESCAPE_ATTEMPTS, NEUTERED, WEIGHT_KG) 
VALUES ('Charmander', '02-08-20', 0, false, -11), 
('Plantmon', '11-15-21', 2, true, -5.7), 
('Squirtle', '04-02-93', 3, false, -12.13), 
('Angemon', '06-12-05', 1, true, -45), 
('Boarmon', '06-07-05', 7, true, 20.4), 
('Blossom', '10-13-98', 3, true, 17), 
('Ditto', '05-14-22', 4, true, 22);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');

UPDATE animals SET species_id = s.id FROM species s WHERE animals.name LIKE '%mon' AND s.name = 'Digimon';

UPDATE animals SET species_id = s.id FROM species s WHERE animals.name NOT LIKE '%mon' AND s.name = 'Pokemon';

UPDATE animals SET owner_id = o.id FROM owners o WHERE animals.name = 'Agumon' AND o.full_name = 'Sam Smith';

UPDATE animals SET owner_id = o.id FROM owners o WHERE (animals.name = 'Gabumon' OR animals.name = 'Pikachu') AND o.full_name = 'Jennifer Orwell';

UPDATE animals SET owner_id = o.id FROM owners o WHERE (animals.name = 'Devimon' OR animals.name = 'Plantmon') AND o.full_name = 'Bob';

UPDATE animals SET owner_id = o.id FROM owners o WHERE (animals.name = 'Charmander' OR animals.name = 'Squirtle' OR animals.name = 'Blossom') AND o.full_name = 'Melody Pond';

UPDATE animals SET owner_id = o.id FROM owners o WHERE (animals.name = 'Angemon' OR animals.name = 'Boarmon') AND o.full_name = 'Dean Winchester';

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '04-23-00'),
('Maisy Smith', 26, '01-17-19'),
('Stephanie Mendez', 64, '05-04-81'),
('Jack Harkness', 38, '06-08-08');

INSERT INTO specializations VALUES (1, 1), (1, 3), (2, 3), (2, 4);

INSERT INTO visits VALUES
(1, 1, '05-24-20'),
(1, 3, '07-22-20'),
(2, 4, '02-02-21'), 
(3, 2, '01-05-20'), 
(3, 2, '03-08-20'), 
(3, 2, '05-14-20'), 
(4, 3, '05-04-21'), 
(5, 4, '02-24-21'), 
(6, 2, '12-21-19'), 
(6, 1, '08-10-20'), 
(6, 2, '04-07-21'), 
(7, 3, '09-29-19'), 
(8, 4, '10-03-20'), 
(8, 4, '11-04-20'), 
(9, 2, '01-24-19'), 
(9, 2, '05-15-19'), 
(9, 2, '02-27-20'), 
(9, 2, '08-03-20'), 
(10, 3, '05-24-20'), 
(10, 1, '01-11-21');

INSERT INTO visits (animals_id, vets_id, date_of_visit)
SELECT * FROM (SELECT id FROM animals) animal_ids,
(SELECT id FROM vets) vets_ids,
generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp
ON CONFLICT DO NOTHING;

INSERT INTO visits (animals_id, vets_id, date_of_visit)
SELECT * FROM (SELECT id FROM animals) animal_ids,
(SELECT id FROM vets) vets_ids,
generate_series('1980-01-01'::timestamp, '2021-01-01', '1 hours') visit_timestamp
ON CONFLICT DO NOTHING;

INSERT INTO owners (full_name, email) select 'Owner ' || generate_series(1,7500000), 'owner_' || generate_series(1,7500000) || '@mail.com';
