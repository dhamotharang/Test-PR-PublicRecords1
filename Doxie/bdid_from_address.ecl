import doxie_cbrs,ut,business_header_ss;
export bdid_from_address(DATASET(layout_addressSearch) indata, boolean dodedup,
                         boolean doSkip = false, unsigned3 KeepVal = 50) :=
FUNCTION



k := doxie_cbrs.key_addr_bdid;
ks := business_header_ss.Key_BH_Addr_pr_pn_sr_st;
ut.MAC_Sequence_Records(indata,seq,indataseq)

r :=
RECORD
	unsigned6 bdid;
	layout_addressSearch;
	boolean did_skip := false;
END;

r tran(indata le, k ri) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.bdid := ri.bdid;
	SELF := le;
END;

r trans(indata le, ks ri) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.bdid := ri.bdid;
	SELF := le;
END;

// JOIN WHEN ZIP PRESENT
j := JOIN(indataseq, k, 
				 keyed(LEFT.prim_name = RIGHT.prim_name) AND
				 keyed((INTEGER)LEFT.zip = RIGHT.zip) AND
				 keyed(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range) AND
				 keyed(LEFT.prim_range = '' or LEFT.prim_range = RIGHT.prim_range),
				 tran(LEFT,RIGHT),
				 limit(10000, FAIL(203, ErrorCodes(203))));
	 
skip_j := JOIN(indataseq, k, 
				 keyed(LEFT.prim_name = RIGHT.prim_name) AND
				 keyed((INTEGER)LEFT.zip = RIGHT.zip) AND
				 keyed(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range) AND
				 keyed(LEFT.prim_range = '' or LEFT.prim_range = RIGHT.prim_range),
				 tran(LEFT,RIGHT),
				 keep(KeepVal), limit(0));

// JOIN WHEN NO ZIP, BUT STATE PRESENT
js := JOIN(indataseq, ks, 
				 keyed(LEFT.state = RIGHT.state) AND
				 keyed(LEFT.prim_name = RIGHT.prim_name) AND
				 keyed(LEFT.prim_range = '' or LEFT.prim_range = RIGHT.prim_range) AND
				 keyed(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range),
				 trans(LEFT,RIGHT),
				 limit(10000, FAIL(203, ErrorCodes(203))));
	 
skip_js := JOIN(indataseq, ks, 
				 keyed(LEFT.state = RIGHT.state) AND
				 keyed(LEFT.prim_name = RIGHT.prim_name) AND
				 keyed(LEFT.prim_range = '' or LEFT.prim_range = RIGHT.prim_range) AND
				 keyed(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range),
				 trans(LEFT,RIGHT),
				 keep(KeepVal), limit(0));

jselect := if(exists(indataseq((unsigned)zip != 0)),j,if(exists(indataseq(state != '')),js));
skip_jselect := if(exists(indataseq((unsigned)zip != 0)),skip_j,if(exists(indataseq(state != '')),skip_js));

//should later make use of bug 15149 
rt := record
	skip_jselect.seq;
	counted := count(group);
end;

t := table(skip_jselect, rt, seq);
wasskipped := exists(t(counted >= KeepVal));

r markSkip(r l) := transform
	self.did_skip := true;
	self := l;
end;
		 
skip_out := 
	if(wasskipped,project(skip_jselect, markSkip(left)), skip_jselect);

outj := IF(doSkip, skip_out, jselect);

l2 := IF(dodedup, DEDUP(outj,seq,bdid,all), outj);

RETURN l2;

END;