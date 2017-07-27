// Index file

export Indx_Document(FileName_Info info, BOOLEAN fPhys=FALSE) := 
	INDEX(File_Indx_Document(info),	
				{docRef.src,docRef.doc}, {fpos}, 
				FileName(info, Types.FileTypeEnum.DocIndx, fPhys));