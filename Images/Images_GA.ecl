f := File_GA_In;

Layout_Common cleaner(Layout_GA_In L) :=
TRANSFORM
	SELF.state := 'GA';	
	SELF.rtype := 'DC';
	SELF.id := StringLib.StringFilter(L.filename, '0123456789');
	SELF.date := '';
	SELF.seq := 0;
	SELF.num := 0;
	SELF := L;
END;
p := PROJECT(f, cleaner(LEFT));

export Images_GA := p : PERSIST('MALTEMP::Images_GA_dc');