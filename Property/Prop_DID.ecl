import did_add, header;

pj_in := property.Prop_Joined;

bad := count(pj_in(dt_first_seen > dt_last_seen or dt_first_seen = 0 and dt_last_seen > 0));
if(bad > 0, fail('You have some bad dates coming out of Prop_Joined'));

matchset := ['A', 'P','Z'];
did_add.MAC_Match_Flex
	(pj_in, matchset,
	 ssn_field, dob_field, fname, mname,lname, suffix,
	 prim_range, prim_name, sec_range, zip, st,phone,
	 DID,header.Layout_New_Records, false, DID_Score_field,
	 75,pj_out)

export Prop_DID := pj_out : persist('persist::property_did');
