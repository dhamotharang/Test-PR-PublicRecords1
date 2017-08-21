import did_add,ut,header_slimsort,lib_stringlib, watchdog, didville, fair_isaac;
dl_file := DL_Joined;

matchset := ['A','D','S'];

did_add.MAC_Match_Flex
	(dl_file, matchset,						//see above
	 ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, st, JUNK,
	 DID,
	 Layout_DL, 
	 false, DID_Score_field,						//*if outrec has scores, these will always be zero
	 75,
	 res)

Layout_DL lFieldTransform(Layout_DL l) := TRANSFORM
self.ssn_safe := l.ssn;
self.restrictions_delimited := if(l.restrictions_delimited <> '',
								  l.restrictions_delimited,
								  l.Restrictions[1] + 
									if(l.Restrictions[2]<>' ',','+l.Restrictions[2],'') +
									if(l.Restrictions[3]<>' ',','+l.Restrictions[3],'') + 
									if(l.Restrictions[4]<>' ',','+l.Restrictions[4],'') +
									if(l.Restrictions[5]<>' ',','+l.Restrictions[5],'') +
									if(l.Restrictions[6]<>' ',','+l.Restrictions[6],'') + 
									if(l.Restrictions[7]<>' ',','+l.Restrictions[7],'') + 
									if(l.Restrictions[8]<>' ',','+l.Restrictions[8],'') + 
									if(l.Restrictions[9]<>' ',','+l.Restrictions[9],'') +
									if(l.Restrictions[10]<>' ',','+l.Restrictions[10],'')
								 );
self := l;
END;

res_safe := PROJECT(res, lFieldTransform(left));

DID_Add.MAC_Add_SSN_By_DID(res_safe,did,ssn,with_ssn)

export DL := with_ssn : persist('~thor_data400::Persist::DrvLic_DLs_With_DIDs','thor_dell400_2');
