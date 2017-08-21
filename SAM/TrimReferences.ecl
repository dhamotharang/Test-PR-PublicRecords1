/*
Starting with all the crossreferences:
1) dedup them
2) return | separated list (max len 8000)

*/

rLine := RECORD
	string	line{MAXLENGTH(12000)};	// this is necessary, some of the SAM records are this long
END;

rLine XItem(rLine s, integer c) := TRANSFORM
	self.line := Trim(StringLib.StringExtract(s.line, c),LEFT,RIGHT);
END;

DATASET(rLine) ListToDS(string itemlist) := FUNCTION
		n := StringLib.StringFindCount(itemlist, ',') + 1;
		dsItems := PROJECT(DATASET([itemlist], rLine), TRANSFORM(rLine,
												SELF.line := TRIM(LEFT.line,RIGHT,LEFT)));
					//dsList := SORT(NORMALIZE(dsItems, n, XItem(LEFT,COUNTER)),line);
						dsList := DEDUP(SORT(NORMALIZE(dsItems, n, XItem(LEFT,COUNTER)),line),line);
		return IF(n<=1,dsList(line<>''),dsList(line<>''));
END;


rLine rollreferences(rLine L, rLine R) := TRANSFORM
		sep := ' | ';
		self.line := IF(L.line='',R.line,
								IF(R.line='', L.line, L.line + sep + R.line));
								//IF(R.line='', L.line, (IF ((R.Line='JR.' or R.line='SR.'),L.line + ' ' + R.Line, L.line + sep + R.line))));
END;

EXPORT TrimReferences(string crossreferences) := FUNCTION
	ds := ListToDS(crossreferences);
	xref := rollup(ds, true, rollreferences(LEFT,RIGHT),LOCAL);
	return IF(COUNT(xref) >= 1, TRIM(xref[1].line[1..7083]),'');

END;