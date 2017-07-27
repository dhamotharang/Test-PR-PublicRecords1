Import FLAccidents_Ecrash;
export Constants := module
	
	export Cluster		:= '~thor_data400';
	export ak_keyname  := Cluster + '::key::flcrash::autokey::';
	export ak_logical(string filedate='')	:= Cluster+'::key::flcrash::'+filedate+'::autokey::';
	export ak_dataset	:= FLAccidents.File_flcrash_AutoKey;
	export ak_skipSet	:= ['P','Q','S','F'];
						//P in this set to skip personal phones
						//Q in this set to skip business phones
						//S in this set to skip SSN
						//F in this set to skip FEIN
						//C in this set to skip ALL personal (Contact) data
						//B in this set to skip ALL Business data
	export ak_typeStr	:= '\'AK\'';
	
	export stem			:= Cluster;
	export srcType		:= 'flcrash';
	export qual			:= 'test';
	
///////////////////////////////////////////////////////////////////////////////////////////////////
	export ntl_keyname  := Cluster + '::key::ntlcrash::autokey::';
	export ntl_logical(string filedate='')	:= Cluster+'::key::ntlcrash::'+filedate+'::autokey::';
	export ntl_dataset	:= FLAccidents.File_ntlcrash_AutoKey;
	export ntl_srcType	:= 'ntlcrash';
	///////////////////////////////////////////////////////////////////////////////////////////////////
	export e_keyname  := Cluster + '::key::ecrash::autokey::';
	export e_logical(string filedate='')	:= Cluster+'::key::ecrash::'+filedate+'::autokey::';
	export e_dataset	:= FLAccidents_Ecrash.File_Ecrash_AutoKey;
	export e_srcType	:= 'ecrash';
	///////////////////////////////////eCrash V2 keys//////////////////////////////////////////////////
	export eV2_keyname  := Cluster + '::key::ecrashV2::autokey::';
	export eV2_logical(string filedate='')	:= Cluster+'::key::ecrashV2::'+filedate+'::autokey::';
	export eV2_dataset	:= FLAccidents_Ecrash.File_Ecrash_AutoKeyV2;
	export eV2_srcType	:= 'ecrash';
end;
