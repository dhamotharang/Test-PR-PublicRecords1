import Data_Services;
export Constants := module
	
	export Cluster		 := Data_Services.Data_location.Prefix()+'thor_200';
	export ak_keyname  := Cluster + '::key::official_records::autokey::';
	export ak_logical(string filedate='')	:= Cluster+'::key::official_records::'+
	                                         filedate+'::autokey::';
	export ak_dataset	:= official_records.File_Autokey_Party;
	export ak_skipSet	:= ['P','Q','S','F'];
						//P in this set to skip personal phones
						//Q in this set to skip business phones
						//S in this set to skip SSN
						//F in this set to skip FEIN
						//C in this set to skip ALL personal (Contact) data
						//B in this set to skip ALL Business data
	export ak_typeStr	:= '\'AK\'';
	
	export stem			:= Cluster;
	export srcType	:= 'official_records';
	export qual			:= 'test';
end;
