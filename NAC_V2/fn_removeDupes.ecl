/****
For new files to be processed:
	keep the most recent version

****/
EXPORT fn_removeDupes(dataset(nac_V2.layout_base2) b) := function
		b1 := DISTRIBUTE(b, hash32(caseid));
		b2 := SORT(b1, caseid,programstate,programcode,groupid,clientid,startdate,enddate,-$.fn_lfnversion(filename), local);
		b3 := DEDUP(b2, caseid,programstate,programcode,groupid,clientid,startdate,enddate, local);
	return b3;
END;
