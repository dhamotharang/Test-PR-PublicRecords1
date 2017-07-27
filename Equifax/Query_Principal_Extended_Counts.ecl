f := Equifax.principal_extended;

count(f);
count(f(record_type='1'));
count(f(record_type='2'));

count(f(record_type='1', did <> 0));
count(f(record_type='2', did <> 0));

count(dedup(f(record_type='1', did <> 0), did, all));
count(dedup(f(record_type='2', did <> 0), did, all));
