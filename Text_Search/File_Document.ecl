// The document dataset
export File_Document(FileName_Info info, BOOLEAN fPhys=FALSE) :=
		DATASET(FileName(info, Types.FileTypeEnum.Doc, fPhys),
						Layout_Document, THOR);