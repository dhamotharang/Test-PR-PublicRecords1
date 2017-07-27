import ut;

f := File_FLdc_In;

Layout_Common fixitup(Layout_FLdc_In L) := transform
	SELF.state := 'FL';
	SELF.rtype := 'DC';
	SELF.id := l.id;
	SELF.date := ut.DateFrom_DaysSince1900(l.date);
	SELF.imgLength := l.len;
	SELF.Photo := l.photo;
	SELF.seq := 0;
	SELF.num := 0;
end;

export Images_FL_dc := PROJECT(f, fixitup(LEFT)) : PERSIST('MALTEMP::Images_FL_dc');