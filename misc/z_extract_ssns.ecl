//export extract_ssns := 'todo';

import Header;

my_ds := Header.File_OUT;

layout_my_ds_slim := record
string9 ssn;
end;

my_ds_slim := project(my_ds, layout_my_ds_slim);


my_ds_dist := distribute(my_ds_slim(ssn<>''), hash(ssn[1..5]));
my_ds_sort := sort(my_ds_dist,ssn,LOCAL);
my_ds_final := dedup(my_ds_sort,ssn,LOCAL);


EXPORT extract_ssns := my_ds_final : PERSIST('TEMP::extract_ssns');