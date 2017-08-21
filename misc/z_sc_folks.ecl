//15 Villa Drive, or 15 Villa Road, 
//Greenville, SC 29615.  
//# 101 to 311
//address.cleanaddress182('15 Villa Road Apt 101', 'Greenville, SC 29615');


my_result := header.File_Headers(ut.date_overlap(dt_first_seen,dt_last_seen,198904,199104)>0, zip='29615',prim_range='15', prim_name='VILLA', suffix='RD');

my_result2:= dedup(sort(distribute(my_result,hash(did)),did,dt_first_seen,dt_last_seen,local),did,dt_first_seen, dt_last_seen,local);
output(choosen(my_result2,10000));

my_result3 := dedup(my_result2,did,local);
output(choosen(my_result3,5000));


my_best := watchdog.file_best;
watchdog.layout_best get_best(my_best l, my_result3 r) := transform
self := l;
end;
my_result4 := join(my_best, my_result3, left.did=right.did, get_best(left,right), lookup);
output(choosen(my_result4,5000));

