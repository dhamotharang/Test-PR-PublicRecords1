rc := dataset([], BIPv2_HRCHY.Layouts.Inrec);
wpc := BIPv2_HRCHY.Functions.WithParentsChildren(rc) ;
lt :=  BIPv2_HRCHY.Functions.LgidTable(wpc);
wi :=  BIPv2_HRCHY.Functions.WithIds(wpc,lt);


// old := dataset('~thor_data400::cemtemp::wi.new17.3', recordof(wi), thor)
old := dataset('~thor_data400::cemtemp::wi.old17', recordof(wi), thor)
(derived_ultid <> 34851)
;
// new := dataset('~thor_data400::cemtemp::wi.new17.4', recordof(wi), thor)
new := dataset('~thor_data400::cemtemp::wi.new17.3', recordof(wi), thor)
(derived_ultid <> 34851)
;

old_integrity_issue1 := old(derived_seleid > proxid);
old_integrity_issue2 := old(derived_orgid > proxid);
old_integrity_issue3 := old(derived_ultid > proxid);
old_issue4 := old(derived_ultid <> derived_orgid);
old_issue5 := old(proxid > 0, derived_ultid = 0 or derived_orgid = 0 or derived_seleid = 0);
old_issue6 :=
join(
	old,
	old,
	left.derived_seleid = right.derived_seleid and 
	left.sele_proxid <> right.sele_proxid
);
old_issue7 := old(proxid = 0);

new_integrity_issue1 := new(derived_seleid > proxid);
new_integrity_issue2 := new(derived_orgid > proxid);
new_integrity_issue3 := new(derived_ultid > proxid);
new_issue4 := new(derived_ultid <> derived_orgid);
new_issue5 := new(proxid > 0, derived_ultid = 0 or derived_orgid = 0 or derived_seleid = 0);
new_issue6 :=
join(
	new,
	new,
	left.derived_seleid = right.derived_seleid and 
	left.sele_proxid <> right.sele_proxid
);
new_issue7 := new(proxid = 0);

// lksd.oc(old_integrity_issue1)
// lksd.oc(old_integrity_issue2)
// lksd.oc(old_integrity_issue3)
// lksd.oc(old_issue4)
lksd.oc(old_issue5)
lksd.oc(old_issue6)
lksd.oc(old_issue7)

// lksd.oc(new_integrity_issue1)
// lksd.oc(new_integrity_issue2)
// lksd.oc(new_integrity_issue3)
// lksd.oc(new_issue4)
lksd.oc(new_issue5)
lksd.oc(new_issue6)
lksd.oc(new_issue7)

oldproxids := dedup(old, proxid, all);
newproxids := dedup(new, proxid, all);
lksd.c(oldproxids)
lksd.c(newproxids)
lksd.oc(old)
lksd.oc(new)

jcrec := {old.proxid, old.derived_seleid, old.derived_orgid, old.derived_ultid, old.ultimate_proxid, old.org_proxid, old.sele_proxid, old.parent_proxid,
					old.is_Ult_level, old.is_Org_level, old.is_SELE_level, old.nodes_below, old.nodes_total};
j :=
join(
	old(proxid > 0),
	new(proxid > 0), 
	left.proxid = right.proxid,
	transform(
		{jcrec oldf, jcrec newf},
		self.oldf := left,
		self.newf := right
	),
	full outer
) : persist('~thor_Data400::cemtemp::BIPv2_HRCHY.BWR_Compare_Two_WI.j');

// j :=
// join(
	// dedup(old(derived_seleid > 0),derived_seleid, all),
	// dedup(new(derived_seleid > 0),derived_seleid, all), 
	// left.derived_seleid = right.derived_seleid,
	// transform(
		// {jcrec oldf, jcrec newf},
		// self.oldf.proxid := 0,
		// self.newf.proxid := 0,
		// self.oldf := left,
		// self.newf := right
	// ),
	// full outer
// ) : persist('~thor_Data400::cemtemp::BIPv2_HRCHY.BWR_Compare_Two_WI.j.seleid');

lksd.ec(j)

ms(f) := functionmacro
	return j.oldf.f = j.newf.f;
endmacro;

ds_same := ms(derived_seleid);
do_same := ms(derived_orgid);
du_same := ms(derived_ultid);
up_same := ms(ultimate_proxid);
op_same := ms(org_proxid);
sp_same := ms(sele_proxid);
pp_same := ms(parent_proxid);
iu_same := ms(is_Ult_level);
io_same := ms(is_Org_level);
is_same := ms(is_SELE_level);
nb_same := ms(nodes_below);
nt_same := ms(nodes_total);
nt_close := j.newf.nodes_total / j.oldf.nodes_total between 0.9 and 1.1;
nt_up :=  j.newf.nodes_total > j.oldf.nodes_total;
op_good := j.oldf.proxid > 0;
np_good := j.newf.proxid > 0;

