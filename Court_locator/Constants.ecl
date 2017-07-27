
export Constants := module
	
	export Cluster		:= '~thor_data400';
	export ak_keyname  := Cluster + '::key::courtlocatorlookup::autokey::';
	export ak_logical(string filedate='')	:= Cluster+'::key::courtlocatorlookup::'+filedate+'::autokey::';
	export ak_dataset	:= Court_locator.file_lookup_autokey;
	export ak_skipSet	:= ['P','S','F','C'];
						//P in this set to skip personal phones
						//S in this set to skip SSN
						//F in this set to skip FEIN
						//C in this set to skip ALL personal (Contact) data
	export ak_typeStr	:= '\'AK\'';
	
	export stem			:= Cluster;
	export srcType		:= 'courtlocatorlookup';
	export qual			:= 'test';

end;

