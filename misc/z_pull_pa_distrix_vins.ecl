import vehlic;

layout_vins_in :=
record
string22 vin_in;
string1	nl;
end;

pa_vins_in := dataset('~thor_200::in::distrix_mv_pa_vins_20061106',layout_vins_in,flat);
my_pa_vins := distribute(pa_vins_in,hash(vin_in[1..10]));
output(my_pa_vins);

shrunk_vins_in := dedup(sort(distribute(doxie_files.File_SavedVina,hash(vin[1..10])),vin[1..10],local),vin[1..10],local);
my_shrunk_vins := distribute(shrunk_vins_in,hash(vin[1..10]));
output(my_shrunk_vins);

shrunk_vins_in trans_keep_on_join(shrunk_vins_in l, pa_vins_in r) := transform
self := l;
end;

pa_shrunk_joined := join(my_shrunk_vins,my_pa_vins,left.vin[1..10]=right.vin_in[1..10],trans_keep_on_join(left,right),local);
 
pa_shrunk_deduped := dedup(sort(distribute(pa_shrunk_joined,hash(vin)),vin,local),vin,local);

output(pa_shrunk_deduped,,'~thor_data400::out::VinaShrunk_PA_20061106',overwrite);
