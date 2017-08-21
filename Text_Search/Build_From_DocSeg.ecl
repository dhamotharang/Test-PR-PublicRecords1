
EXPORT Build_From_DocSeg(FileName_Info info, BOOLEAN BuildDocSegNdx = FALSE,
												BOOLEAN NoNdxFile = TRUE, UNSIGNED kwdVersion=0,
												Types.SegmentType segType=0) :=  FUNCTION
	kwd := KeywordingFunc(info, FALSE, kwdVersion, segType);
	docsegs := DISTRIBUTED(File_DocSeg(info), docRef.doc);
	invFile := Make_Inversion_List_Func(docsegs, info, kwd);
	segList := File_Segment_Definition(info);
	r := Build_From_Inversion(info, invFile, kwd, FALSE, BuildDocSegNdx, NoNdxFile, segList);
	RETURN r;
END;