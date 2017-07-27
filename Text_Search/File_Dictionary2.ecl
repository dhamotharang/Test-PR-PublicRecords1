EXPORT File_Dictionary2(FileName_Info info, BOOLEAN fPhys=FALSE) :=
	DATASET(FileName(info, Types.FileTypeEnum.LocalDictX2, fPhys),
					{Text_Search.Layout_Dictionary2; UNSIGNED8 fpos{virtual(fileposition)}},
					THOR);