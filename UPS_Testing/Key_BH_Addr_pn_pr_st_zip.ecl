IMPORT Business_Header_SS;

biz_file := Business_Header_SS.File_BH_CompanyName_Address_Plus;
recs := biz_file(pr_pn_zip_bdids > 0 and pr_pn_zip_bdids < 100);

layout_address_index := RECORD
	recs.prim_name;
	recs.prim_range;
	recs.state;
	recs.zip;
	recs.sec_range;
	qstring2  cn2 := recs.company_name[1..2];
	qstring40 indic := datalib.companyclean(recs.company_name)[1..40];
	qstring40 sec := datalib.companyclean(recs.company_name)[41..80];
	recs.bdid;
	recs.cn_pr_pn_zip_bdids;
	recs.__filepos;
END;

EXPORT Key_BH_Addr_pn_pr_st_zip := INDEX(	recs, 
																					layout_address_index, 
																					'~thor400_88_staging::jcwtemp::key::business_header.Addr_pn_pr_st_zip_' + business_header_ss.key_version, 
																					OPT);