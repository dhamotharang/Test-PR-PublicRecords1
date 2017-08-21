/*
  BIPV2_Tools.SetDuns() 
    Refreshes the D&B fields; active_duns_number, hist_duns_number, deleted_key(duns_number), company_fein, deleted_fein.
    Explodes proxid and lgid3 clusters that contain a duns_number,cnp_name tuple that is deleted + that same duns_number
      with a different cnp_name that is not deleted.  After explosion of proxid to dotid for the offending clusters, 
      the old cluster will be grouped by dotid and cnp_name, setting the lowest dotid per cnp_name as the proxid.
      This is to reduce the increase in proxids by getting the low hanging fruit out of the way.  Doing this reduces the 
      increase in proxids from ~15% to 1.7%, for the first time this is run.  Subsequent build to build increases should
      be more like 0.1-0.2%.
    Allows duns_numbers and feins to come back to life if we get a replacement record from D&B for that duns.
  possible future improvements:
    can do more iterates for more collapses, although that seems to have dimishing returns.  BIPV2_Tools.mac_reform with loop could help.
    make it more generic to handle corp corrections.  in addition to deleted_key, would need to use the source field.
*/
import BIPV2_Build,bipv2,dnb_dmi,mdr,bipv2_files,ut,_control;
export SetDuns(
     dataset(BIPV2.CommonBase.Layout)                     ds_in
    ,boolean                                              pDoStrata       = true
    ,dataset(recordof(dnb_dmi.files().base.companies.qa)) pDuns_file      = dnb_dmi.files().base.companies.qa
    ,string                                               pPersistUnique  = ''
    ,string                                               pversion        = bipv2.KeySuffix
    ,boolean                                              pIsTesting      = false
    ,boolean                                              pOverwrite      = false
    ,string                                               pEmailList      = BIPV2_Build.mod_email.emailList
    ,unsigned6                                            pLgid3_example  = 0           
    ,boolean                                              pDebug_Outputs  = true
  ) := 
