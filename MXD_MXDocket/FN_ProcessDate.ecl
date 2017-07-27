export unsigned4 FN_ProcessDate(unicode d) := FUNCTION
	trimmed := TRIM((string)d,ALL);
	year := trimmed[1..(StringLib.StringFind(trimmed,'/',1)-1)];
	month := trimmed[(StringLib.StringFind(trimmed,'/',1)+1)..(StringLib.StringFind(trimmed,'/',2)-1)];
	day := trimmed[(StringLib.StringFind(trimmed,'/',2)+1)..];
	
	month_padded := IF(LENGTH(month)=1,'0'+month,month);
	day_padded := IF(LENGTH(day)=1,'0'+day,day);
	
	result :=
		IF(LENGTH(trimmed)=0,0,
			 IF(StringLib.StringFindCount(trimmed,'/') != 2,0,
					(unsigned4)(year+month_padded+day_padded)));
	
	return result;
END;
