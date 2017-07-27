import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

Lay_Voters_WithDID := record
		VotersV2.Layouts_Voters.Layout_Voters_Common;
		unsigned6 DID       := 0;
		unsigned1 did_score := 0;
end;

In_Base_File    := VotersV2.Updated_Voters;

dist_In_Base_File := distribute(In_Base_File, hash64(source_state, lname, name_suffix, fname, mname, 
																dob, prim_range, prim_name, predir, addr_suffix, postdir,
																unit_desig, sec_range, p_city_name, st, zip));

// deduping the records based on vtid key, political party, mailing address fields.																
ded_In_base_file  := dedup(sort(dist_In_Base_File, vtid, -process_date, lname, name_suffix, fname, mname, dob,
																prim_range, prim_name, predir, addr_suffix, postdir, unit_desig, sec_range,
																p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
                                mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir,
													  		mail_unit_desig, mail_sec_range, mail_p_city_name, mail_st,	mail_ace_zip, local), 
													 vtid, lname, name_suffix, fname, mname, dob, prim_range, prim_name, predir, addr_suffix, postdir,
													 unit_desig, sec_range, p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
													 mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir, mail_unit_desig, 
													 mail_sec_range, mail_p_city_name, mail_st, mail_ace_zip, local);

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor

matchSet := ['A','D','P'];

DID_Add.MAC_Match_Flex            // regular did macro
				(ded_In_base_file, matchSet, '',
				 dob, fname, mname, lname, name_suffix,
				 prim_range, prim_name, sec_range, zip, st, phone,
				 DID,
				 Lay_Voters_WithDID,
				 true, did_score,
				 75,                 //dids with a score below here will be dropped
				 Ds_Voters_WithDID					
				)

Lay_Voters_WithDidSsn := record
	Lay_Voters_WithDID;
	string9	ssn := '';	
end;

Lay_Voters_WithDidSsn tDefault_ssn(Ds_Voters_WithDID l) := transform
	self.ssn := '';
	self := l;
end;

In_Voters_WithDidSsn := project(Ds_Voters_WithDID, tDefault_ssn(left));

did_add.MAC_Add_SSN_By_DID(In_Voters_WithDidSsn, did, ssn, Out_Voters_WithDidSsn)

//output(count(Out_Voters_WithDidSsn(trim(ssn,left,right)<>'')));

Ds_Voters_with_did_ssn := Out_Voters_WithDidSsn;

export Cleaned_Voters_DID := Ds_Voters_with_did_ssn : persist(VotersV2.Cluster + 'Persist::Cleaned_Voters_With_did_ssn');
