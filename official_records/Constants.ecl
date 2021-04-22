import STD,dx_official_records;
export Constants := module
	
	export Cluster		 := '~thor_200';
	// For testing on dataland, comment out the line above and uncomment the line below.
	// Make the same change to: Key_Document_ORID, Key_Party_ORID and Key_Official_Record_Payload.
	//export Cluster		 := '~thor_data400';
	export ak_keyname  := Cluster + '::key::official_records::autokey::';
	export ak_logical(string filedate='')	:= Cluster+'::key::official_records::'+
	                                         filedate+'::autokey::';
	export ak_dataset(boolean isDelta = false)	:= official_records.Data_Keys(isDelta).i_autokey_party;
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
	//check the number of subfiles in superkey file to determine the build is delta update or full build
	//threshold is 4
	num_subfiles := nothor(STD.File.SuperFileContents(dx_official_records.names().i_party));
  export DeltaBuild := if(count(num_subfiles) <= 4, true, false);
													
end;

