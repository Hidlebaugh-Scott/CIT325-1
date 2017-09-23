# Remove file from system.
find . -name apply_plsql_lab2-2.txt -exec rm -f {} \;
 
# Create log file with header information.
echo 'Log: apply_plsql_lab2-2.txt' >> apply_plsql_lab2-2.txt
echo '==========================================' >> apply_plsql_lab2-2.txt
 
# Call script file with a string less than 10 characters.
echo 'Test Case: String less than 11 characters'  >> apply_plsql_lab2-2.txt
echo '------------------------------------------' >> apply_plsql_lab2-2.txt
sqlplus -s student/student @apply_plsql_lab2-2.sql Harry 2>/dev/null |
while IFS='\n' read msg; do
  echo $msg >> apply_plsql_lab2-2.txt
done
 
# Call script file with a string great than 10 characters.
echo '==========================================' >> apply_plsql_lab2-2.txt
echo 'Test Case: String more than 10 characters'  >> apply_plsql_lab2-2.txt
echo '------------------------------------------' >> apply_plsql_lab2-2.txt
sqlplus -s student/student @apply_plsql_lab2-2.sql Rumpelstilskin 2>/dev/null |
while IFS='\n' read msg; do
  echo $msg >> apply_plsql_lab2-2.txt
done
 
# Call script file with a null value.
echo '==========================================' >> apply_plsql_lab2-2.txt
echo 'Test Case: Empty string'                    >> apply_plsql_lab2-2.txt
echo '------------------------------------------' >> apply_plsql_lab2-2.txt
sqlplus -s student/student @apply_plsql_lab2-2.sql '' 2>/dev/null |
while IFS='\n' read msg; do
  echo $msg >> apply_plsql_lab2-2.txt
done

echo '==========================================' >> apply_plsql_lab2-2.txt
exit
