// The normalized document data set.
export File_DocSeg(FileName_Info info, BOOLEAN fPhys=FALSE) :=
		DATASET(FileName(info, Types.FileTypeEnum.DocSeg, fPhys),
						Layout_DocSeg, THOR);