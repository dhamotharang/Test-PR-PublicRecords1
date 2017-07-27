import Data_Services;

export constants  := module
// autokey
	export ak_dataset := CNLD_Facilities.file_Facilities_Autokeys;
	export ak_keyname := thor_cluster + 'key::cnldfacilities::autokey::@version@::';
	export ak_logical(string filedate) := thor_cluster + 'key::cnldfacilites::' + filedate + '::autokey::';
	export ak_qa_keyname := thor_cluster + 'key::cnldfacilities::autokey::qa::';
	export set_skip := ['P','S','C'];
					//  P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

	// export ak_typeStr	:= '\'AK\''	;
	// export STRING stem		:= '~thor_data400::base';
	// export STRING srcType:= 'cnld';
	// export STRING qual		:= 'test';
	
end;

