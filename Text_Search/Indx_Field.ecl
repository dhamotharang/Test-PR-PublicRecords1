EXPORT Indx_Field(FileName_Info info, BOOLEAN fPhys=FALSE, BOOLEAN NoIndexFile = TRUE,
										DATASET(Layout_FieldData) InvFields =DATASET([],Layout_FieldData)) := 
	INDEX(InvFields,	
					{prefix, typ, pos, part, docRef.src, docRef.doc, seg, kwp, segType, wip}, 
					{subTerm, fpos},
					FileName(info, Types.FileTypeEnum.FieldNdx, fPhys), DISTRIBUTED);