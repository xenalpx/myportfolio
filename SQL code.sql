/* Retrieving specific columns */

SELECT P_CODE, P_DESCRIPT, P_INDATE FROM PRODUCT;
SELECT P_CODE, P_DESCRIPT, P_INDATE, P_QOH, P_MIN, P_PRICE, P_DISCOUNT, V_CODE
FROM   PRODUCT;

/*Retrieving specific columns – using a criteria */


SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  V_CODE < > 21344;

/* Alternate formulation */ 

SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  V_CODE != 21344;

/* Another way */

SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE NOT (V_CODE = 21344);

/*-- Other comparison operators >, >=, <, <=, = */

Select *
from Product;

SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE, P_INDATE
FROM   PRODUCT
WHERE  P_INDATE >= To_Date('01-01-2012', 'dd-mm-yyyy');

SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE
FROM   PRODUCT
WHERE  P_PRICE >= 10;

/* Using Logical operators AND, OR , NOT */


SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  V_CODE = 21344
   OR  V_CODE = 24288;

/* use to_date function if the query does not run as the date format does not match what is expected */ 	
SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  P_PRICE < 50
AND    P_INDATE > '01-15-2012';

/* using the To_Date function  */

SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  P_PRICE < 50
AND    P_INDATE > To_Date('01-15-2012', 'mm-dd-yyyy');

	
SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE (P_PRICE < 50
AND    P_INDATE > To_Date('01-15-2012', 'mm-dd-yyyy')) 
OR V_CODE = 24288;

	
/*Using the BETWEEN, IS NULL, LIKE, IN, EXISTS operators */
	
SELECT *
FROM   PRODUCT
WHERE  P_PRICE BETWEEN 5.00 AND 100.00;


/*You could have also used the following SQL code as an alternative */
	
SELECT *
FROM   PRODUCT
WHERE  P_PRICE > 5.00 AND P_PRICE < 100.00; 
WHERE  V_CODE IS NULL;


/*Retrieving records from PRODUCT table where V_CODE value is null */
	
SELECT P_CODE, P_DESCRIPT, V_CODE
FROM   PRODUCT
WHERE  V_CODE IS NULL;

/* Retrieving records from PRODUCT table where V_CODE value is not null */
	
SELECT P_CODE, P_DESCRIPT, V_CODE
FROM   PRODUCT
WHERE  V_CODE IS NOT NULL;


/*Retrieving records where you know that the contact name has Smith as the first five characters and you are not sure about other characters. You can use the % symbol for the wild card characters that follow. */
	
SELECT V_NAME, V_CONTACT, V_AREACODE, V_PHONE
FROM   VENDOR
WHERE  V_CONTACT LIKE 'Smith%';

/* use the UPPER function to convert the data into upper case if you are not sure how the data is put in the table */

SELECT V_NAME, V_CONTACT, V_AREACODE, V_PHONE
FROM   VENDOR
WHERE  UPPER(V_CONTACT) LIKE 'SMITH%';


/*Retrieving records where you are not sure of a single character which can be replaced with an underscore. */

SELECT V_NAME, V_CONTACT, V_AREACODE, V_PHONE
FROM   VENDOR
WHERE  V_CONTACT LIKE 'Smithso_';


/*Retrieving records where you know the values are in a specific range. */
	
SELECT *
FROM   PRODUCT
WHERE  V_CODE IN (21225, 24288);


/*Retrieving records where you know the values are NOT in a specific range. */
	
SELECT *
FROM   PRODUCT
WHERE  V_CODE NOT IN (21225, 24288);


/*Retrieving records where attribute V_CODE has unique values. */
	
SELECT DISTINCT V_CODE FROM PRODUCT;


/*Retrieving multiple attributes from PRODUCT table where V_CODE is unique. 
Notice the nested nature of the query. 
The query above returns a set which is referred to by another query. */ 
	
SELECT V_CODE, V_NAME
FROM   VENDOR
WHERE  V_CODE IN (SELECT DISTINCT V_CODE FROM PRODUCT);

/*-- Q: List the V_CODE and V_NAME of vendors that do not provide products */
	
SELECT V_CODE, V_NAME
FROM   VENDOR
WHERE  V_CODE NOT IN (SELECT DISTINCT V_CODE FROM PRODUCT WHERE V_CODE IS NOT NULL);

/*--Use of  EXISTS Operator.  Returns true if the inner query returns at least 1 row, otherwise it returns false */
/*-- Question: List all vendors but only if there are products to order (P_QOH <= P_MIN) */
	
SELECT *
FROM   VENDOR
WHERE  EXISTS (SELECT * FROM PRODUCT WHERE P_QOH >= P_MIN);

/* -- Question: List all vendors but only if there are products with the qty on hand less than double the min qty */

SELECT * FROM VENDOR
WHERE  EXISTS (SELECT * FROM PRODUCT WHERE P_QOH < P_MIN*2);

/*-- Question: List the products that are supplied by a vendor */

SELECT *
FROM   PRODUCT
WHERE  V_CODE IS NOT NULL;

/* Updating Values - change the value of P_INDATE from December 13, 2011 to January 18, 2012 for P_CODE = 13-Q2/P2 */

UPDATE PRODUCT
SET    P_INDATE = To_Date('01-18-2012', 'mm-dd-yyyy')
WHERE  P_CODE = '13-Q2/P2';

/*Updating values for multiple attributes for a record */

/* apply the to_date function here */ 

UPDATE PRODUCT
SET    P_INDATE = '01-18-2012',
P_PRICE = 17.99, P_MIN = 10
WHERE  P_CODE = '13-Q2/P2';


/*Verify that the change has happened.  */
	
SELECT * from PRODUCT;


/* Deleting rows based on a criteria */
	
DELETE FROM PRODUCT
WHERE  P_CODE = 'BRT-345';
SELECT * from PRODUCT;


/* Create a copy of the table */

/* first define the table structure so that there is something to put the data into */	

CREATE TABLE VENDOR_COPY
(
V_CODE INTEGER NOT NULL,
V_NAME VARCHAR(35) NOT NULL,
V_CONTACT VARCHAR(25) NOT NULL,
V_AREACODE CHAR(3) NOT NULL,
V_PHONE CHAR(8) NOT NULL,
V_STATE CHAR(2) NOT NULL,
V_ORDER CHAR(1) NOT NULL,
CONSTRAINT V_PK PRIMARY KEY (V_CODE)
);


/*  Copy data from one table into the another (which has the same structure) */
	
INSERT INTO VENDOR_COPY SELECT * FROM VENDOR

/* check if the data has been entered */ 

SELECT * FROM VENDOR_COPY;

/* now drop this table  */   

DROP TABLE VENDOR_COPY; 

/* Add a new attribute (column) for the Customer table */
	
ALTER TABLE CUSTOMER
ADD CUS_PAID NUMBER (8,2);

/* Change the data type of a column. Just for seeing how it is done */
ALTER TABLE CUSTOMER
MODIFY CUS_PAID VARCHAR2(20);

/* Drop the newly added column */
	
ALTER TABLE CUSTOMER
DROP COLUMN CUS_PAID;









