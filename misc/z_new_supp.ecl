/*
// in to base
layout_in := record
string32 hval_s;
string2	nl;
end;
in_ds := dataset('~thor_data400::in::md5::bdid_address',layout_in,flat);

layout_out := record
data16 	hval;
end;
layout_out in_to_out(layout_in l) := transform
self.hval := stringlib.string2data(l.hval_s);
end;


out_ds := project(in_ds, in_to_out(left));
output(out_ds,,'~thor_data400::base::md5::bdid_address::20070813',overwrite);
*/




layout_out := record
data16 	hval;
end;
my_ds := dataset('~thor_data400::base::md5::relative',layout_out,flat);
output(my_ds);

my_ds2 := dataset('~thor_data400::base::md5::gong',layout_out,flat);
output(my_ds2);

my_ds3 := dataset('~thor_data400::base::md5::bdid_address',layout_out,flat);
output(my_ds3);

