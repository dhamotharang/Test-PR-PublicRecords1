IMPORT Data_Services, doxie;

EXPORT Constants := MODULE

		//Base/Input/Key Prefix
		EXPORT In_Prefix 		:= '~prte::in::bbb::';
		EXPORT Base_Prefix	:= '~prte::base::bbb::';
		EXPORT Key_Prefix		:= '~prte::key::bbb::';
		
		//Key suffixes
		EXPORT Memeber_Bdid_suffix 			:= '::member::bdid';
		EXPORT Nonmember_Bdid_suffix 		:= '::nonmember::bdid';
		EXPORT Member_Linkids_Suffix 		:= '::member::linkids';
		EXPORT Nonmember_Linkids_Suffix := '::nonmember::linkids';
		
		//Basefile names
		EXPORT Base_Member 		:= Base_Prefix+'member';	
		EXPORT Base_NonMember := Base_Prefix+'nonmember';			
		
		//Key Names
		EXPORT Key_BBB_Member_LinkIds_Name 			:= Key_Prefix+doxie.Version_SuperKey+Member_Linkids_Suffix;
		EXPORT Key_BBB_Non_Member_LinkIds_Name 	:= Key_Prefix+doxie.Version_SuperKey+Nonmember_Linkids_Suffix;
		EXPORT Key_BBB_Member_BDID_Name 				:= Key_Prefix+doxie.Version_SuperKey+Memeber_Bdid_suffix;
		EXPORT Key_BBB_Non_Member_BDID_Name 		:= Key_Prefix+doxie.Version_SuperKey+Nonmember_Bdid_suffix;

		//Key Names Generationsal
		EXPORT Key_BBB_Member_LinkIds_Gen_Name 			:= '~prte::key::bbb_linkids_@version@';
		EXPORT Key_BBB_Non_Member_LinkIds_Gen_Name 	:= '~prte::key::bbb_non_member_linkids_@version@';
		EXPORT Key_BBB_Member_BDID_Gen_Name 				:= '~prte::key::bbb_bdid_@version@';
		EXPORT Key_BBB_Non_Member_BDID_Gen_Name 		:= '~prte::key::bbb_non_member_bdid_@version@';
		
END;