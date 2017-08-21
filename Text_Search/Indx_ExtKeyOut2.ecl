EXPORT Indx_ExtKeyOut2(FileName_Info info, BOOLEAN fPhys=FALSE, 
										DATASET(Layout_ExternalKeyOut) KeyFileOut =DATASET([],Layout_ExternalKeyOut)) := 
	      INDEX(KeyFileOut,	
						 {DocRef.src, DocRef.doc}, 
						 {part, ver, ExternalKey},
				FileName(info, Types.FileTypeEnum.ExtKeyOut2, fPhys), DISTRIBUTED, OPT);