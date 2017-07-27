import Business_Header,doxie;
bh := Business_Header.File_Business_Header_FP;

export layout_NameWords := record

	STRING40 word;
	bh.state;
	unsigned1 seq;
	doxie.Layout_ref_bdid;
	
end;