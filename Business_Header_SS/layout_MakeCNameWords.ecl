import Business_Header;
bh := Business_Header.Files().Base.Business_Headers.keybuild;

export layout_MakeCNameWords := record

	bh.company_name;
	bh.state;
	bh.bdid;
	bh.__filepos;
	unsigned4 lookups := 0;
END;