import header,mdr,ut;
head := header.file_headers(~mdr.Source_is_DPPA(src));
head_good := head(did > 0, (INTEGER)ssn > 0);

head_nonglb := head_good(header.isPreGlb(head_good));
head_nonutil := head_good(~mdr.Source_is_Utility(src));
head_nonglb_nonutil := head_good(header.isPreGLB(head_good(~mdr.Source_is_Utility(src))));

slim_rec := 
RECORD
	head.did;
	head.ssn;
	QSTRING4 ssn4;
	unsigned2 cnt;
	unsigned2 freq;
END;

slim_rec slim_down(head L) := 
TRANSFORM
	SELF.ssn4 := INTFORMAT((INTEGER)L.ssn % 10000, 4, 1);
	SELF.cnt := 0;
	SELF.freq := 1;
	SELF := L;
END;

head_slim := project(head_good, slim_down(left));
head_nonglb_slim := project(head_nonglb,slim_down(LEFT));
head_nonutil_slim := project(head_nonutil,slim_down(LEFT));
head_nonglb_nonutil_slim := project(head_nonglb_nonutil,slim_down(LEFT));

head_dist := distribute(head_slim, hash(did));
head_ng_dist := distribute(head_nonglb_slim,hash(did));
head_nu_dist := distribute(head_nonutil_slim,hash(did));
head_ngnu_dist := distribute(head_nonglb_nonutil_slim,hash(did));

head_sort := SORT(head_dist, did, ssn, LOCAL);
head_ng_sort := sort(head_ng_dist,did,ssn,local);
head_nu_sort := sort(head_nu_dist,did,ssn,local);
head_ngnu_sort := sort(head_ngnu_dist,did,ssn,local);

slim_rec getFreq (slim_rec L, slim_rec R) :=
TRANSFORM
	SELF.freq := L.freq + R.freq;
	SELF := L;
END;
head_ddp := ROLLUP(head_sort, LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, getFreq(LEFT, RIGHT), LOCAL);
head_ng_ddp := rollup(head_ng_sort,LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, getFreq(LEFT, RIGHT), LOCAL);
head_nu_ddp := rollup(head_nu_sort,LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, getFreq(LEFT, RIGHT), LOCAL);
head_ngnu_ddp := rollup(head_ngnu_sort,LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, getFreq(LEFT, RIGHT), LOCAL);

slim_rec trans (slim_rec L, slim_rec R) :=
TRANSFORM
	SELF.did := L.did;
	SELF.ssn := L.ssn;
	SELF.ssn4 := L.ssn4;
	SELF.cnt := IF(L.ssn = R.ssn, 0, 1);
	SELF.freq := L.freq;
END;

j1 := JOIN(head_ddp, head_ddp, LEFT.did = RIGHT.did AND 
							  LEFT.ssn4 = RIGHT.ssn4, trans(LEFT, RIGHT), LOCAL);
j2 := JOIN(head_ng_ddp, head_ng_ddp, LEFT.did = RIGHT.did AND 
							  LEFT.ssn4 = RIGHT.ssn4, trans(LEFT, RIGHT), LOCAL);
j3 := JOIN(head_nu_ddp, head_nu_ddp, LEFT.did = RIGHT.did AND 
							  LEFT.ssn4 = RIGHT.ssn4, trans(LEFT, RIGHT), LOCAL);
j4 := JOIN(head_ngnu_ddp, head_ngnu_ddp, LEFT.did = RIGHT.did AND 
							  LEFT.ssn4 = RIGHT.ssn4, trans(LEFT, RIGHT), LOCAL);


slim_rec roller(slim_rec L, slim_rec R) :=
TRANSFORM
	SELF.did := L.did;
	SELF.ssn := L.ssn;
	SELF.ssn4 := L.ssn4;
	SELF.cnt := L.cnt + R.cnt;
	SELF.freq := L.freq;
END;

r1 := ROLLUP(SORT(j1, did, ssn, LOCAL), LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, roller(LEFT, RIGHT), LOCAL);
r2 := ROLLUP(SORT(j2, did, ssn, LOCAL), LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, roller(LEFT, RIGHT), LOCAL);
r3 := ROLLUP(SORT(j3, did, ssn, LOCAL), LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, roller(LEFT, RIGHT), LOCAL);
r4 := ROLLUP(SORT(j4, did, ssn, LOCAL), LEFT.did = RIGHT.did AND LEFT.ssn = RIGHT.ssn, roller(LEFT, RIGHT), LOCAL);


// add one
slim_rec addone(slim_rec L) :=
TRANSFORM
	SELF.cnt := L.cnt + 1;
	SELF := L;
END;

p1 := PROJECT(r1(LENGTH(TRIM(ssn)) = 9), addone(LEFT));
p2 := PROJECT(r2(LENGTH(TRIM(ssn)) = 9), addone(LEFT));
p3 := PROJECT(r3(LENGTH(TRIM(ssn)) = 9), addone(LEFT));
p4 := PROJECT(r4(LENGTH(TRIM(ssn)) = 9), addone(LEFT));

ut.MAC_SF_BuildProcess(p1,'~thor_data400::base::did_ssn_glb',a1,2)
ut.MAC_SF_BuildProcess(p2,'~thor_data400::base::did_ssn_nonglb',a2,2)
ut.MAC_SF_BuildProcess(p3,'~thor_data400::base::did_ssn_nonUtil',a3,2)
ut.MAC_SF_BuildProcess(p4,'~thor_data400::base::did_ssn_nonglb_nonUtil',a4,2)


export did_ssn := sequential(a1,a2,a3,a4);