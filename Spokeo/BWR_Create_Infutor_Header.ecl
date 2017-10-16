#option('multiplePersistInstances',FALSE);
 inf := Infutor.infutor_header_filtered(true);	// : PERSIST('~thor::spokeo::persist::infutor_header');
 inf2 := DISTRIBUTE(inf(did<>0), did);
 hdr := SORT(inf2, did, prim_range, prim_name, zip, -sec_range, LOCAL);
 infh := ROLLUP(hdr, 
								left.did=right.did AND
								left.prim_range=right.prim_range AND
								left.prim_name=right.prim_name AND
								left.zip=right.zip 
								AND ut.NNEQ(left.sec_range, right.sec_range),
								TRANSFORM(recordof(hdr),
									self.dt_first_seen := ut.min2(left.dt_first_seen, right.dt_first_seen);
									self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
									self.sec_range := IF(right.sec_range='', left.sec_range, right.sec_range);
									self := right;),
									LOCAL);	//	 : PERSIST('~thor::spokeo::persist::infutor_header_rolledup');
 getbest := Infutor.infutor_best(true);

SEQUENTIAL(									
	OUTPUT(inf,,'~thor::spokeo::infutor_header', compressed, overwrite),
	OUTPUT(infh,,'~thor::spokeo::infutor_header_rolledup', compressed, overwrite),
	getbest
);

