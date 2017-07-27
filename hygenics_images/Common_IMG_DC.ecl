import ut, images;

export Common_IMG_DC(STRING2 state, STRING fname) := FUNCTION

	injpg := RECORD, MAXLENGTH(100000000)
		STRING   filename;
		UNSIGNED4 imgLength;
		JPEG(SELF.imgLength) photo;
	END;

	ds1 := dataset(fname,injpg,flat);

	images.MAC_ShrinkImage(ds1,filename,imgLength,photo,ds2);

	Layout_Common getspk(ds2 le, hygenics_images.File_IMG_CommonInfo ri) := TRANSFORM
		SELF.did 		:= 0;
		SELF.state 		:= state;
		SELF.rtype 		:= 'DC';
		SELF.id 		:= ri.offender_key;
		SELF.seq 		:= 0;
		SELF.date 		:= '';
		SELF.num 		:= 1;
		self.image_link := ri.filename;
		SELF.imgLength 	:= le.imgLength;
		SELF.photo 		:= le.photo;
	END;

	j := JOIN(ds2, hygenics_images.File_IMG_CommonInfo, 
				LEFT.filename=RIGHT.filename AND 
				RIGHT.state_origin=state, 
				getspk(LEFT,RIGHT));
																		
RETURN j;

END;
