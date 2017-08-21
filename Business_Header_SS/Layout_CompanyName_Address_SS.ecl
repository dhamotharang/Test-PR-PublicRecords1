IMPORT Business_Header;
bh := Business_Header.Layout_Business_Header_base;

EXPORT Layout_CompanyName_Address_SS := RECORD
	bh.bdid;
	bh.company_name;
	bh.prim_range;
	bh.prim_name;
	bh.sec_range;
	bh.zip;
	bh.state;
	UNSIGNED4 pr_pn_zip_bdids := 0;
	UNSIGNED4 pr_pn_sr_st_bdids := 0;
	UNSIGNED1 cn_pr_pn_zip_bdids := 254;
	UNSIGNED1 cn_pr_pn_sr_st_bdids := 254;
END;