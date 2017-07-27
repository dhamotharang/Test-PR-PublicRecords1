
export Indx_DocSeg(FileName_Info info, BOOLEAN fPhys=FALSE,
									DATASET(Layout_IndxDocSeg) dseg=DATASET([],Layout_IndxDocSeg)) := 
	INDEX(dseg,	
				{docRef.src,docRef.doc,segment,sect}, {fpos}, 
				FileName(info, Types.FileTypeEnum.DocSegNdx, fPhys));