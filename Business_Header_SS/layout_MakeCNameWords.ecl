import Business_Header;
bh := Business_Header.File_Business_Header_FP;

export layout_MakeCNameWords := record

	bh.company_name;
	bh.state;
	bh.bdid;
	bh.__filepos;
	unsigned4 lookups := 0;
END;