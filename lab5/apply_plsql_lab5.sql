-- Add your lab here:
-- ----------------------------------------------------------------------
-- Lab Instructions:
-- You need to write an anonymous block PL/SQL program that uses one collection. 
-- The collection is a table of the following structure, and this same structure 
-- is also the structure of a new table – the RATING_AGENCY table.
-- ----------------------------------------------------------------------
-- The lab requires you to implement:
-- A new RATING_AGENCY table and RATING_AGENCY_S sequence that starts with a value of 1001.
-- Add a new RATING_AGENCY_ID column to the ITEM table.
-- A SQL structure or composite object type, as qualified above.
-- A SQL collection, as a table of the composite object type.
-- An anonymous block PL/SQL program that:
-- -- Declare a local cursor to read the contents of the RATING_AGENCY table.
-- -- A cursor for loop that reads the cursor contents and assigns them to a local variable of the SQL collection data type.
-- -- A range for loop that reads the collection contents and updates the RATING_AGENCY_ID column in the item table by checking the ITEM_RATING and ITEM_RATING_AGENCY column values with the members of the collection’s composite object type.
-- ----------------------------------------------------------------------

-- Show the output
SET SERVEROUTPUT ON

-- Begin log file
SPOOL /home/student/Data/cit325/oracle/lab5/apply_plsql_lab5.txt

-- Clean up existing code
@/home/student/Data/cit325/oracle/lib/cleanup_oracle.sql
@/home/student/Data/cit325/oracle/lib/Oracle12cPLSQLCode/Introduction/create_video_store.sql

-- Adding the rating_agency_id column to the item table
ALTER TABLE item
    ADD rating_agency_id    NUMBER;

-- Creates a sequence for the soon to be rating_agency table
CREATE SEQUENCE rating_agency_s START WITH 1001;

-- Creates the rating_agency table 
CREATE TABLE rating_agency AS
  SELECT rating_agency_s.NEXTVAL AS rating_agency_id
  ,      il.item_rating AS rating
  ,      il.item_rating_agency AS rating_agency
  FROM  (SELECT DISTINCT
                i.item_rating
         ,      i.item_rating_agency
         FROM   item i) il;
-- After creating the table, you should be able to check it’s contents with the following query:
SELECT * FROM rating_agency;
		 
-- You add the RATING_AGENCY_ID column to the ITEM table. 
-- After adding the RATING_AGENCY_ID column to the ITEM table, 
-- you should be able to modified ITEM table with this query: 
SET NULL ''
COLUMN table_name   FORMAT A18
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'ITEM'
ORDER BY 2;

-- See what it prints, compare lab output

-- Drop pre-existing object type.
DROP TYPE c_ratings;

-- Creates object type
CREATE OR REPLACE
    TYPE c_ratings IS OBJECT
    ( rating_agency_id     NUMBER
    , rating               VARCHAR2(8)
    , rating_agency        VARCHAR2(4));
/

-- Creates a collection type called c_ratings
CREATE OR REPLACE
    TYPE c_ratings_list IS TABLE OF c_ratings; 
/

-- Begins anonymous PL/SQL block
DECLARE
-- Declares local variables and their data types
    lv_rating_agency_id     NUMBER;
    lv_rating               VARCHAR2(8);    
    lv_rating_agency        VARCHAR2(4);

-- Declares a local CURSOR for reading the contents of the rating_agency table
    CURSOR c IS
        SELECT  i.rating_agency_id 
        ,       i.rating
        ,       i.rating_agency 
        FROM    rating_agency i;

-- Declares an empty collection
    lv_c_ratings_list C_RATINGS_LIST := c_ratings_list();
BEGIN
-- Cursor loop used to populate the collection and to assign the collection values for rating_agency_id to the column in the item table
    FOR i IN c LOOP
        lv_c_ratings_list.EXTEND;
        lv_c_ratings_list(lv_c_ratings_list.COUNT) := c_ratings( lv_rating_agency_id
                                                               , lv_rating
                                                               , lv_rating_agency);
-- Update statement to assign rating_agency_ids to the item table
        UPDATE item
        SET rating_agency_id = i.rating_agency_id
        WHERE item_rating = i.rating AND item_rating_agency = i.rating_agency;
    END LOOP;
    COMMIT;
END;
/
-- You should be able to run the following query to verify the results of your anonymous PL/SQL block:
SELECT   rating_agency_id
,        COUNT(*)
FROM     item
WHERE    rating_agency_id IS NOT NULL
GROUP BY rating_agency_id
ORDER BY 1;

SPOOL OFF
EXIT;