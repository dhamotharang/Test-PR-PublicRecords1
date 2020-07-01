/* 
  BIPV2_Statuses.mac_Set_Statuses()
    -- Set statuses for each BIP ID, allowing for public(no use of DNB) and private(limited use of DNB to corroborate other sources' status)

   2. Create new Active Score field (scores should be based on source ranking , latest dt_last_seen)

  

*/
EXPORT mac_Set_Statuses(

   infile                   = 'bipv2.CommonBase.ds_clean'                             // assuming this dataset is ds_clean or cleaned
  ,pBIP_ID                  = 'seleid'
  ,pActive_Fieldname        = 'seleid_status_private'
  ,pUse_DNB                 = 'false'
  ,pBIP_ID_Test_Value       = '0'
  ,pFuture_Dates            = 'true'                                                  // set future dates to 19700101 so they are treated as old.  
  ,pToday                   = 'bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate'  // in case you want to run as of a date in the past.  default to date of newest data.
  ,pShow_Work               = 'false'
  ,pSet_Trusted_Sources     = 'BIPV2_Statuses._Config.set_High_Conf'                  // sources required to be in cluster, BIPV2_Statuses._Config.set_medium_conf, BIPV2_Statuses._Config.set_low_conf
  ,pOldWay                  = 'false'
  ,pConfFlag                = '\'\''
) :=
FUNCTIONMACRO

  import bipv2,ut,mdr,bipv2,AutoStandardI,BIPV2_PostProcess,std;

  today := pToday;
    
  // -- prep file and fix future dates to make them old
  h   := project(infile ,transform(recordof(left) 
          ,self.dt_first_seen             := if(left.dt_first_seen            = 0 or (left.dt_first_seen            > (unsigned6)today and pFuture_Dates = true) or if(pOldWay = true ,false  ,left.source not in pSet_Trusted_Sources) ,19700101  ,left.dt_first_seen           )
          ,self.dt_last_seen              := if(left.dt_last_seen             = 0 or (left.dt_last_seen             > (unsigned6)today and pFuture_Dates = true) or if(pOldWay = true ,false  ,left.source not in pSet_Trusted_Sources) ,19700101  ,left.dt_last_seen            )
          ,self.dt_vendor_first_reported  := if(left.dt_vendor_first_reported = 0 or (left.dt_vendor_first_reported > (unsigned6)today and pFuture_Dates = true) or if(pOldWay = true ,false  ,left.source not in pSet_Trusted_Sources) ,19700101  ,left.dt_vendor_first_reported)
          ,self.dt_vendor_last_reported   := if(left.dt_vendor_last_reported  = 0 or (left.dt_vendor_last_reported  > (unsigned6)today and pFuture_Dates = true) or if(pOldWay = true ,false  ,left.source not in pSet_Trusted_Sources) ,19700101  ,left.dt_vendor_last_reported )
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

  // -- get sources used in determining the status
  ds_get_sources_used1 := table(ds_latest_status,{pBIP_ID,string source := mdr.sourceTools.translatesource(source),unsigned6 dt_last_seen := max(group,dt_last_seen),company_status_derived},pBIP_ID,source,company_status_derived,merge);
  ds_get_sources_used2 := project(ds_get_sources_used1  ,transform({unsigned6 pBIP_ID ,dataset({recordof(left) - pBIP_ID}) src_recs}  ,self.src_recs := project(dataset(left) ,transform({recordof(left) - pBIP_ID},self := left)) ,self := left  ));
  ds_get_sources_used3 := distribute(ds_get_sources_used2 ,pBIP_ID);
  ds_get_sources_used4 := sort(ds_get_sources_used3 ,pBIP_ID  ,-src_recs[1].dt_last_seen,BIPV2.Constants_Status._rank(src_recs[1].company_status_derived) ,local);
  ds_get_sources_used  := rollup(ds_get_sources_used4  ,left.pBIP_ID = right.pBIP_ID ,transform(recordof(left),self.src_recs := left.src_recs + right.src_recs,self := left),local);
  
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
  
  ddp_best_status_add_sources := join(ddp_best_status ,ds_get_sources_used  ,left.pBIP_ID = right.pBIP_ID ,transform({recordof(left) or recordof(right)} ,self := left,self := right));
  
  lay_active_calc := {string calculation ,boolean result};
  // -- set active status field
  lay_out := {recordof(infile) or {string1 pActive_Fieldname}};
  
  outfile := 
  join(
     infile_dt_last_seen2
    ,ddp_best_status
    ,left.pBIP_ID = right.pBIP_ID
    ,transform(
// #IF(pShow_Work = false)
      // lay_out,
// #ELSE
      {lay_out,dataset(lay_active_calc) active_calculation },
// #END
      most_recent_rec := left.dt_last_seen_unsorted;
      self_isDefunct  := right.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setDefunct ;
      self_isInactive := right.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setInactive;
      over_2_years_old  := ~(    ut.Age(left.dt_last_seen_unsorted              ,(UNSIGNED4)pToday) < 2
                             OR  ut.Age(left.dt_last_seen_unsorted_unrestricted ,(UNSIGNED4)pToday) < 2
                            );
      // self.company_status_derived := '';// blank out company_status_derived.  i was setting it to what is in the key, but now (bug 146880) that is unrestricted, so i cannot show it.  we may be able to remove the field later. 
      self.pActive_Fieldname      := 
        map(
                self_isDefunct                                                    => BIPV2_PostProcess.constants.Inactive_Reported 
          ,     over_2_years_old
            or  self_isInactive                                                   => BIPV2_PostProcess.constants.Inactive_NoActivity 
          ,                                                                          ''
        );
      self := left;
// #IF(pShow_Work = true)
      self.active_calculation := dataset([
         {'Reported Defunct'  ,self_isDefunct   }
        ,{'Over 2 years old'  ,over_2_years_old }
        ,{'Reported Inactive' ,self_isInactive  }
      ] ,lay_active_calc)
// #END

    )
    ,keep(1)
    ,left outer
  );

// #IF(pShow_Work = true)
  ddp_best_status_add_sources_plus_status := join(
     ddp_best_status_add_sources
    ,dedup(sort(distribute(project(outfile  ,transform({outfile.pBIP_ID,outfile.pActive_Fieldname,dataset(lay_active_calc) active_calculation},self.active_calculation := left.active_calculation,self := left)),pBIP_ID) ,pBIP_ID,pActive_Fieldname,local) ,pBIP_ID,pActive_Fieldname ,local)
    ,left.pBIP_ID = right.pBIP_ID
    ,transform(
      {unsigned6 pBIP_ID  ,string1 pActive_Fieldname ,dataset(lay_active_calc) active_calculation,recordof(left) - pBIP_ID}

      ,self.pActive_Fieldname   := right.pActive_Fieldname
      ,self                     := left
      ,self.active_calculation  := right.active_calculation    
    )
  ,keep(1)
  ,hash);
// #END

  LOADXML('<xml/>');
  #EXPORTXML(pLayout_MetaInfo ,recordof(infile))
	#uniquename(SET_IDS_DO_NOT_EXIST)
  import tools,bipv2_build;
  tools.mac_DoFieldsExist(pLayout_MetaInfo	,[#TEXT(pActive_Fieldname)],SET_IDS_DO_NOT_EXIST,true);




  #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
  count_old_statuses := table(table(infile  ,{pBIP_ID,pActive_Fieldname}  ,pBIP_ID,pActive_Fieldname ,merge)  ,{pActive_Fieldname ,unsigned cnt := count(group)} ,pActive_Fieldname ,few);
  count_old_ids      := table(infile  ,{pBIP_ID,pActive_Fieldname}  ,pBIP_ID,pActive_Fieldname ,merge);
  #END
  count_new_statuses := table(table(outfile ,{pBIP_ID,pActive_Fieldname}  ,pBIP_ID,pActive_Fieldname ,merge)  ,{pActive_Fieldname ,unsigned cnt := count(group)} ,pActive_Fieldname ,few);
  count_new_ids      := table(outfile  ,{pBIP_ID,pActive_Fieldname}  ,pBIP_ID,pActive_Fieldname ,merge);

  #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
    ds_get_status_diffs := join(count_old_ids ,count_new_ids  ,left.pBIP_ID = right.pBIP_ID and left.pActive_Fieldname != right.pActive_Fieldname ,transform({unsigned6 pBIP_ID ,string1 pActive_Fieldname_old  ,string1 pActive_Fieldname_new}
      ,self.pActive_Fieldname_old := left.pActive_Fieldname
      ,self.pActive_Fieldname_new := right.pActive_Fieldname
      ,self                       := left
    )  ,hash);
    ds_append_info_diffs := join(ds_get_status_diffs ,ddp_best_status_add_sources_plus_status ,left.pBIP_ID = right.pBIP_ID ,transform({recordof(left) or recordof(right) - pActive_Fieldname},self := left,self := right)  ,hash);
  #END

  ds_stats := dataset([
  #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
    {'Input'  ,#TEXT(pBIP_ID),#TEXT(pActive_Fieldname)  ,count(infile)  ,count(count_old_ids)  ,count_old_statuses(trim(pActive_Fieldname) = ''  )[1].cnt ,count_old_statuses(trim(pActive_Fieldname) = 'I'  )[1].cnt  ,count_old_statuses(trim(pActive_Fieldname) = 'D'  )[1].cnt ,Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),pConfFlag},
  #END                        
    {'Output' ,#TEXT(pBIP_ID),#TEXT(pActive_Fieldname)  ,count(outfile) ,count(count_new_ids)  ,count_new_statuses(trim(pActive_Fieldname) = ''  )[1].cnt ,count_new_statuses(trim(pActive_Fieldname) = 'I'  )[1].cnt  ,count_new_statuses(trim(pActive_Fieldname) = 'D'  )[1].cnt ,Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),pConfFlag} 

  #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
    ,{'Diffs'  ,#TEXT(pBIP_ID),#TEXT(pActive_Fieldname)  ,count(ds_append_info_diffs) ,count(ds_append_info_diffs)  ,0 ,0  ,0 ,Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),pConfFlag}
  #END                        
  
  ]  ,{string file,string BIP_ID,string Active_fieldname,unsigned cnt_total_recs,unsigned cnt_total_ids,unsigned cnt_actives,unsigned cnt_inactives,unsigned cnt_defuncts  ,string timestamp ,string Conf});
  
  
  
  
  // #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
  // count_old_actives := count(table(infile (trim(pActive_Fieldname) = ''  ),{pBIP_ID}  ,pBIP_ID ,merge));
  // #END
  // count_new_actives := count(table(outfile(trim(pActive_Fieldname) = ''  ),{pBIP_ID}  ,pBIP_ID ,merge));

  // ds_stats := dataset([
  // #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
    // {'count_old_actives' ,count_old_actives ,Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),pConfFlag},
  // #END
    // {'count_new_actives' ,count_new_actives ,Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),pConfFlag}
  
  // ]  ,{string stat,unsigned stat_value  ,string timestamp ,string Conf});

  outfile_out := project(outfile  ,lay_out);

#IF(pShow_Work = false)
  // -- return result
  return when(outfile_out
    ,parallel(
     output(ds_stats  ,named('BIPV2_Tools_mac_Set_Statuses_ds_stats'),EXTEND)
    ,if(pBIP_ID_Test_Value != 0
    ,parallel(
       output(choosen(ds_status_rollup_unrestricted (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ds_status_rollup_unrestricted_' + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_status_rollup              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ds_status_rollup_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(srt_forstatus                 (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_srt_forstatus_'                 + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ddp_forstatus                 (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ddp_forstatus_'                 + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_latest_status              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ds_latest_status_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(cnt_by_type                   (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_cnt_by_type_'                   + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(cnt_by_type_help_active       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_cnt_by_type_help_active_'       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(sort_best_status              (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_sort_best_status_'              + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_latest                     (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ds_latest_'                     + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(infile_dt_last_seen1          (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_infile_dt_last_seen1_'          + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_latest_unrestricted        (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ds_latest_unrestricted_'        + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(infile_dt_last_seen2          (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_infile_dt_last_seen2_'          + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ddp_best_status               /*(pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value)*/,100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ddp_best_status_'               + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_get_sources_used               /*(pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value)*/,100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ds_get_sources_used_'               + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ddp_best_status_add_sources               /*(pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value)*/,100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_ddp_best_status_add_sources_'               + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(outfile                       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_stats_outfile_'                       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
  #IF(count(%SET_IDS_DO_NOT_EXIST%) = 0)
      ,output(choosen(ds_get_status_diffs           (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_get_status_diffs_'                       + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
      ,output(choosen(ds_append_info_diffs          (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_Tools_mac_Set_Statuses_ds_append_info_diffs_'                      + #TEXT(pBIP_ID)+ #TEXT(pUse_DNB)+ #TEXT(pFuture_Dates)))
  #END
    ))                                                                                                                                                                                   
  ));
#ELSE
  // return when(ddp_best_status_add_sources_plus_status,output(ds_stats  ,named('BIPV2_Tools_mac_Set_Statuses_ds_stats')));
  return when(ddp_best_status_add_sources_plus_status ,output(ds_stats  ,named('BIPV2_Tools_mac_Set_Statuses_ds_stats'),EXTEND));
#END

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