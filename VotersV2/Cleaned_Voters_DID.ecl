import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,mdr,header;
//DF-27577 Moved DID after AID and Name processes
//DF-27577 Reduced number of persist files to speed up build

in_file := VotersV2.Cleaned_Voters_Names;

//DF-27577 Using vendor names for cleaned name fields
// ut.mac_flipnames(in_file,fname,mname,lname, base_FlipNames)

dist_In_Base_File := distribute(in_file, hash64(source_state, lname, name_suffix, fname, mname, 
																dob, prim_range, prim_name, predir, addr_suffix, postdir,
																unit_desig, sec_range, p_city_name, st, zip));
																
// sorting and deduping the records 																
sort_In_base_file  := sort(dist_In_Base_File, vtid, -process_date,
                                lname, name_suffix, fname, mname, dob, 
																prim_range, prim_name, predir, addr_suffix, postdir, unit_desig, sec_range,
																p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
                                mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir,
													  		mail_unit_desig, mail_sec_range, mail_p_city_name, mail_st,	mail_ace_zip, 
																local)
													 //uncomment for testing
													 // :persist(VotersV2.Cluster + 'Persist::Cleaned_Voters_DID_Sorted', SINGLE)
													 ; 																
ded_In_base_file  := dedup(sort_In_base_file,
													 vtid, 
													 lname, name_suffix, fname, mname, dob, prim_range, prim_name, predir, addr_suffix, postdir,
													 unit_desig, sec_range, p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
													 mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir, mail_unit_desig, 
													 mail_sec_range, mail_p_city_name, mail_st, mail_ace_zip, 
													 local)
													 //uncomment for testing
													 // :persist(VotersV2.Cluster + 'Persist::Cleaned_Voters_DID_Deduped', SINGLE)
													 ;

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
Ds_Voters_WithDID := project(Ds_Voters_WithDID_src, 
                             transform(VotersV2.Layouts_Voters.Layout_Voters_base_new, 	
																			 string2 temp_st := if(trim(left.source_state,right,left) <> '',left.source_state,
																														 if(trim(left.st,left,right) <> '',left.st,left.mail_st));
                                       // persistent hash value									 
	                                     self.rid := if (left.rid = 0, hash64(temp_st, left.vendor_id, left.lname, left.name_suffix, left.fname, left.mname, 
																											                      left.name_type, left.dob, left.addr_type, left.prim_range, left.prim_name, left.predir,
																																						left.addr_suffix, left.postdir, left.unit_desig, left.sec_range, left.p_city_name,
																																						left.st, left.zip, left.file_acquired_date), left.rid);
                                       self := left)) ;

did_add.MAC_Add_SSN_By_DID(Ds_Voters_WithDID, did, ssn, Out_Voters_WithDidSsn)

export Cleaned_Voters_DID := Out_Voters_WithDidSsn 
//uncomment for testing purposes
// : persist(VotersV2.Cluster + 'Persist::Cleaned_Voters_DID', SINGLE)
;