// CREATE NODES SCRIPT

// CUSTOMER node creation
CREATE (customer:CUSTOMER {
  cId: {cIdValue},
  Cname: {CnameValue},
  Street: {StreetValue},
  City: {CityValue},
  StateAb: {StateAbValue},
  Zipcode: {ZipcodeValue}
})

// ITEM node creation
CREATE (item:ITEM {
  iId: {iIdValue},
  Iname: {InameValue},
  Sprice: {SpriceValue}
})

// VENDOR node creation
CREATE (vendor:VENDOR {
  vId: {vIdValue},
  Vname: {VnameValue},
  Street: {StreetValue},
  City: {CityValue},
  StateAb: {StateAbValue},
  ZipCode: {ZipCodeValue}
})

// VENDOR_ITEM node creation
CREATE (vendorItem:VENDOR_ITEM {
  vId: {vIdValue},
  iId: {iIdValue},
  Vprice: {VpriceValue}
})

// STORE node creation
CREATE (store:STORE {
  sId: {sIdValue},
  Sname: {SnameValue},
  Street: {StreetValue},
  City: {CityValue},
  StateAb: {StateAbValue},
  ZipCode: {ZipCodeValue},
  Sdate: {SdateValue},
  Telno: {TelnoValue},
  URL: {URLValue}
})

// ORDERS node creation
CREATE (order:ORDERS {
  oId: {oIdValue},
  sId: {sIdValue},
  cId: {cIdValue},
  Odate: {OdateValue},
  Ddate: {DdateValue},
  Amount: {AmountValue}
})

// ORDER_ITEM node creation
CREATE (orderItem:ORDER_ITEM {
  oId: {oIdValue},
  iId: {iIdValue},
  Icount: {IcountValue}
})

// EMPLOYEE node creation
CREATE (employee:EMPLOYEE {
  sId: {sIdValue},
  SSN: {SSNValue},
  Sname: {SnameValue},
  Street: {StreetValue},
  City: {CityValue},
  StateAb: {StateAbValue},
  Etype: {EtypeValue},
  Bdate: {BdateValue},
  Sdate: {SdateValue},
  Edate: {EdateValue},
  Level: {LevelValue},
  Asalary: {AsalaryValue},
  Agency: {AgencyValue},
  Hsalary: {HsalaryValue},
  Institute: {InstituteValue},
  Itype: {ItypeValue}
})

// CONTRACT node creation
CREATE (contract:CONTRACT {
  vId: {vIdValue},
  ctId: {ctIdValue},
  Sdate: {SdateValue},
  Ctime: {CtimeValue},
  Cname: {CnameValue}
})

// OLDPRICE node creation
CREATE (oldprice:OLDPRICE {
  iId: {iIdValue},
  Sprice: {SpriceValue},
  Sdate: {SdateValue},
  Edate: {EdateValue}
})


// CREATE RELATIONSHIPS SCRIPT:


// Vendor SELLS Item
MATCH (vi:VENDOR_ITEM)
WITH vi.vId AS vendorId, vi.iId AS itemId
MATCH (v:VENDOR {vId: vendorId})
MATCH (i:ITEM {iId: itemId})
CREATE (v)-[:SELLS]->(i)

// Vendor_Item FOUND_IN Vendor
MATCH (vi:VENDOR_ITEM), (v:VENDOR)
WHERE vi.vId = v.vId
CREATE (vi)-[found:FOUND]->(v)

// Order BELONGS_TO Customer
MATCH (o:ORDERS), (c:CUSTOMER)
WHERE o.cId = c.cId
CREATE (o)-[belongs_to:BELONGS_TO]->(c)

// Order CONTAINS Item
MATCH (oi:ORDER_ITEM)
WITH oi.oId AS orderId, oi.iId AS itemId
MATCH (o:ORDERS {oId: orderId})
MATCH (i:ITEM {iId: itemId})
CREATE (o)-[contains:CONTAINS]->(i)

// Order_Item MATCHES Item
MATCH (oi:ORDER_ITEM),(i:ITEM)
WHERE oi.iId = i.iId
CREATE (oi)-[matches:MATCHES]->(i)

// Employee WORKS_AT Store
MATCH (e:EMPLOYEE), (s:STORE)
WHERE e.sId = s.sId
CREATE (e)-[works_at:WORKS_AT]->(s)

