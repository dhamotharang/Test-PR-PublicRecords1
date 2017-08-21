Import Data_Services, business_header_ss, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
bh_base := PRTE2_Business_Header.File_Business_Header_Base_For_Keybuild;
#ELSE
bh_base := Business_Header.File_Business_Header_Base_for_keybuild;
#END;

export Key_Business_Header_RCID := INDEX(bh_base, 
		  {rcid, bdid}, 
		 '~thor_data400::key::business_header.rcid_' + business_header_ss.key_version);