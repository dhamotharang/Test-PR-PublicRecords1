export Layout_UTdl_In := 
RECORD, MAXLENGTH(50000)
	STRING10 dl_num;
	STRING8 date;
	STRING6 len;
	JPEG((INTEGER)SELF.len) photo;
END;