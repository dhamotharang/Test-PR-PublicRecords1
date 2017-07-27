export Layout_GA_In :=
RECORD, MAXLENGTH(50000)
	STRING   filename;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;