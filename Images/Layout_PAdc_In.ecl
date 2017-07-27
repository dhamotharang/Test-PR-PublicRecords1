export Layout_PAdc_In := 
RECORD, MAXLENGTH(50000)
	STRING   filename;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;