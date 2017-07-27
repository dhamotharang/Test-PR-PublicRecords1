IMPORT Business_Header,ut;

f_a := Business_Header_SS.File_BH_CompanyName_Address_Broad_Plus
	((st_bdids > 0 and st_bdids < 100) or
	 (cn_st_bdids > 0 and cn_st_bdids < 100));

layout_address_index := RECORD
	f_a.state;
	qstring2 cn2 := f_a.company_name[1..2];
	qstring40 indic := datalib.companyclean(f_a.company_name)[1..40];
	qstring40 sec := datalib.companyclean(f_a.company_name)[41..80];
	//f_a.st_bdids;
	f_a.bdid;
	f_a.cn_st_bdids;
	f_a.__filepos;
END;

EXPORT Key_BH_Addr_st := INDEX(
	f_a, layout_address_index, 
	'~thor_data400::key::business_header.Addr_st_' + business_header_ss.key_version, OPT);