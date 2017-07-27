EXPORT Layout_IndxInv := RECORD
	Text_Search.Layout_Posting; 
	UNSIGNED8 fpos{virtual(fileposition)} := 0;
END;
