
EXPORT Indx_ExternalKeyOut(FileName_Info info, BOOLEAN fPhys=FALSE, 
										DATASET(Layout_ExternalKeyOut) KeyFileOut =DATASET([],Layout_ExternalKeyOut)) := 
	      INDEX(KeyFileOut,	
						 {DocRef.src, DocRef.doc}, 
						 {ExternalKey},
				FileName(info, Types.FileTypeEnum.ExternalKeyOut, fPhys), DISTRIBUTED);