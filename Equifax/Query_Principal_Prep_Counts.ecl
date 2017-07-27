f := Equifax.principal_prep;

count(f);
count(f((first_name + middle_initial + last_name) <> ''));
count(f(Business_Name <> ''));
count(f(did <> 0));
count(f(bdid <> 0));

