IMPORT Data_Services, doxie;

EXPORT Constants := MODULE

		//Base/Input/Key Prefix
		EXPORT IN_NAME 								:= '~prte::in::yellowpages';
		EXPORT BASE_NAME							:= '~prte::base::yellowpages';
		EXPORT KEY_PREFIX							:= '~prte::key::yellowpages::';
																
		//Suffix
		EXPORT BDID_SUFFIX 			:= '::bdid';
		EXPORT LINKIDS_SUFFIX 	:= '::linkids';
		EXPORT PHONE_SUFFIX 	:= '::phone';

		EXPORT Key_Bdid				 	 := KEY_PREFIX+doxie.Version_SuperKey+BDID_SUFFIX;
		EXPORT Key_Bdid_Gen_Name := KEY_PREFIX+'bdid_' + doxie.Version_SuperKey;
		
		EXPORT Key_Linkids				 	:= KEY_PREFIX+doxie.Version_SuperKey+LINKIDS_SUFFIX;
		EXPORT Key_Linkids_Gen_Name := KEY_PREFIX+'linkids_' + doxie.Version_SuperKey;
		
		EXPORT Key_Phone				 	:= KEY_PREFIX+doxie.Version_SuperKey+PHONE_SUFFIX;
		EXPORT Key_Phone_Gen_Name := KEY_PREFIX+'phone_' + doxie.Version_SuperKey;
		
END;