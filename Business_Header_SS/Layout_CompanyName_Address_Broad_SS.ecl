IMPORT Business_Header;
bh := Business_Header.File_Business_Header_Base;

EXPORT Layout_CompanyName_Address_Broad_SS := RECORD
	bh.bdid;
	bh.company_name;
	bh.zip;
	bh.state;
	UNSIGNED4 zip_bdids := 0;
	UNSIGNED4 st_bdids := 0;
	UNSIGNED1 cn_zip_bdids := 254;
	UNSIGNED1 cn_st_bdids := 254;
END;