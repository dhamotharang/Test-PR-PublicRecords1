
EXPORT Indx_ExtKeyIn2(FileName_Info info, BOOLEAN fPhys=FALSE, 
										DATASET(Layout_ExternalKeyIn) KeyFileIn =DATASET([],Layout_ExternalKeyIn)) := 
	      INDEX(KeyFileIn,	
						 {HashKey, part, DocRef.src, DocRef.doc}, 
						 {ver, ExternalKey},
				FileName(info, Types.FileTypeEnum.ExtKeyIn2, fPhys), DISTRIBUTED);