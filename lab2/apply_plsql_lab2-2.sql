-- Add your lab here:
-- ----------------------------------------------------------------------
-- Lab Instructions.
/* You need to write an anonymous block PL/SQL program that accepts a single parameter. If there is no parameter, you should print “Hello World!”; if the parameter is 10 characters or less, you should print the parameter instead of “World”; if the parameter is more than 10 characters in length, you should print the first 10 characters of the parameter instead of “World”.

You should use two variables inside your program. The lv_raw_input should contain the input value regardless of length. The lv_input should contain the first ten characters of the input value.

You should remember that all dynamic assignments should be made inside the execution block. There’s no way for you to manage assignment errors raised inside the declaration block. You should consider the execution block like the try{} element of a Java program and the exception block as the catch{} element of a Java program.

An IF-ELSIF-ELSE block should manage all three possibilities, and print the appropriate message to the console or log file. You should name your lab solution file as apply_plsql_lab2-2.sql, which is what you see in the test case section. */ 
-- ----------------------------------------------------------------------

-- Show the output
set serveroutput on

DECLARE
  lv_raw_input VARCHAR2(100);
  lv_input VARCHAR2(10);
  lv_print VARCHAR2(20);
  i_length NUMBER;
  i_switch NUMBER := 10;
  i_min NUMBER := 0;

BEGIN
-- Get input from the user 
  lv_raw_input := '&1';

-- How large is the input?
  i_length := LENGTH(lv_raw_input);

-- If less than 10 and not NULL
  IF i_length < i_switch AND i_length > i_min
    THEN
      lv_input := lv_raw_input;
  
-- Trim to 10 characters
  ELSIF i_length > i_switch
    THEN
      lv_input := SUBSTR(lv_raw_input, 1, i_switch);

-- If no parameter output Hello World!
  ELSE
      lv_input := 'World';
  END IF;

-- Variable for printing
  lv_print := 'Hello ' || lv_input || '!';

-- Print the result
  dbms_output.put_line(lv_print);

END;
/
