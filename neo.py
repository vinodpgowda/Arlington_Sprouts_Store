from neo4j import GraphDatabase, basic_auth
import csv


class NeoClient:

    def __init__(self):
        self.driver = None
        self.fileNames = ["CUSTOMER.csv", "CONTRACT.csv", "EMPLOYEE.csv", "ITEM.csv", "ORDERS.csv",
                          "STORE.csv", "VENDOR.csv", "VENDOR_ITEM.csv", "OLDPRICE.csv", "ORDER_ITEM.csv"]

    def connectToNeo(self):
        try:
            self.driver = GraphDatabase.driver(
                "bolt://3.83.228.76:7687",
                auth=basic_auth("neo4j", "quarter-comfort-oscillations"))
            print("Connected to Neo4j")

        except Exception as e:
            print(e)

    def closeConnection(self):
        self.driver.close()

    @staticmethod
    def getTypedValue(value):
        # Check the data type of the value and return the value with the corresponding type
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
                            typed_value = NeoClient.getTypedValue(row[i])
                            node_properties[headerList[i]] = typed_value

                        query = f"CREATE ({variable}: {label} {{"
                        properties = ", ".join([f"{key}: ${key}" for key in node_properties.keys()])
                        query += properties + "})"
                        result = session.run(query, node_properties)
                        print(result)

    def createRelationships(self):
        with self.driver.session(database="neo4j") as session:
            queries = ["MATCH (vi:VENDOR_ITEM),(i:ITEM) WHERE vi.iId=i.iId CREATE(vi)-[sells:SELLS]->(i)",

                       "MATCH (vi:VENDOR_ITEM),(v:VENDOR) WHERE vi.vId=v.vId CREATE(vi)-[found:FOUND]->(v)",

                       "MATCH (o:ORDERS),(c:CUSTOMER) WHERE o.cId=c.cId CREATE(o)-[belongs_to:BELONGS_TO]->(c)",

                       "MATCH (o:ORDERS),(oi:ORDER_ITEM) WHERE o.oId=oi.oId CREATE(o)-[contains:CONTAINS]->(oi)",

                       "MATCH (oi:ORDER_ITEM),(i:ITEM) WHERE oi.iId=i.iId CREATE(oi)-[matches:MATCHES]->(i)",

                       "MATCH (e:EMPLOYEE),(s:STORE) WHERE e.sId=s.sId CREATE(e)-[works_at:WORKS_AT]->(s)",

                       "MATCH (v:VENDOR),(ct:CONTRACT) WHERE v.vId=ct.vId CREATE(v)-[has:HAS]->(c)",

                       "MATCH (i:ITEM),(op:OLDPRICE) WHERE i.iId=op.iId CREATE(i)-[had:HAD]->(op)"]

            for query in queries:
                result = session.run(query)
                print(result)


def main():
    try:
        neoClient = NeoClient()

        # Connect to Neo4j
        neoClient.connectToNeo()

        # Create Nodes
        neoClient.createNodes()

        # Create relationship
        neoClient.createRelationships()

    except Exception as e:
        print(e)

    finally:
        neoClient.closeConnection()


if __name__ == "__main__":
    main()
