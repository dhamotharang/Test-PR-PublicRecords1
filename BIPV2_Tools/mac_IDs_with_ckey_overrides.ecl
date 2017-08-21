EXPORT mac_IDs_with_ckey_overrides( 

   pDs_Full_File
  ,pID                      //'proxid' or 'lgid3'
  ,pPersistRoot   = '\'~persist::BIPV2_Files.tools_dotid.\''
  ,pPersistUnique = '\'\''

) :=
functionmacro

  ds_concat_pre_slim_ckey := table(pDs_Full_File ,{pID,cnp_name,active_domestic_corp_key},pID,cnp_name,active_domestic_corp_key,merge)
    : persist(pPersistRoot + 'ds_concat_pre_slim_ckey'+ pPersistUnique);
  // -- we care about: pID,cnp_name,active_domestic_corp_key
  ds_refresh_corpkey_slim := table(pDs_Full_File(active_domestic_corp_key != '') ,{pID,cnp_name,active_domestic_corp_key},pID,cnp_name,active_domestic_corp_key,merge)
    : persist(pPersistRoot + 'ds_refresh_corpkey_slim'+ pPersistUnique);
  // -----------------------------------------------------------------------------------------
  // -- Explode pIDs First to proxid for offending clusters.  Save old pID for use later
  // -----------------------------------------------------------------------------------------
  ds_to_explode_pID_ckey     := ds_refresh_corpkey_slim(pID != 0  );
  ds_to_explode_pIDs_ckey    := table(ds_to_explode_pID_ckey  ,{pID},pID,merge) : persist(pPersistRoot + 'ds_to_explode_pIDs_ckey'+ pPersistUnique);
      
  ds_concat_with_pID_ckey          := ds_concat_pre_slim_ckey(pID != 0); 
  ds_get_all_explode_recs_pID_ckey := join(ds_concat_with_pID_ckey ,ds_to_explode_pIDs_ckey  ,left.pID = right.pID ,transform(left),hash)            : persist(pPersistRoot + 'ds_get_all_explode_recs_pID_ckey'+ pPersistUnique);
  import BIPV2_ProxID,salt30;
  key_cnp_name_pID_ckey := BIPV2_ProxID.specificities(BIPV2_ProxID.In_DOT_Base).cnp_name_values_index;
  ds_explode_get_bow_pID_ckey := join(ds_get_all_explode_recs_pID_ckey  ,key_cnp_name_pID_ckey, left.cnp_name = right.cnp_name ,transform({string cnp_name_bow,real field_specificity,recordof(left)}
    ,self.cnp_name_bow      := right.word
    ,self.field_specificity := right.field_specificity
    ,self                   := left
  ),left outer,hash);
  ds_find_candidates_pID_ckey := table(join(
                             table(ds_explode_get_bow_pID_ckey(active_domestic_corp_key != '') ,{pID,active_domestic_corp_key,cnp_name_bow,field_specificity},pID,active_domestic_corp_key,cnp_name_bow,field_specificity,merge)
                            ,table(ds_explode_get_bow_pID_ckey(active_domestic_corp_key != '') ,{pID,active_domestic_corp_key,cnp_name_bow,field_specificity},pID,active_domestic_corp_key,cnp_name_bow,field_specificity,merge)
                            ,left.pID = right.pID and left.active_domestic_corp_key = right.active_domestic_corp_key and left.cnp_name_bow != '' and right.cnp_name_bow != '' and left.cnp_name_bow != right.cnp_name_bow 
                              and (     SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1) < BIPV2_ProxID.Config.cnp_name_Force * 100  //use cnp_name for a little fuzzy here
                                    or(      SALT30.HyphenMatch(left.cnp_name_bow,right.cnp_name_bow,1)<=1 
                                        and (MIN(left.field_specificity,right.field_specificity) * 100  < BIPV2_ProxID.Config.cnp_name_Force * 100)
                                    )
                                  )
                            ,transform({unsigned6 pID,string active_domestic_corp_key,string cnp_name_bow_left  ,string cnp_name_bow_right,integer cnp_match_score}
                            ,self.cnp_name_bow_left   := if(left.cnp_name_bow  > right.cnp_name_bow  ,left.cnp_name_bow  ,right.cnp_name_bow)
                            ,self.cnp_name_bow_right  := if(left.cnp_name_bow  > right.cnp_name_bow  ,right.cnp_name_bow ,left.cnp_name_bow )
                            ,self.cnp_match_score     := SALT30.MatchBagOfWords(left.cnp_name_bow,right.cnp_name_bow,46614,1)
                            ,self := right),hash)
                          ,{pID,active_domestic_corp_key,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score},pID,active_domestic_corp_key,cnp_name_bow_left,cnp_name_bow_right,cnp_match_score,merge)  : persist(pPersistRoot + 'ds_find_candidates_pID_ckey'+ pPersistUnique);
  
  return ds_find_candidates_pID_ckey;
  
endmacro;