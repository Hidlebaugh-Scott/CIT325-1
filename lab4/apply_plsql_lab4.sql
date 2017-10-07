-- Add your lab here:
-- ----------------------------------------------------------------------
-- Lab Instructions:
/* The lab is designed to have you enter the unique elements of the Twelve Days of Christmas into collections and then prints the lyrics of the song. You need to write an anonymous block PL/SQL program that uses two collections. One collection implements a list of eight character variable length strings. The other collection implements a list of the following object type, which you need to create as part of this lab. */ 
-- ----------------------------------------------------------------------

-- Show the output
SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF
SET ECHO ON;

-- Create day and gift objects
CREATE OR REPLACE
        TYPE day_name IS OBJECT
        ( xnumber  NUMBER
        , xtext    VARCHAR2(8));
/

CREATE OR REPLACE
        TYPE gift_name IS OBJECT
        ( xqty    VARCHAR2(8)
        , xgift   VARCHAR2(24));
/

-- Begin log file, starting here to exclude object creation in log
SPOOL /home/student/Data/cit325/oracle/lab4/apply_plsql_lab4.txt

DECLARE
-- Declare tables of days and gifts
        TYPE days IS TABLE OF day_name;
        TYPE gifts IS TABLE OF gift_name;

-- Initialize the collection that implements a list of eight character variable length string                
        lv_days DAYS := days( day_name(1,'First')
                , day_name(2,'Second')
                , day_name(3,'Third')
                , day_name(4,'Fourth')
                , day_name(5,'Fifth')
                , day_name(6,'Sixth')
                , day_name(7,'Seventh')
                , day_name(8,'Eighth')
                , day_name(9,'Ninth')
                , day_name(10,'Tenth')
                , day_name(11,'Eleventh')
                , day_name(12,'Twelfth'));

-- Initialize the collection of the object type should include the unique elements of the lyrics
        lv_gifts GIFTS := gifts(gift_name('-and a','Partridge in a pear tree')
                , gift_name('-Two','Turtle doves')
                , gift_name('-Three','French hens')
                , gift_name('-Four','Calling birds')
                , gift_name('-Five','Golden rings')
                , gift_name('-Six','Geese a laying')
                , gift_name('-Seven','Swans a swimming')
                , gift_name('-Eight','Maids a milking')
                , gift_name('-Nine','Ladies dancing')
                , gift_name('-Ten','Lords a leaping')
                , gift_name('-Eleven','Pipers piping')
                , gift_name('-Twelve','Drummers drumming'));

BEGIN
-- Read forward through the contents of the loop
        FOR i IN 1..lv_days.COUNT LOOP
            dbms_output.put_line('On the '||lv_days(i).xtext||' day of Christmas' || chr(13) || 'my true love gave to me:');

-- Read backward through a range of values
        FOR x IN REVERSE 1..i LOOP

-- Print Twelve Days of Christmas
        IF i > 1 THEN
            dbms_output.put_line(lv_gifts(x).xqty||' '||lv_gifts(x).xgift);
        ELSE
-- Note that the first day of Christmas is a capital “A” as opposed to “and a” when it is the first day of Christmas
            dbms_output.put_line('- A '||lv_gifts(x).xgift);
        END IF;

        END LOOP;
            dbms_output.put_line(CHR(13));
  END LOOP;

END;
/

SPOOL OFF
EXIT;
