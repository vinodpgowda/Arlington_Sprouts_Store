# **Arlington Sprouts Store Neo4j Project**

Arlington Sprouts Store Neo4j Project aims to visualize and interact with data from the Arlington Sprouts Store, converting tabular data from CSV files into a structured Neo4j graph database. The conversion allows for enhanced and efficient data retrieval through graph-based queries, facilitating a better understanding of customer preferences, purchase patterns, and inventory management.

## **Table of Contents**
- [**Arlington Sprouts Store Neo4j Project**](#arlington-sprouts-store-neo4j-project)
  - [**Table of Contents**](#table-of-contents)
  - [**Programming Languages and Systems**](#programming-languages-and-systems)
    - [**Programming Languages**](#programming-languages)
    - [**Database Management System**](#database-management-system)
  - [**Project Structure**](#project-structure)
  - [**Getting Started**](#getting-started)
    - [**Prerequisites**](#prerequisites)
    - [**Setting up the Environment**](#setting-up-the-environment)
    - [**Running the Program**](#running-the-program)
  - [**Contribution**](#contribution)
  - [**License**](#license)
  - [**Contact**](#contact)

## **Programming Languages and Systems**

### **Programming Languages**
- **Python:** Utilized for CSV data parsing, interaction with the Neo4j database, and executing Cypher queries to both populate the database and retrieve information.

### **Database Management System**
- **Neo4j:** An industry-leading graph database that focuses on storing interconnected data, making complex queries faster and more intuitive.

## **Project Structure**

- `main.py`: The entry point of the application. Initiates the conversion process and the interaction with Neo4j.
- `NeoClient.py`: Contains the main class for database operations, including node creation and relationship mapping.
- `/SproutsData`: Directory containing the CSV files with the Arlington Sprouts Store data.
- `queries/`: Directory storing various Cypher query files.

## **Getting Started**

### **Prerequisites**

- Python 3.x
- Neo4j Server
- pip (Python package installer)

### **Setting up the Environment**

1. **Clone the Repository**: Obtain a local copy of the project:
   ```bash
   git clone [repository_url]
   ```

2. **Navigate to the Project Directory**:
   ```bash
   cd path_to_project_directory
   ```

3. **Install the Necessary Python Libraries**:
   ```bash
   pip install neo4j
   ```

### **Running the Program**

1. **Setup Neo4j Database**: Ensure your Neo4j server is up and running.

2. **Configure Connection Details**: Modify the connection details in the `NeoClient` class with the correct credentials.

3. **Execute the Main Python Script**:
   ```bash
   python main.py
   ```

4. **Follow On-Screen Instructions**: The script will provide prompts to guide you through populating the database and executing the desired queries.

## **Contribution**

The project was a collaborative effort:

- **[Avinash Mahala]**: Data Parsing, and Node Creation, and Documentation.
- **[Vinod Kumar Puttamadegowda]**: Worked On The Initial Setup, Cypher Queries and Relationship Mapping 

## **License**

This project is licensed under the MIT License. For more details, see `LICENSE.md`.

## **Contact**

For any questions, feedback, or issues, please reach out to:

- **[Avinash Mahala]**: [axm9433@mavs.uta.edu]
- **[Vinod Kumar Puttamadegowda]**: [vxp8556@mavs.uta.edu]

---