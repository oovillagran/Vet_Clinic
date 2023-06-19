/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL(4, 2)
);

ALTER TABLE animals ADD COLUMN species varchar;

CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR, AGE INT);

CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);

-- 4TH MILESTONE

CREATE TABLE vets (id SERIAL PRIMARY KEY, name VARCHAR, age INT, date_of_graduation DATE);

CREATE TABLE specializations (species_id INT REFERENCES species(id), vets_id INT REFERENCES vets(id));

ALTER TABLE specializations ADD CONSTRAINT pk_specializations PRIMARY KEY (species_id, vets_id);

CREATE TABLE visits (animals_id INT REFERENCES animals(id), vets_id INT REFERENCES vets(id), date_of_visit DATE);

ALTER TABLE visits ADD CONSTRAINT pk_visits PRIMARY KEY (animals_id, vets_id);

ALTER TABLE VISITS ALTER COLUMN date_of_visit TYPE TIMESTAMP;

CREATE INDEX idx_animals_id ON animals (animals_id);
CREATE INDEX idx_vets_id ON visits (vets_id);
CREATE INDEX idx_email_id ON owners (email);
