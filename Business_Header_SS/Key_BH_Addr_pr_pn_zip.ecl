IMPORT Business_Header;

f_a := Business_Header_SS.File_BH_CompanyName_Address_Plus
	((pr_pn_zip_bdids > 0 and pr_pn_zip_bdids < 100) or
	 (pr_pn_zip_bdids > 0 and pr_pn_zip_bdids < 100));

layout_address_index := RECORD
	f_a.zip;
	f_a.prim_name;
	f_a.prim_range;
	qstring2 cn2 := f_a.company_name[1..2];
	qstring40 indic := datalib.companyclean(f_a.company_name)[1..40];
	qstring40 sec := datalib.companyclean(f_a.company_name)[41..80];
	//f_a.pr_pn_zip_bdids;
	f_a.bdid;
	f_a.cn_pr_pn_zip_bdids;
	f_a.__filepos;
END;

EXPORT Key_BH_Addr_pr_pn_zip := INDEX(
	f_a, layout_address_index, 
	'~thor_data400::key::business_header.Addr_pr_pn_zip_' + business_header_ss.key_version, OPT);