function
    l_dot := BIPV2.CommonBase.Layout;
  
    pPersistname := 'thor_data400::persist::BIPV2::file_current_Duns';
    ds_active_duns_new2 :=  BIPV2_Tools.GetDuns(pDuns_file,pPersistUnique) : persist('~'+pPersistname + '.new' + '_' + pPersistUnique);
    
    // --------------------------------------
    // -- Refresh Duns number fields
    // --------------------------------------
    l_dot_temp := {unsigned6 lgid3_old := 0,unsigned proxid_old := 0,l_dot/*,string prev_deleted_duns := ''*/};
    isdmi(string src) := MDR.sourceTools.SourceIsDunn_Bradstreet(src);
    
		l_dot_temp tr_Refresh_Duns(l_dot L, ds_active_duns_new2 R) := 
    transform
			self.active_duns_number	  := if(trim(R.status)       = 'Active'   and isdmi(L.source)  ,R.duns_number  ,''  ); //if it matches and duns status is Active  , populate this field 
			self.hist_duns_number		  := if(trim(R.status)       = 'Historic' and isdmi(L.source)  ,R.duns_number  ,''  ); //if it matches and duns status is Historic, populate this field 
      self.deleted_key          := if(trim(R.status)       = 'Deleted'                       ,R.duns_number  ,''  ); //save deleted duns number here in a field not used for linking.
      self.company_fein         := if(trim(R.status)       = 'Deleted'                       ,''             ,if(L.company_fein != '' ,L.company_fein ,L.deleted_fein) ); //save deleted fein here in a field not used for linking.
      self.deleted_fein         := if(trim(R.status)       = 'Deleted'                       ,if(L.company_fein != '' ,L.company_fein ,L.deleted_fein) ,''              ); //save deleted fein here in a field not used for linking.
      // self.prev_deleted_duns    := L.deleted_key                                                           ; //save previous deleted duns number here for stat purposes.
			self                      := L;
		end;
    // -- fix duns numbers, add D&B fein so their duns_numbers can get deleted too.
    ds_in_fix   := project(ds_in,transform(recordof(left)
      ,self.duns_number := map(
         left.duns_number != ''                                                                      => left.duns_number
        ,mdr.sourcetools.sourceisDunn_Bradstreet     (left.source) and left.active_duns_number != '' => left.active_duns_number 
        ,mdr.sourcetools.sourceisDunn_Bradstreet     (left.source) and left.hist_duns_number   != '' => left.hist_duns_number 
        ,mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(left.source) and length(trim(left.vl_id)) = 9  => left.vl_id
        ,mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(left.source) and trim(left.vl_id)[1..2] = 'DF' and length(trim(left.vl_id)) > 9 => trim(left.vl_id)[(length(trim(left.vl_id)) - 8)..]
        ,left.duns_number
      );
      ,self.company_fein := if(Left.company_fein != '' ,Left.company_fein ,Left.deleted_fein);
      ,self.deleted_fein := '';
      ,self := left)) 
      : persist('~persist::BIPV2_Files.tools_dotid.ds_in_fix'+ pPersistUnique); 
    ds_blank_duns     := ds_in_fix(duns_number ='') : persist('~persist::BIPV2_Files.tools_dotid.ds_blank_duns'   + pPersistUnique);
    ds_nonblank_duns  := ds_in_fix(duns_number<>'') : persist('~persist::BIPV2_Files.tools_dotid.ds_nonblank_duns'+ pPersistUnique);
    
    ds_refresh_duns  := join(
			ds_nonblank_duns, ds_active_duns_new2,
			trim(left.duns_number) = trim(right.duns_number) and trim(left.cnp_name) = trim(right.cnp_name),
			tr_Refresh_Duns(left,right),
			left outer, hash
		)
    : persist('~persist::BIPV2_Files.tools_dotid.ds_refresh_duns'+ pPersistUnique);
 
    ds_concat_pre_full   := project(ds_blank_duns,transform(l_dot_temp,self.active_duns_number := '',self.hist_duns_number := '',self := left)) 
                            & ds_refresh_duns
      : persist('~persist::BIPV2_Files.tools_dotid.ds_concat_pre_full'+ pPersistUnique);
    ds_concat_pre_slim := table(ds_concat_pre_full ,{dotid,proxid,lgid3,cnp_name,duns_number,deleted_key/*,prev_deleted_duns*/},dotid,proxid,lgid3,cnp_name,duns_number,deleted_key/*,prev_deleted_duns*/,merge)
      : persist('~persist::BIPV2_Files.tools_dotid.ds_concat_pre_slim'+ pPersistUnique);
    // -- we care about: dotid,proxid,lgid3,cnp_name,duns_number,deleted_key,prev_deleted_duns
    ds_refresh_duns_slim := table(ds_refresh_duns ,{dotid,proxid,lgid3,cnp_name,duns_number,deleted_key/*,prev_deleted_duns*/},dotid,proxid,lgid3,cnp_name,duns_number,deleted_key/*,prev_deleted_duns*/,merge)
      : persist('~persist::BIPV2_Files.tools_dotid.ds_refresh_duns_slim'+ pPersistUnique);
    l_dot_temp2 := {unsigned6 lgid3_old := 0 ,unsigned proxid_old := 0 ,recordof(ds_concat_pre_slim)};
    // -----------------------------------------------------------------------------------------
    // -- Explode Lgid3s First to proxid for offending clusters.  Save old lgid3 for use later
    // -----------------------------------------------------------------------------------------
    ds_to_explode_lgid3     := ds_refresh_duns_slim(  deleted_key != '' and lgid3 != 0 /*and prev_deleted_duns = ''*/ );
    ds_not_explode_lgid3    := ds_refresh_duns_slim(~(deleted_key != '' and lgid3 != 0 /*and prev_deleted_duns = ''*/));
    ds_to_explode_lgid3s    := table(ds_to_explode_lgid3  ,{lgid3},lgid3,merge) : persist('~persist::BIPV2_Files.tools_dotid.ds_to_explode_lgid3s'+ pPersistUnique);
    
    // ds_concat_lgid3         := project(ds_blank_duns,transform(l_dot_temp,self.active_duns_number := '',self.hist_duns_number := '',self := left)) + ds_refresh_duns;
    
    ds_concat_with_lgid3    := ds_concat_pre_slim(lgid3 != 0); 
    ds_concat_without_lgid3 := ds_concat_pre_slim(lgid3  = 0);
    ds_get_all_explode_recs_lgid3 := join(ds_concat_with_lgid3 ,ds_to_explode_lgid3s  ,left.lgid3 = right.lgid3 ,transform(left),hash)            : persist('~persist::BIPV2_Files.tools_dotid.ds_get_all_explode_recs_lgid3'+ pPersistUnique);
    ds_get_rest_recs_lgid3        := join(ds_concat_with_lgid3 ,ds_to_explode_lgid3s  ,left.lgid3 = right.lgid3 ,transform(left),left only,hash)  : persist('~persist::BIPV2_Files.tools_dotid.ds_get_rest_recs_lgid3'       + pPersistUnique);
    import BIPV2_ProxID,salt30;
    key_cnp_name_lgid3 := BIPV2_ProxID.specificities(BIPV2_ProxID.In_DOT_Base).cnp_name_values_index;
    ds_explode_get_bow_lgid3 := join(ds_get_all_explode_recs_lgid3  ,key_cnp_name_lgid3, left.cnp_name = right.cnp_name ,transform({string cnp_name_bow,real field_specificity,recordof(left)}
      ,self.cnp_name_bow  := right.word
      ,self.field_specificity := right.field_specificity
      ,self               := left
    ),left outer,hash);
    ds_find_candidates_lgid3_prep := table(join(
                               table(ds_explode_get_bow_lgid3(deleted_key   = '' and duns_number      != ''    ) ,{lgid3,duns_number,cnp_name_bow,field_specificity},lgid3,duns_number,cnp_name_bow,field_specificity,merge)
                              ,table(ds_explode_get_bow_lgid3(deleted_key  != '' /*and prev_deleted_duns = ''*/) ,{lgid3,duns_number,cnp_name_bow,field_specificity},lgid3,duns_number,cnp_name_bow,field_specificity,merge)
                              ,left.lgid3 = right.lgid3 and left.duns_number = right.duns_number and left.cnp_name_bow != '' and right.cnp_name_bow != '' and left.cnp_name_bow != right.cnp_name_bow 
                                and (SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1) < BIPV2_ProxID.Config.cnp_name_Force * 100  //use cnp_name for a little fuzzy here
                                or(     SALT30.HyphenMatch(left.cnp_name_bow,right.cnp_name_bow,1)<=1 
                                    and (MIN(left.field_specificity,right.field_specificity) * 100  < BIPV2_ProxID.Config.cnp_name_Force * 100)
                                ))
                              ,transform({unsigned6 lgid3,string duns_number,string cnp_name_bow_left  ,string cnp_name_bow_right,integer cnp_match_score}
                            ,self.cnp_name_bow_left   := if(left.cnp_name_bow  > right.cnp_name_bow  ,left.cnp_name_bow  ,right.cnp_name_bow)
                            ,self.cnp_name_bow_right  := if(left.cnp_name_bow  > right.cnp_name_bow  ,right.cnp_name_bow ,left.cnp_name_bow )
                            ,self.cnp_match_score     := SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1)
                            ,self := right),hash)
                          ,{lgid3,duns_number,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score},lgid3,duns_number,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score,merge)  : persist('~persist::BIPV2_Files.tools_dotid.ds_find_candidates_lgid3'+ pPersistUnique);
    
    ds_corpkey_overrides_lgid3 := BIPV2_Tools.mac_IDs_with_ckey_overrides(ds_concat_pre_full,lgid3,,'ds_corpkey_overrides_lgid3');
    // -- remove lgid3 explodes that also would have been linked by corpkey
    ds_find_candidates_lgid3_prep2_inner := join(ds_find_candidates_lgid3_prep ,ds_corpkey_overrides_lgid3  ,
          left.lgid3              = right.lgid3 
      and left.cnp_name_bow_left  = right.cnp_name_bow_left 
      and left.cnp_name_bow_right = right.cnp_name_bow_right 
    ,transform({recordof(left) or recordof(right)},self := left,self := right),hash);

    ds_find_candidates_lgid3_prep2 := join(ds_find_candidates_lgid3_prep ,ds_corpkey_overrides_lgid3  ,
          left.lgid3              = right.lgid3 
      and left.cnp_name_bow_left  = right.cnp_name_bow_left 
      and left.cnp_name_bow_right = right.cnp_name_bow_right 
    ,transform(left),left only,hash);
    // -- needs to be cut down to only lgid in ds_find_candidates_lgid3
    ds_find_candidates_lgid3 := table(ds_find_candidates_lgid3_prep2  ,{lgid3} ,lgid3,merge);
    // ----------------------------------
    
    ds_non_candidates_lgid3     := join(ds_get_all_explode_recs_lgid3 ,ds_find_candidates_lgid3 ,left.lgid3 = right.lgid3 ,transform(left),left only,hash)  : persist('~persist::BIPV2_Files.tools_dotid.ds_non_candidates_lgid3'+ pPersistUnique);
    ds_reset_candidates_lgid3   := join(ds_get_all_explode_recs_lgid3 ,ds_find_candidates_lgid3 ,left.lgid3 = right.lgid3 ,transform(l_dot_temp2,self.lgid3_old := left.lgid3,self.lgid3 := left.proxid,self := left),hash): persist('~persist::BIPV2_Files.tools_dotid.ds_reset_candidates_lgid3'    + pPersistUnique);
    ds_result_lgid3             := project(ds_concat_without_lgid3 + ds_get_rest_recs_lgid3 + ds_non_candidates_lgid3,l_dot_temp2) + ds_reset_candidates_lgid3 : persist('~persist::BIPV2_Files.tools_dotid.ds_result_lgid3'+ pPersistUnique);
    
    records_affected_lgid3 := join(
       table(ds_in  ,{rcid,proxid,lgid3})  
      ,table(ds_reset_candidates_lgid3,{lgid3,lgid3_old},lgid3,lgid3_old,merge)  
      ,left.lgid3 = right.lgid3_old and left.proxid = right.lgid3 and left.lgid3 != right.lgid3
      ,transform({unsigned6 rcid,unsigned6 lgid3_before,unsigned6 lgid3_after}
        ,self.lgid3_before := left.lgid3
        ,self.lgid3_after := right.lgid3
        ,self := right
        ,self := left
      )
      ,hash
    );
    ds_changes_lgid3 := table(ds_result_lgid3(lgid3_old != 0)  ,{lgid3,lgid3_old,proxid},lgid3,lgid3_old,proxid,merge);
    ds_changes_lgid3_dups           := table(ds_changes_lgid3 ,{proxid,lgid3_old,unsigned cnt := count(group)},proxid,lgid3_old,merge)(cnt > 1);
    ds_changes_lgid3_dups_examples  := join(ds_changes_lgid3 ,topn(ds_changes_lgid3_dups,5,-cnt) ,left.proxid = right.proxid and left.lgid3_old = right.lgid3_old,transform({unsigned cnt,recordof(left)},self.cnt := right.cnt,self := left),lookup);
    ds_result_lgid3_full := join(ds_concat_pre_full(lgid3 != 0)  ,ds_changes_lgid3 ,left.lgid3 = right.lgid3_old and left.proxid = right.proxid
      ,transform(recordof(left),self.lgid3 := if(right.lgid3 > 0 ,right.lgid3  ,left.lgid3),self := right,self := left),hash,left outer)
        + ds_concat_pre_full(lgid3 = 0)
      ;
    // ----------------------------------------------------------------------------------------------------------------------------------------------------------
    // -- Explode Proxids(and lgid3s) to Dotid for offending clusters.  Group dotids by cnp_name, getting lowest dotid by cnp_name to assign to proxid and lgid3.
    // ----------------------------------------------------------------------------------------------------------------------------------------------------------
    ds_blank_duns_lgid3     := ds_result_lgid3(duns_number ='') : persist('~persist::BIPV2_Files.tools_dotid.ds_blank_duns_lgid3'   + pPersistUnique);
    ds_nonblank_duns_lgid3  := ds_result_lgid3(duns_number<>'') : persist('~persist::BIPV2_Files.tools_dotid.ds_nonblank_duns_lgid3'+ pPersistUnique);
    ds_to_explode  := ds_nonblank_duns_lgid3(  deleted_key != '' and proxid != 0 /*and prev_deleted_duns = ''*/ );
    ds_not_explode := ds_nonblank_duns_lgid3(~(deleted_key != '' and proxid != 0 /*and prev_deleted_duns = ''*/));
    ds_to_explode_proxids := table(ds_to_explode  ,{proxid},proxid,merge) : persist('~persist::BIPV2_Files.tools_dotid.ds_to_explode_proxids'+ pPersistUnique);
    
    ds_concat := project(ds_blank_duns_lgid3,transform(l_dot_temp2,self := left)) + ds_nonblank_duns_lgid3 : independent;
    
    ds_concat_with_proxid    := ds_concat(proxid != 0) : independent; 
    ds_concat_without_proxid := ds_concat(proxid  = 0);
    ds_get_all_explode_recs := join(ds_concat_with_proxid ,ds_to_explode_proxids  ,left.proxid = right.proxid ,transform(left),hash)            : persist('~persist::BIPV2_Files.tools_dotid.ds_get_all_explode_recs'+ pPersistUnique);
    ds_get_rest_recs        := join(ds_concat_with_proxid ,ds_to_explode_proxids  ,left.proxid = right.proxid ,transform(left),left only,hash)  : persist('~persist::BIPV2_Files.tools_dotid.ds_get_rest_recs'       + pPersistUnique);
    // import BIPV2_ProxID,salt30;
    // key_cnp_name := BIPV2_ProxID.specificities(BIPV2_ProxID.In_DOT_Base).cnp_name_values_index;
    import BIPV2_ProxID,salt30;
    key_cnp_name := BIPV2_ProxID.specificities(BIPV2_ProxID.In_DOT_Base).cnp_name_values_index;
    ds_explode_get_bow := join(ds_get_all_explode_recs  ,key_cnp_name, left.cnp_name = right.cnp_name ,transform({string cnp_name_bow,real field_specificity,recordof(left)}
      ,self.cnp_name_bow  := right.word
      ,self.field_specificity := right.field_specificity
      ,self               := left
    ),left outer,hash);
    ds_find_candidates_prep := table(join(
                               table(ds_explode_get_bow(deleted_key   = '' and duns_number      != ''    ) ,{proxid,duns_number,cnp_name_bow,field_specificity},proxid,duns_number,cnp_name_bow,field_specificity,merge)
                              ,table(ds_explode_get_bow(deleted_key  != '' /*and prev_deleted_duns = ''*/) ,{proxid,duns_number,cnp_name_bow,field_specificity},proxid,duns_number,cnp_name_bow,field_specificity,merge)
                              ,left.proxid = right.proxid and left.duns_number = right.duns_number and left.cnp_name_bow != '' and right.cnp_name_bow != '' and left.cnp_name_bow != right.cnp_name_bow and SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1) < BIPV2_ProxID.Config.cnp_name_Force * 100  //use cnp_name for a little fuzzy here
                                and (SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1) < BIPV2_ProxID.Config.cnp_name_Force * 100  //use cnp_name for a little fuzzy here
                                or(     SALT30.HyphenMatch(left.cnp_name_bow,right.cnp_name_bow,1)<=1 
                                    and (MIN(left.field_specificity,right.field_specificity) * 100  < BIPV2_ProxID.Config.cnp_name_Force * 100)
                                ))
                              ,transform({unsigned6 proxid,string duns_number,string cnp_name_bow_left  ,string cnp_name_bow_right,integer cnp_match_score}
                            ,self.cnp_name_bow_left   := if(left.cnp_name_bow  > right.cnp_name_bow  ,left.cnp_name_bow  ,right.cnp_name_bow)
                            ,self.cnp_name_bow_right  := if(left.cnp_name_bow  > right.cnp_name_bow  ,right.cnp_name_bow ,left.cnp_name_bow )
                            ,self.cnp_match_score     := SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1)
                            ,self := right),hash)
                          // ,{proxid},proxid,merge)  : persist('~persist::BIPV2_Files.tools_dotid.ds_find_candidates'+ pPersistUnique);
