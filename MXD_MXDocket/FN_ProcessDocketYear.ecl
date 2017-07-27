export STRING FN_ProcessDocketYear(STRING year) := FUNCTION
	newYear :=
		MAP(LENGTH(year)=2 AND year[1] IN ['0','1','2','3'] => '20'+year,
				LENGTH(year)=2 => '19'+year,
				LENGTH(year)=3 AND year[1]='1' => '19'+year[2..3],
				LENGTH(year)=3 => '20'+year[2..3],
				year);
	return newYear;
END;
