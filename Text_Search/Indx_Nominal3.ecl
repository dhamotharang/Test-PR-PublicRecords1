rtypes := [Text_Search.Types.WordType.NumericRange,Text_Search.Types.WordType.DateRange];

EXPORT Indx_Nominal3(FileName_Info info, BOOLEAN fPhys=FALSE, BOOLEAN NoIndexFile = TRUE,
										DATASET(Layout_IndxInv) InvPosting =DATASET([],Layout_IndxInv)) := 
	INDEX(IF(NoIndexFile, InvPosting, File_Inversion(info, Fphys)),	
						 {typ, nominal, Types.Segment lseg:=IF(typ IN rtypes, seg, 0), part,
							docRef.src, docRef.doc, seg, kwp, wip, suffix}, 
						 {sect, fpos},
				FileName(info, Types.FileTypeEnum.NominalNdx3, fPhys), DISTRIBUTED);