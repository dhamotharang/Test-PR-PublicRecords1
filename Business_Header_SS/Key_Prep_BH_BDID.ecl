Import Data_Services, Business_Header, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_bh := PRTE2_Business_Header.File_Business_Header_Base_for_keybuild;
#ELSE
f_bh := business_header.File_Business_Header_Base_for_keybuild;
#END;

layout_bdid_index := RECORD
	f_bh.bdid;
	f_bh.__filepos;
END;

EXPORT Key_Prep_BH_BDID := INDEX(
	f_bh, layout_bdid_index, 
	'~thor_data400::key::business_header.BDID' + thorlib.wuid());