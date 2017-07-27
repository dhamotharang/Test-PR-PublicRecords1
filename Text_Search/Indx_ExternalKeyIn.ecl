


EXPORT Indx_ExternalKeyIn(FileName_Info info, BOOLEAN fPhys=FALSE, 
										DATASET(Layout_ExternalKeyIn) KeyFileIn =DATASET([],Layout_ExternalKeyIn)) := 
	      INDEX(KeyFileIn,	
						 {HashKey, part, DocRef.src, DocRef.doc}, 
						 {ExternalKey},
				FileName(info, Types.FileTypeEnum.ExternalKeyIn, fPhys), DISTRIBUTED);