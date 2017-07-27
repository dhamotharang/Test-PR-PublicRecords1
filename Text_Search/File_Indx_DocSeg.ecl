EXPORT File_Indx_DocSeg(FileName_Info info, BOOLEAN fPhys=FALSE) :=
		DATASET(FileName(info, Types.FileTypeEnum.DocSeg, fPhys),
						Layout_IndxDocSeg, THOR);