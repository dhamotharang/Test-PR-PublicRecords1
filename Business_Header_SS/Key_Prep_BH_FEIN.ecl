IMPORT Business_Header, data_services;

f_f := Business_Header_SS.File_Prep_BH_CompanyName_FEIN_Plus;

layout_fein_index := RECORD
	f_f.FEIN;
	f_f.company_name;
	f_f.bdid;
	f_f.cn_f_bdids;
	f_f.__filepos;
END;

EXPORT Key_Prep_BH_FEIN := INDEX(
	f_f, layout_fein_index, 
	data_services.data_location.prefix() + 'thor_data400::key::business_header.FEIN_2' + thorlib.wuid());