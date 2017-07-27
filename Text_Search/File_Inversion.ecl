// Layout1 := RECORD(Text_Search.Layout_Posting)
	// UNSIGNED8 fpos{virtual(fileposition)};
// END;

export File_Inversion(FileName_Info info, BOOLEAN fPhys=FALSE) :=
	DATASET(FileName(info, Types.FileTypeEnum.Inv, fPhys), 
					{Text_Search.Layout_Posting, UNSIGNED8 fpos{virtual(fileposition)}}, THOR);