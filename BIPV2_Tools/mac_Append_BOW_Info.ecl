export mac_Append_BOW_Info(

   pID                      = 'proxid'
  ,pDataset                 = 'bipv2.CommonBase.ds_base'
  ,pBOW_field               = 'cnp_name'
  ,pBOW_Index               = 'BIPV2_proxid.specificities(BIPV2_proxid.In_DOT_Base).cnp_name_values_index'
  ,pBOW_Function            = 'SALT37.MatchBagOfWords'
  ,pBOW_Mode                = '46614'
  ,pBOW_Score_Mode          = '1'
  ,pHyphen_Match_function   = 'SALT37.HyphenMatch'
  ,pHyphen_Match_min_len    = '1'
  ,pName_Force              = 'BIPV2_ProxID.Config.cnp_name_Force'

) := 
functionmacro

    // -- get annotated cnp_name field from proxid cnp_names key to prep for BOW scoring
    import BIPV2_ProxID,salt37;
    
    // -- only care about records with a cluster id on them.
    ds_has_ID := pDataset(pID != 0)  : persist('~persist::BIPV2_Tools::mac_Append_BOW_Info::ds_has_ID.' + #TEXT(pID));
    
    ds_slim := table(ds_has_ID ,{pID,duns_number,deleted_key,prev_deleted_duns,cnp_name},pID,duns_number,deleted_key,prev_deleted_duns,cnp_name,merge);
    
    ds_append_bow_field := join(ds_slim  ,pBOW_Index, left.cnp_name = right.cnp_name ,transform({string cnp_name_bow,real field_specificity,recordof(left)}
      ,self.cnp_name_bow      := if(right.word != '' ,(unsigned)(right.field_specificity * 100) +' '+ trim(right.word)  ,'')
      ,self.field_specificity := right.field_specificity
      ,self                   := left
    ),left outer,hash);
    
    ds_not_deleted_duns := ds_append_bow_field(deleted_key   = '' and duns_number       != ''    );
    ds_old_deleted_duns := ds_append_bow_field(deleted_key  != '' and prev_deleted_duns != ''    );
    ds_deleted_duns     := ds_append_bow_field(deleted_key  != '' and prev_deleted_duns  = ''    );
    
    // -- to be considered for explosion, the record must match a non-deleted record with a different cnp_name.  So inner join
    ds_BOW_join := join(
                               table(ds_not_deleted_duns ,{pID,duns_number,cnp_name,cnp_name_bow,field_specificity},pID,duns_number,cnp_name,cnp_name_bow,field_specificity,merge)
                              ,table(ds_deleted_duns     ,{pID,duns_number,cnp_name,cnp_name_bow,field_specificity},pID,duns_number,cnp_name,cnp_name_bow,field_specificity,merge)
                              ,left.pID = right.pID and left.duns_number = right.duns_number and left.cnp_name_bow != '' and right.cnp_name_bow != '' and left.cnp_name != right.cnp_name //not a self join so need to do this to get everything
                              ,transform(
                                {unsigned6 pID,string duns_number,string cnp_name_left  ,string cnp_name_right,string cnp_name_bow_left  ,string cnp_name_bow_right,integer4 cnp_match_score,integer4   min_specificity  ,UNSIGNED4  hyphenmatch_score    ,real field_specificity_left,real field_specificity_right}
                                  ,self.cnp_name_left           := if(left.cnp_name < right.cnp_name  ,left.cnp_name          ,right.cnp_name         )
                                  ,self.cnp_name_right          := if(left.cnp_name < right.cnp_name  ,right.cnp_name         ,left.cnp_name          )
                                  ,self.cnp_name_bow_left       := if(left.cnp_name < right.cnp_name  ,left.cnp_name_bow      ,right.cnp_name_bow     )
                                  ,self.cnp_name_bow_right      := if(left.cnp_name < right.cnp_name  ,right.cnp_name_bow     ,left.cnp_name_bow      ) 
                                  ,self.field_specificity_left  := if(left.cnp_name < right.cnp_name  ,left.field_specificity ,right.field_specificity)
                                  ,self.field_specificity_right := if(left.cnp_name < right.cnp_name  ,right.field_specificity,left.field_specificity )
                                  ,self                         := right
                                  ,self                         := []
                              ),hash);
    
    ds_BOW_dedup := table(ds_BOW_join ,{pID,duns_number,cnp_name_left,cnp_name_right,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score,min_specificity,hyphenmatch_score,field_specificity_left,field_specificity_right}
                                       ,pID,duns_number,cnp_name_left,cnp_name_right,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score,min_specificity,hyphenmatch_score,field_specificity_left,field_specificity_right,merge); 
                    
    // -- distribute evenly and then do the heavy lifting of BOW and hyphen match functions to speed it up                
    ds_calc_bow_scores := project(distribute(ds_BOW_dedup) ,transform(
      {recordof(left),boolean is_good_bow_match,boolean is_good_hyphen_match,boolean isoverall_match}
     ,self.cnp_match_score             := pBOW_Function         (trim(left.cnp_name_bow_left),trim(left.cnp_name_bow_right) ,pBOW_Mode,pBOW_Score_Mode)
     ,self.hyphenmatch_score           := pHyphen_Match_function(trim(left.cnp_name_bow_left),trim(left.cnp_name_bow_right) ,pHyphen_Match_min_len    )
     ,self.min_specificity             := (integer4)(MIN(left.field_specificity_left,left.field_specificity_right) * 100)
     ,self.is_good_bow_match           := self.cnp_match_score >= pName_Force * 100
     ,self.is_good_hyphen_match        :=     self.hyphenmatch_score <= 1 
                                          and self.min_specificity   >= pName_Force * 100
     ,self.isoverall_match             := self.is_good_bow_match or self.is_good_hyphen_match
     ,self                             := left
    ));

    // -- remove ones that match since those will come back together in linking
    ds_calc_bow_scores_non_match := ds_calc_bow_scores(isoverall_match = false);    

    // -- Stats for this
    ds_stats := dataset([
       {#TEXT(pID),'Input'                                            ,count(pDataset                                     ) ,count(table(pDataset                                     ,{pID},pID,merge))}
      ,{#TEXT(pID),'ds_has_ID'                                        ,count(ds_has_ID                                    ) ,0                                                                          }
      ,{#TEXT(pID),'ds_slim'                                          ,count(ds_slim                                      ) ,count(table(ds_slim                                      ,{pID},pID,merge))}
      ,{#TEXT(pID),'ds_not_deleted_duns'                              ,count(ds_not_deleted_duns                          ) ,count(table(ds_not_deleted_duns                          ,{pID},pID,merge))}
      ,{#TEXT(pID),'ds_old_deleted_duns'                              ,count(ds_old_deleted_duns                          ) ,count(table(ds_old_deleted_duns                          ,{pID},pID,merge))}
      ,{#TEXT(pID),'ds_new_deleted_duns'                              ,count(ds_deleted_duns                              ) ,count(table(ds_deleted_duns                              ,{pID},pID,merge))}
      ,{#TEXT(pID),'ds_BOW_join'                                      ,count(ds_BOW_join                                  ) ,count(table(ds_BOW_join                                  ,{pID},pID,merge))}
      ,{#TEXT(pID),'ds_BOW_dedup'                                     ,count(ds_BOW_dedup                                 ) ,count(table(ds_BOW_dedup                                 ,{pID},pID,merge))}
      ,{#TEXT(pID),'Output'                                           ,count(ds_calc_bow_scores                           ) ,count(table(ds_calc_bow_scores                           ,{pID},pID,merge))}
      ,{#TEXT(pID),'Output no match(still considered for explosion)'  ,count(ds_calc_bow_scores_non_match                 ) ,count(table(ds_calc_bow_scores_non_match                 ,{pID},pID,merge))}
     
    ],{string ID  ,string file  ,unsigned cnt_records ,unsigned cnt_clusters });
    
  return when(ds_calc_bow_scores,output(ds_stats  ,named('Stats_mac_Append_BOW_Info'),extend,all));

endmacro;