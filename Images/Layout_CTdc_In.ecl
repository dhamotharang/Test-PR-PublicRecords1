export Layout_CTdc_In :=
RECORD, MAXLENGTH(50000)
	STRING8 pkey;
	STRING8 inmate_no;
	STRING5 imgLength;
	Images.JPEG((INTEGER)SELF.imgLength) photo;
END;