IMPORT STD;
EXPORT MOD_AgeToDOB(UNSIGNED age, STRING8 in_asof='') := MODULE
	// dob_lo = asof - age - 1 year + 1 day
	// dob_hi = asof - age
	SHARED asof := IF(in_asof='', StringLib.getDateYYYYMMDD(), in_asof);
	
	d_lo := STD.Date.ToGregorianYMD(STD.Date.FromGregorianYMD((INTEGER)(asof[1..4]) - age - 1,(UNSIGNED)(asof[5..6]),(UNSIGNED)(asof[7..8])) + 1);
	EXPORT dob_lo := (STRING8)STD.Date.DateFromParts(d_lo.Year, d_lo.Month, d_lo.Day);	// oldest dob that would be this age
	EXPORT dob_hi := (STRING4)((INTEGER)(asof[1..4]) - age) + asof[5..8];								// youngest dob that would be this age
END;
