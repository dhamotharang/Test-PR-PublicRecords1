f := File_GA_In;

Layout_Common cleaner(F L, images.File_GA_Info R) :=
TRANSFORM
	SELF.state := 'GA';	
	SELF.rtype := 'DC';
	SELF.id := R.seisint_primary_key[3..75];
	SELF.date := '';
	SELF.seq := 0;
	SELF.num := 0;
	SELF := L;
	self.image_link := self.state + l.filename;
END;

jpgPos(STRING nm) := IF(StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1) > 0,
						StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1)-1, 
						LENGTH(TRIM(nm)));

p := join(distribute(f,hash(filename[1..jpgpos(filename)])), distribute(images.file_ga_info,hash(file_name)),
		left.filename[1..jpgpos(left.filename)] = right.file_name,
		cleaner(LEFT, RIGHT), local);

export Images_GA := p : PERSIST('MALTEMP::Images_GA_dc');