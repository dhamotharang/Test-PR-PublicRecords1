f := File_UTdl_In;

Layout_Common cleaner(Layout_UTdl_In L) :=
TRANSFORM
	SELF.state := 'UT';	
	SELF.rtype := 'DL';
	SELF.id := L.dl_num;
	SELF.date := L.date;
	SELF.seq := 0;
	SELF.num := 0;
	SELF.imgLength := (INTEGER)L.len;
	SELF.photo := L.photo;
END;
p := PROJECT(f, cleaner(LEFT));

export Images_UT_dl := p : PERSIST('MALTEMP::Images_UT_dl');