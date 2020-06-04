zk := bizlinkfull.Key_BizHead_L_ADDRESS2.key;
myids := dedup(zk(prim_name = 'ANDERSON', zip = '78757'), proxid, all);

// lksd.oc(myids)

biph := 
join(
	myids,
	BIPV2.Key_BH_Linking_Ids.key,
	left.ultid = right.ultid and
	left.proxid = right.proxid,
	transform(right)
);

// lksd.oc(biph)


newrec := bipv2_testing_pow.layouts.newrec;

recs := 
project(
	biph(company_bdid > 0, (integer)prim_range > 0),
	transform(
		newrec,
		self.bdid := ((integer)left.prim_range * 1000000000000) + left.company_bdid,
		self.bdid_orig := left.company_bdid,
		self := left
	)
);

// lksd.oc(recs)



ozk := Business_Header_SS.Key_BH_Addr_pr_pn_zip;
opl := Business_Header_SS.Key_BH_BDID_pl;
// lksd.o(ozk)
// lksd.o(opl)

oids := dedup(ozk(keyed(zip = 78757 and prim_name = 'ANDERSON')), bdid, all);
// lksd.oc(oids)

ohr := 
join(
	oids,
	opl,
	left.bdid = right.bdid,
	transform(right)
);

// lksd.oc(ohr)



recs2 :=
join(
	dedup(recs, company_name, prim_range, prim_name, zip, sec_range, powid, all),
	dedup(ohr, company_name, prim_range, prim_name, zip, sec_range, bdid, all),
	left.company_name = right.company_name and
	left.prim_range = right.prim_range and
	left.prim_name = right.prim_name and
	(integer)left.zip = (integer)right.zip and
	left.sec_range = right.sec_range and
	(integer)left.zip > 0 and
	left.prim_name <> '',
	transform(
		newrec,
		self.bdid := right.bdid,
		self.bdid_orig := left.company_bdid,
		self := left
	)
);

lksd.oc(recs2)



BIPV2_Testing_POW.fnCompare(recs, 'derive');
BIPV2_Testing_POW.fnCompare(recs2, 'join');

		