// -------------------------------------
                          ,{proxid,duns_number,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score},proxid,duns_number,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score,merge)  : persist('~persist::BIPV2_Files.tools_dotid.ds_find_candidates_proxid'+ pPersistUnique);
    
    ds_corpkey_overrides_proxid := BIPV2_Tools.mac_IDs_with_ckey_overrides(ds_result_lgid3_full,proxid,,'ds_corpkey_overrides_proxid');
    // -- remove proxid explodes that also would have been linked by corpkey
    ds_find_candidates_proxid_prep2_inner := join(ds_find_candidates_prep ,ds_corpkey_overrides_proxid  ,
          left.proxid             = right.proxid 
      and left.cnp_name_bow_left  = right.cnp_name_bow_left 
      and left.cnp_name_bow_right = right.cnp_name_bow_right 
    ,transform({recordof(left) or recordof(right)},self := left,self := right),hash);

    ds_find_candidates_proxid_prep2 := join(ds_find_candidates_prep ,ds_corpkey_overrides_proxid  ,
          left.proxid             = right.proxid 
      and left.cnp_name_bow_left  = right.cnp_name_bow_left 
      and left.cnp_name_bow_right = right.cnp_name_bow_right 
    ,transform(left),left only,hash);
    // -- needs to be cut down to only lgid in ds_find_candidates_proxid
    ds_find_candidates := table(ds_find_candidates_proxid_prep2  ,{proxid} ,proxid,merge);

