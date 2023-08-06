/*
FILENAMES = ["CUSTOMER.csv", "CONTRACT.csv", "EMPLOYEE.csv", "ITEM.csv", "ORDERS.csv", "STORE.csv",
                          "VENDOR.csv", "VENDOR_ITEM.csv", "ORDER_ITEM.csv", "OLDPRICE.csv"]

*/

// DELETE SCRIPT:

MATCH (n)
WHERE n:CUSTOMER OR n:CONTRACT OR n:EMPLOYEE OR n:ITEM OR n:ORDERS OR n:STORE OR n:VENDOR OR n:VENDOR_ITEM OR n:ORDER_ITEM OR n:OLDPRICE
DETACH DELETE n


// CREATE RELATIONSHIPS SCRIPT:


MATCH (vi:VENDOR_ITEM), (i:ITEM)
WHERE vi.iId = i.iId
CREATE (vi)-[sells:SELLS]->(i)

MATCH (vi:VENDOR_ITEM), (v:VENDOR)
WHERE vi.vId = v.vId
CREATE (vi)-[found:FOUND]->(v)

MATCH (o:ORDERS), (c:CUSTOMER)
WHERE o.cId = c.cId
CREATE (o)-[belongs_to:BELONGS_TO]->(c)

MATCH (o:ORDERS), (oi:ORDER_ITEM)
WHERE o.oId = oi.oId
CREATE (o)-[contains:CONTAINS]->(oi)

MATCH (oi:ORDER_ITEM),(i:ITEM)
WHERE oi.iId = i.iId
CREATE (oi)-[matches:MATCHES]->(i)

MATCH (e:EMPLOYEE), (s:STORE)
WHERE e.sId = s.sId
CREATE (e)-[works_at:WORKS_AT]->(s)

MATCH (v:VENDOR), (ct:CONTRACT)
WHERE v.vId = ct.vId
CREATE (v)-[has:HAS]->(c)

MATCH (i:ITEM), (op:OLDPRICE)
WHERE i.iId = op.iId
CREATE (:ITEM) - [had:HAD] -> (:OLDPRICE)



// QUERIES:

// Q1) Find the name and state of all the customers whose names start with the letter ‘E’.

MATCH (c:CUSTOMER)
WHERE c.Cname STARTS WITH 'E'
RETURN c.Cname, c.StateAb

// Q2) Find the names of all the customers who have made a purchase of more than $12 in the store.

MATCH (c:CUSTOMER)-[r:BELONGS_TO]->(o:ORDERS)
WHERE o.Amount > 12
RETURN c.Cname

// Q3) Return 5 most costly items from the store in descending order.

MATCH (i:ITEM)
RETURN i
ORDERY BY i.Sprice DESC
LIMIT 5 


// Q4) Find the Order date and total purchase made on that date when the sale of the store was more than $30.

MATCH (o:ORDERS)
WITH o.Odate as Order_Date, sum(o.Amount) as Total_Purchase 
WHERE Total_Purchase > 30
RETURN Order_Date, Total_Purchase


// Q5) Find the first 6 distinct customer’s names in ascending order who are 4 hops away from ‘Abdur // Rahman’.







/* Q6) Find the vendor name and the city they belong to, for all the distinct vendors who are 3 hops away from ‘Whole Foods’ based on what items they sell. */



/* Q7) Find the shortest path between ‘Clover Sprouts’ and ‘Mung Sprouts’ and show the path using graph. */

// Q8) Find the item name and its total purchase count for the most bought item of the Store.

MATCH (oi:ORDER_ITEM), (i:ITEM)
WHERE oi.iId = i.iId
WITH oi.iId as Id, count(oi.Icount) as total_purchase_count, i
RETURN i.Iname, total_purchase_count


/* Q9) Find the sets of names of customers who made a purchase on ‘1/20/2023’ and have a similar item in their orders.
Find the sets of names of customers who bought the same items on ‘1/20/2023’.  */


/* Q10) Find the name, street, dob and start date for all employees whose date of birth (day and month) is the same as their start date (day and month) at the store. */

MATCH (e:EMPLOYEE)
WHERE date.month(Bdate) = date.month(Sdate) AND date.day(Bdate) = date.day(Sdate)
RETURN Sname,Street,Bdate,Sdate