// Vendor HAS Contract
MATCH (v:VENDOR), (ct:CONTRACT)
WHERE v.vId = ct.vId
CREATE (v)-[has:HAS]->(ct)

// Item HAD Oldprice
MATCH (i:ITEM), (op:OLDPRICE)
WHERE i.iId = op.iId
CREATE (i)-[had:HAD]->(op)


// DELETE Script

MATCH (n)
WHERE n:CUSTOMER OR n:CONTRACT OR n:EMPLOYEE OR n:ITEM OR n:ORDERS OR n:STORE OR n:VENDOR OR n:VENDOR_ITEM OR n:ORDER_ITEM OR n:OLDPRICE
DETACH DELETE n


// QUERIES:

// Q1) Find the name and state of all the customers whose names start with the letter ‘E’.

MATCH (c:CUSTOMER)
WHERE c.Cname STARTS WITH 'E'
RETURN c.Cname, c.StateAb

// Q2) Find the names of all the customers who have made a purchase of more than $12 in the store.

MATCH (o:ORDERS)-[r:BELONGS_TO]->(c:CUSTOMER)
WHERE o.Amount > 12
RETURN c.Cname

// Q3) Return 5 most costly items from the store in descending order.

MATCH (i:ITEM)
RETURN i
ORDER BY i.Sprice DESC
LIMIT 5 

// Q4) Find the Order date and total purchase made on that date when the sale of the store was more than $30.

MATCH (o:ORDERS)
WITH o.Odate as Order_Date, sum(o.Amount) as Total_Purchase 
WHERE Total_Purchase > 30
RETURN Order_Date, Total_Purchase

// Q5) Find the first 6 distinct customer’s names in ascending order who are 4 hops away from ‘Abdur // Rahman’.

MATCH path = (c1:CUSTOMER {Cname: 'Abdur Rahman'})-[*4]-(c2:CUSTOMER)
RETURN DISTINCT c2.Cname
LIMIT 6

// Q6) Find the vendor name and the city they belong to, for all the distinct vendors who are 3 hops away from ‘Whole Foods’ based on what items they sell. */

MATCH (v1:VENDOR {Vname: 'Whole Foods'})-[*3]-(v2:VENDOR)-[:SELLS]->(i:ITEM)
RETURN DISTINCT v2.Vname, v2.City;
  
// OR

MATCH (v1:VENDOR {Vname: 'Whole Foods'})-[*1..3]-(v2:VENDOR)-[:SELLS]->(i:ITEM)
RETURN DISTINCT v2.Vname, v2.City;

// Q7) Find the shortest path between ‘Clover Sprouts’ and ‘Mung Sprouts’ and show the path using graph. */

MATCH (start:ITEM {Iname: 'Clover Sprouts'}), (end:ITEM {Iname: 'Mung Sprouts'}),
      path = shortestPath((start)-[*]-(end))
RETURN path;

// Q8) Find the item name and its total purchase count for the most bought item of the Store.

MATCH (oi:ORDER_ITEM), (i:ITEM)
WHERE oi.iId = i.iId
WITH oi.iId as Id, count(oi.Icount) as total_purchase_count, i
RETURN i.Iname, total_purchase_count
ORDER BY total_purchase_count DESC
LIMIT 1

// Q9) Find the sets of names of customers who made a purchase on ‘1/20/2023’ and have a similar item in their orders.
// Find the sets of names of customers who bought the same items on ‘1/20/2023’.  */

MATCH (order:ORDERS {Odate: '2023-01-20'})-[:BELONGS_TO]->(customer:CUSTOMER),
      (order)-[:CONTAINS]->(item:ITEM)
WITH item, COLLECT(DISTINCT customer.Cname) AS Customers
WHERE SIZE(Customers) > 1
RETURN item.Iname AS Item_name, Customers

// Q10) Find the name, street, dob and start date for all employees whose date of birth (day and month) is the same as their start date (day and month) at the store. */

MATCH (e:EMPLOYEE)
WHERE substring(e.Bdate, 6, 5) = substring(e.Sdate, 6, 5)
RETURN e.Sname AS Name, e.Street as Street, e.Bdate as DOB ,e.Sdate as Start_date