// -------------------------------------                        
    // ds_corpkey_overrides_proxid := BIPV2_Tools.mac_IDs_with_ckey_overrides(ds_result_lgid3_full,proxid,,'ds_corpkey_overrides_proxid');
    // -- remove lgid3 explodes that also would have been linked by corpkey
    // ds_find_candidates := join(ds_find_candidates_prep ,ds_corpkey_overrides_proxid  ,left.proxid = right.proxid ,transform(left),left only,hash);

    ds_non_candidates    := join(ds_get_all_explode_recs ,ds_find_candidates ,left.proxid = right.proxid ,transform(left),left only,hash)                                       : persist('~persist::BIPV2_Files.tools_dotid.ds_non_candidates'+ pPersistUnique);
    
    ds_candidates1        := join(ds_get_all_explode_recs ,ds_find_candidates ,left.proxid = right.proxid ,transform(recordof(left),self.proxid := left.proxid,self := left),hash): persist('~persist::BIPV2_Files.tools_dotid.ds_candidates'    + pPersistUnique);
    ds_iter_prep := table(ds_candidates1 ,{proxid,cnp_name,dotid,unsigned6 lowest_dotid := dotid,unsigned loop_counter := 0,boolean isdone := false},proxid,cnp_name,dotid,merge);
    
    // ds_cand_iter5 := loop(ds_iter_prep  
      ////,counter < 10 and exists(table(table(rows(left),{proxid,cnp_name,lowest_dotid},proxid,cnp_name,lowest_dotid,merge) ,{proxid,cnp_name,unsigned cnt := count(group)},proxid,cnp_name,merge) (cnt > 1))
      // ,counter < 10 and exists(rows(left)(isdone = false))
      // ,BIPV2_Tools.mac_reform(rows(left),counter)
      // );
    ds_cand_table1       := group(sort(distribute(table(ds_candidates1 ,{proxid,cnp_name,dotid,unsigned6 lowest_dotid := dotid},proxid,cnp_name,dotid,merge),hash64(proxid,cnp_name)),proxid,cnp_name,dotid,local),proxid,cnp_name,local);
    ds_cand_iter1        := iterate(ds_cand_table1  ,transform(
        recordof(left)
       ,self.lowest_dotid := if(left.lowest_dotid = 0 ,right.lowest_dotid ,left.lowest_dotid)
       ,self              := right
    ));
    ds_cand_table2       := group(sort(distribute(ds_cand_iter1 ,hash64(proxid,dotid)),proxid,dotid,lowest_dotid,local),proxid,dotid,local);
    ds_cand_iter2        := iterate(ds_cand_table2  ,transform(
        recordof(left)
       ,self.lowest_dotid := if(left.lowest_dotid = 0 ,right.lowest_dotid ,left.lowest_dotid)
       ,self              := right
    ));
    
    ds_cand_table3       := group(sort(distribute(ds_cand_iter2 ,hash64(proxid,cnp_name)),proxid,cnp_name,lowest_dotid,local),proxid,cnp_name,local);
    ds_cand_iter3        := iterate(ds_cand_table3  ,transform(
        recordof(left)
       ,self.lowest_dotid := if(left.lowest_dotid = 0 ,right.lowest_dotid ,left.lowest_dotid)
       ,self              := right
    ));
////
    ds_cand_table4       := group(sort(distribute(ds_cand_iter3 ,hash64(proxid,dotid)),proxid,dotid,lowest_dotid,local),proxid,dotid,local);
    ds_cand_iter4        := iterate(ds_cand_table4  ,transform(
        recordof(left)
       ,self.lowest_dotid := if(left.lowest_dotid = 0 ,right.lowest_dotid ,left.lowest_dotid)
       ,self              := right
    ));
    
    ds_cand_table5       := group(sort(distribute(ds_cand_iter4 ,hash64(proxid,cnp_name)),proxid,cnp_name,lowest_dotid,local),proxid,cnp_name,local);
    ds_cand_iter5        := iterate(ds_cand_table5  ,transform(
        recordof(left)
       ,self.lowest_dotid := if(left.lowest_dotid = 0 ,right.lowest_dotid ,left.lowest_dotid)
       ,self              := right
    )) : independent;
//////
    ds_cand_table6       := table(ds_cand_iter5 ,{proxid,dotid,unsigned6 lowest_dotid := min(group,lowest_dotid)}, proxid,dotid,merge);    