ALL_same := ds_same and do_same and du_same and up_same and op_same and sp_same and pp_same and iu_same and io_same and is_same and nb_same and nt_same and op_good and np_good;
ALL_close := ds_same and do_same and du_same and up_same and op_same and sp_same and pp_same and iu_same and io_same and is_same and nb_same and nt_close and op_good and np_good;



jt := table(j, {ALL_same,ALL_close,op_good,np_good,ds_same,do_same,du_same,up_same,op_same,sp_same,pp_same,iu_same,io_same,is_same,nb_same,nt_same,nt_close,nt_up });
jtfulldiff := table(j(not ALL_same), {j,ALL_same,op_good,np_good,ds_same,do_same,du_same,up_same,op_same,sp_same,pp_same,iu_same,io_same,is_same,nb_same,nt_same,nt_close,nt_up });
jtfulldiffclose := table(j(not ALL_close), {j,ALL_close,op_good,np_good,ds_same,do_same,du_same,up_same,op_same,sp_same,pp_same,iu_same,io_same,is_same,nb_same,nt_same,nt_close,nt_up });
lksd.ec(jtfulldiff)
lksd.ec(jtfulldiffclose)

fb(boolean b) := function
	return if(b, '   true', 'FALSE');
end;

attrec := record
	_ALL_same := fb(jt.ALL_same);
	_op_good := fb(jt.op_good);
	_np_good := fb(jt.np_good);
	_ds_same := fb(jt.ds_same);
	_do_same := fb(jt.do_same);
	_du_same := fb(jt.du_same);
	_up_same := fb(jt.up_same);
	_op_same := fb(jt.op_same);
	_sp_same := fb(jt.sp_same);
	_pp_same := fb(jt.pp_same);
	_iu_same := fb(jt.iu_same);
	_io_same := fb(jt.io_same);
	_is_same := fb(jt.is_same);
	_nb_same := fb(jt.nb_same);
	_nt_same := fb(jt.nt_same);
	_nt_close := fb(jt.nt_close);
	_nt_up   := fb(jt.nt_up);
	cnt := count(group);
	pct_of_all 				:= (real)(100 * count(group) / count(j));

end;

atttab0 := table(jt, attrec, ALL_same,op_good,np_good,ds_same,do_same,du_same,up_same,op_same,sp_same,pp_same,iu_same,io_same,is_same,nb_same,nt_same,nt_close,nt_up );
atttab := sort(atttab0, -cnt);
lksd.o(atttab)


attrec_close := record
	_ALL_close:= fb(jt.ALL_close);
	_op_good := fb(jt.op_good);
	_np_good := fb(jt.np_good);
	_ds_same := fb(jt.ds_same);
	_do_same := fb(jt.do_same);
	_du_same := fb(jt.du_same);
	_up_same := fb(jt.up_same);
	_op_same := fb(jt.op_same);
	_sp_same := fb(jt.sp_same);
	_pp_same := fb(jt.pp_same);
	_iu_same := fb(jt.iu_same);
	_io_same := fb(jt.io_same);
	_is_same := fb(jt.is_same);
	_nb_same := fb(jt.nb_same);
	_nt_close := fb(jt.nt_close);
	cnt := count(group);
	pct_of_all 				:= (real)(100 * count(group) / count(j));

end;

atttab0_close := table(jt, attrec_close, ALL_close,op_good,np_good,ds_same,do_same,du_same,up_same,op_same,sp_same,pp_same,iu_same,io_same,is_same,nb_same,nt_close );
atttab_close := sort(atttab0_close, -cnt);
lksd.o(atttab_close)

type1 := not jt.iu_same and jt.io_same and jt.is_same;

jdiff1 := jt(type1);
lksd.ec(jdiff1)

// jdiff2 := j(not ds_same, not do_same);
// lksd.ec(jdiff2)

type2 := not jt.np_good;

jdiff2 := jt(type2);
lksd.ec(jdiff2)

type3 := not jt.ds_same and jt.do_same;

jdiff3 := jt(type3);
lksd.ec(jdiff3)


jdiff_derived_seleid := jt(not ds_same);
// lksd.ec(jdiff_derived_seleid)

jdiff_is_Ult_level := jt(not iu_same);
// lksd.ec(jdiff_is_Ult_level)

jdiff_other := jt(not type1 and not type2 and not type3);
lksd.ec(jdiff_other)
