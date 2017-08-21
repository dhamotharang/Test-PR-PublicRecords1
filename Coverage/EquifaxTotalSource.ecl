/* W20080221-144120
Equifax Total Source
*/

eq_sol_file := marketing_best.file_equifax_base;
//output(eq_sol_file);

r1 := record
 eq_sol_file.verification_date_of_household;
 count_ := count(group);
end;

ta1 := sort(table(eq_sol_file,r1,verification_date_of_household,few),verification_date_of_household);
output(ta1,all);