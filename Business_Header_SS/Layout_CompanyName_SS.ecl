IMPORT Business_Header;
bh := Business_Header.File_Business_Header_Base;

EXPORT Layout_CompanyName_SS := RECORD
	bh.bdid;
	STRING80  clean_company_name;
	UNSIGNED1 cn_bdids := 254;
END;