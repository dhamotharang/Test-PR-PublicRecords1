#option('outputLimit', 30);

f := Equifax.principal_extended;

count(f);

fsort := sort(f, cid, pid, record_type);

//output(choosen(fsort,2000));

output(fsort,all);