import ut;
ds :=	CHOOSEN(dataset(File_DJ, {string1 s}, THOR),50,37);

ds1 := PROJECT(ds, {string40 s;});

{string40 s;} x({string40 s;} L, {string40 s;} R) := TRANSFORM
		self.s := TRIM(L.s,LEFT,RIGHT) + TRIM(R.s,LEFT,RIGHT);
END;
ds2 := ITERATE(ds1, x(LEFT,RIGHT));

pfatoken := ds2[37].s;
date := REGEXFIND('date="([0-9]+)"',pfatoken,1);
 
FormatDate(string YYYYMMDDHHMM) := ut.ConvertDate(YYYYMMDDHHMM, '%Y%m%d%H%M', '%Y-%m-%dT%H:%M')+':00.0000000Z';
 
EXPORT pubdate := FormatDate(date);