import VotersV2;

in_file := VotersV2.Cleaned_Addr_Cache_Base;

layout_base := VotersV2.Layouts_Voters.Layout_Voters_Base;

Invalid_Maiden_Names := ['','JR','SR','MRS','NONE','N/A',
                         'NOT AVAILABLE','UNAVAILABLE',
                         'UNK','UNKN','UNKNOWN'];

// Transform the Maiden Prior name value
layout_base trfMaidenPrior(in_file l, unsigned c) := transform
    string2 temp_st := if(trim(l.source_state,right,left) <> '',l.source_state,
	                      if(trim(l.st,left,right) <> '',l.st,l.mail_st));
														 
	self.lname      := choose(c, l.lname, trim(l.clean_maiden_pri,left,right));
	self.name_type  := choose(c, '','2');
	self.rid        := hash64(temp_st, l.vendor_id, self.lname, l.name_suffix, l.fname, l.mname, 
			 				  self.name_type, l.dob, l.addr_type, l.prim_range, l.prim_name, l.predir,
							  l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, l.p_city_name,
							  l.st, l.zip, l.file_acquired_date);
	self := l;
end;

// Normalize the Maiden Prior name value
Clean_Name_Norn_file  := NORMALIZE(in_file
									,if(trim(left.clean_maiden_pri,left,right) in Invalid_Maiden_Names or
									    trim(left.lname,left,right) = trim(left.clean_maiden_pri,left,right),1,2)
									,trfMaidenPrior(left,counter));
												
dis_clean_norm_file := distribute(Clean_Name_Norn_file, hash64(source_state, lname, name_suffix, fname, mname, dob,
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
															
export Norm_Voters_Cleaned_Base := deduped_clean_file : persist(VotersV2.Cluster+'persist::Voters_Norm_base');