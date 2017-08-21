newrec := BIPV2_Testing_POW.layouts.newrec;

EXPORT fnCompare(dataset(newrec) ds, string modifier) := FUNCTION

idrec := record
	unsigned8 rid1;
	unsigned8 rid2;
	unsigned8 bdid;
	unsigned8 powid;
end;

bdids :=
join(
	ds,
	ds,
	left.bdid = right.bdid and 
	left.rcid < right.rcid,
	transform(
		idrec,
		self.rid1 := left.rcid,
		self.rid2 := right.rcid,
		self.bdid := right.bdid,
		self.powid := 0
	)
	,hash
);

powids :=
join(
	ds,
	ds,
	left.powid = right.powid and 
	left.rcid < right.rcid,
	transform(
		idrec,
		self.rid1 := left.rcid,
		self.rid2 := right.rcid,
		self.bdid := 0,
		self.powid := right.powid
	)
	,hash
);

both0 := 
join(
	bdids,
	powids,
	left.rid1 = right.rid1 and
	left.rid2 = right.rid2,
	transform(
		idrec,
		self.rid1 := if(left.rid1 > 0, left.rid1, right.rid1),
		self.rid2 := if(left.rid2 > 0, left.rid2, right.rid2),
		self.bdid := left.bdid,
		self.powid := right.powid
	)
	,full outer
	,hash
);

both := dedup(both0, all) : persist('~thor_data400::cemtemp::both_' + modifier);

clinkstot := count(both);

linkssame := both(bdid > 0 and powid > 0);
clinkssame := count(linkssame);

clinksbdid := count(both(bdid > 0));

linksbdidonly := both(bdid > 0, powid = 0);
clinksbdidonly := count(linksbdidonly);

clinkspowid := count(both(powid > 0));

linkspowidonly := both(powid > 0, bdid = 0);
clinkspowidonly := count(linkspowidonly);

pctsame 			:= 100 * clinkssame/clinkstot;
pctbdidonly 	:= 100 * clinksbdidonly/clinkstot;
pctpowidonly 	:= 100 * clinkspowidonly/clinkstot;

cbdid  := count(dedup(both(bdid > 0), bdid, all));
cbdid_nopowid  := count(dedup(both(bdid > 0, powid = 0), bdid, all));
cpowid := count(dedup(both(powid > 0), powid, all));
cpowid_nobdid := count(dedup(both(powid > 0, bdid = 0), powid, all));

fsamp1(dataset(idrec) ids) :=
FUNCTION

	eids := enth(ids, 100) : independent;
	h0 := ds(rcid in set(eids, rid1) or rcid in set(eids, rid2)) : independent;
	hsamp :=
		h0(rcid = eids[1].rid1) & h0(rcid = eids[1].rid2) & project(h0[1], transform(newrec, self := []))
		&h0(rcid = eids[2].rid1) & h0(rcid = eids[2].rid2) & project(h0[1], transform(newrec, self := []))
		&h0(rcid = eids[3].rid1) & h0(rcid = eids[3].rid2) & project(h0[1], transform(newrec, self := []))
		&h0(rcid = eids[4].rid1) & h0(rcid = eids[4].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[5].rid1) & h0(rcid = eids[5].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[6].rid1) & h0(rcid = eids[6].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[7].rid1) & h0(rcid = eids[7].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[8].rid1) & h0(rcid = eids[8].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[9].rid1) & h0(rcid = eids[9].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[10].rid1) & h0(rcid = eids[10].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[11].rid1) & h0(rcid = eids[11].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[12].rid1) & h0(rcid = eids[12].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[13].rid1) & h0(rcid = eids[13].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[14].rid1) & h0(rcid = eids[14].rid2) & project(h0[1], transform(newrec, self := []))	
		&h0(rcid = eids[15].rid1) & h0(rcid = eids[15].rid2) & project(h0[1], transform(newrec, self := []))	
	;
	output(Choosen(eids, 500));
	output(Choosen(h0, 500));
	output(h0(rcid = eids[1].rid1) & h0(rcid = eids[1].rid2) & project(h0[1], transform(newrec, self := [])));
	output(h0(rcid = eids[2].rid1) & h0(rcid = eids[2].rid2) & project(h0[1], transform(newrec, self := [])));
	output(h0(rcid = eids[3].rid1) & h0(rcid = eids[3].rid2) & project(h0[1], transform(newrec, self := [])));
	return project(hsamp, {hsamp.powid, hsamp.bdid, hsamp.bdid_orig, hsamp.company_name, hsamp.prim_range, hsamp.prim_name, hsamp.zip, hsamp.sec_range, hsamp.company_charter_number, hsamp.company_fein, hsamp.company_phone, hsamp.vl_id});
END;
/*
elinkspowidonly := enth(linkspowidonly, 100);
samplinkspowidonly0 := ds(rcid in set(elinkspowidonly, rid1) or rcid in set(elinkspowidonly, rid2));



samplinkspowidonly := 
samplinkspowidonly0(rcid = elinkspowidonly[1].rid1) & samplinkspowidonly0(rcid = elinkspowidonly[1].rid2) & project(samplinkspowidonly0[1], transform(newrec, self := []))
&samplinkspowidonly0(rcid = elinkspowidonly[2].rid1) & samplinkspowidonly0(rcid = elinkspowidonly[2].rid2) & project(samplinkspowidonly0[1], transform(newrec, self := []))
&samplinkspowidonly0(rcid = elinkspowidonly[3].rid1) & samplinkspowidonly0(rcid = elinkspowidonly[3].rid2) & project(samplinkspowidonly0[1], transform(newrec, self := []))
&samplinkspowidonly0(rcid = elinkspowidonly[4].rid1) & samplinkspowidonly0(rcid = elinkspowidonly[4].rid2) & project(samplinkspowidonly0[1], transform(newrec, self := []))
;*/

samplinksbdidonly := fsamp1(linksbdidonly);
samplinkspowidonly := fsamp1(linkspowidonly);

// lksd.oc(bdids)
// lksd.oc(powids)
// lksd.oc(both)

return parallel(
	output(clinkstot, 	named('total_links_'+modifier))
	,output(both, 	named('choosen_links_'+modifier))
	,output(pctsame, 	named('pct_links_same_'+modifier))
	,output(pctbdidonly, 	named('pct_links_bdid_only_'+modifier))
	,output(pctpowidonly, 	named('pct_links_powid_only_'+modifier))
	,output(choosen(samplinksbdidonly, 400), 	named('samp_links_bdid_only_'+modifier))
	,output(choosen(samplinkspowidonly, 400), 	named('samp_links_powid_only_'+modifier))
	
	,output(cbdid, named('count_bdids_'+modifier))
	,output(cbdid_nopowid, named('count_bdid_no_powid_'+modifier))
	,output(cpowid, named('count_powids_'+modifier))
	,output(cpowid_nobdid, named('count_powids_no_bdid_'+modifier))
);
END;