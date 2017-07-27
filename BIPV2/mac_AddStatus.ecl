EXPORT mac_AddStatus(infile) :=
FUNCTIONMACRO
import ut,mdr;

key_Status_unsorted1_unrestricted := BIPV2.key_Status.kFetch_unrestricted(project(infile, transform(BIPV2.IDlayouts.l_xlink_ids, self := left, self := [])));
key_Status_unsorted1 := BIPV2.mod_sources.applyMasking(key_Status_unsorted1_unrestricted,PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt));
//was briefly doing restrictions in BIPV2.key_Status, but moved it down into BIPV2.mac_AddStatus so i could utilize the dates for an activity decision first

srt_forstatus := sort(key_Status_unsorted1(company_status_derived <> ''), seleid, -dt_last_seen);
ddp_forstatus := dedup(table(srt_forstatus, {seleid, dt_last_seen, source, company_status_derived}), all);



most_recent_statuss := 
join(
	ddp_forstatus,
	dedup(srt_forstatus, seleid),
	left.seleid =right.seleid and 
	ut.MonthsApart((string)left.dt_last_seen,(string)right.dt_last_seen) <= 3,
	transform(left)
);


cnt_by_type := table(most_recent_statuss, {seleid, company_status_derived, cnt := count(group)}, seleid, company_status_derived);
sort_best_status := sort(cnt_by_type, seleid, -cnt, BIPV2.Constants_Status._rank(company_status_derived));
outfile := 
join(
  infile,
  dedup(sort_best_status, seleid),
  left.seleid = right.seleid,
  transform(
    {infile, boolean isActive, boolean isDefunct},
		most_recent_rec := sort(key_Status_unsorted1(seleid = left.seleid), -dt_last_seen)[1];
		self_isDefunct := right.company_status_derived in BIPV2.Constants_Status.set_defunct;
    self.company_status_derived := '';// blank out company_status_derived.  i was setting it to what is in the key, but now (bug 146880) that is unrestricted, so i cannot show it.  we may be able to remove the field later. 
		self.isDefunct := self_isDefunct;
		self.isActive := 
		map(
			self_isDefunct or right.company_status_derived in BIPV2.Constants_Status.set_inactive
				=> FALSE,
      ut.GetAge((string)most_recent_rec.dt_last_seen) < 2
			OR ut.GetAge((string)max(key_Status_unsorted1_unrestricted(seleid = left.seleid),dt_last_seen)) < 2
				=> TRUE,
					 FALSE
		);
    self := left
  ),
  keep(1),
	left outer
);

// output(key_Status_unsorted1_unrestricted, named('key_Status_unsorted1_unrestricted'), extend);
// output(key_Status_unsorted1, named('key_Status_unsorted1'), extend);
// output(srt_forstatus, named('srt_forstatus'), extend);
// output(ddp_forstatus, named('ddp_forstatus'), extend);
// output(most_recent_statuss, named('most_recent_statuss'), extend);
// output(cnt_by_type, named('cnt_by_type'), extend);
// output(sort_best_status, named('sort_best_status'), extend);
return outfile;

ENDMACRO;
/*
// CODE FOR TESTING A CHANGE

c := choosen(dataset('~thor_data400::cemtemp::test.mac_AddStatus', { unsigned6 seleid, string50 company_status_derived }, thor), 1000)
;

ws_old := bipv2.mac_AddStatus(c);// : persist('~thor_data400::cemtemp::ws_old');
ws_new := bipv2_DevZone.mac_AddStatus(c);// : persist('~thor_data400::cemtemp::ws_new');

lksd.oc(ws_old)
lksd.oc(ws_new)

j :=
join(
	ws_old,
	ws_new,
	left.seleid = right.seleid,
	transform(
		{recordof(ws_old) old, recordof(ws_new) new},
		self.old := left,
		self.new := right
	)
);

status_change := j.old.company_status_derived <> j.new.company_status_derived;
isActive_change := j.old.isActive <> j.new.isActive;
isDefunct_change := j.old.isDefunct <> j.new.isDefunct;

status_changed := j(status_change);
isActive_changed := j(isActive_change);
isDefunct_changed := j(isDefunct_change);
nothing_changed := j(~status_change and ~isActive_change and ~isDefunct_change);

lksd.oc(status_changed)
lksd.oc(isActive_changed)
lksd.oc(isDefunct_changed)
lksd.oc(nothing_changed)
*/