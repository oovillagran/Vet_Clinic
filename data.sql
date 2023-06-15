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

