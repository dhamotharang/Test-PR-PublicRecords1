/*
Well, a blank signifies active.  Thinking this through, thoughâ€¦.those removed clusters will not be counted by the 
seg stats anywayâ€¦.so it probably doesnâ€™t matter.  But the records that are removed in ds_clean that are part of 
a cluster that is kept donâ€™t need to be part of the active calculation.  I can ensure that.  But for consistencyâ€™s 
sake, should they be stamped with the same active status as the rest of the cluster?

  in build_commonbase:
    take output dataset, run it through ds_clean once.
    then call this macro several times to append the active flags for each ID.  might be able to slim down the dataset
      to just the fields that the macro cares about, and dedup.
    this macro will not need to do .clean, because it will assume the dataset being passed in is cleaned.
    then, after calling this macro several times to append the statuses, commonbase will 
      join that output to the full file on the lowest ID, proxid, appending the statuses.  will this work?
        that will not work for everything.  probably have to do several joins for consistency's sake, deduping
          each time on the join condition ID.

seleid, proxid, powid, orgid, ultid

*/
EXPORT mac_Set_Statuses(

   infile                         //assuming this dataset is ds_clean or cleaned
  ,pBIP_ID            = 'seleid'
  ,pActive_Fieldname  = 'seleid_status'
  ,pUse_DNB           = 'false'
  ,pBIP_ID_Test_Value = '0'

) :=
FUNCTIONMACRO

  import ut,mdr,bipv2,AutoStandardI,BIPV2_PostProcess;

	h := infile;  //assume this is cleaned
	rec := {h.ultid, h.orgid, h.seleid,h.proxid,h.powid, h.source, h.company_status_derived, h.dt_first_seen, h.dt_last_seen, h.dt_vendor_first_reported, h.dt_vendor_last_reported};

  d := table(h  ,rec
  ,ultid, orgid, seleid,proxid,powid, source, company_status_derived, dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,merge);

	rec xroll(rec l, rec r) := transform
		ut.mac_roll_DFS(dt_first_seen)
		ut.mac_roll_DFS(dt_vendor_first_reported)
		ut.mac_roll_DLS(dt_last_seen)
		ut.mac_roll_DLS(dt_vendor_last_reported)		
		self := l
	end;

	key_Status_unsorted1_unrestricted := 
	rollup(
		sort(d, ultid, orgid, seleid, proxid,powid, source, company_status_derived),
		xroll(left, right),
		ultid, orgid, seleid, proxid,powid, source, company_status_derived
	);


///////////////////////////
key_Status_unsorted1              := BIPV2.mod_sources.applyMasking(key_Status_unsorted1_unrestricted,PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt));
//was briefly doing restrictions in BIPV2.key_Status, but moved it down into BIPV2.mac_AddStatus so i could utilize the dates for an activity decision first

srt_forstatus := sort(key_Status_unsorted1_unrestricted/*(company_status_derived <> '')*/, pBIP_ID, -dt_last_seen);
ddp_forstatus := dedup(table(srt_forstatus, {pBIP_ID, dt_last_seen, source, company_status_derived}), all);

most_recent_statuss := 
join(
	ddp_forstatus,
	dedup(srt_forstatus, pBIP_ID),
	left.pBIP_ID = right.pBIP_ID and 
	ut.MonthsApart((string)left.dt_last_seen,(string)right.dt_last_seen) <= 3,
	transform(left)
);


cnt_by_type := table(most_recent_statuss, {pBIP_ID, company_status_derived
,cnt          := count(group)
,cnt_nonblank := sum(group,if(company_status_derived != ''                    ,1,0))
,cnt_dnb      := sum(group,if(mdr.sourcetools.SourceIsDunn_Bradstreet(source) ,1,0))
,cnt_active   := sum(group,if(company_status_derived = 'ACTIVE'               ,1,0))
}, pBIP_ID, company_status_derived)
;

