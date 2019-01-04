EXPORT Constants(string filedate = '', boolean isFCRA = false) := module

	// DF-22108 FCRA Consumer Data Deprecation for FCRA_BankruptcyKeys
	export fields_to_clear := module
		// thor_data400::key::bankruptcyv3::fcra::main::tmsid_qa
		export main_tmsid								:= 'assets,complaint_deadline,confheardate,datereclosed,judges_identification,' +
																						'liabilities,meeting_time,planconfdate,trusteeemail';
		// thor_data400::key::bankruptcyv3::fcra::search::tmsid_linkids_qa																				
		export search_tmsid_linkids	:= 'datetransferred,holdcase,orig_email,orig_fax,phone,tax_id';

		// thor_data400::key::bankruptcy::autokey::fcra::payload_qa																				
		export autokey_payload	:= 'tax_id';
	end;

end;