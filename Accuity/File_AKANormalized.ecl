
rAKANormalized := RECORD
	string		id;
	string		full_name;
	string		aka;
END;

rAKANormalized x(Layout_AkaConversion src, integer c) := TRANSFORM
	self.id := src.id;
	self.full_name := src.full_name;
	self.aka := CASE(c,
		1 => IF(src.aka_1='',SKIP,TRIM(src.aka_1)),
		2 => IF(src.aka_2='',SKIP,TRIM(src.aka_2)),
		3 => IF(src.aka_3='',SKIP,TRIM(src.aka_3)),
		4 => IF(src.aka_4='',SKIP,TRIM(src.aka_4)),
		5 => IF(src.aka_5='',SKIP,TRIM(src.aka_5)),
		6 => IF(src.aka_6='',SKIP,TRIM(src.aka_6)),
		SKIP);
END;

export File_AKANormalized := SORT(
		NORMALIZE(File_AKAList, 6, x(LEFT,COUNTER)),
			id, full_name);