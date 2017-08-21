import drivers;

my_ds:= Drivers.File_Dl;

my_lo := record
string2 orig_state;
integer1 position;
string1  contents;
end;

my_lo dl_number_normalize(my_ds L,INTEGER c) := transform
self := L;
self.position := C;
self.contents := L.dl_number[C..C];
end;

my_ds_normalized := normalize(my_ds,14,dl_number_normalize(left,counter));

d:= my_ds_normalized;

stat_rec := record
d.orig_state;
d.position;
d.contents;
total_records 	:= count(group);
end;

stats := table(d,stat_rec,d.orig_state,d.position,d.contents,few);

sorted_stats := sort(stats,orig_state,position,contents);

export dl_number_query1 :=sorted_stats : persist('~thor_200::temp::dl_number_query1');
