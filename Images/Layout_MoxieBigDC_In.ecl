export Layout_MoxieBigDC_In :=
RECORD, MAXLENGTH(600000)
	STRING   filename;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;