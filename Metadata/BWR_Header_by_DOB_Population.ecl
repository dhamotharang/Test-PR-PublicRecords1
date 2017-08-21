// W20080327-155825 Header by DOB Population jjb

t1:=distribute(table(Watchdog.File_Best_marketing,{dob,did}),hash32(did));
t2:=distribute(table(Watchdog.File_Best,{dob,did}),hash32(did));
t3:=distribute(table(Watchdog.File_Best_nonglb,{dob,did}),hash32(did));

output(table(t1(dob=0),{count(group)}));
output(table(t2(dob=0),{count(group)}));
output(table(t3(dob=0),{count(group)}));

output(table(t1(dob<>0),{count(group)}));
output(table(t2(dob<>0),{count(group)}));
output(table(t3(dob<>0),{count(group)}));