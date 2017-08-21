IMPORT Business_Header;
bh := Business_Header.Layout_Business_Header_base;

export Layout_CompanyName_Phone_SS := RECORD
	bh.bdid;
	bh.company_name;
	bh.phone;
	bh.prim_range;
	bh.prim_name;
	bh.sec_range;
	bh.zip;
	UNSIGNED1 cn_p_bdids := 254;
END;