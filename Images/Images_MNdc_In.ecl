import ut;

f := File_MNdc_In;


MAC_ShrinkImage(f, filename, imgLength, photo, rtrn)

Layout_Common make_common (rtrn L, File_Moxie_Info R) :=
TRANSFORM
	SELF.state := R.st;
	SELF.rtype := 'DC';
	SELF.id := R.seisint_primary_key;
	SELF.seq := 0;
	SELF.date := '';
	SELF.num := 0;
	SELF.imgLength := L.imgLength;
	SELF.photo := L.photo;
	self.image_link := self.state + l.filename;
END;

j := JOIN(DISTRIBUTE(rtrn, HASH(TRIM(filename))), File_Moxie_Info, 
			LEFT.filename = RIGHT.file_name,
			make_common(LEFT, RIGHT), LOCAL);

export Images_MNdc_In := j : PERSIST('MALTEMP::Images_MN_dc');