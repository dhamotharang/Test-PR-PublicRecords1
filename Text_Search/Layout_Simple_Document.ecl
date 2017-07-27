export Layout_Simple_Document := RECORD
	STRING	HeadLine;
	STRING	Body{maxlength(3000000)};
	STRING	Date;
	INTEGER	docID;
END;