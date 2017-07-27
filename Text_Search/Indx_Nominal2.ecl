
EXPORT Indx_Nominal2(FileName_Info info, BOOLEAN fPhys=FALSE, BOOLEAN NoIndexFile = TRUE,
										DATASET(Layout_IndxInv) InvPosting =DATASET([],Layout_IndxInv)) := 
	INDEX(IF(NoIndexFile, InvPosting, File_Inversion(info, Fphys)),	
				{Types.PartitionID lpart:=part, typ, nominal, part, 
					docRef.src, docRef.doc, seg, kwp, wip}, 
				{suffix, sect, fpos},
				FileName(info, Types.FileTypeEnum.NominalNdx2, fPhys), OPT, DISTRIBUTED);