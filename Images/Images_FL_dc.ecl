import ut;

jpgPos(STRING nm) := IF(StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1) > 0,
						StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1)-1, 
						LENGTH(TRIM(nm)));

f := distribute(File_FLdc_In, hash(filename[1..jpgpos(filename)]));

Layout_Common fixitup(Layout_MoxieDC_In L, file_florida_info R) := transform
	SELF.state := 'FL';
	SELF.rtype := 'DC';
	SELF.id := R.seisint_primary_key[3..75];
	SELF.date := R.date_created;
	SELF.imgLength := l.imglength;
	SELF.Photo := l.photo;
	SELF.seq := 0;
	SELF.num := 0;
	self.image_link := self.state + l.filename;
end;

export Images_FL_dc := join(f, distribute(file_florida_info, hash(file_name)),
			left.filename[1..jpgpos(left.filename)] = right.file_name,
			fixitup(LEFT, right), local) : PERSIST('MALTEMP::Images_FL_dc');