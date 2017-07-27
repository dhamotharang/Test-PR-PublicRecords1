export Layout_IndxDocSeg := RECORD
	Layout_DocSeg;
	UNSIGNED8		fpos{virtual(fileposition)} := 0;
END;