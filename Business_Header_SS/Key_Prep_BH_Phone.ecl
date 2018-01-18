IMPORT Business_Header, data_services;

f_p := Business_Header_SS.File_Prep_BH_CompanyName_Phone_Plus;

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
	data_services.data_location.prefix() + 'thor_data400::key::business_header.Phone_2' + thorlib.wuid());