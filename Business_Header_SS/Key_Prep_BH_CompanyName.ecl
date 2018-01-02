IMPORT Business_Header, data_services;

f_cn := Business_Header_SS.File_Prep_BH_CompanyName_Plus;

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
	data_services.data_location.prefix() + 'thor_data400::key::business_header.CompanyName_3' + thorlib.wuid());