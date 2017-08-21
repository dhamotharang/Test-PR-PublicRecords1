import ut, PromoteSupers;

//OUTPUT(Domains.whois_did,,'~thor_data400::BASE::Whois_' + whois_build_date, overwrite);

//*** appending the source record ids for the records.                                                                                                                                                   
ut.MAC_Append_Rcid (domains.whois_did,source_rec_id,out_file);

PromoteSupers.MAC_SF_BuildProcess(out_file,'~thor_data400::base::whois',do1,2);

export make_whois_base := do1;

