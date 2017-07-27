// 
export RetrieveDocSeg(DATASET(Text_Search.Layout_DocHits) hits, 
											Text_Search.FileName_Info info, boolean fullDoc = TRUE) := FUNCTION
	docsegIndxFile := Text_Search.File_Indx_DocSeg(info);
	
	Text_Search.Layout_DocSeg trans(hits l, docsegIndxFile r) := TRANSFORM
		SELF := r;
	END;
	
	docHits := DEDUP(hits, docRef.src, docRef.doc);
	d1 := JOIN(docHits, docsegIndxFile, 
							LEFT.docRef.src=RIGHT.docRef.src AND LEFT.docRef.doc=RIGHT.docRef.doc, 
							trans(LEFT,RIGHT), KEYED(Indx_DocSeg(info, , docSegIndxFile)),
							LIMIT(Limits.Max_DocHits, FAIL(Limits.Join_Code, Limits.Join_Msg)));
	docs := SORT(d1, docRef.src, docRef.doc, segment, sect);
	
	// f1 := JOIN(hits, docsegIndxFile,
							// LEFT.docRef.src=RIGHT.docRef.src AND LEFT.docREf.doc=RIGHT.docREf.doc
							// AND LEFT.seg=RIGHT.segment AND LEFT.sect=RIGHT.sect,
							// trans(LEFT,RIGHT), KEYED(Indx_DocSeg(info, , docSegIndxFile)),
							// LIMIT(Limits.Max_DocHits, FAIL(Limits.Join_Code, Limits.Join_Msg)));
	// frags := SORT(f1, docREf.src, docRef.doc, segment, sect);
								
	RETURN docs; //IF(fullDoc, docs, frags);
END;
