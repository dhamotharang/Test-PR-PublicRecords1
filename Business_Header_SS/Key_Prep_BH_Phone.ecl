Import Data_Services, Business_Header, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_p := PRTE2_Business_Header.files().base.CompanynamePhone.keybuild;
#ELSE
f_p := business_header.files().base.CompanynamePhone.keybuild;
#END;


layout_phone_index := RECORD
	f_p.phone;
	f_p.company_name;
	f_p.bdid;
	f_p.cn_p_bdids;
	f_p.prim_range;
	f_p.prim_name;
	f_p.sec_range;
	f_p.zip;
	f_p.__filepos;
END;

EXPORT Key_Prep_BH_Phone := INDEX(
	f_p, layout_phone_index, 
	'~thor_data400::key::business_header.Phone_2' + thorlib.wuid());