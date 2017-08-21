import gong, header;

/*
f := watchdog.DID_Gong;
//(phone10<>'' and did!=0);

*/

f:= gong.File_GongBase;
output(f);

lstats := record
string3	bell_id :=f.bell_id;
string1 cr_sort_sz := f.cr_sort_sz;
string1 omit_phone := f.omit_phone;
string1 omit_address := f.omit_address;
string1 omit_locality := f.omit_locality;
integer8	ttl_recs :=count(group);
end;
dStats := table(f,lStats,bell_id,cr_sort_sz,omit_phone,omit_address,omit_locality,few);
output(dStats);

