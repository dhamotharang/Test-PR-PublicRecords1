IMPORT Business_Header;

f_cn := Business_Header_SS.File_BH_CompanyName;

layout_company_name_index := RECORD
	STRING20 clean_company_name20 := f_cn.clean_company_name[1..20];
	STRING60 clean_company_name60 := f_cn.clean_company_name[21..80];
	f_cn.bdid;
END;

t := table(f_cn, layout_company_name_index);
d := dedup(t, all);

export Key_BH_CompanyName_Unlimited := INDEX(
	d, 
	{clean_company_name20,clean_company_name60},
	{bdid},
	'~thor_data400::key::business_header.CompanyName_Unlimited_' +  
	business_header_ss.key_version);