import ut,appriss;

export Common_JB(STRING fname) :=
FUNCTION

injpg := 
RECORD, MAXLENGTH(100000000)
	STRING    filename;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;

image_ds := dataset(fname,injpg,flat);
//output(ds1,{filename[2..length(filename)-4]});
//output(ds1,{filename,imglength});

//---------------------------------------------------------------------------

d_File_Image_link := File_Image_link;

image_ds stripxml_name(image_ds le) := transform
  ffile_loc := stringlib.stringfind(le.filename,'_F',1);
	pfile_loc := stringlib.stringfind(le.filename,'_P',1);
	self.filename := MAP(ffile_loc > 0 => trim(le.filename[ffile_loc+1..]),
	                     pfile_loc > 0 => trim(le.filename[pfile_loc+1..]),
	                     '');
  self := Le;											 
end;

ds1 :=  Project(image_ds,stripxml_name(left) ); 

ds2 := distribute(ds1,hash(trim(filename[2..length(filename)-4])));

MAC_ShrinkImage(ds2,filename,imgLength,photo,ds3);
//--------------------------------------------------------------------------
Layout_Common getspk(ds3 le, d_File_Image_link ri) :=
TRANSFORM

	SELF.did   := ri.did;
	SELF.state := ri.state_cd; 
	SELF.rtype      := 'JB';
	SELF.Booking_sid:= trim(ri.Booking_sid,all);
	SELF.seq        := 0;
	SELF.date       := ut.GetDate;
	SELF.num        := 1;
  self.image_link := trim(le.filename);
	SELF.imgLength  := le.imgLength;
	SELF.photo      := le.photo;
	self := ri;
END;

j := JOIN(ds3, d_File_Image_link, trim(LEFT.filename[2..])= trim(right.Booking_sid)+'.jpg' 
									, getspk(LEFT,RIGHT),local); //, LOOKUP);
									
RETURN j;

END;
