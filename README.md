# Project Roofs - Shelter Management System

Project Roofs is a Shelter Management System that allows administrators to manage residents, volunteers, donations, and visualize key statistics related to shelters. This command-line interface (CLI) application is designed to provide essential functionalities for efficient shelter administration.

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Installation](#installation)
4. [Usage](#usage)
5. [CLI Commands](#cli-commands)
6. [Conclusion](#conclusion)

## Introduction

Project Roofs is developed to streamline the management of shelters, making it easier for administrators to perform various tasks such as adding residents, managing volunteers, recording donations, and visualizing key statistics.

## Features

- Add and manage residents in shelters along with performing updates on leave date to indicate that residents have left the shelter
- Removal of residents as well as an option available to add new health records for current residents, along with the ability to update employment records to lete data remain up to date
- Adding a resident will ensure that their health record as well as employment record are both stored
- Volunteer management, including addition of new volunteers and changing their preferences (opt out)
- Donation management with the ability to view and add donations
- Visualizations for key statistics related to shelters

## Installation

To install and run the Project Roofs CLI, follow these steps:

1. Clone the repository.
2. Navigate to Projects Roofs directory: `cd Project-Roofs-Shelter-Management-System`
3. Ensure Python along with MySQL is installed in the system in order to carry out smooth functionality of the application.
Note: Latest version of Python and MySQL are recommended but not compulsory.
4. Install dependencies:
`pip install -r requirements.txt`
5. Running the MySQL Database dump file to ensure all tables and programming objects are available on the system.

## Usage
1. Run the main script:
`python main_script.py`
2. Follow the on-screen prompts to log in as an administrator and manage shelters.

## CLI Commands
There are various on screen commands that will help the user to navigate through the applcation. A lot of typing is not involved unless data is being entered like addition of residents. The commands will not require long strings to be inserted, they will be short strings or numbers for menu driven operations.

Do not worry about entering wrong or blank values, the error handling mechanism will reprompt the same question again.

## Conclusion
Creating Project Roofs was an ambition for us, we chose this project after reading multiple articles about homeless people's situation around the country. We aim to develop the GUI for the same through the winter break of 2023 using some library that we are accustomed to (ex. Custom Tkinter). If you think something needs to be fixed then do not hesitate to reach out.

[Dhruv Prakash Belai](mailto:belai.d@northeastern.edu)

[Padmasini Venkat](mailto:krishnanvenkat.p@northeastern.edu)