
eq_sol_file := marketing_best.file_equifax_base;

r1 := record
 eq_sol_file.verification_date_of_household;
 count_ := count(group);
end;

ta1 := sort(table(eq_sol_file,r1,verification_date_of_household,few),verification_date_of_household);

export coverage_equifax_solutions := output(ta1,all);