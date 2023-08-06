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
  - [**Team Member Contributions**](#team-member-contributions)
    - [**Avinash:**](#avinash)
    - [**Vinod:**](#vinod)
  - [**Collaborative Efforts:**](#collaborative-efforts)
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

## **Team Member Contributions**

### **Avinash:**
1. **Initial Setup and Data Understanding:** 
   - Was responsible for initially setting up the Neo4j sandbox and the Python environment.
   - Played a pivotal role in understanding the relationships and structure of the dataset.
2. **NeoClient Design and Connection Handling:** 
   - Designed the basic framework of the NeoClient class.
   - Implemented the connection handling methods.
3. **Node Creation from CSVs:** 
   - Took the lead on parsing CSV data and the node creation process.
4. **Testing and Validation:** 
   - Focused on writing various MATCH queries to validate that data was entered correctly.

### **Vinod:**
1. **Understanding Relationships:** 
   - Dug deep into understanding potential relationships among the entities.
2. **Relationship Creation in Neo4j:** 
   - Took the lead on implementing the relationship functions.
3. **Cypher Querying for Part 3:** 
   - Addressed the queries provided in Part 3 using the Cypher query language.
4. **Error Handling and Optimization:** 
   - Worked on optimizing the code and implemented error handling.
5. **Documentation and Reporting:** 
   - Played a major role in maintaining detailed documentation throughout the project.

## **Collaborative Efforts:**
1. **Joint Brainstorming Sessions:** Both initiated the project with brainstorming sessions, ensuring a unified vision.
2. **Code Pairing:** Practiced pair programming, ensuring cleaner code and knowledge exchange.
3. **Database Design and Integration:** Worked collaboratively on schema design and ensured seamless integration.
4. **Debugging Sessions:** Addressed bugs in tandem, squashing them efficiently.
5. **Documentation and Reporting:** Collaborated to ensure comprehensive documentation.
6. **Feedback & Iterative Improvement:** Maintained open feedback channels, ensuring continual evolution of the project.
## **License**

This project is licensed under the MIT License. For more details, see `LICENSE.md`.

## **Contact**

For any questions, feedback, or issues, please reach out to:

- **[Avinash Mahala]**: [axm9433@mavs.uta.edu]
- **[Vinod Kumar Puttamadegowda]**: [vxp8556@mavs.uta.edu]

---