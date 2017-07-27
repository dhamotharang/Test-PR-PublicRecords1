imges := File_CTdc_In;
info := File_CTdc_Info;


Layout_Common toCommon(imges L, info R) :=
TRANSFORM
	SELF.state := 'CT';	
	SELF.rtype := 'DC';
	SELF.id := (STRING)L.inmate_no;
	SELF.date := (STRING)(99999999 - (INTEGER)R.date);
	SELF.seq := 0;
	SELF.num := 0;
	SELF.imgLength := (INTEGER)L.imgLength;
	SELF.photo := (DATA)L.photo;
END;

j1 := JOIN(imges, info, LEFT.pkey = RIGHT.photo_key, toCommon(LEFT, RIGHT), HASH);

export Images_CT_dc := j1 : PERSIST('cjmtemp::Images_CT_dc');