CREATE DATABASE IF NOT EXISTS chicago;

USE chicago;

DROP TABLE IF EXISTS community_data;

CREATE TABLE community_data (
    ca INT PRIMARY KEY,
    community_area_name VARCHAR(255),
    percent_of_housing_crowded FLOAT,
    percent_households_below_poverty FLOAT,
    percent_aged_16_unemployed FLOAT,
    percent_aged_25_without_high_school_diploma FLOAT,
    percent_aged_under_18_or_over_64 FLOAT,
    per_capita_income_ FLOAT,
    hardship_index FLOAT
);
