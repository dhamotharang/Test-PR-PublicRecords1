

export Indx_Nominals(
										FileName_Info info
										, BOOLEAN fPhys=FALSE
										, BOOLEAN NoIndexFile = FALSE
										, DATASET(Layout_Posting) InvPosting =DATASET([],Layout_Posting)
										) := 
	INDEX(
				IF(
					 NoIndexFile
					 , PROJECT(
										InvPosting,
										TRANSFORM(
															{Text_Search.Layout_Posting; UNSIGNED8 fpos{virtual(fileposition)}}
															,	SELF.fpos := 0
															, SELF := LEFT 
															
															)
							  		)
						, File_Inversion(info, Fphys)),	
				{part, typ, nominal, docRef.src, docRef.doc, seg, kwp, UNSIGNED1 wip:=wip}, 
				{UNSIGNED3 suffix:=suffix, fpos}, 
				FileName(info, Types.FileTypeEnum.NominalNdx, fPhys), OPT, DISTRIBUTED);