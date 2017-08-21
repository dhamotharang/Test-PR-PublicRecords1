IMPORT Business_Header;
bh := Business_Header.Layout_Business_Header_base;

EXPORT Layout_CompanyName_SS := RECORD
	bh.bdid;
	STRING80  clean_company_name;
	UNSIGNED1 cn_bdids := 254;
END;