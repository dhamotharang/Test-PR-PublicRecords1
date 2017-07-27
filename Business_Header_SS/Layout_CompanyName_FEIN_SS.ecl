IMPORT Business_Header;
bh := Business_Header.File_Business_Header_Base;

export Layout_CompanyName_FEIN_SS := RECORD
	bh.bdid;
	bh.company_name;
	bh.fein;
	UNSIGNED1 cn_f_bdids := 254;
END;