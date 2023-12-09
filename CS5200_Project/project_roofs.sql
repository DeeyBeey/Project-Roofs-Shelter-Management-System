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
    ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (
        (employment_status = TRUE AND employer_name IS NOT NULL AND job_title IS NOT NULL AND employment_begin IS NOT NULL) OR
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
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- table storing services provided
CREATE TABLE service(
	service_name VARCHAR(255) PRIMARY KEY NOT NULL);

-- services provided by shelter.
CREATE TABLE shelter_service(
	service_name VARCHAR(255) NOT NULL,
	shelter_name VARCHAR(128) NOT NULL,
    FOREIGN KEY (service_name) REFERENCES service(service_name)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (shelter_name) REFERENCES shelter(shelter_name)
    ON UPDATE CASCADE ON DELETE CASCADE
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
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (shelter_name) REFERENCES shelter(shelter_name)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- table storing information about the donations made to the shelter.
CREATE TABLE donation(
	first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    donation_date DATE NOT NULL,
    donation_description VARCHAR(1000) NOT NULL,
    shelter_name VARCHAR (128) NOT NULL,
    FOREIGN KEY (shelter_name) REFERENCES shelter (shelter_name)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- insert into admin (AES_ENCRYPT)    
INSERT INTO pr_admin 
VALUES 
('belai.d@northeastern.edu','dhruvbelai', AES_ENCRYPT('holygrail2965','CS5200')),
('venkat.p@northeastern.edu','padmavenkat', AES_ENCRYPT('godzilla1993','CS5200')),
('downey.r@northeastern.edu','robertdowney', AES_ENCRYPT('godspeed9001','CS5200'));

-- retrieve decrypted admin data.
SELECT username, CAST(AES_DECRYPT(admin_password,'CS5200') AS CHAR) FROM pr_admin;

-- insert into shelter.
INSERT INTO shelter
VALUES
("Boston Community Shelter", "128","Smith St.","Boston", "Massachusetts","02189","+1(762)-123-4567","120"),
("Brigham Shelter", "1280","Tremont St.","Boston", "Massachusetts","02120","+1(552)-123-4567","300"),
("Holy Hearts Shelter", "551","Huntington Ave.","Boston", "Massachusetts","02115","+1(890)-123-4567","120");

-- retrieve from shelter.
SELECT * FROM shelter;

-- insert into resident.
INSERT INTO resident (first_name, last_name, shelter_name, gender, dob, phone_no, join_date, leave_date)
VALUES 
("Smith", "Roberts", "Brigham Shelter", "Male", "1954-10-19","+1(932)-129-3340", "2023-11-25", NULL),
("Shelly", "Martin", "Boston Community Shelter", "Transgender", "1984-12-13","+1(431)-120-1230", "2023-11-20", NULL),
("Cassie", "Johnson", "Holy Hearts Shelter", "Female", "1990-03-01","+1(585)-789-0910", "2023-10-31", NULL),
("Isac", "King", "Boston Community Shelter", "Male", "1972-01-07","+1(832)-191-0091", "2023-10-24", NULL),
("Baljeet", "Singh", "Brigham Shelter", "Male", "1960-08-10","+1(657)-231-9981", "2023-12-01", NULL),
("Amelia", "Lens", "Holy Hearts Shelter", "Female", "1992-05-18","+1(556)-856-6790", "2023-10-20", NULL);

-- retrieve from residents.
SELECT * FROM resident;

-- update resident info.
UPDATE resident
SET leave_date= "2023-12-02"
WHERE resident_id = 3;

-- insert resident employment records.
INSERT INTO resident_employment
VALUES
("1",False, NULL, NULL, NULL, NULL),
("2", True, "7 Eleven", "Store Employee", "2023-01-09",NULL),
("3",False, NULL, NULL, NULL, NULL),
("4", True, "Stop and Shop", "Store Employee", "2023-05-01",NULL),
("5",False, NULL, NULL, NULL, NULL),
("6",False, NULL, NULL, NULL, NULL);

-- retrieve resident employment records.
SELECT * FROM resident_employment;

-- insert resident health records
INSERT INTO resident_health
VALUES
("1","2023-11-26","Sustained head injuries","Low Blood Pressure",NULL,"Painkillers"),
("2","2023-11-21","Dental issues","Asthama","Peanuts","Cavity Evictor"),
("3","2023-11-01","In good health",NULL,NULL,NULL),
("4","2023-10-25","Heart related issues, must avoid extreme physical activities","Blood Sugar High","Clam","Heart Aid"),
("5","2023-12-02","In good health",NULL,NULL,NULL),
("6","2023-11-01","In good health",NULL,NULL,NULL);

-- retrieve resident_health records
SELECT * FROM resident_health;

-- insert possible services that can be provided
INSERT INTO service
VALUES
("Beds"),
("Counselling"),
("Exercise"),
("Yoga");

-- retrieve the total possible services
SELECT * FROM service;

-- insert services provided by each shelter
INSERT INTO shelter_service 
VALUES
("Beds", "Boston Community Shelter"),
("Beds", "Holy Hearts Shelter"),
("Beds", "Brigham Shelter"),
("Counselling", "Boston Community Shelter"),
("Counselling", "Brigham Shelter"),
("Exercise", "Boston Community Shelter"),
("Exercise", "Brigham Shelter"),
("Yoga","Brigham Shelter"),
("Yoga", "Boston Community Shelter");

-- retrieve service provdided by each shelter
SELECT * FROM shelter_service;

-- insert services accessed by the resident
INSERT INTO resident_services
VALUES
("1", "Beds"),
("2", "Beds"),
("3", "Beds"),
("4", "Beds"),
("5", "Beds"),
("6", "Beds");

-- retrieve services accessed by the resident
SELECT * FROM resident_services;

-- insert volunteer details
INSERT INTO volunteer
VALUES
(1,"Ronald","Smith","+1(119)-732-4890"),
(2,"Daniel","Lawrence","+1(232)-459-7651"),
(3,"John","Fitzgerald","+1(769)-123-4060");

-- retrieve volunteer information
SELECT * FROM volunteer;

-- insert information about which volunteer volunteers at which shelter
INSERT INTO volunteer_shelter
VALUES
("1","Boston Community Shelter"),
("2","Boston Community Shelter"),
("1","Brigham Shelter"),
("3","Brigham Shelter"),
("3","Holy Hearts Shelter");

-- retrieve which volunteer volunteers from which shelter
SELECT * FROM volunteer_shelter;

INSERT INTO donation
VALUES
("Mack", "Birch", "2023-12-01", "Meal for 20 people", "Boston Community Shelter"),
("Jack", "Mullins", "2023-12-02", "Christmas gifts for 20 people", "Boston Community Shelter"),
("Veronica", "Sanders", "2023-11-30", "Knitted sweaters for the elderly", "Brigham Shelter"),
("Mia", "Martin", "2023-11-28", "Chocolates for everyone", "Brigham Shelter"),
("Sal", "King", "2023-12-05", "Snow shoes", "Holy Hearts Shelter"),
("Daniel", "Scott", "2023-12-08", "Groceries", "Holy Hearts Shelter");

-- Procedures START:

-- Procedure to insert a new admin to handle shelters.
DELIMITER //
CREATE PROCEDURE InsertNewAdmin(
    IN admin_email VARCHAR(255),
    IN admin_username VARCHAR(255),
    IN admin_password VARCHAR(255)
)
BEGIN
    DECLARE hashed_password VARBINARY(255);
    SET hashed_password = AES_ENCRYPT(admin_password, 'CS5200');
    INSERT INTO pr_admin (email_id, username, admin_password)
    VALUES (admin_email, admin_username, hashed_password);
    
    SELECT "\nNew admin added successfully" AS status;
END //
DELIMITER ;

-- Procedure to fetch all admins from the table for the sake of evaluation.
DELIMITER //
CREATE PROCEDURE GetAllAdmins()
BEGIN
    SELECT email_id, username, CAST(AES_DECRYPT(admin_password, 'CS5200') AS CHAR) AS pass
    FROM pr_admin;
END //
DELIMITER ;

-- Procedure to fetch all shelters.
DELIMITER //
CREATE PROCEDURE GetAllShelters()
BEGIN
    SELECT * FROM shelter;
END //
DELIMITER ;

-- Procedure to view statistics.
DELIMITER //
CREATE PROCEDURE GetShelterStatistics(IN shelter_name_p VARCHAR(255))
BEGIN
    DECLARE resident_count INT;
    DECLARE donation_count INT;
    DECLARE volunteer_count INT;
    DECLARE services_list VARCHAR(255);

	SELECT COUNT(*) INTO resident_count
	FROM resident
	WHERE shelter_name = shelter_name_p 
	AND (leave_date IS NULL OR leave_date > CURRENT_DATE);

    SELECT COUNT(*) INTO donation_count
    FROM donation
    WHERE shelter_name = shelter_name_p;

    SELECT COUNT(DISTINCT volunteer_id) INTO volunteer_count
    FROM volunteer_shelter
    WHERE shelter_name = shelter_name_p;

    SELECT GROUP_CONCAT(DISTINCT service_name) INTO services_list
    FROM shelter_service
    WHERE shelter_name = shelter_name_p;

    SELECT
        resident_count AS 'Number of Residents',
        donation_count AS 'Number of Donations',
        volunteer_count AS 'Number of Volunteers',
        services_list AS 'Services Provided'
    FROM DUAL;

END //
DELIMITER ;

-- Procedure to view residents in the shelter.
DELIMITER //
CREATE PROCEDURE ViewResidentsInShelter(IN shelter_name_p VARCHAR(255))
BEGIN
    SELECT
        resident_id AS id,
        first_name AS FirstName,
        last_name AS LastName,
        gender AS Gender,
        TIMESTAMPDIFF(YEAR, dob, CURRENT_DATE) AS Age,
        phone_no AS PhoneNumber,
        join_date AS JoinDate,
        leave_date AS LeaveDate
    FROM resident
    WHERE shelter_name = shelter_name_p
    AND (leave_date IS NULL OR leave_date > CURRENT_DATE);
END //
DELIMITER ;

-- Procedure to view residents who have left the shelter (past residents).
DELIMITER //
CREATE PROCEDURE ViewPastResidentsInShelter(IN shelter_name_p VARCHAR(255))
BEGIN
    SELECT
		resident_id AS id,
        first_name AS FirstName,
        last_name AS LastName,
        gender AS Gender,
        TIMESTAMPDIFF(YEAR, dob, CURRENT_DATE) AS Age,
        phone_no AS PhoneNumber,
        join_date AS JoinDate,
        leave_date AS LeaveDate
    FROM resident
    WHERE shelter_name = shelter_name_p
    AND (leave_date IS NOT NULL OR leave_date < CURRENT_DATE);
END //
DELIMITER ;

-- Procedure to insert a new resident into shelter.
DELIMITER //
CREATE PROCEDURE InsertNewResident(
    IN first_name_p VARCHAR(255),
    IN last_name_p VARCHAR(255),
    IN shelter_name_p VARCHAR(255),
    IN gender_p VARCHAR(20),
    IN dob_p DATE,
    IN phone_no_p VARCHAR(20),
    IN join_date_p DATE
)
BEGIN
    DECLARE new_resident_id INT;

    IF join_date_p > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid join date. Please enter a date not greater than the current date.';
    ELSE
        INSERT INTO resident (first_name, last_name, shelter_name, gender, dob, phone_no, join_date)
        VALUES (first_name_p, last_name_p, shelter_name_p, gender_p, dob_p, phone_no_p, join_date_p);
        SELECT LAST_INSERT_ID() INTO new_resident_id;
    END IF;
    SELECT new_resident_id AS new_resident_id;
END //
DELIMITER ;

-- Procedure to remove a resident.
DELIMITER //
CREATE PROCEDURE RemoveResident(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);

    SELECT shelter_name INTO shelter_name_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db IS NOT NULL AND shelter_name_db = shelter_name_p THEN
        DELETE FROM resident
        WHERE resident_id = resident_id_p;

        SELECT '\nResident removed successfully.' AS status;
    ELSE
        SELECT '\nError: Resident not found or not part of the specified shelter.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to update leave date to show that a resident has left the shelter.
DELIMITER //
CREATE PROCEDURE UpdateLeaveDate(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255),
    IN leave_date_p DATE
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);
    DECLARE join_date_db DATE;

    SELECT shelter_name, join_date INTO shelter_name_db, join_date_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db = shelter_name_p THEN
        IF leave_date_p IS NOT NULL AND leave_date_p <= CURRENT_DATE AND leave_date_p >= join_date_db THEN
            UPDATE resident
            SET leave_date = leave_date_p
            WHERE resident_id = resident_id_p;

            SELECT '\nLeave date updated successfully.' AS status;
        ELSE
            SELECT '\nError: Invalid leave date. Leave date must be less than or same as current date and greater than or equal to join date.' AS status;
        END IF;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to add a health report.
DELIMITER //
CREATE PROCEDURE AddHealthReport(
    IN shelter_name_p VARCHAR(128),
    IN health_report_details_p VARCHAR(1000),
    IN resident_conditions_p VARCHAR(255),
    IN resident_allergies_p VARCHAR(255),
    IN resident_medication_p VARCHAR(255)
)
BEGIN
    DECLARE latest_resident_id INT;
    DECLARE join_date_resident DATE;

    SELECT resident_id, join_date INTO latest_resident_id, join_date_resident
    FROM resident
    WHERE shelter_name = shelter_name_p
    ORDER BY resident_id DESC
    LIMIT 1;

    INSERT INTO resident_health (resident_id, health_report_date, health_report_details, resident_condition, resident_allergies, resident_medication)
    VALUES (latest_resident_id, join_date_resident, health_report_details_p, resident_conditions_p, resident_allergies_p, resident_medication_p);

    SELECT '\nHealth report added successfully.' AS status;
END //
DELIMITER ;

-- Procedure to add a new resident employment record.
DELIMITER //
CREATE PROCEDURE AddResidentEmploymentRecord(
    IN shelter_name_p VARCHAR(255),
    IN employment_status_p BOOLEAN,
    IN employer_name_p VARCHAR(255),
    IN job_title_p VARCHAR(255),
    IN employment_begin_date_p DATE,
    IN employment_end_date_p DATE
)
BEGIN
    DECLARE latest_resident_id INT;

    SELECT MAX(resident_id) INTO latest_resident_id
    FROM resident
    WHERE shelter_name = shelter_name_p;

    INSERT INTO resident_employment (resident_id, employment_status, employer_name, job_title, employment_begin, employment_end)
    VALUES (
        latest_resident_id,
        employment_status_p,
        employer_name_p,
        job_title_p,
        employment_begin_date_p,
        employment_end_date_p
    );
    SELECT '\nResident employment record added successfully.' AS status;
END //
DELIMITER ;

-- Procedure to view health records of residents.
DELIMITER //
CREATE PROCEDURE ViewHealthRecords(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);

    SELECT shelter_name INTO shelter_name_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db IS NOT NULL AND shelter_name_db = shelter_name_p THEN
        SELECT health_report_date, health_report_details, resident_condition, resident_allergies, resident_medication
        FROM resident_health
        WHERE resident_id = resident_id_p;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to view employment records of residents.
DELIMITER //
CREATE PROCEDURE ViewEmploymentRecords(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);

    SELECT shelter_name INTO shelter_name_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db = shelter_name_p THEN
        SELECT *
        FROM resident_employment
        WHERE resident_id = resident_id_p;

    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to view volunteers at a shelter
DELIMITER //
CREATE PROCEDURE ViewShelterVolunteers(
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    SELECT v.volunteer_id, v.first_name, v.last_name, v.phone_no
    FROM volunteer v
    INNER JOIN volunteer_shelter vs ON v.volunteer_id = vs.volunteer_id
    WHERE vs.shelter_name = shelter_name_p;
END //
DELIMITER ;

-- Procedure to view donations received by a shelter
DELIMITER //
CREATE PROCEDURE ViewShelterDonations(
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    SELECT first_name, last_name, donation_date, donation_description
    FROM donation
    WHERE shelter_name = shelter_name_p;
END //
DELIMITER ;

-- Procedure to add donations to the shelter.
DELIMITER //
CREATE PROCEDURE AddDonationToShelter(
    IN first_name_p VARCHAR(255),
    IN last_name_p VARCHAR(255),
    IN donation_date_p DATE,
    IN donation_description_p VARCHAR(255),
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    INSERT INTO donation (first_name, last_name, donation_date, donation_description, shelter_name)
    VALUES (first_name_p, last_name_p, donation_date_p, donation_description_p, shelter_name_p);
    SELECT '\nDonation added successfully.' AS status;
END //
DELIMITER ;

-- Procedure to insert new volunteers.
DELIMITER //
CREATE PROCEDURE InsertVolunteer(
    IN first_name_p VARCHAR(255),
    IN last_name_p VARCHAR(255),
    IN phone_no_p VARCHAR(20),
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE volunteer_id INT;

    INSERT INTO volunteer (first_name, last_name, phone_no)
    VALUES (first_name_p, last_name_p, phone_no_p);

    SELECT LAST_INSERT_ID() INTO volunteer_id;

    INSERT INTO volunteer_shelter (volunteer_id, shelter_name)
    VALUES (volunteer_id, shelter_name_p);

    SELECT '\nVolunteer added successfully.' AS status;
END //
DELIMITER ;

-- Procedure to delete a colunteer record.
DELIMITER //
CREATE PROCEDURE DeleteVolunteer(
    IN volunteer_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE volunteer_shelter_name VARCHAR(255);

    SELECT shelter_name INTO volunteer_shelter_name
    FROM volunteer_shelter
    WHERE volunteer_id = volunteer_id_p
    LIMIT 1;

    IF volunteer_shelter_name = shelter_name_p THEN
        DELETE FROM volunteer
        WHERE volunteer_id = volunteer_id_p;

        SELECT '\nVolunteer record deleted successfully.' AS status;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the volunteer\'s shelter.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to add resident health record
DELIMITER //
CREATE PROCEDURE AddResidentHealthRecord(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255),
    IN health_report_date_p DATE,
    IN health_report_details_p VARCHAR(255),
    IN resident_conditions_p VARCHAR(255),
    IN resident_allergies_p VARCHAR(255),
    IN resident_medications_p VARCHAR(255)
)
BEGIN
    DECLARE resident_shelter_name VARCHAR(255);

    SELECT shelter_name INTO resident_shelter_name
    FROM resident
    WHERE resident_id = resident_id_p
    LIMIT 1;  

    IF resident_shelter_name = shelter_name_p THEN
        INSERT INTO resident_health (
            resident_id,
            health_report_date,
            health_report_details,
            resident_condition,
            resident_allergies,
            resident_medication
        )
        VALUES (
            resident_id_p,
            health_report_date_p,
            health_report_details_p,
            resident_conditions_p,
            resident_allergies_p,
            resident_medications_p
        );

        SELECT '\nResident health record added successfully.' AS status;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to update resident employment record.
DELIMITER //
CREATE PROCEDURE UpdateResidentEmploymentRecord(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255),
    IN employment_status_p BOOLEAN,
    IN employer_name_p VARCHAR(255),
    IN job_title_p VARCHAR(255),
    IN employment_begin_date_p DATE,
    IN employment_end_date_p DATE
)
BEGIN
    DECLARE matching_records_count INT;
    SELECT COUNT(*)
    INTO matching_records_count
    FROM resident
    WHERE resident_id = resident_id_p AND shelter_name = shelter_name_p;

    IF matching_records_count > 0 THEN
        UPDATE resident_employment
        SET
            employment_status = employment_status_p,
            employer_name = employer_name_p,
            job_title = job_title_p,
            employment_begin = employment_begin_date_p,
            employment_end = employment_end_date_p
        WHERE resident_id = resident_id_p;

        SELECT '\nResident employment record updated successfully.' AS status;
    ELSE
        SELECT '\nError: Provided Resident ID or Shelter Name does not match the existing records.' AS status;
    END IF;
END //
DELIMITER ;

-- Procedure to get gender distributions in the shelter.
DELIMITER //
CREATE PROCEDURE GetGenderDistribution()
BEGIN
    SELECT gender, COUNT(*) as gender_count
    FROM resident
    GROUP BY gender;
END //
DELIMITER ;

-- Procedure to get resident distribution in shelters.
DELIMITER //
CREATE PROCEDURE GetResidentCountByShelter()
BEGIN
    SELECT
        shelter_name,
        COUNT(*) AS resident_count
    FROM resident
    GROUP BY shelter_name
    ORDER BY shelter_name;
END //
DELIMITER ;

-- Procedure to get join count by grouping join date.
DELIMITER //
CREATE PROCEDURE GetJoinCountByDate()
BEGIN
    SELECT join_date, COUNT(*) AS join_count
    FROM resident
    GROUP BY join_date;
END //
DELIMITER ;