f := dataset('~thor_data400::out::amex_merchant_analysis', TM_Test.Layout_Amex_Merchant_Out, flat);

count(f(emp_ssn <> ''));
output(f(emp_ssn <> ''));
count(dedup(f(emp_ssn <> ''), rid, emp_ssn, all));
count(dedup(f(emp_ssn <> ''), emp_ssn, all));

count(f(emp_dob <> ''));
output(f(emp_dob <> ''));
count(dedup(f(emp_dob <> ''), rid, emp_ssn, emp_dob, all));
count(dedup(f(emp_dob <> ''), emp_ssn, emp_dob, all));
