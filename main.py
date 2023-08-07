from neo4j import GraphDatabase, basic_auth
import csv


class DatabaseOperations:

    def __init__(self):
        self.driver = None
        self.fileNames = ["CUSTOMER.csv", "CONTRACT.csv", "EMPLOYEE.csv", "ITEM.csv", "ORDERS.csv",
                          "STORE.csv", "VENDOR.csv", "VENDOR_ITEM.csv", "OLDPRICE.csv", "ORDER_ITEM.csv"]

    def connectToNeo(self):
        """

        Connects to Neo4j sandbox

        """

        try:
            self.driver = GraphDatabase.driver(
                "bolt://44.192.122.40:7687",
                auth=basic_auth("neo4j", "thanks-medicines-forks"))
            print("Connected to Neo4j")

        except Exception as e:
            print(e)

    def closeConnection(self):
        """

        Disconnects from the Neo4j sandbox

        """
        self.driver.close()
        print("Disconnected from Neo4j")

    @staticmethod
    def getTypedValue(value):
        """

        Check the data type of the value and return the value with the corresponding type

        """

        if value.isdigit():
            return int(value)
        try:
            return float(value)
        except ValueError:
            # If the value is not a valid float, return it as a string
            return value

    def createNodes(self):
        """

        This function creates the nodes in Neo4j, by using the data from the csv file

        """

        print("Creating nodes!")
        for fileName in self.fileNames:
            label = fileName[:-4]
            variable = label.lower()

            fileName = "SproutsData/" + fileName
            with self.driver.session(database="neo4j") as session:
                with open(fileName, 'r', encoding='utf-8-sig') as file:
                    csv_reader = csv.reader(file)

                    headerList = next(csv_reader)

                    for row in csv_reader:
                        node_properties = {}

                        for i in range(len(headerList)):
                            typed_value = DatabaseOperations.getTypedValue(row[i])
                            node_properties[headerList[i]] = typed_value

                        query = f"CREATE ({variable}: {label} {{"
                        properties = ", ".join([f"{key}: ${key}" for key in node_properties.keys()])
                        query += properties + "})"
                        result = session.run(query, node_properties)
        print("Successfully created all the nodes!!")

    def createRelationships(self):
        """

        This function creates the relationships between nodes in Neo4j using static data given by the program.

        """

        print("Creating relationships!")
        with self.driver.session(database="neo4j") as session:
            queries = [
                "MATCH (vi:VENDOR_ITEM) WITH vi.vId AS vendorId, vi.iId AS itemId MATCH (v:VENDOR {vId: vendorId}) MATCH (i:ITEM {iId: itemId}) CREATE (v)-[:SELLS]->(i)",

                "MATCH (vi:VENDOR_ITEM),(v:VENDOR) WHERE vi.vId=v.vId CREATE(vi)-[found:FOUND]->(v)",

                "MATCH (o:ORDERS),(c:CUSTOMER) WHERE o.cId=c.cId CREATE(o)-[belongs_to:BELONGS_TO]->(c)",

                "MATCH (oi:ORDER_ITEM) WITH oi.oId AS orderId, oi.iId AS itemId MATCH (o:ORDERS {oId: orderId}) MATCH (i:ITEM {iId: itemId}) CREATE (o)-[:CONTAINS]->(i)",

                "MATCH (oi:ORDER_ITEM),(i:ITEM) WHERE oi.iId=i.iId CREATE(oi)-[matches:MATCHES]->(i)",

                "MATCH (e:EMPLOYEE),(s:STORE) WHERE e.sId=s.sId CREATE(e)-[works_at:WORKS_AT]->(s)",

                "MATCH (v:VENDOR),(ct:CONTRACT) WHERE v.vId=ct.vId CREATE(v)-[has:HAS]->(ct)",

                "MATCH (i:ITEM),(op:OLDPRICE) WHERE i.iId=op.iId CREATE(i)-[had:HAD]->(op)"]

            for query in queries:
                result = session.run(query)
        print("Successfully created all the relationships!!")


def main():
    try:
        neoClient = DatabaseOperations()

        # Connect to Neo4j
        neoClient.connectToNeo()

        # Create Nodes
        neoClient.createNodes()

        # Create relationship
        neoClient.createRelationships()

        # Disconnect to Neo4j
        neoClient.closeConnection()

    except Exception as e:
        print(e)



if __name__ == "__main__":
    main()
