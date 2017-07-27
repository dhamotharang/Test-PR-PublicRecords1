
EXPORT Build_From_DocSeg_Records(
																DATASET(Layout_DocSeg) ds,
																FileName_Info info,
																BOOLEAN NoIndexFile = TRUE) := 	FUNCTION
	// Data is required to be distributed such that all records for a 
	// doc reference value are on the same node.
	kwd := KeywordingFunc(info);
	d1 := DISTRIBUTED(ds, HASH32(docRef.doc));
	docsegs := SORT(d1, docRef, segment, sect, LOCAL);
	
	// There may be segment defined for external keys, extract them here if it exists
	segd := Segment_Metadata(info);
	ExternalKeys := IF(segd.KeySeg>0,docsegs(segment=segd.KeySeg),dataset([],recordof(docsegs)));
	docsegs1 := IF(segd.KeySeg>0,docsegs(segment<>segd.KeySeg),docsegs);
	
	invFile := Make_Inversion_List_Func(docsegs1, info, kwd);
	r := Build_From_Inversion(info, invFile, kwd, FALSE, FALSE, NoIndexFile, ExternalKeys);
	RETURN r;
END;