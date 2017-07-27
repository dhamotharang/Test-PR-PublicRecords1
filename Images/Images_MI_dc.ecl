f := File_MIdc_In;

// separate out the big ones to convert
toobig := f(LENGTH(StringLib.String2Data((STRING)photo)) > 49000);
justright := f(LENGTH(StringLib.String2Data((STRING)photo)) <= 49000);

// add a sequency number, convert to fixed-width binary
plusSeq_Layout :=
RECORD
	Layout_MIdc_In.id;
	Layout_MIdc_In.date;
	DATA1500000 photo;
	INTEGER seq;
END;
plusSeq_Layout addSeq(f L, INTEGER C) :=
TRANSFORM
	SELF.photo := StringLib.String2Data((STRING)L.photo);
	SELF.seq := C;
	SELF := L;
END;
withSeq := PROJECT(toobig, addSeq(LEFT, COUNTER));

// pull out the photo
justPhoto_Layout :=
RECORD
	withSeq.photo;
END;
justPhoto := TABLE(withSeq, justPhoto_Layout);

// pipe through the photos
smallPhoto_Layout :=
RECORD, MAXLENGTH(50000)
	DATA photo;
END;
justSmallPhoto := PIPE(justPhoto, '/mnt/usrbin/jpeg/doit.sh', smallPhoto_Layout, REPEAT);

// add back the sequence number
smallPhoto_Layout2 :=
RECORD, MAXLENGTH(50000)
	INTEGER seq;
	DATA photo;
END;
smallPhoto_Layout2 addSeq2(smallPhoto_Layout L, INTEGER C) :=
TRANSFORM
	SELF.seq := C;
	SELF.photo := L.photo;
END;
SmallPhotoSeq := PROJECT(justSmallPhoto, addSeq2(LEFT, COUNTER));

Layout_Common joiner(SmallPhotoSeq L, withSeq R) :=
TRANSFORM
	SELF.state := 'MI';
	SELF.rtype := 'DC';
	SELF.id := (STRING)R.id;
	SELF.seq := 0;
	SELF.date := R.date[7..10] + R.date[1..2] + R.date[4..5];
	SELF.num := 0;
	SELF.imgLength := LENGTH(L.photo);
	SELF.photo := L.photo;
END;
tooBigInCommon := JOIN(SmallPhotoSeq, withSeq, LEFT.seq = RIGHT.seq, joiner(LEFT, RIGHT), NOSORT, LOCAL);

Layout_Common cleaner(Layout_MIdc_In L) :=
TRANSFORM
	SELF.state := 'MI';	
	SELF.rtype := 'DC';
	SELF.id := (STRING)L.id;
	SELF.date := L.date[7..10] + L.date[1..2] + L.date[4..5];
	SELF.seq := 0;
	SELF.num := 0;
	SELF.imgLength := LENGTH(StringLib.String2Data((STRING)L.photo));
	SELF.photo := (DATA)StringLib.String2Data((STRING)L.photo);
END;
justRightInCommon := PROJECT(justright, cleaner(LEFT));

allInCommon := toobigInCommon + justRightInCommon;

export Images_MI_dc := allInCommon : PERSIST('MALTEMP::Images_MI_dc');