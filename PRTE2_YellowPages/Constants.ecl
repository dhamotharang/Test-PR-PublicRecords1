IMPORT Data_Services, doxie;

EXPORT Constants := MODULE

		//Base/Input/Key Prefix
		EXPORT IN_NAME 								:= '~prte::in::yellowpages';
		EXPORT BASE_NAME							:= '~prte::base::yellowpages';
		EXPORT KEY_PREFIX							:= '~prte::key::yellowpages::';
																
		//Suffix
		EXPORT BDID_SUFFIX 		:= '::bdid';
		EXPORT LINKIDS_SUFFIX 	:= '::linkids';
		EXPORT PHONE_SUFFIX 	:= '::phone';

		EXPORT Key_Bdid_Name	 := '~prte::key::yellowpages::bdid_'+doxie.Version_SuperKey;
		EXPORT Key_Bdid_Gen_Name := '~prte::key::yellowpages::bdid_@version@';
	
		EXPORT Key_Linkids_Name     := '~prte::key::yellowpages::linkids_'+doxie.Version_SuperKey;
		EXPORT Key_Linkids_Gen_Name := '~prte::key::yellowpages::linkids_@version@';
		
		EXPORT Key_Phone_Name 	  := '~prte::key::yellowpages::phone_'+doxie.Version_SuperKey;
		EXPORT Key_Phone_Gen_Name := '~prte::key::yellowpages::phone_@version@';
		
END;