import Text_Search;

export RetrieveDoc(DATASET(Text_Search.Layout_DocHits) docHits, Text_Search.FileName_Info info, boolean fullDoc = TRUE) := FUNCTION
	docIndxFile := Text_Search.File_Indx_Document(info);
	
	Text_Search.Layout_Document trans(docHits l, docIndxFile r) := TRANSFORM
		SELF.segs := IF(fullDoc, r.segs, r.segs(segment IN SET(l.entries,seg)));
		SELF := l;
	END;
	
	docs := JOIN(docHits,docIndxFile, LEFT.docRef.src = RIGHT.docRef.src and LEFT.docRef.doc = RIGHT.docRef.doc, trans(LEFT,RIGHT),KEYED(Text_Search.Indx_Document(info)));
	RETURN docs;
END;