//
    ds_reset_candidates  := join(ds_candidates1 ,ds_cand_table6 ,left.proxid = right.proxid and left.dotid = right.dotid  ,transform(recordof(left),self.lgid3_old := if(left.lgid3_old != 0,left.lgid3_old,left.lgid3),self.proxid_old := left.proxid,self.proxid := right.lowest_dotid,self.lgid3 := right.lowest_dotid,self := left),hash);
    ds_result_proxid := project(ds_concat_without_proxid + ds_get_rest_recs + ds_non_candidates,l_dot_temp2) + ds_reset_candidates : persist('~persist::BIPV2_Files.tools_dotid.ds_result_proxid'+ pPersistUnique);
    // ds_result := ds_concat_without_proxid + ds_get_rest_recs + ds_non_candidates + ds_reset_candidates : persist('~persist::BIPV2_Files.tools_dotid.ds_result_proxid'+ pPersistUnique);
    // ds_result := project(ds_concat_without_proxid + ds_get_rest_recs + ds_non_candidates + ds_reset_candidates,l_dot) : persist('~persist::BIPV2_Files.tools_dotid.ds_result_proxid'+ pPersistUnique);
    ds_changes_proxid := table(ds_result_proxid(proxid_old != 0)  ,{lgid3_old,lgid3,proxid_old,proxid,cnp_name},lgid3_old,lgid3,proxid_old,proxid,cnp_name,merge);
    ds_changes_proxid_dups           := table(ds_changes_proxid ,{proxid_old,lgid3_old,cnp_name,unsigned cnt := count(group)},proxid_old,lgid3_old,cnp_name,merge)(cnt > 1);
    ds_changes_proxid_dups_examples  := join(ds_changes_proxid ,topn(ds_changes_proxid_dups,5,-cnt) ,left.proxid_old = right.proxid_old and left.lgid3_old = right.lgid3_old and left.cnp_name = right.cnp_name,transform({unsigned cnt,recordof(left)},self.cnt := right.cnt,self := left),lookup);
    ds_result_proxid_full := join(ds_concat_pre_full(lgid3 != 0)  ,ds_changes_proxid ,left.proxid = right.proxid_old and left.cnp_name = right.cnp_name
      ,transform(l_dot_temp,self.proxid := if(right.proxid > 0 ,right.proxid  ,left.proxid),self.lgid3 := if(right.lgid3 > 0 ,right.lgid3  ,left.lgid3),self := right,self := left),hash,left outer)
        + ds_concat_pre_full(lgid3 = 0)
      ;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------
    // -- Group proxids by cnp_name to help with lgid3 linking--get low hanging fruit.  This helps minimize the increase in lgid3s because of these corrections.
    // ------------------------------------------------------------------------------------------------------------------------------------------------------
    ds_find_candidates_lgid3_2 := ds_result_proxid(lgid3_old != 0);
    
    ds_non_candidates_lgid3_2    := ds_result_proxid(lgid3_old = 0);
    ds_iter_prep_lgid3 := table(ds_find_candidates_lgid3_2  ,{lgid3_old,cnp_name,proxid,unsigned6 lowest_proxid := proxid,unsigned loop_counter := 0,boolean isdone := false},lgid3_old,cnp_name,proxid,merge);
                          
    // ds_cand_iter1_lgid3_6 := loop(ds_iter_prep_lgid3  
      ////,counter < 10 and exists(table(table(rows(left),{proxid,cnp_name,lowest_dotid},proxid,cnp_name,lowest_dotid,merge) ,{proxid,cnp_name,unsigned cnt := count(group)},proxid,cnp_name,merge) (cnt > 1))
      // ,counter < 20 and exists(rows(left)(isdone = false))
      // ,BIPV2_Tools.mac_reform(rows(left),counter,lgid3_old,proxid,lowest_proxid)
    // );
   ds_cand_table1_lgid3_2       := group(sort(distribute(ds_iter_prep_lgid3,hash64(lgid3_old,cnp_name)),lgid3_old,cnp_name,proxid,local),lgid3_old,cnp_name,local);
    ds_cand_iter1_lgid3_2        := iterate(ds_cand_table1_lgid3_2  ,transform(
        recordof(left)
       ,self.lowest_proxid := if(left.lowest_proxid = 0 ,right.lowest_proxid ,left.lowest_proxid)
       ,self               := right
    ));
    
    ds_cand_table1_lgid3_3       := group(sort(distribute(ds_cand_iter1_lgid3_2 ,hash64(lgid3_old,proxid)),lgid3_old,proxid,lowest_proxid,local),lgid3_old,proxid,local);
    ds_cand_iter1_lgid3_3        := iterate(ds_cand_table1_lgid3_3  ,transform(
        recordof(left)
       ,self.lowest_proxid := if(left.lowest_proxid = 0 ,right.lowest_proxid ,left.lowest_proxid)
       ,self               := right
    ));
    
    ds_cand_table1_lgid3_4       := group(sort(distribute(ds_cand_iter1_lgid3_3 ,hash64(lgid3_old,cnp_name)),lgid3_old,cnp_name,lowest_proxid,local),lgid3_old,cnp_name,local);
    ds_cand_iter1_lgid3_4        := iterate(ds_cand_table1_lgid3_4  ,transform(
        recordof(left)
       ,self.lowest_proxid := if(left.lowest_proxid = 0 ,right.lowest_proxid ,left.lowest_proxid)
       ,self               := right
    ));
    
    ds_cand_table1_lgid3_5       := group(sort(distribute(ds_cand_iter1_lgid3_4 ,hash64(lgid3_old,proxid)),lgid3_old,proxid,lowest_proxid,local),lgid3_old,proxid,local);
    ds_cand_iter1_lgid3_5        := iterate(ds_cand_table1_lgid3_5  ,transform(
        recordof(left)
       ,self.lowest_proxid := if(left.lowest_proxid = 0 ,right.lowest_proxid ,left.lowest_proxid)
       ,self               := right
    ));
    
    ds_cand_table1_lgid3_6       := group(sort(distribute(ds_cand_iter1_lgid3_5 ,hash64(lgid3_old,cnp_name)),lgid3_old,cnp_name,lowest_proxid,local),lgid3_old,cnp_name,local);
    ds_cand_iter1_lgid3_6        := iterate(ds_cand_table1_lgid3_6  ,transform(
        recordof(left)
       ,self.lowest_proxid := if(left.lowest_proxid = 0 ,right.lowest_proxid ,left.lowest_proxid)
       ,self               := right
    ));
    //
    ds_cand_table2_lgid3_2       := table(ds_cand_iter1_lgid3_6 ,{lgid3_old,proxid,unsigned6 lowest_proxid := min(group,lowest_proxid)}, lgid3_old,proxid,merge);    
    ds_reset_candidates_lgid3_2  := join(ds_find_candidates_lgid3_2 ,ds_cand_table2_lgid3_2 ,left.lgid3_old = right.lgid3_old and left.proxid = right.proxid  ,transform(recordof(left),self.lgid3 := right.lowest_proxid,self := left),hash);
    // ds_result_lgid3_concat       := project(ds_non_candidates_lgid3_2 + ds_reset_candidates_lgid3_2 ,transform(recordof(left),self.lgid3_old := if(left.lgid3_old > 0,left.lgid3_old,left.lgid3)  ,self.proxid_old := if(left.proxid_old > 0,left.proxid_old,left.proxid),self := left )) : persist('~persist::BIPV2_Files.tools_dotid.ds_result_lgid3_2'+ pPersistUnique);
    ds_result_slim       := ds_non_candidates_lgid3_2 + ds_reset_candidates_lgid3_2  : persist('~persist::BIPV2_Files.tools_dotid.ds_result_slim'+ pPersistUnique);
    
    ds_changes := table(project(ds_reset_candidates_lgid3_2(proxid_old != 0 or lgid3_old != 0),transform({recordof(left),boolean Proxid_Old0},self.proxid_old := if(left.proxid_old = 0,left.proxid,left.proxid_old)
                  ,self.Proxid_Old0 := if(left.proxid_old = 0,true,false),self := left))
    ,{proxid_old,lgid3_old,cnp_name,unsigned6 proxid := min(group,proxid),unsigned6 lgid3 := min(group,lgid3)},proxid_old,lgid3_old,cnp_name,merge)
                  : independent;
    
    ds_result_pre := join(ds_concat_pre_full(proxid != 0)  ,ds_changes ,left.proxid = right.proxid_old and left.lgid3 = right.lgid3_old and left.cnp_name = right.cnp_name 
      ,transform(recordof(left)
        ,self.proxid      := if(right.proxid > 0,right.proxid,left.proxid)
        ,self.lgid3       := if(right.lgid3 > 0 ,right.lgid3  ,left.lgid3)
        ,self.lgid3_old   := right.lgid3_old
        ,self.proxid_old  := right.proxid_old
        ,self := left),hash,left outer)
