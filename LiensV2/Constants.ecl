IMPORT BIPV2;

export Constants := module

	export text_search := module
		export string stem		:= '~thor_data400::base';
		export string srcType	:= 'liensv2';
		export string qual		:= 'test';
		export string dateSegName			:= 'process-date';
		export unsigned2 alertSWDays	:= 31;
	end;

	EXPORT MAXCOUNT_PARTIES   := 25;
	EXPORT MAXCOUNT_FILINGS   := 15;
  
  EXPORT UNSIGNED2 JOIN_LIMIT     := 25000;
	EXPORT UNSIGNED1 JOIN_TYPE      := BIPV2.IDconstants.JoinTypes.KeepJoin;
	EXPORT UNSIGNED1 LIENS_DID_KEEP := 1000;

	//DF-22188 - Deprecate followings in thor_data400::key::liensv2::fcra::main::tmsid.rmsid_qa
	EXPORT fields_to_clear_main_id_fcra := 'accident_date,agency_city,case_title,date_vendor_removed,filing_time,' +
																			'judg_vacated_date,judge,lapse_date,legal_block,legal_borough,legal_lot,sherrif_indc,' +
																						 'tax_code,vendor_entry_date';
	//DF-22188 - Deprecate followings in thor_data400::key::liensv2::fcra::party::tmsid.rmsid_qa
	EXPORT fields_to_clear_party_id_fcra := 'phone,tax_id';
  
end;