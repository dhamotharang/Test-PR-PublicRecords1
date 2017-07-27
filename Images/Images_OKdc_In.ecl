import ut;

behaving_badly := ['7ba6438fc4aa8a13d5e124587f58f84d'];

f := File_OKdc_In(filename NOT IN behaving_badly);


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
END;

j := JOIN(DISTRIBUTE(rtrn, HASH(TRIM(filename))), File_Moxie_Info, 
			LEFT.filename = RIGHT.file_name,
			make_common(LEFT, RIGHT), LOCAL);

export Images_OKdc_In := j : PERSIST('MALTEMP::Images_OK_dc');