import header;

	toMonths(unsigned3 dt) := (dt DIV 100 - 1980) * 12 + (dt%100);	// months since 1980
  delta(unsigned3 d1, unsigned3 d2) := ABS(toMonths(d1) - toMonths(d2));
	
	maxmonths := 24;

r1 := RECORD
	unsigned6		did;
	unsigned3    max_last_seen;
	unsigned3    en_last_seen;
	unsigned3    eq_last_seen;
	unsigned3    tn_last_seen;
	unsigned2		max_delta;
	string2			outlier;
	unsigned2		cnt;
	unsigned2		en_cnt;
	unsigned2		eq_cnt;
	unsigned2		tn_cnt;
	string20    fname;
	string20    mname;
	string20    lname;
	string5     name_suffix;
	string10    prim_range;
	string2      predir;
	string28    prim_name;
	string4     suffix;
	string2      postdir;
	string10    unit_desig;
	string8     sec_range;
	string25    city_name;
	string2      st;
	string5     zip;
	string4     zip4;
	unsigned8		addrid;
	unsigned8		rawaid;
END;

	r1 xCombine(header.layout_header L, DATASET(header.layout_header) allRows) := TRANSFORM
				self.did := allrows[1].did;
				self.max_last_seen := MAX(allRows,dt_last_seen);
				self.en_last_seen := MAX(allRows(src='EN'),dt_last_seen);
				self.eq_last_seen := MAX(allRows(src='EQ'),dt_last_seen);
				self.tn_last_seen := MAX(allRows(src='TN'),dt_last_seen);
				
				self.max_delta := MAX(delta(self.max_last_seen, self.en_last_seen), delta(self.max_last_seen, self.eq_last_seen), delta(self.max_last_seen, self.tn_last_seen));

				self.cnt := COUNT(allRows);
				self.en_cnt := COUNT(allRows(src='EN'));
				self.eq_cnt := COUNT(allRows(src='EQ'));
				self.tn_cnt := COUNT(allRows(src='TN'));

				self.addrid := hash64(L.zip, L.prim_name, L.prim_range, L.sec_range);
				
				// eliminate outliers
				self.outlier := MAP(
							self.en_cnt=0 OR self.eq_cnt=0 OR self.tn_cnt=0 => '',			// all three bureaus must be in the cluster
							self.max_last_seen=self.en_last_seen AND
											delta(self.max_last_seen, self.eq_last_seen) >= maxmonths AND
											delta(self.max_last_seen, self.tn_last_seen) >= maxmonths
													=> 'EN',
							self.max_last_seen=self.eq_last_seen AND
											delta(self.max_last_seen, self.en_last_seen) >= maxmonths AND
											delta(self.max_last_seen, self.tn_last_seen) >= maxmonths
													=> 'EQ',
							self.max_last_seen=self.tn_last_seen AND
											delta(self.max_last_seen, self.eq_last_seen) >= maxmonths AND
											delta(self.max_last_seen, self.en_last_seen) >= maxmonths
													=> 'TN',
							'');
				
				self := L;
	END;


EXPORT fn_remove_outliers(dataset(header.layout_header) full_hdr) := FUNCTION

		hdr 	:= distribute(full_hdr(src in ['EQ','EN','TN'] and dt_last_seen > 0), did);
								// : PERSIST('~thor::spokeo::persist::bureaus');

		g := group(sort(hdr, did, zip, prim_name, prim_range, sec_range, local), did, zip, prim_name, prim_range, sec_range, local)
								 : PERSIST('~thor::spokeo::persist::clustered');

	
		c := ROLLUP(g, GROUP, xCombine(LEFT, ROWS(LEFT)));

		outliers := DISTRIBUTE(c(outlier<>''), did);
		
		hdr_ok := JOIN(DISTRIBUTE(full_hdr,did), outliers, LEFT.did=RIGHT.did AND
														LEFT.src = RIGHT.outlier AND
														hash64(LEFT.zip, LEFT.prim_name, LEFT.prim_range, LEFT.sec_range) = RIGHT.addrid,
														LEFT ONLY, LOCAL);
														
		return hdr_ok;


END;