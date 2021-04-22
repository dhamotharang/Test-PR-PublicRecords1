/*
fixup base file to eliminate duplicate records

*/
EXPORT fn_fixup(DATASET(nac_v2.Layout_Base2) dsin) := FUNCTION
		d1 := DISTRIBUTE(dsin, hash32(groupid, caseid, clientid));
		d2 := SORT(d1, groupid, caseid, clientid, startdate, enddate, addresstype, -nac_v2.fn_lfnversion(filename), local);
		d3 := ROLLUP(d2, 					
							TRANSFORM($.layout_base2,
								self.created := IF(right.created=0, left.created, right.created);
								self.filename := IF(right.filename='', left.filename, right.filename);
								self := left),								
							groupid, caseid, clientid, programState, programCode, startdate, enddate, addresstype,
							LOCAL);
		return d3;
END;