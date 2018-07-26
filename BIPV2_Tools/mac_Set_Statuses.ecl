/* 
  BIPV2_Tools.mac_Set_Statuses()
    -- Set statuses for each BIP ID, allowing for public(no use of DNB) and private(limited use of DNB to corroborate other sources' status)

*/
EXPORT mac_Set_Statuses(

   infile                         //assuming this dataset is ds_clean or cleaned
  ,pBIP_ID            = 'seleid'
  ,pActive_Fieldname  = 'seleid_status'
  ,pUse_DNB           = 'false'
  ,pBIP_ID_Test_Value = '0'
  ,pFuture_Dates      = 'true'    // set future dates to 19700101 so they are treated as old.  
  ,pToday             = 'bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate'//in case you want to run as of a date in the past.  default to date of newest data.

) :=
FUNCTIONMACRO

  import bipv2,ut,mdr,bipv2,AutoStandardI,BIPV2_PostProcess;

  today := pToday;
  
  // -- prep file and fix future dates to make them old
  h   := project(infile ,transform(recordof(left) 
          ,self.dt_first_seen             := if(left.dt_first_seen            = 0 or (left.dt_first_seen            > (unsigned6)today and pFuture_Dates = true)  ,19700101  ,left.dt_first_seen           )
          ,self.dt_last_seen              := if(left.dt_last_seen             = 0 or (left.dt_last_seen             > (unsigned6)today and pFuture_Dates = true)  ,19700101  ,left.dt_last_seen            )
          ,self.dt_vendor_first_reported  := if(left.dt_vendor_first_reported = 0 or (left.dt_vendor_first_reported > (unsigned6)today and pFuture_Dates = true)  ,19700101  ,left.dt_vendor_first_reported)
          ,self.dt_vendor_last_reported   := if(left.dt_vendor_last_reported  = 0 or (left.dt_vendor_last_reported  > (unsigned6)today and pFuture_Dates = true)  ,19700101  ,left.dt_vendor_last_reported )
          ,self                           := left
        ));  //assume this is cleaned
  
  rec := {               h.ultid ,h.orgid ,h.seleid  ,h.proxid ,h.powid  ,h.source  ,h.company_status_derived  ,h.dt_first_seen ,h.dt_last_seen  ,h.dt_vendor_first_reported  ,h.dt_vendor_last_reported       };
  d   := table(h  ,rec  ,ultid   ,orgid   ,seleid    ,proxid   ,powid    ,source    ,company_status_derived    ,dt_first_seen   ,dt_last_seen    ,dt_vendor_first_reported    ,dt_vendor_last_reported   ,merge);

  // -- rollup status
  rec xroll(rec l, rec r) := 
  transform
    ut.mac_roll_DFS(dt_first_seen           )
    ut.mac_roll_DFS(dt_vendor_first_reported)
    ut.mac_roll_DLS(dt_last_seen            )
    ut.mac_roll_DLS(dt_vendor_last_reported )   
    self := l
  end;

  ds_status_rollup_prep         := sort   (d                                        ,ultid, orgid, seleid, proxid,powid, source, company_status_derived);
  ds_status_rollup_unrestricted := rollup (ds_status_rollup_prep ,xroll(left, right),ultid, orgid, seleid, proxid,powid, source, company_status_derived);
  ds_status_rollup_mask         := BIPV2.mod_sources.applyMasking(ds_status_rollup_unrestricted ,PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt));

  // -- get latest dt_last_seens per ID(restricted and unrestricted)
  ds_status_rollup        := project(ds_status_rollup_mask  ,transform(recordof(left),self.dt_last_seen := if(left.dt_last_seen = 0 ,19700101 ,left.dt_last_seen),self := left));
  ds_latest               := dedup(sort(distribute(table(ds_status_rollup              ,{pBIP_ID,dt_last_seen},pBIP_ID,dt_last_seen,merge),pBIP_ID),pBIP_ID,-dt_last_seen,local),pBIP_ID,local);
  ds_latest_unrestricted  := dedup(sort(distribute(table(ds_status_rollup_unrestricted ,{pBIP_ID,dt_last_seen},pBIP_ID,dt_last_seen,merge),pBIP_ID),pBIP_ID,-dt_last_seen,local),pBIP_ID,local);

  // -- Prep infile for result join setting dt_last_seens(restricted and unrestricted)
  infile_dt_last_seen1 := join(infile,ds_latest,left.pBIP_ID = right.pBIP_ID,transform(
    {recordof(left),unsigned dt_last_seen_unsorted}
    ,self.dt_last_seen_unsorted := right.dt_last_seen
    ,self                       := left
    ),hash,left outer);

  infile_dt_last_seen2 := join(infile_dt_last_seen1,ds_latest_unrestricted,left.pBIP_ID = right.pBIP_ID,transform(
    {recordof(left),unsigned dt_last_seen_unsorted_unrestricted}
    ,self.dt_last_seen_unsorted_unrestricted  := right.dt_last_seen
    ,self                                     := left
    ),hash,left outer);

  // -- Dedup latest statuses
  srt_forstatus         := sort (ds_status_rollup_unrestricted  ,pBIP_ID  ,-dt_last_seen);
  ddp_forstatus         := dedup( table(srt_forstatus           ,{pBIP_ID  ,dt_last_seen  ,source  ,company_status_derived})  ,all);
  ds_latest_status_slim := dedup(srt_forstatus  ,pBIP_ID);
  
  ds_latest_status := join(ddp_forstatus  ,ds_latest_status_slim  ,left.pBIP_ID = right.pBIP_ID and ut.MonthsApart((string)left.dt_last_seen  ,(string)right.dt_last_seen) <= 3 ,transform(left));

  // -- count statuses per ID
  cnt_by_type := table(ds_latest_status, {pBIP_ID, company_status_derived
    ,cnt          := count(group)
    ,cnt_nonblank := sum(group  ,if(company_status_derived != ''                    ,1,0))
    ,cnt_dnb      := sum(group  ,if(mdr.sourcetools.SourceIsDunn_Bradstreet(source) ,1,0))
    ,cnt_active   := sum(group  ,if(company_status_derived  = 'ACTIVE'              ,1,0))
    }
    ,pBIP_ID  ,company_status_derived)
  ;

  // -- allow blanks to help actives win over inactives
  cnt_by_type_help_active := join(cnt_by_type ,cnt_by_type(company_status_derived = '') ,left.pBIP_ID = right.pBIP_ID
    ,transform(
      recordof(left)
      ,self.cnt          := if(left.company_status_derived = 'ACTIVE' ,left.cnt          + right.cnt  ,left.cnt         )
      ,self.cnt_nonblank := if(left.company_status_derived = 'ACTIVE' ,left.cnt_nonblank + right.cnt  ,left.cnt_nonblank)
      ,self              := left
    )
    ,hash
    ,left outer
  ) (pUse_DNB = true or cnt > cnt_dnb);

  // -- get best status per ID
  sort_best_status  := sort(cnt_by_type_help_active, pBIP_ID, -cnt_nonblank, BIPV2.Constants_Status._rank(company_status_derived));
  ddp_best_status   := dedup(sort_best_status, pBIP_ID);
  
  // -- set active status field
  outfile := 
  join(
     infile_dt_last_seen2
    ,ddp_best_status
    ,left.pBIP_ID = right.pBIP_ID
    ,transform(
      {recordof(infile) or {string1 pActive_Fieldname}},
      most_recent_rec := left.dt_last_seen_unsorted;
      self_isDefunct  := right.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setDefunct ;
      self_isInactive := right.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setInactive;
      // self.company_status_derived := '';// blank out company_status_derived.  i was setting it to what is in the key, but now (bug 146880) that is unrestricted, so i cannot show it.  we may be able to remove the field later. 
      self.pActive_Fieldname      := 
        map(
           self_isDefunct                                                           => BIPV2_PostProcess.constants.Inactive_Reported 
          ,   ~(    ut.Age(left.dt_last_seen_unsorted              ) < 2
                OR  ut.Age(left.dt_last_seen_unsorted_unrestricted ) < 2
               )
               or self_isInactive                                                   => BIPV2_PostProcess.constants.Inactive_NoActivity 
          ,                                                                            ''
        );
      self := left
    )
    ,keep(1)
    ,left outer
  );

  // -- return result
  return when(outfile
    ,if(pBIP_ID_Test_Value != 0
    ,parallel(
       output(choosen(ds_status_rollup_unrestricted (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ds_status_rollup_unrestricted_' + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_status_rollup              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ds_status_rollup_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(srt_forstatus                 (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('srt_forstatus_'                 + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ddp_forstatus                 (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ddp_forstatus_'                 + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_latest_status              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ds_latest_status_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(cnt_by_type                   (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('cnt_by_type_'                   + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(cnt_by_type_help_active       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('cnt_by_type_help_active_'       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(sort_best_status              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('sort_best_status_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_latest                     (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ds_latest_'                     + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(infile_dt_last_seen1          (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('infile_dt_last_seen1_'          + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_latest_unrestricted        (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('ds_latest_unrestricted_'        + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(infile_dt_last_seen2          (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('infile_dt_last_seen2_'          + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(outfile                       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('outfile_'                       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
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