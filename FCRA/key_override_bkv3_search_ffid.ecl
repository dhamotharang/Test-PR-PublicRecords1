import bankruptcyv2, data_services, vault, _control;

layout_search_ffid_v3 := record
	bankruptcyv2.layout_bankruptcy_search_v3;
	string20 flag_file_id;
end;

kfSearch := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::bankrupt_search', 
                               layout_search_ffid_v3,
                               csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),
                               -flag_file_id),
                               except flag_file_id,keep(1));
															 

#IF(_Control.Environment.onVault) 
export key_override_bkv3_search_ffid := vault.FCRA.key_override_bkv3_search_ffid;
#ELSE
export key_override_bkv3_search_ffid := index (kfSearch, 
                                               {flag_file_id}, 
                                               {kfSearch}, 
                                               data_services.data_location.prefix()+'thor_data400::key::override::fcra::bankrupt_search::qa::ffid_v3');
#END;															 

