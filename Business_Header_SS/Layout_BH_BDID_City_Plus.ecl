import Business_Header;
bh := Business_Header.File_Business_Header;

export Layout_BH_BDID_City_Plus := RECORD
	bh.bdid;
	bh.city;
	bh.zip;
	bh.fein;
	bh.phone;
END;