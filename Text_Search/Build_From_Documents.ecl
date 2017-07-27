

export Build_From_Documents(FileName_Info info, 
														BOOLEAN BuildDocNdx=TRUE,
														BOOLEAN NoIndexFile=TRUE) := FUNCTION
	kwd := KeywordingFunc(info);
	d1 := DISTRIBUTE(File_Document(info), HASH32(docRef.doc));
	docs := SORT(d1, docRef, LOCAL);
	docsegs := Documents2DocSeg(docs);
	invFile := Make_Inversion_List_Func(docsegs, info, kwd);
	r := Build_From_Inversion(info, invFile, kwd, BuildDocNdx, FALSE, NoIndexFile);
	RETURN r;
END;