export Layout_Moxiedc_In :=
RECORD, MAXLENGTH(150000)
	STRING   filename;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;