export File_Dictionary(FileName_Info info, BOOLEAN fPhys=FALSE) :=
	DATASET(FileName(info, Types.FileTypeEnum.Dictionary, fPhys),
					{Text_Search.Layout_Dictionary; UNSIGNED8 fpos{virtual(fileposition)}},
					THOR);