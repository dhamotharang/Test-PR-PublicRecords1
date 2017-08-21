import ut;

imges := File_PAdc_In;
info := File_PAdc_Info;

Layout_Common toCommon(imges L, info R) :=
TRANSFORM
	SELF.state := 'PA';	
	SELF.rtype := 'DC';
	SELF.id := (STRING)R.inmate_num;
	SELF.date := ut.dob_convert(R.photo_date, 4);
	SELF.seq := 0;
	SELF.num := 0;
	SELF.imgLength := (INTEGER)L.imgLength;
	SELF.photo := (DATA)L.photo;
	self.image_link := self.state + l.filename;
END;
j1 := JOIN(imges, info, LEFT.filename = RIGHT.filename, toCommon(LEFT, RIGHT), HASH);

export Images_PA_dc := dedup(j1, all) : PERSIST('CJMTEMP::Images_PA_dc');
