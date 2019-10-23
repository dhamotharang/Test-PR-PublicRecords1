import bankruptcyv2, address, fcra, ut, data_services, BankruptcyV3;



kfSearch := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::bankrupt_search', FCRA.layout_search_ffid_v3,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::bankrupt_search::qa::ffid_v3
ut.MAC_CLEAR_FIELDS(kfSearch, kfSearch_cleared, BankruptcyV3.Constants().fields_to_clear.search_tmsid_linkids);

export key_override_bkv3_search_ffid := index (kfSearch_cleared, {flag_file_id}, {kfSearch_cleared}, 
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::bankrupt_search::qa::ffid_v3');