import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,mdr,header;
//DF-27577 Moved DID after AID
//DF-27577 Reduced number of persist files to speed up build

in_file := VotersV2.Cleaned_Addr_Cache_Base;

VotersV2.Layouts_Voters.Layout_Voters_base_new transformBase(in_file l) := transform	
//populated name fields for flip name utility below 
  self.title := l.prefix_title;
	self.fname := l.first_name;
	self.mname := l.middle_name;
	self.lname := l.last_name;
	self.name_suffix := l.name_suffix_in;
	self              := l;
  self              := [];
end;

transformedBaseFile := project(in_file, transformBase(left));

ut.mac_flipnames(transformedBaseFile,fname,mname,lname, base_FlipNames)

dist_In_Base_File := distribute(base_FlipNames, hash64(source_state, lname, name_suffix, fname, mname, 
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
//add src 
src_rec := record
header_slimsort.Layout_Source;
VotersV2.Layouts_Voters.Layout_Voters_base_new;
end;

ded_Plus_Base_File := ded_In_base_file;

DID_Add.Mac_Set_Source_Code(ded_Plus_Base_File, src_rec, 'VO', ded_In_base_file_src)

matchSet := ['A','D','P'];

DID_Add.MAC_Match_Flex            // regular did macro
				 (ded_In_base_file_src, matchSet, '',
				 dob, fname, mname, lname, name_suffix,
				 prim_range, prim_name, sec_range, zip, st, phone,
				 DID,
				 src_rec,
				 true, did_score,
				 75,                 //dids with a score below here will be dropped
				 Ds_Voters_WithDID_src,true,src					
				)

//remove src
Ds_Voters_WithDID := project(Ds_Voters_WithDID_src, transform(VotersV2.Layouts_Voters.Layout_Voters_base_new, self := left)) ;

VotersV2.Layouts_Voters.Layout_Voters_base_new tDefault_ssn(Ds_Voters_WithDID l) := transform
	self.ssn := '';
	self := l;	
  self := [];
end;

In_Voters_WithDidSsn := project(Ds_Voters_WithDID, tDefault_ssn(left));

did_add.MAC_Add_SSN_By_DID(In_Voters_WithDidSsn, did, ssn, Out_Voters_WithDidSsn)

export Cleaned_Voters_DID := Out_Voters_WithDidSsn : persist(VotersV2.Cluster + 'Persist::Cleaned_Voters_DID', REFRESH(TRUE),SINGLE);
