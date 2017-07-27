import civil_court;
export Constants(string filedate='') := module
  // this is new format.
	export ak_QAname      :='~thor_data400::key::civil_court::qa::autokey::';
	export ak_keyname	:= '~thor_data400::key::civil_court::@version@::autokey::';
	export ak_logical := '~thor_data400::key::civil_court::'+filedate+'::autokey::';
	export ak_dataset	:=  civil_court.file_civilCourt_autokey;
	export ak_skipSet	:= ['P','Q','S','F'];
						//P in this set to skip personal phones
						//Q in this set to skip business phones
						//S in this set to skip SSN
						//F in this set to skip FEIN
						//C in this set to skip ALL personal (Contact) data
						//B in this set to skip ALL Business data

	export ak_typeStr	:= '\'AK\'';  // like official records

end;

