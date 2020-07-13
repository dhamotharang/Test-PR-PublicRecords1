import VotersV2, NID, Address;
//NID processing
//DF-27577 Moved NID between AID and DID, Renamed NID process from Norm_Voters_Cleaned_Base to Cleaned_Voters_Names_NID

in_file := VotersV2.Cleaned_Addr_Cache_Base;

layout_base := VotersV2.Layouts_Voters.Layout_Voters_Base_new;								

sendRecs		:= in_file(trim(fname + mname + lname) <> '');
notSendRecs := in_file(trim(fname + mname + lname) = '');

NID.Mac_CleanParsedNames(PROJECT(sendRecs, VotersV2.Layouts_Voters.Layout_Voters_base_new) 
																,NID_output
																,fname ,mname ,lname, name_suffix_in);	

VotersV2.Layouts_Voters.Layout_Voters_base_new tCleanPers(NID_output L) := TRANSFORM
	SELF.title		    := L.cln_title;
	SELF.fname	      := L.cln_fname;
	SELF.mname	      := L.cln_mname;
	SELF.lname		    := L.cln_lname;
	SELF.name_suffix	:= L.cln_suffix;
	SELF							:= L;			
END;

dStandardizedPerson := project(NID_output, tCleanPers(LEFT)) + notSendRecs : INDEPENDENT;								

dis_clean_norm_file := distribute(dStandardizedPerson, hash64(source_state, lname, name_suffix, fname, mname, dob,
								  prim_range, prim_name, predir, addr_suffix, postdir, unit_desig, sec_range,
								  p_city_name, st, zip, political_party, phone, work_phone, clean_maiden_pri,
                                  mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix, mail_postdir,
								  mail_unit_desig, mail_sec_range, mail_p_city_name, mail_st, mail_ace_zip));
// dedup all the duplicate records.
deduped_clean_file  := dedup(sort(dis_clean_norm_file, lname, name_suffix, fname, mname, dob, prim_range, prim_name,
								  predir, addr_suffix, postdir, unit_desig, sec_range, p_city_name, st, zip, political_party,
								  phone, work_phone, name_type, addr_type, -process_date, -file_acquired_date, -date_last_seen, local), 
							 lname, name_suffix, fname, mname, dob, prim_range, prim_name, predir, addr_suffix, postdir,
							 unit_desig, sec_range, p_city_name, st, zip, political_party, phone, work_phone, local);
															
export Cleaned_Voters_Names_NID := deduped_clean_file 
//uncomment for testing purposes
// : persist(VotersV2.Cluster+'persist::Cleaned_Voters_Names_NID', SINGLE)
;