Import Data_Services, Business_Header, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_f := PRTE2_Business_Header.files().base.CompanynameFein.keybuild;
#ELSE
f_f := business_header.files().base.CompanynameFein.keybuild;
#END;


layout_fein_index := RECORD
	f_f.FEIN;
	f_f.company_name;
	f_f.bdid;
	f_f.cn_f_bdids;
	f_f.__filepos;
END;

EXPORT Key_Prep_BH_FEIN := INDEX(
	f_f, layout_fein_index, 
	'~thor_data400::key::business_header.FEIN_2' + thorlib.wuid());