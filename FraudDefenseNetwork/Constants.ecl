EXPORT Constants(

	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
MODULE

	EXPORT autokey_buildskipset := [];
	/*
		'C' -- skip person keys altogether
          'P' -- skip person phone key
		      'S' -- skip ssn key

		
		'B' -- skip business keys altogether 
      		'Q' -- skip biz phone key
		      'F' -- skip Fein key

*/
	EXPORT          TYPE_STR	       := 'AK';
	EXPORT          ak_dataset       := FraudDefenseNetwork.File_Autokey();
	EXPORT          ak_qa_keyname    := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'key::fdn::qa::autokey::';
	EXPORT          AUTOKEY_SKIP_SET := autokey_buildskipset;  


END;