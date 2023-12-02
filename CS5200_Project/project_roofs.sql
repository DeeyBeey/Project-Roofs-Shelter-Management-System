-- This is the file where we create the database.

CREATE DATABASE project_roofs;

USE project_roofs;

-- admin table.
CREATE TABLE pr_admin(
	email_id VARCHAR(128) PRIMARY KEY NOT NULL,
    username VARCHAR(128) UNIQUE NOT NULL,
    admin_password VARBINARY(255) NOT NULL 
);

-- shelter table.
CREATE TABLE shelter(
	shelter_name VARCHAR(128) PRIMARY KEY NOT NULL,
    street_no VARCHAR(10) NOT NULL,
    street_name VARCHAR(128) NOT NULL,
    city VARCHAR(64) NOT NULL,
    state VARCHAR(64) NOT NULL,
    zipcode VARCHAR(10) NOT NULL,
    CHECK (zipcode REGEXP '^[0-9]{5}(-[0-9]{4})?$'),
    phone_no VARCHAR(20) NOT NULL,
    CHECK (phone_no REGEXP '^[0-9+()-]*$'),
    max_capacity INT NOT NULL
);

-- resident table
CREATE TABLE resident(
	resident_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR (255),
    last_name VARCHAR (255),
    shelter_name VARCHAR(128) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    phone_no VARCHAR(20) NOT NULL,
    CHECK (phone_no REGEXP '^[0-9+()-]*$'),
    join_date DATE NOT NULL,
    leave_date DATE,
    FOREIGN KEY (shelter_name) REFERENCES shelter(shelter_name)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- table storing resident employment details.
CREATE TABLE resident_employment(
	resident_id INT,
	employment_status BOOLEAN NOT NULL,
    employer_name VARCHAR(255),
    job_title VARCHAR(255),
    employment_begin DATE,
    employment_end DATE,
    FOREIGN KEY (resident_id) REFERENCES resident(resident_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
    CHECK (
        (employment_status = TRUE AND employer_name IS NOT NULL AND job_title IS NOT NULL AND employment_begin IS NOT NULL AND employment_end IS NOT NULL) OR
        (employment_status = FALSE AND employer_name IS NULL AND job_title IS NULL AND employment_begin IS NULL AND employment_end IS NULL))
    );

-- table storing resident health details    
CREATE TABLE resident_health(
	resident_id INT,
	health_report_date DATE NOT NULL,
    health_report_details VARCHAR(1000) NOT NULL,
    resident_condition VARCHAR(512),
    resident_allergies VARCHAR(512),
    resident_medication VARCHAR(512),
    FOREIGN KEY (resident_id) REFERENCES resident(resident_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- table storing services provided by a shelter
CREATE TABLE service(
	service_name VARCHAR(255) PRIMARY KEY NOT NULL,
    shelter_name VARCHAR (128) NOT NULL,
    FOREIGN KEY (shelter_name) REFERENCES shelter(shelter_name)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


-- table storing services accessed by a resident
CREATE TABLE resident_services(
	resident_id INT NOT NULL,
    service_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (resident_id) REFERENCES resident(resident_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (service_name) REFERENCES service(service_name)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- table storing volunteer information
CREATE TABLE volunteer(
	volunteer_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_no VARCHAR(20) NOT NULL,
    CHECK (phone_no REGEXP '^[0-9+()-]*$')
);

--  table storing information about which shelters a volunteer volunteers at.
CREATE TABLE volunteer_shelter(
	volunteer_id INT NOT NULL,
    shelter_name VARCHAR(128) NOT NULL,
    FOREIGN KEY (volunteer_id) REFERENCES volunteer(volunteer_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (shelter_name) REFERENCES shelter(shelter_name)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- table storing information about the donations made to the shelter.
CREATE TABLE donation(
	first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    donation_date DATE NOT NULL,
    donation_description VARCHAR(1000) NOT NULL,
    shelter_name VARCHAR (128) NOT NULL,
    FOREIGN KEY (shelter_name) REFERENCES shelter (shelter_name)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- table storing information about meals provided by a shelter
CREATE TABLE meal(
	meal_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	meal_type ENUM("Breakfast","Lunch","Dinner","Snack","Brunch") NOT NULL,
    meal_date DATE NOT NULL,
    meal_description VARCHAR(255) NOT NULL,
	shelter_name VARCHAR(128) NOT NULL,
    FOREIGN KEY (shelter_name) REFERENCES shelter (shelter_name)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- table storing information about meals consumed by a resident.
CREATE TABLE resident_meal(
	meal_id INT NOT NULL,
    resident_id INT NOT NULL,
	FOREIGN KEY (meal_id) REFERENCES meal(meal_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (resident_id) REFERENCES resident(resident_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
    );