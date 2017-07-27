IMPORT InstantID_Archiving;

export AutoKey_constants := module
	export str_autokeyname := InstantID_Archiving.str_AutokeyName;
	export ak_keyname	:= InstantID_Archiving.str_AutokeyName;
	export ak_logical	:= InstantID_Archiving.str_AutokeyLogicalName;
	
	export ak_dataset	:=  InstantID_Archiving.Files_Base.Delta; 
	export ak_skipSet	:= ['P','Q','F', 'B'];
	export ak_typeStr	:=  'AK'; //'\'AK\'';//'AK'; //or shoudl this be BC

END;