cnt_by_type_help_active := join(cnt_by_type ,cnt_by_type(company_status_derived = '') ,left.pBIP_ID = right.pBIP_ID
  ,transform(
    recordof(left)
    ,self.cnt          := if(left.company_status_derived = 'ACTIVE' ,left.cnt          + right.cnt  ,left.cnt         )
    ,self.cnt_nonblank := if(left.company_status_derived = 'ACTIVE' ,left.cnt_nonblank + right.cnt  ,left.cnt_nonblank)
    ,self              := left
  )
  ,hash
  ,left outer
  )  //allow blanks to help actives win over inactives
(pUse_DNB = true or cnt > cnt_dnb);


sort_best_status := sort(cnt_by_type_help_active, pBIP_ID, -cnt_nonblank, BIPV2.Constants_Status._rank(company_status_derived));

key_latest  := dedup(sort(distribute(table(key_Status_unsorted1,{pBIP_ID,dt_last_seen},pBIP_ID,dt_last_seen,merge),pBIP_ID),pBIP_ID,-dt_last_seen,local),pBIP_ID,local);

infile_dt_last_seen1 := join(infile,key_latest,left.pBIP_ID = right.pBIP_ID,transform(
  {recordof(left),unsigned dt_last_seen_unsorted}
  ,self.dt_last_seen_unsorted := right.dt_last_seen
  ,self                       := left
  ),hash,left outer);

key_latest2  := dedup(sort(distribute(table(key_Status_unsorted1_unrestricted,{pBIP_ID,dt_last_seen},pBIP_ID,dt_last_seen,merge),pBIP_ID),pBIP_ID,-dt_last_seen,local),pBIP_ID,local);

infile_dt_last_seen2 := join(infile_dt_last_seen1,key_latest2,left.pBIP_ID = right.pBIP_ID,transform(
  {recordof(left),unsigned dt_last_seen_unsorted_unrestricted}
  ,self.dt_last_seen_unsorted_unrestricted  := right.dt_last_seen
  ,self                                     := left
  ),hash,left outer);

outfile := 
join(
  infile_dt_last_seen2,
  dedup(sort_best_status, pBIP_ID),
  left.pBIP_ID = right.pBIP_ID,
  transform(
    {recordof(infile) or {string1 pActive_Fieldname}},
		most_recent_rec := left.dt_last_seen_unsorted;
		self_isDefunct  := right.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setDefunct ;
		self_isInactive := right.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setInactive;
    // self.company_status_derived := '';// blank out company_status_derived.  i was setting it to what is in the key, but now (bug 146880) that is unrestricted, so i cannot show it.  we may be able to remove the field later. 
	self.pActive_Fieldname			:= 
	map(
		 self_isDefunct 	                                                        => BIPV2_PostProcess.constants.Inactive_Reported 
		,   ~(    ut.GetAge((string)left.dt_last_seen_unsorted              ) < 2
          OR  ut.GetAge((string)left.dt_last_seen_unsorted_unrestricted ) < 2
         )
         or self_isInactive                                                   => BIPV2_PostProcess.constants.Inactive_NoActivity 
		,                                                                            ''
  );
    self := left
  ),
  keep(1),
	left outer
);

return when(outfile
  ,if(pBIP_ID_Test_Value != 0
  ,parallel(
     output(choosen(key_Status_unsorted1_unrestricted (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('key_Status_unsorted1_unrestricted_' + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(key_Status_unsorted1              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('key_Status_unsorted1_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(srt_forstatus                     (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('srt_forstatus_'                     + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(ddp_forstatus                     (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ddp_forstatus_'                     + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(most_recent_statuss               (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('most_recent_statuss_'               + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(cnt_by_type                       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('cnt_by_type_'                       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(cnt_by_type_help_active           (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('cnt_by_type_help_active_'           + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(sort_best_status                  (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('sort_best_status_'                  + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(key_latest                        (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('key_latest_'                        + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(infile_dt_last_seen1              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('infile_dt_last_seen1_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(key_latest2                       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('key_latest2_'                       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(infile_dt_last_seen2              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('infile_dt_last_seen2_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
    ,output(choosen(outfile                           (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('outfile_'                           + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)))
  ))                                                                                                                                                                                   
);

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