import VotersV2, NID, Address;
//DF-27577 Remove NID processing because we decided to use already parsed names from the vendor. 
//DF-27577 Renamed NID process from Norm_Voters_Cleaned_Base to Cleaned_Voters_Names_NID

in_file := VotersV2.Cleaned_Addr_Cache_Base;

layout_base := VotersV2.Layouts_Voters.Layout_Voters_Base_new;									
		
VotersV2.Layouts_Voters.Layout_Voters_base_new tCleanPers(in_file L) := TRANSFORM
	SELF.title		    := L.prefix_title;
	SELF.fname	      := L.first_name;
	SELF.mname	      := L.middle_name;
	temp_last_name    := if(L.name_type = '2',trim(L.clean_maiden_pri,left,right),trim(L.last_name,left,right));
	SELF.lname        := temp_last_name;
	SELF.name_suffix	:= L.name_suffix_in;
	SELF						  := L;			
END;

dStandardizedPerson := project(in_file, tCleanPers(LEFT)): INDEPENDENT;								

dis_clean_norm_file := distribute(dStandardizedPerson, 
                                  hash64(hashmd5(source_state, vendor_id, last_name, name_suffix_in, first_name, middle_name, 
																	               clean_maiden_pri, name_type, dob, addr_type,
																								 res_addr1,res_addr2,res_city,res_state,res_zip, 
																								 mail_addr1,mail_addr2,mail_city,mail_state,mail_zip,
								                                 political_party, phone, work_phone)));
// dedup all the duplicate records.
deduped_clean_file  := dedup(sort(dis_clean_norm_file, vendor_id, last_name, name_suffix_in, first_name, middle_name, 
																	clean_maiden_pri, name_type, dob, addr_type,
																	res_addr1,res_addr2,res_city,res_state,res_zip, 
																	mail_addr1,mail_addr2,mail_city,mail_state,mail_zip,
								                  political_party, phone, work_phone, 
																	-process_date, -file_acquired_date, -date_last_seen, local), 
							               vendor_id, last_name, name_suffix_in, first_name, middle_name, 
														 clean_maiden_pri, name_type, dob, addr_type,
														 res_addr1,res_addr2,res_city,res_state,res_zip, 
														 mail_addr1,mail_addr2,mail_city,mail_state,mail_zip,
								             political_party, phone, work_phone, local);
															
export Cleaned_Voters_Names_NID := deduped_clean_file 
//uncomment for testing purposes
: persist(VotersV2.Cluster+'persist::Cleaned_Voters_Names', SINGLE)
;