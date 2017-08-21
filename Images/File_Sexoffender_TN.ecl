import ut;

fname := '~images::in::sexoffender_tn_all';

injpg := 
RECORD, MAXLENGTH(10000000)
	STRING   filename;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;

ds1 := dataset(fname,injpg,flat);

images.MAC_ShrinkImage(ds1,filename,imgLength,photo,ds2);

images.Layout_Common getspk(ds2 le, images.File_SO_CommonInfo ri) :=
TRANSFORM
	SELF.did := 0;
	SELF.state := 'TN';
	SELF.rtype := 'SO';
	SELF.id := ri.seisint_primary_key;
	SELF.seq := 0;
	SELF.date := '';
	SELF.num := 1;
	SELF.imgLength := le.imgLength;
	SELF.photo := le.photo;
	self.image_link := self.state + le.filename;
END;

// needed to workaround a bug in TN info .... can swap out for the standard code
// once it is fixed. -- filenames are missing leading '
j := JOIN(ds2, images.File_SO_CommonInfo, LEFT.filename= RIGHT.filename AND 
									RIGHT.seisint_primary_key[3..4]='TN', getspk(LEFT,RIGHT), LOOKUP);
									


export File_Sexoffender_TN := j : persist('images::base::sexoffender_tn');
