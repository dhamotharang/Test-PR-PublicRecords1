IMPORT Business_Header;

f_cn := Business_Header_SS.File_BH_CompanyName_Plus;

layout_company_name_index := RECORD
	STRING20 clean_company_name20 := f_cn.clean_company_name[1..20];
	STRING60 clean_company_name60 := f_cn.clean_company_name[21..80];
	f_cn.bdid;
	f_cn.cn_bdids;
	f_cn.__filepos;
END;

EXPORT Key_BH_CompanyName := INDEX(
	f_cn, layout_company_name_index, 
	'~thor_data400::key::business_header.CompanyName_3_' +  
	//'built');
	business_header_ss.key_version, OPT);