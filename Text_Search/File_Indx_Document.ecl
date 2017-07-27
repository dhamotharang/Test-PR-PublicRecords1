// The document dataset
export File_Indx_Document(FileName_Info info, BOOLEAN fPhys=FALSE) :=
		DATASET(FileName(info, Types.FileTypeEnum.Doc, fPhys),
						{Layout_Document; UNSIGNED8 fpos{virtual(fileposition)}}, THOR);