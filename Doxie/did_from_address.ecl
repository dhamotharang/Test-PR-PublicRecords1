IMPORT doxie, dx_header;

export did_from_address(DATASET(doxie.Layout_AddressSearch) indata, boolean dodedup, unsigned atmost_limit = 1000) :=
FUNCTION

/*
There was a lot of old code in here that clumsily worked around bug 21948 (wild breaks atmost)
This code also did at least three ugly things:
	1) created extra code
	2) used a combination of mac_header_field declare and indata cities and zips to get to a city_code_set
	3) used the combined city_code_set from ALL indata as the criteria for EACH ROW of the join 

Since ATMOST is not used as widely now, we can replace it with limit, skip.  this will function the same since this is not an outer join
This means the join can go back to its original wild() form 
*/

k := dx_header.key_address();

r :=
RECORD
	unsigned6 did;
	layout_addressSearch;
END;

r tran(indata le, k ri) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.did := ri.did;
	SELF := le;
END;

// Workaround for atmost involves using keyed city_code field as opposed to making that field wild
j := JOIN(indata, k, keyed(LEFT.prim_range = RIGHT.prim_range) AND
				 keyed(LEFT.prim_name = RIGHT.prim_name) AND
				 keyed(LEFT.state = RIGHT.st) AND
				 wild(right.city_code) and
				 keyed(LEFT.sec_range = RIGHT.sec_range) AND
				 keyed(LEFT.zip = RIGHT.zip), tran(LEFT,RIGHT), 
				 limit(atmost_limit, skip));
	 

l2 := IF(dodedup, DEDUP(j,seq,did,all), j);


RETURN l2;

END;