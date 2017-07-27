import Data_Services;
export Constants := module
	
	export Cluster		:= Data_Services.Data_location.SexOffender + 'thor_data400';
	export ak_keyname  := Cluster + '::key::sexoffender::autokey::';
	export ak_logical(string filedate='')	:= Cluster+'::key::sexoffender::'+filedate+'::autokey::';
	export ak_dataset	:= SexOffender.File_AutoKey_Main;
	export ak_skipSet	:= ['P','B'];  //skip personal phones and all business data
						//P in this set to skip personal phones
						//Q in this set to skip business phones
						//S in this set to skip SSN
						//F in this set to skip FEIN
						//C in this set to skip ALL personal (Contact) data
						//B in this set to skip ALL Business data
	export ak_typeStr	:= '\'AK\'';
	
	export stem			:= Cluster;
	export srcType		:= 'sexoffender';
	export qual			:= 'test';
	
	// These states have explicit text in "offense_description_2"
	export explicitOffenseStates := ['ND'];

	EXPORT OffenseCategory := MODULE
		export unsigned8 ABDUCTION := 2;
		export unsigned8 BURGLARY := 4;
		export unsigned8 COMPUTER_CRIME := 8;
		export unsigned8 CONTRIBUTING := 16777216;
		export unsigned8 CORRUPTION := 16;
		export unsigned8 ENDANGER_WELFARE_OF_MINORS := 32;
		export unsigned8 EXPLOITATION := 64;
		export unsigned8 EXPOSURE := 128;
		export unsigned8 FAILURE_TO_COMPLY := 256;
		export unsigned8 FALSE_IMPRISONMENT:= 512;
		export unsigned8 IMPORTUNING:= 1024;
		export unsigned8 INCEST:= 2048;
		export unsigned8 MURDER := 4096;
		export unsigned8 OTHER:= 8192;
		export unsigned8 PORNOGRAPHY:= 16384;
		export unsigned8 PROSTITUTION := 32768;
		export unsigned8 RAPE := 65536;
		export unsigned8 REGISTRATION:= 131072;
		export unsigned8 RESTRAINT:= 262144;
		export unsigned8 ROBBERY:= 524288;
		export unsigned8 SEXUAL_ASSAULT:= 1048576;
		export unsigned8 SEXUAL_ASSAULT_MINOR:= 2097152;
		export unsigned8 SOLICITATION:= 4194304;
		export unsigned8 UNLAWFUL_COMMUNICATION_MINOR:= 8388608;
	END;
	
end;