import Data_Services;

export constants  := module
// autokey
	export ak_dataset := Prof_License_Mari.file_mari_search;
	export ak_keyname := thor_cluster + 'key::proflic_mari::autokey::@version@::';
	export ak_logical(string filedate) := thor_cluster + 'key::proflic_mari::' + filedate + '::autokey::';
	export ak_qa_keyname := thor_cluster + 'key::proflic_mari::autokey::qa::';
	export set_skip := [];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

	export TYPE_STR := 'ak';
	export USE_ALL_LOOKUPS := TRUE;

end;


