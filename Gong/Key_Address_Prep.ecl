//gong prep key based on address fields
import data_services, gong;

g := Gong.File_Gong_full(trim(prim_name)<>'', trim(z5)<>'');

rec := record
	g;
	string20 fname;
	string20 mname;
	string20 lname;
end;

rec addcn(g l) := transform
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := L.name_last;
	self := l;
end;

wcn := project(g, addcn(left));

export key_address_prep := index(wcn,
                           {prim_name, z5, prim_range, sec_range, predir, suffix},{phone10, listed_name, fname, mname, lname},
					  data_services.data_location.prefix() + 'thor_data400::key::gong_address' + thorlib.wuid());