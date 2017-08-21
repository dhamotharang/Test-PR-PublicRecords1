import Business_Header;
bh := Business_Header.Layout_Business_Header_base;

export Layout_BH_BDID_City_Plus := RECORD
	bh.bdid;
	bh.city;
	bh.zip;
	bh.fein;
	bh.phone;
END;