-- Add your lab here:
-- ----------------------------------------------------------------------
-- Lab Instructions.
/* You need to write an anonymous block PL/SQL program that accepts a three string parameters and loads them into a collection of 100-character variable length strings. You assign substitution variables with numbers as names. The example below shows an anonymous block with two substitution variables that can be provided as arguments to a PL/SQL program. */ 
-- ----------------------------------------------------------------------

-- Show the output
/* Show the output */
SET SERVEROUTPUT ON
SET VERIFY OFF;

DECLARE
  TYPE list_type IS RECORD
    (
      test_id NUMBER
      ,name   VARCHAR2(100)
      ,d_date DATE
    );
  r LIST_TYPE;
  lv_input1 VARCHAR2(100);
  lv_input2 VARCHAR2(100);
  lv_input3 VARCHAR2(100);

BEGIN
-- Get input from the user and assign to the record
  lv_input1 := '&1';
  lv_input2 := '&2';
  lv_input3 := '&3';

  r.test_id := lv_input1;
  r.name := lv_input2;
  r.d_date := to_date(lv_input3, 'dd/mm/yyyy');

-- Print the result
  dbms_output.put_line('Record'|| ' [' ||r.test_id ||']' || ' [' ||r.name||']' || ' [' ||to_char(r.d_date)||']');

  EXCEPTION
    WHEN others THEN
      dbms_output.put_line('Error! ' || SQLERRM);
END;
/
EXIT;
