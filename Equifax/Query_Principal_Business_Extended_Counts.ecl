f := Equifax.principal_business_extended;

count(f);
count(f(record_type='1'));

count(f(record_type='2'));
count(f(record_type='2', bdid <> 0));
count(dedup(f(record_type='2', bdid <> 0), bdid, all));
