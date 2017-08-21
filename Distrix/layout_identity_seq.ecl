import crim;

export layout_identity_seq := record
	unsigned2	seq;
	crim.Layout_Crim_Identity;
	string25 state_of_origin_name;
end;