Import Data_Services, Business_Header, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_cn := PRTE2_Business_Header.files().base.Companyname.keybuild;
#ELSE
f_cn := business_header.files().base.Companyname.keybuild;
#END;

layout_company_name_index := RECORD
	STRING20 clean_company_name20 := f_cn.clean_company_name[1..20];
	STRING60 clean_company_name60 := f_cn.clean_company_name[21..80];
	f_cn.bdid;
	f_cn.cn_bdids;
	f_cn.__filepos;
END;

ft := table(f_cn, layout_company_name_index);

r := record
	ft;
end;

EXPORT Key_Prep_BH_CompanyName := INDEX(
	ft(cn_bdids > 0 and cn_bdids <= 10), r, 
	'~thor_data400::key::business_header.CompanyName_3' + thorlib.wuid());