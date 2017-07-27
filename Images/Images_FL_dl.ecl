import ut;

d := File_FLdl_In;

Layout_Common fixitup(Layout_FLdl_In l) := transform
	SELF.state := 'FL';
	SELF.rtype := 'DL';
	SELF.id := l.id_l + (string)((l.id_n_hi * 4294967296)+l.id_n_lo);
	SELF.date := ut.DateFrom_DaysSince1900(l.date);
	SELF.imgLength := l.len;
	SELF.Photo := l.photo;
	SELF.seq := 0;
	SELF.num := 0;
end;

export Images_FL_dl := PROJECT(d, fixitup(LEFT)) : PERSIST('persist::Images_FL_dl');