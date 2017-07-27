//gong add prep key based on address fields
import gong, doxie;

g := Gong.file_daily_full(trim(prim_name)<>'', trim(z5)<>'');

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

export key_address_add := 
       index(wcn,
            {prim_name, z5, prim_range, sec_range, predir, suffix},{phone10, listed_name, fname, mname, lname},
	       '~thor_data400::key::gong_address_add_' + doxie.Version_SuperKey,OPT);
