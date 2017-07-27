//gong key based on some address fields
import doxie, gong_v2;

g := Gong_v2.proc_roxie_keybuild_prep_current(trim(prim_name)<>'', trim(z5)<>'');

rec := record
	g;
	string20 fname;
	string20 mname;
	string20 lname;
	string8 date_first_seen;
end;

rec addcn(g l) := transform
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := L.name_last;
	self.date_first_seen := L.dt_first_seen[1..8];
	self := l;
end;

wcn := project(g, addcn(left));

export key_address := index(wcn,
                           {prim_name, z5, prim_range, sec_range, predir,
                            suffix},
	                   {phone10, listed_name, fname, mname, lname, 
                            name_suffix, dual_name_flag, 
			    date_first_seen, listing_type_bus, 
                            listing_type_res, listing_type_gov},
			    Gong_v2.thor_cluster + 'key::gongv2_address_' + 
                            doxie.Version_SuperKey);