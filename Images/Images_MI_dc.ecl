import ut;

f0 := File_MIdc_In;

// separate out the big ones to convert
toobig := f0(imglength > 49000);
justright := f0(imglength <= 49000);


images.MAC_ShrinkImage(toobig,filename,imglength,photo,shrunk)

f1 := justright + shrunk;

jpgPos(STRING nm) := IF(StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1) > 0,
						StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1)-1, 
						LENGTH(TRIM(nm)));
layout_common get_info(f1 L, images.File_MI_Info R) := transform
	self.state := 'MI';
	self.rtype := 'DC';
	self.seq := 0;
	self.num := 0;
	self.id := R.seisint_primary_key;
	self.date := R.date_created;
	self := L;
	self.image_link := self.state + l.filename;
end;

outf := join(distribute(f1,hash(filename[1..jpgpos(filename)])),distribute(images.File_MI_Info,hash(file_name)),
					left.filename[1..jpgpos(left.filename)] = right.file_name,
					get_info(LEFT,RIGHT), left outer, local);

					
export Images_MI_dc := outf : PERSIST('MALTEMP::Images_MI_dc');