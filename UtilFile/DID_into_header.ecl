import header, did_add;

recfrmt := record
	header.Layout_New_Records;
	unsigned6	seq := 0;
end;

infile := sequenced;

matchset := ['A','S','P'];
did_Add.MAC_Match_Flex
	(infile, matchset,
	 ssn, dob, fname, mname,lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, st, phone,
	 DID, recfrmt, false, DID_Score_field,
	 75, truout)

header.layout_header slimUT(truout L) := transform
 self := l;
end;

export DID_into_header := project(truout,slimUT(left)) : persist('persist::utility_DID');
