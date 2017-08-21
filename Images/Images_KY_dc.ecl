import ut;

jpgPos(STRING nm) := IF(StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1) > 0,
						StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1)-1, 
						LENGTH(TRIM(nm)));

f := File_Kydc_In;

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

j := JOIN(DISTRIBUTE(rtrn, HASH(filename[1..jpgPos(filename)])), 
		  File_Moxie_Info, 
		  LEFT.filename[1..jpgPos(LEFT.filename)] = RIGHT.file_name[1..jpgPos(RIGHT.file_name)],
		  make_common(LEFT, RIGHT), LOCAL);

export Images_KY_dc := j : PERSIST('MALTEMP::Images_KY_dc');