;      // : persist('~persist::BIPV2_Files.tools_dotid.ds_result'+ pPersistUnique)
      ;
    ds_result_full := join(ds_result_pre(company_fein != '') ,table(ds_result_pre(deleted_fein != '',(mdr.sourcetools.sourceisDunn_Bradstreet(source) or mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source))),{proxid,deleted_fein},proxid,deleted_fein,merge) 
         ,left.proxid       = right.proxid
      and left.company_fein = right.deleted_fein
      and (mdr.sourcetools.sourceisDunn_Bradstreet(left.source) or mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(left.source))      
      ,transform(
         recordof(left)
        ,self.deleted_fein  := if(right.deleted_fein != ''  ,right.deleted_fein ,'')
        ,self.company_fein  := if(right.deleted_fein  = ''  ,if(Left.company_fein != '' ,Left.company_fein ,Left.deleted_fein)  ,'')
        ,self               := left
        
      )
      ,left outer
      ,hash
    )
    + ds_result_pre(company_fein = '')
    + ds_concat_pre_full(proxid = 0)
    : independent
    ;
    ds_result := project(ds_result_full,l_dot) : independent;
    
    // ds_result             := project(ds_non_candidates_lgid3_2 + ds_reset_candidates_lgid3_2 ,l_dot): persist('~persist::BIPV2_Files.tools_dotid.ds_result_lgid3_2'+ pPersistUnique);
    ds_changes_dups           := table(ds_changes ,{proxid_old,lgid3_old,cnp_name,unsigned cnt := count(group)},proxid_old,lgid3_old,cnp_name,merge)(cnt > 1);
    ds_changes_dups_examples  := join(ds_changes ,topn(ds_changes_dups,5,-cnt) ,left.proxid_old = right.proxid_old and left.lgid3_old = right.lgid3_old and left.cnp_name = right.cnp_name,transform({unsigned cnt,recordof(left)},self.cnt := right.cnt,self := left),lookup);
    
    records_affected_lgid3_2 := join(table(ds_in  ,{rcid,proxid,lgid3})  ,table(ds_result,{rcid,proxid,lgid3})  ,left.rcid = right.rcid and left.lgid3 != right.lgid3 or left.proxid != right.proxid
      ,transform({unsigned6 rcid,unsigned6 lgid3_before,unsigned6 lgid3_after,unsigned6 proxid_before,unsigned6 proxid_after},self.lgid3_before := left.lgid3,self.lgid3_after := right.lgid3,self.proxid_before := left.proxid,self.proxid_after := right.proxid,self := right),hash);
    // --------------------------------------------- group lgid3s
    count_proxids_in  := count(table(ds_in    (proxid != 0)   ,{proxid},proxid,merge));
    count_proxids_out := count(table(ds_result(proxid != 0)   ,{proxid},proxid,merge));
    count_diff_proxid := count_proxids_out - count_proxids_in;
    pct_change_proxid := realformat(count_diff_proxid / count_proxids_in * 100.0 ,6,2);
    blank_proxid_recs_in  := ds_in    (proxid = 0)   ;
    blank_proxid_recs_out := ds_result(proxid = 0)   ;
    count_lgid3s_in  := count(table(ds_in    (lgid3 != 0)   ,{lgid3},lgid3,merge));
    count_lgid3s_out := count(table(ds_result(lgid3 != 0)   ,{lgid3},lgid3,merge));
    count_diff_lgid3 := count_lgid3s_out - count_lgid3s_in;
    pct_change_lgid3 := realformat(count_diff_lgid3 / count_lgid3s_in * 100.0 ,6,2);
    blank_lgid3_recs_out := ds_result(lgid3 = 0)   ;
    
    records_affected_total := join(table(ds_in  ,{rcid,proxid,lgid3})  ,table(ds_result,{rcid,proxid,lgid3})  ,left.rcid = right.rcid and (left.proxid != right.proxid or left.lgid3 != right.lgid3)
      ,transform({unsigned6 rcid,unsigned6 proxid_before,unsigned6 proxid_after,unsigned6 lgid3_before,unsigned6 lgid3_after}
      ,self.proxid_before := left.proxid
      ,self.proxid_after  := right.proxid
      ,self.lgid3_before  := left.lgid3 
      ,self.lgid3_after   := right.lgid3
      ,self := right),hash);
    
    // for strata, we want to know:
    // # of records affected.  # clusters in and out. # of blank proxids.  pct increase in clusters.  
    // 	BuildBizStrat 	:= Strata.macf_CreateXMLStats(biz_stats		,'BIPV2','Data'	,pversion	,BIPV2_Build.mod_email.emailList	,'stats' ,'USBusiness'	  ,pIsTesting,pOverwrite);
   import wk_ut;
   dmi_input_file := wk_ut.Orbit_Item_list(workunit,'dmi'); //get the dmi file used
   ds_strata := dataset([
    {
     dmi_input_file[1].name
    ,0
    ,0
    ,0 
    ,0  
    ,0  
    ,0 
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0 
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    ,0
    }
    ,{
     'Current'
    ,count(ds_in)
    ,count(ds_in) - count(ds_result)
    ,count(records_affected_lgid3) 
    ,count(records_affected_total) 
    ,count_proxids_in  
    ,count_proxids_out  
    ,count_diff_proxid 
    ,(unsigned)((real8)pct_change_proxid * 100)
    ,count(blank_proxid_recs_out)
    ,count_lgid3s_in  
    ,count_lgid3s_out  
    ,count_diff_lgid3 
    ,(unsigned)((real8)pct_change_lgid3 * 100)
    ,count(blank_lgid3_recs_out)
    
    ,count(ds_in    (cnp_name   != ''))//cnp_name_in   
    ,count(ds_result(cnp_name   != ''))//cnp_name_out 
    ,count(ds_in    (duns_number   != ''))//duns_number_in   
    ,count(ds_result(duns_number   != ''))//duns_number_out 
    ,count(ds_in    (active_duns_number   != ''))//active_duns_in   
    ,count(ds_result(active_duns_number   != ''))//active_duns_out 
    ,count(ds_in    (hist_duns_number     != ''))//hist_duns_in    
    ,count(ds_result(hist_duns_number     != ''))//hist_duns_out 
    ,count(ds_in    (deleted_key  != ''))//deleted_duns_in 
    ,count(ds_result(deleted_key  != ''))//deleted_duns_out 
    ,count(ds_in    (company_fein != ''))//company_fein_in 
    ,count(ds_result(company_fein != ''))//company_fein_out 
    ,count(ds_in    (deleted_fein != ''))//deleted_fein_in 
    ,count(ds_result(deleted_fein != ''))//deleted_fein_out 
    }
   ],{string file,unsigned countgroup,integer diff_in_out0,unsigned records_affected_lgid3  ,unsigned records_affected_total 
   ,unsigned proxids_in ,unsigned proxids_out ,unsigned cnt_proxid_increase ,unsigned pct_proxid_increase ,unsigned cnt_blank_proxids
   ,unsigned lgid3s_in  ,unsigned lgid3s_out  ,unsigned cnt_lgid3_increase  ,unsigned pct_lgid3_increase  ,unsigned cnt_blank_lgid3s
   ,unsigned cnp_name_in     ,unsigned cnp_name_out 
   ,unsigned duns_number_in  ,unsigned duns_number_out 
   ,unsigned active_duns_in  ,unsigned active_duns_out 
   ,unsigned hist_duns_in    ,unsigned hist_duns_out 
   ,unsigned deleted_duns_in ,unsigned deleted_duns_out 
   ,unsigned company_fein_in ,unsigned company_fein_out 
   ,unsigned deleted_fein_in ,unsigned deleted_fein_out 
    
 })
   : persist('~persist::BIPV2_Files.tools_dotid.ds_strata'+ pPersistUnique);
   import strata;
   Strata_explode_stats := Strata.macf_CreateXMLStats(ds_strata		,'BIPV2','RunIngest'	,pversion	,pEmailList	,'Proxid_Correction_Stats' ,'SetDuns'	  ,pIsTesting,pOverwrite);
    fslim(pmydata) := functionmacro 
      // return project(pmydata,{unsigned6 lgid3,unsigned6 lgid3_old,unsigned6 proxid,unsigned6 proxid_old,unsigned6 dotid,string source,string cnp_name,string active_duns_number,string deleted_key,string duns_number,string company_fein,string prim_range,string prim_name,string st,string zip ,recordof(left) - company_name_type_derived - source - cnp_name - lgid3 - prim_range - prim_name - st - zip - company_fein - active_domestic_corp_key - active_duns_number - duns_number - hist_duns_number - deleted_key - proxid - dotid});
      return table(pmydata,{lgid3_old,lgid3,proxid_old,proxid,cnp_name,deleted_key,duns_number,company_fein,deleted_fein,prim_range, prim_name,st,zip }
      ,lgid3,lgid3_old,proxid,proxid_old,cnp_name,deleted_key,duns_number,company_fein,deleted_fein,prim_range, prim_name,st,zip ,merge);
    endmacro;
    ds_result__ := project(ds_result_full ,transform(recordof(left)
      ,self.lgid3_old  := if(left.lgid3_old  > 0 ,left.lgid3_old ,left.lgid3 )
      ,self.proxid_old := if(left.proxid_old > 0 ,left.proxid_old,left.proxid)
      ,self := left
    ));
    ds_result_ := fslim(ds_result__) : persist('~persist::persist::BIPV2_Files.tools_dotid.ds_result_'+ pPersistUnique);
    set_example                 := [37182283,53045067];
    get_example_lgid3s          := table(ds_in(rcid in set_example or proxid in set_example or lgid3 in set_example),{lgid3},lgid3,merge);
    ds_result_specific_example  := join(ds_result_  ,get_example_lgid3s ,left.lgid3_old = right.lgid3 ,transform(left),lookup) : persist('~persist::BIPV2_Files.tools_dotid.ds_result_specific_example'+ pPersistUnique);
    ds_get_exploded_lgid3s      := table(ds_result_full(lgid3_old  != 0,lgid3_old  != lgid3 ),{lgid3_old },lgid3_old ,merge);
    ds_get_exploded_proxids     := table(ds_result_full(proxid_old != 0,proxid_old != proxid),{proxid_old},proxid_old,merge);
    ds_result_lgid3_examples    := join(ds_result_ ,ds_get_exploded_lgid3s  ,left.lgid3_old  = right.lgid3_old   ,transform(left),hash): persist('~persist::BIPV2_Files.tools_dotid.ds_result_lgid3_examples' + pPersistUnique);
    ds_result_proxid_examples   := join(ds_result_ ,ds_get_exploded_proxids ,left.proxid_old = right.proxid_old  ,transform(left),hash): persist('~persist::BIPV2_Files.tools_dotid.ds_result_proxid_examples'+ pPersistUnique);
 
    // -- get more descriptive examples of splits
    ds_proxid_explodes_example  := ds_find_candidates_prep       (proxid = pLgid3_example);//{unsigned6 proxid,string duns_number,string cnp_name_bow_left  ,string cnp_name_bow_right,integer cnp_match_score}
    ds_lgid3_explodes_example   := ds_find_candidates_lgid3_prep (lgid3  = pLgid3_example);//{unsigned6 lgid3 ,string duns_number,string cnp_name_bow_left  ,string cnp_name_bow_right,integer cnp_match_score}
                               // {pID,active_domestic_corp_key,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score}
    
    // -- proxid explodes removed because of corpkey link
    ds_proxid_explodes_removed_example := ds_find_candidates_proxid_prep2_inner(proxid = pLgid3_example);
    ds_lgid3_explodes_removed_example  := ds_find_candidates_lgid3_prep2_inner (lgid3  = pLgid3_example);
    
    // -- query the corpkey removes to see if the id is in there at all
    ds_corpkey_overrides_proxid_example := ds_corpkey_overrides_proxid(proxid = pLgid3_example);
    ds_corpkey_overrides_lgid3_example  := ds_corpkey_overrides_lgid3 (lgid3  = pLgid3_example);
    
    // -- output debug
    output_debug := if(pDebug_Outputs = true
    ,parallel(
      if(pDoStrata = true,parallel(
         Strata_explode_stats
        ,output(records_affected_total ,,'~thor_data400::BIPV2_Tools.SetDuns::' + pversion + '::records_affected_total' ,compressed,overwrite)
        ,output(ds_find_candidates_prep               ,,'~thor_data400::BIPV2_Tools.SetDuns::' + pversion + '::proxid_explodes'         ,compressed,overwrite)
        ,output(ds_find_candidates_lgid3_prep         ,,'~thor_data400::BIPV2_Tools.SetDuns::' + pversion + '::lgid3_explodes'          ,compressed,overwrite)
        ,output(ds_find_candidates_proxid_prep2_inner ,,'~thor_data400::BIPV2_Tools.SetDuns::' + pversion + '::proxid_explodes_removed' ,compressed,overwrite)
        ,output(ds_find_candidates_lgid3_prep2_inner  ,,'~thor_data400::BIPV2_Tools.SetDuns::' + pversion + '::lgid3_explodes_removed'  ,compressed,overwrite)
      ))
     ,output(ds_strata  ,named('ds_strata'),extend)
     ,if(pLgid3_example != 0  ,parallel(
        output(topn(ds_proxid_explodes_example          ,500  ,proxid,duns_number,cnp_name_bow_left) ,named('ds_proxid_explodes_example'),all)
       ,output(topn(ds_lgid3_explodes_example           ,500  ,lgid3 ,duns_number,cnp_name_bow_left) ,named('ds_lgid3_explodes_example' ),all)
       ,output(topn(ds_corpkey_overrides_proxid_example  ,500  ,proxid,active_domestic_corp_key,cnp_name_bow_left) ,named('ds_corpkey_overrides_proxid_example'),all)
       ,output(topn(ds_corpkey_overrides_lgid3_example   ,500  ,lgid3 ,active_domestic_corp_key,cnp_name_bow_left) ,named('ds_corpkey_overrides_lgid3_example'  ),all)
       ,output(topn(ds_proxid_explodes_removed_example  ,500  ,proxid,duns_number,active_domestic_corp_key,cnp_name_bow_left) ,named('ds_proxid_explodes_removed_example'),all)
       ,output(topn(ds_lgid3_explodes_removed_example   ,500  ,lgid3 ,duns_number,active_domestic_corp_key,cnp_name_bow_left) ,named('ds_lgid3_explodes_removed_example' ),all)
     ))
     // ,output(topn(fslim(ds_result_lgid3_full  (regexfind('^OLD HEIDELBERG PASTRY SHOP$',trim(cnp_name),nocase))),800,lgid3_old,lgid3,proxid,dotid) ,named('ds_result_lgid3' ),all)
     // ,output(topn(fslim(ds_result_proxid_full (regexfind('^OLD HEIDELBERG PASTRY SHOP$',trim(cnp_name),nocase))),800,lgid3_old,lgid3,proxid,dotid) ,named('ds_result_proxid'),all)
     // ,output(topn(fslim(ds_result             (regexfind('^OLD HEIDELBERG PASTRY SHOP$',trim(cnp_name),nocase))),800,lgid3_old,lgid3,proxid,dotid) ,named('ds_result'       ),all)
     ,output(choosen(ds_cand_iter5,300)  ,named('ds_cand_iter5'+ pPersistUnique),all)
     ,output(topn(ds_result_specific_example,800,lgid3_old,lgid3,proxid_old,proxid) ,named('Example_From_Bug'      + pPersistUnique),all)
     ,output(topn(ds_result_lgid3_examples  ,800,lgid3_old,lgid3,proxid_old,proxid) ,named('Example_Lgid3_Changes' + pPersistUnique),all)
     ,output(topn(ds_result_proxid_examples ,800,lgid3_old,lgid3,proxid_old,proxid) ,named('Example_Proxid_Changes'+ pPersistUnique),all)
     ,output(topn(ds_changes_lgid3,800,lgid3_old,lgid3) ,named('ds_changes_lgid3'       + pPersistUnique),all)
     ,output(topn(ds_changes_proxid,800,lgid3_old,lgid3,proxid_old,proxid) ,named('ds_changes_proxid'       + pPersistUnique),all)
     ,output(topn(ds_changes,800,lgid3_old,lgid3,proxid_old,proxid) ,named('ds_changes'       + pPersistUnique),all)
     ,output(topn(ds_changes_lgid3_dups         ,800,-cnt,lgid3_old,proxid) ,named('ds_changes_lgid3_dups'                + pPersistUnique),all)
     ,output(topn(ds_changes_lgid3_dups_examples,800,-cnt,lgid3_old,lgid3,proxid) ,named('ds_changes_lgid3_dups_examples'       + pPersistUnique),all)
     ,output(topn(ds_changes_proxid_dups         ,800,-cnt,lgid3_old,proxid_old) ,named('ds_changes_proxid_dups'               + pPersistUnique ),all)
     ,output(topn(ds_changes_proxid_dups_examples,800,-cnt,lgid3_old,lgid3,proxid_old,proxid) ,named('ds_changes_proxid_dups_examples'     + pPersistUnique  ),all)
     ,output(topn(ds_changes_dups         ,800,-cnt,lgid3_old,proxid_old,cnp_name) ,named('ds_changes_dups'             + pPersistUnique   ),all)
     ,output(topn(ds_changes_dups_examples,800,-cnt,lgid3_old,lgid3,proxid_old,proxid) ,named('ds_changes_dups_examples'   + pPersistUnique    ),all)
     // ,output(count(ds_in                    )  ,named('count_ds_in'                    + pPersistUnique))
     // ,output(count(ds_blank_duns            )  ,named('count_ds_blank_duns'            + pPersistUnique))
     // ,output(count(ds_nonblank_duns         )  ,named('count_ds_nonblank_duns'         + pPersistUnique))
     // ,output(count(ds_refresh_duns          )  ,named('count_ds_refresh_duns'          + pPersistUnique))
     // ,output(count(ds_to_explode            )  ,named('count_ds_to_explode'            + pPersistUnique))
     // ,output(count(ds_not_explode           )  ,named('count_ds_not_explode'           + pPersistUnique))
     // ,output(count(ds_to_explode_proxids    )  ,named('count_ds_to_explode_proxids'    + pPersistUnique))
     // ,output(count(ds_concat                )  ,named('count_ds_concat'                + pPersistUnique))
     // ,output(count(ds_concat_with_proxid    )  ,named('count_ds_concat_with_proxid'    + pPersistUnique))
     // ,output(count(ds_concat_without_proxid )  ,named('count_ds_concat_without_proxid' + pPersistUnique))
     // ,output(count(ds_get_all_explode_recs  )  ,named('count_ds_get_all_explode_recs'  + pPersistUnique))
     // ,output(count(ds_get_rest_recs         )  ,named('count_ds_get_rest_recs'         + pPersistUnique))
     // ,output(count(ds_explode_get_bow       )  ,named('count_ds_explode_get_bow'       + pPersistUnique))
     // ,output(count(ds_find_candidates       )  ,named('count_ds_find_candidates'       + pPersistUnique))
     // ,output(count(ds_non_candidates        )  ,named('count_ds_non_candidates'        + pPersistUnique))
     
     // ,output(count(ds_candidates1           )  ,named('count_ds_candidates1'           + pPersistUnique))
     // ,output(count(ds_cand_table1           )  ,named('count_ds_cand_table1'           + pPersistUnique))
     // ,output(count(ds_cand_iter1            )  ,named('count_ds_cand_iter1'            + pPersistUnique))
     // ,output(count(ds_cand_table2           )  ,named('count_ds_cand_table2'           + pPersistUnique))
     // ,output(count(ds_reset_candidates            )  ,named('count_ds_reset_candidates'            + pPersistUnique))
     
     // ,output(count(ds_result                )  ,named('count_ds_result'                + pPersistUnique))
     // ,output(count_proxids_in                  ,named('count_proxids_in'               + pPersistUnique))
     // ,output(count_proxids_out                 ,named('count_proxids_out'              + pPersistUnique))
     // ,output(count_diff_proxid                 ,named('count_diff'                     + pPersistUnique))
     // ,output(pct_change_proxid                 ,named('pct_change'                     + pPersistUnique))
     // ,output(count(blank_proxid_recs_in     )  ,named('count_blank_proxid_recs_in'     + pPersistUnique))
     // ,output(count(blank_proxid_recs_out    )  ,named('count_blank_proxid_recs_out'    + pPersistUnique))
     
     // ,output(choosen(ds_in                    ,800)  ,named('choosen_ds_in'                    + pPersistUnique),all)
     // ,output(choosen(ds_blank_duns            ,800)  ,named('choosen_ds_blank_duns'            + pPersistUnique),all)
     // ,output(choosen(ds_nonblank_duns         ,800)  ,named('choosen_ds_nonblank_duns'         + pPersistUnique),all)
     // ,output(choosen(ds_refresh_duns          ,800)  ,named('choosen_ds_refresh_duns'          + pPersistUnique),all)
     // ,output(choosen(ds_to_explode            ,800)  ,named('choosen_ds_to_explode'            + pPersistUnique),all)
     // ,output(choosen(ds_not_explode           ,800)  ,named('choosen_ds_not_explode'           + pPersistUnique),all)
     // ,output(choosen(ds_to_explode_proxids    ,800)  ,named('choosen_ds_to_explode_proxids'    + pPersistUnique),all)
     // ,output(choosen(ds_concat                ,800)  ,named('choosen_ds_concat'                + pPersistUnique),all)
     // ,output(choosen(ds_concat_with_proxid    ,800)  ,named('choosen_ds_concat_with_proxid'    + pPersistUnique),all)
     // ,output(choosen(ds_concat_without_proxid ,800)  ,named('choosen_ds_concat_without_proxid' + pPersistUnique),all)
     // ,output(choosen(ds_get_all_explode_recs  ,800)  ,named('choosen_ds_get_all_explode_recs'  + pPersistUnique),all)
     // ,output(choosen(ds_get_rest_recs         ,800)  ,named('choosen_ds_get_rest_recs'         + pPersistUnique),all)
     // ,output(choosen(ds_explode_get_bow       ,800)  ,named('choosen_ds_explode_get_bow'       + pPersistUnique),all)
     // ,output(choosen(ds_find_candidates       ,800)  ,named('choosen_ds_find_candidates'       + pPersistUnique),all)
     // ,output(choosen(ds_non_candidates        ,800)  ,named('choosen_ds_non_candidates'        + pPersistUnique),all)
     // ,output(choosen(ds_candidates1           ,800)  ,named('choosen_ds_candidates1'           + pPersistUnique),all)
     // ,output(choosen(ds_cand_table1           ,800)  ,named('choosen_ds_cand_table1'           + pPersistUnique),all)
     // ,output(choosen(ds_cand_iter1            ,800)  ,named('choosen_ds_cand_iter1'            + pPersistUnique),all)
     // ,output(choosen(ds_cand_table2           ,800)  ,named('choosen_ds_cand_table2'           + pPersistUnique),all)
     // ,output(choosen(ds_reset_candidates            ,800)  ,named('choosen_ds_reset_candidates'            + pPersistUnique),all)
     // ,output(choosen(ds_result                ,800)  ,named('choosen_ds_result'                + pPersistUnique),all)
     // ,output(choosen(blank_proxid_recs_in     ,800)  ,named('choosen_blank_proxid_recs_in'     + pPersistUnique),all)
     // ,output(choosen(blank_proxid_recs_out    ,800)  ,named('choosen_blank_proxid_recs_out'    + pPersistUnique),all)
    
    ));
      
		return when(ds_result,output_debug);
    
	end;
