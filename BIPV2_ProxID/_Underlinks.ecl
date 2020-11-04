// BIPV2_ProxID._Underlinks();

// -- Designed to let you know where the underlinks are lurking
// -- tries to do a sloppy match on address for the singleton proxids 
// -- filters out the high dup addresses, > 1000 to prevent skews
// -- this is designed to run after an iteration, assuming that the candidates, specificities and attribute file keys already exist(and are passed into the macro).  it will not rebuild them

// -- Default Filter for only those matches that have either a cnp_name match, corpkey, duns or fein match.  Change pMatchRegex to play with this to see different possible underlinks
 
IMPORT SALT37,std,tools,BIPV2_Build;
EXPORT _Underlinks(
   pversion         = 'BIPV2.KeySuffix'
  ,pih              = 'BIPV2_ProxID.In_DOT_Base'                                                              // -- Input file for Iteration
  ,pKeyCandidates   = 'BIPV2_ProxID.Keys(,\'built\').candidates'                                              // -- Match Candidates Key
  ,pKeySpecs        = 'BIPV2_ProxID.Keys(,\'built\').Specificities_Key'                                       // -- Specificities Key
  ,pKeyAttMatches   = 'BIPV2_ProxID.Keys(,\'built\').Attribute_Matches'                                       // -- Attribute Matches Key
  ,MatchThreshold   = 'BIPV2_ProxID.Config.MatchThreshold'                                                    // -- Threshold for Internal Linking
  ,pMatchRegex      = '\'([|]cnp_name|[|]active_domestic_corp_key|[|]active_duns_number|[|]company_fein)\''   // -- Regex to filter the match summary field.  blank will allow all types of matches.  by default we make sure at least cnp_name, active corpkey, active duns or fein matches
  ,pJustSingletons  = 'true'                                                                                  // -- if true, then will only look at underlinks from singletons.  if false, it will try to find underlinks throughout the whole file(this takes a lot longer....)
  ,pEmail           = 'BIPV2_Build.mod_email.emailList' // -- if blank, will not email

) := 
functionmacro

  import ut,BIPV2_Build,tools,BIPV2_Tools;
  
  // -- get MC key and input file ready
  ih        := pih;
  lay_cand  := BIPV2_ProxID.match_candidates(ih).layout_candidates;
  ds_mc     := project(pKeyCandidates ,transform(lay_cand,self := left,self := []));

  // -- find rejected records
  ds_rejected_records   := BIPV2_ProxID.Specificities(ih).Rejected_file;
  
  // -- find unlinkable records
  // TotalWeight is from BIPV2_ProxID.match_candidates
  TotalWeight := ds_mc.sbfe_id_weight100 + ds_mc.company_charter_number_weight100 + ds_mc.active_enterprise_number_weight100 + ds_mc.hist_enterprise_number_weight100 + ds_mc.ebr_file_number_weight100 + ds_mc.hist_corp_key_weight100 + ds_mc.active_duns_number_weight100 + ds_mc.hist_duns_number_weight100 + ds_mc.company_phone_weight100 + ds_mc.company_address_weight100 + ds_mc.company_fein_weight100 + ds_mc.cnp_number_weight100 + ds_mc.cnp_name_phonetic_weight100 + ds_mc.cnp_name_weight100 + ds_mc.company_inc_state_weight100 + ds_mc.cnp_btype_weight100 + ds_mc.company_name_type_derived_weight100;
  ds_unlinkable_records := ds_mc(~(TotalWeight >= MatchThreshold));
  // ds_unlinkable_records := BIPV2_ProxID.match_candidates(ih).Unlinkables;~Linkable

  // -- find singleton proxids
  ds_base_table       := table(ih ,{proxid  ,unsigned cnt := count(group)} ,proxid ,merge) : persist('~persist::BIPV2_ProxID::_Underlinks::ds_base_table');
  ds_base_singletons  := ds_base_table(cnt = 1);

  // -- Singletons in whole file(not just match candidates)
  ds_base_singletons_recs := join(ih  ,ds_base_singletons ,left.proxid = right.proxid ,transform(left)  ,hash) : persist('~persist::BIPV2_ProxID::_Underlinks::ds_base_singletons_recs');

  // -- get singletons in mc
  ds_mc_add_cnts := join(ds_mc  ,ds_base_table ,left.proxid = right.proxid ,transform({string cluster_type,recordof(left)},self.cluster_type := if(right.cnt = 1  ,'Singleton' ,'Non-Singleton')  ,self := left)  ,hash) : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_add_cnts');

  ds_mc_singletons    := ds_mc_add_cnts(trim(cluster_type) = 'Singleton'    );
  ds_mc_nonsingletons := ds_mc_add_cnts(trim(cluster_type) = 'Non-Singleton');

  ds_rejected_singletons   := join(ds_base_singletons_recs ,table(ds_rejected_records  ,{proxid},proxid,merge)  ,left.proxid = right.proxid  ,transform(left),hash);
  ds_unlinkable_singletons := join(ds_base_singletons_recs ,table(ds_unlinkable_records,{proxid},proxid,merge)  ,left.proxid = right.proxid  ,transform(left),hash);
  ds_unlinkable_or_rejected_singletons := join(ds_base_singletons_recs ,table(ds_rejected_singletons + ds_unlinkable_singletons,{proxid},proxid,merge)  ,left.proxid = right.proxid  ,transform(left),hash);
  
  // -- get counts of recs per proxid in mc
  ds_mc_table_prep      := table(ds_mc             ,{proxid,prim_range,prim_name,v_city_name,st,zip                               } ,proxid ,prim_range,prim_name,v_city_name,st,zip ,merge)  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_table_prep');
  ds_mc_table           := table(ds_mc_table_prep  ,{       prim_range,prim_name,v_city_name,st,zip  ,unsigned cnt := count(group)}         ,prim_range,prim_name,v_city_name,st,zip ,merge)  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_table');
  ds_mc_table_under1000 := ds_mc_table(cnt <  1000);
  ds_mc_table_over1000  := ds_mc_table(cnt >= 1000);

  // -- join back to mc to get full record for matching
  ds_mc_under1000 := join(ds_mc_add_cnts ,ds_mc_table_under1000  ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip ,transform(left)  ,hash)   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_under1000');
  ds_mc_over1000  := join(ds_mc_add_cnts ,ds_mc_table_over1000   ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip ,transform(left)  ,hash)   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_over1000' );

  // -- setup up over 1000 dataset for join
  ds_mc_over1000_prep   := sort(ds_mc_over1000  ,prim_range,prim_name,v_city_name,st,zip);
  ds_mc_singletons_prep := sort(ds_mc_singletons,prim_range,prim_name,v_city_name,st,zip);

  // -- do joins

  // -- look at max number of matches we could possibly get.  match singletons on address to other clusters
  // -- to get an idea of that upper bound

  ds_mc_under1000_table    := table(ds_mc_under1000     ,{proxid ,cluster_type ,prim_range,prim_name,v_city_name,st,zip} ,proxid ,cluster_type ,prim_range,prim_name,v_city_name,st,zip ,merge);

  ds_mc_singletons_table    := table(ds_mc_singletons    ,{proxid ,cluster_type ,prim_range,prim_name,v_city_name,st,zip} ,proxid ,cluster_type ,prim_range,prim_name,v_city_name,st,zip ,merge);
  ds_mc_nonsingletons_table := table(ds_mc_nonsingletons ,{unsigned6 proxid := min(group,proxid),cluster_type ,prim_range,prim_name,v_city_name,st,zip} ,cluster_type ,prim_range,prim_name,v_city_name,st,zip ,merge);
  ds_mc_proxid_table        := table(ds_mc_add_cnts      ,{proxid ,cluster_type ,prim_range,prim_name,v_city_name,st,zip} ,proxid ,cluster_type ,prim_range,prim_name,v_city_name,st,zip ,merge);
  
  lay_child := {recordof(ds_mc_under1000_table)};

  ds_mc_address_matches_table_prep := 
      ds_mc_singletons_table     
    + ds_mc_nonsingletons_table  
    ;
  
  ds_mc_address_matches_table_cnts := table(ds_mc_address_matches_table_prep  ,{prim_range,prim_name,v_city_name,st,zip 
    ,unsigned cnt := count(group)
    ,unsigned cnt_singletons    := sum(group ,if(trim(cluster_type) = 'Singleton'       ,1,0))
    ,unsigned cnt_nonsingletons := sum(group ,if(trim(cluster_type) = 'Non-Singleton'   ,1,0))
  }  ,prim_range,prim_name,v_city_name,st,zip  ,merge)
  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_address_matches_table_cnts');
  
  // -- count singletons that match another cluster/do not match another cluster
  count_singletons_that_do_not_match_another_cluster := sum(ds_mc_address_matches_table_cnts( cnt_singletons = 1 and cnt_nonsingletons = 0                        ) ,cnt_singletons);
  count_singletons_that_do_match_another_cluster     := sum(ds_mc_address_matches_table_cnts((cnt_singletons = 1 and cnt_nonsingletons > 0) or cnt_singletons > 1 ) ,cnt_singletons);  
  
  // -- DON'T do over 1000 join because it takes way too long and doesn't add much 
  // ds_over1000_join  := join(ds_mc_singletons_prep  ,ds_mc_over1000  ,left.proxid != right.proxid and left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip 
    // ,transform({unsigned6 proxid1, unsigned6 proxid2  ,dataset(lay_child) recs},self.proxid1 := left.proxid,self.proxid2 := right.proxid,self.recs := dataset(left) + dataset(right)) 
    // ,hash,keep(50)) : persist('~persist::BIPV2_ProxID::_Underlinks::ds_over1000_join');
    
   // -- Prep match candidates for join, dedup a little to speed up join.  Don't care too much about dates, so remove them from dedup criteria
   ds_mc_table1       := project    (ds_mc             ,transform(recordof(left),self := left));
   ds_mc_table_dist   := distribute (ds_mc_table1      ,hash(proxid,SALT_Partition));
   ds_mc_table_sort   := sort       (ds_mc_table_dist  ,proxid,record,except rcid,dt_first_seen,dt_last_seen,local);
   ds_mc_table_dedup  := dedup      (ds_mc_table_sort  ,proxid,record,except rcid,dt_first_seen,dt_last_seen,local)
     : persist('~persist::BIPV2_ProxID::_Underlinks::ds_mc_table_dedup');

  // -- Join to get all potential matches. Takes awhile
  ds_under1000_join  := join(
#IF(pJustSingletons = true)   
   ds_mc_singletons_table  
  ,ds_mc_under1000_table  ,left.proxid != right.proxid
#ELSE
   ds_mc_under1000_table
  ,ds_mc_under1000_table  ,left.proxid > right.proxid
#END
   and left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip 
    ,transform({unsigned6 proxid1, unsigned6 proxid2  ,dataset(lay_child) recs},self.proxid1 := left.proxid,self.proxid2 := right.proxid,self.recs := dataset(left) + dataset(right))  
    ,keep(100)
    ,hash)  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_under1000_join');
    
  // -- distribute evenly
  ds_concat := distribute(/*ds_over1000_join + */ds_under1000_join)  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_concat');

  key_spec        := pKeySpecs;
  s               := project(key_spec ,transform(BIPV2_ProxID.Layout_Specificities.R,self := left,self := []))[1];

  key_att         := pKeyAttMatches;
  ds_att          := project(key_att ,BIPV2_ProxID.Match_Candidates(ih).layout_attribute_matches);

  annotate_matches := BIPV2_ProxID.debug(ih,s,MatchThreshold).AnnotateMatchesFromData;
  layout_matches   := BIPV2_ProxID.match_candidates(ih).layout_matches;

  // -- dedup and prep to annotate those matches(Score them) using the Debug attribute
  ds_prep_matches1 := table(ds_concat  ,{proxid1,proxid2} ,proxid1,proxid2 ,merge);
  ds_prep_matches2 := project(ds_prep_matches1  ,transform(layout_matches ,self.proxid1 := left.proxid1,self.proxid2 := left.proxid2  ,self := []))   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_prep_matches2');

  cnt_prep_matches := count(ds_prep_matches2);
  quarter_slice    := (unsigned)((cnt_prep_matches / 4) + 1);
  
  ds_prep_matches_to_annotate1 := choosen(ds_prep_matches2  ,quarter_slice  ,1                      );
  ds_prep_matches_to_annotate2 := choosen(ds_prep_matches2  ,quarter_slice  , quarter_slice      + 1);
  ds_prep_matches_to_annotate3 := choosen(ds_prep_matches2  ,quarter_slice  ,(quarter_slice * 2) + 1);
  ds_prep_matches_to_annotate4 := choosen(ds_prep_matches2  ,quarter_slice  ,(quarter_slice * 3) + 1);

  // -- Annotate the matches in 4 batches.
  ds_match_join1 := annotate_matches(ds_mc_table_dedup ,ds_prep_matches_to_annotate1 ,ds_att)   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_match_join1');
  ds_match_join2 := annotate_matches(ds_mc_table_dedup ,ds_prep_matches_to_annotate2 ,ds_att)   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_match_join2');
  ds_match_join3 := annotate_matches(ds_mc_table_dedup ,ds_prep_matches_to_annotate3 ,ds_att)   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_match_join3');
  ds_match_join4 := annotate_matches(ds_mc_table_dedup ,ds_prep_matches_to_annotate4 ,ds_att)   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_match_join4');

  // -- Dedup those annotated matches, keeping the best scoring ones per Proxid1
  ds_match_join_dedup1 := dedup(sort(
    ds_match_join1
  + ds_match_join2
  + ds_match_join3
  + ds_match_join4
  ,proxid1,-(integer)conf,proxid2,local)
  ,proxid1,local);

  ds_match_join := dedup(sort(distribute(ds_match_join_dedup1,hash(proxid1)) ,proxid1,-(integer)conf,proxid2,local)  ,proxid1,local)
   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_match_join');
  
  // -- Add summary string of the fields that matched and mismatched
  lay_summary := RECORD
    ds_match_join;
    SALT37.StrType Summary;
  END;
  lay_summary tosummary(ds_match_join le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.prim_range_derived_Score = 0,'','|'+IF(le.prim_range_derived_Score < 0,'-','')+'prim_range_derived')+IF(le.sbfe_id_Score = 0,'','|'+IF(le.sbfe_id_Score < 0,'-','')+'sbfe_id')+IF(le.company_charter_number_Score = 0,'','|'+IF(le.company_charter_number_Score < 0,'-','')+'company_charter_number')+IF(le.hist_enterprise_number_Score = 0,'','|'+IF(le.hist_enterprise_number_Score < 0,'-','')+'hist_enterprise_number')+IF(le.ebr_file_number_Score = 0,'','|'+IF(le.ebr_file_number_Score < 0,'-','')+'ebr_file_number')+IF(le.active_enterprise_number_Score = 0,'','|'+IF(le.active_enterprise_number_Score < 0,'-','')+'active_enterprise_number')+IF(le.hist_corp_key_Score = 0,'','|'+IF(le.hist_corp_key_Score < 0,'-','')+'hist_corp_key')+IF(le.hist_duns_number_Score = 0,'','|'+IF(le.hist_duns_number_Score < 0,'-','')+'hist_duns_number')+IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.company_phone_Score = 0,'','|'+IF(le.company_phone_Score < 0,'-','')+'company_phone')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.company_addr1_Score = 0,'','|'+IF(le.company_addr1_Score < 0,'-','')+'company_addr1')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.company_csz_Score = 0,'','|'+IF(le.company_csz_Score < 0,'-','')+'company_csz')+IF(le.cnp_name_phonetic_Score = 0,'','|'+IF(le.cnp_name_phonetic_Score < 0,'-','')+'cnp_name_phonetic')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.prim_name_derived_Score = 0,'','|'+IF(le.prim_name_derived_Score < 0,'-','')+'prim_name_derived')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.company_inc_state_Score = 0,'','|'+IF(le.company_inc_state_Score < 0,'-','')+'company_inc_state')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype')+IF(le.company_name_type_derived_Score = 0,'','|'+IF(le.company_name_type_derived_Score < 0,'-','')+'company_name_type_derived')+IF(le.company_address_Score = 0,'','|'+IF(le.company_address_Score < 0,'-','')+'company_address');
  END;
  ds_add_Summary := PROJECT(ds_match_join,tosummary(LEFT))    : PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_add_Summary'   );

  // -- Count the summaries
  ds_summary_table := SORT(TABLE(ds_add_Summary,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
  
  // -- Count proxids per address in MC and Full file
  ds_mc_address_table1    := table(ds_mc                  ,{proxid  ,prim_range,prim_name,v_city_name,st,zip                              } ,proxid ,prim_range,prim_name,v_city_name,st,zip ,merge);
  ds_mc_address_table2    := table(ds_mc_address_table1   ,{         prim_range,prim_name,v_city_name,st,zip ,unsigned cnt := count(group)}         ,prim_range,prim_name,v_city_name,st,zip ,merge);

  ds_ih_address_table1    := table(ih                     ,{proxid  ,prim_range,prim_name,v_city_name,st,zip                              } ,proxid ,prim_range,prim_name,v_city_name,st,zip ,merge);
  ds_ih_address_table2    := table(ds_ih_address_table1   ,{         prim_range,prim_name,v_city_name,st,zip ,unsigned cnt := count(group)}         ,prim_range,prim_name,v_city_name,st,zip ,merge);

  // count total proxids in MC and Potential matches based on number of unique addresses
  cnt_mc_clusters       := count(table(ds_mc  ,{proxid},proxid,merge));
  cnt_potential_matches := cnt_mc_clusters - count(ds_mc_address_table2);
  
  // -- Filter the Summaries for any regex passed in.
  ds_summary_table_good := ds_summary_table(trim(pMatchRegex) = '' or regexfind(pMatchRegex,summary,nocase));

  // -- Take Top 20 most frequent field match summaries
  ds_summary_table_good_top20 := topn(ds_summary_table_good ,20 ,-cnt);

  // -- add match rank to top 20 summary table, and percentage of underlinks
  ds_summary_table_top20_rank  := project(ds_summary_table_good_top20 ,transform({unsigned match_rank,recordof(left),string pct_underlinks,unsigned cnt_running_total,string pct_running_total},self.match_rank := counter,self := left
#IF(pJustSingletons = true)   
  ,self.pct_underlinks := realformat((left.cnt / count_singletons_that_do_match_another_cluster) * 100.0,6,2)
  ,self.cnt_running_total := left.cnt
  ,self.pct_running_total := self.pct_underlinks
#ELSE
  ,self.pct_underlinks := realformat((left.cnt / cnt_potential_matches) * 100.0,6,2)
  ,self.cnt_running_total := left.cnt
  ,self.pct_running_total := self.pct_underlinks
#END
  ));

  // -- add running totals to summary table
  ds_summary_table_top20_rank_iter := iterate(ds_summary_table_top20_rank ,transform({recordof(left)}
#IF(pJustSingletons = true)   
    ,self.cnt_running_total := left.cnt_running_total + right.cnt_running_total
    ,self.pct_running_total := realformat((self.cnt_running_total / count_singletons_that_do_match_another_cluster) * 100.0,6,2)
    ,self := right
#ELSE
    ,self.cnt_running_total := left.cnt_running_total + right.cnt_running_total
    ,self.pct_running_total := realformat((self.cnt_running_total / cnt_potential_matches) * 100.0,6,2)
    ,self := right
#END
  ));

  // -- prep summary table for output.
  ds_summary_table_top20_rank_iter_out := project(ds_summary_table_top20_rank_iter  ,transform({unsigned match_rank,string summary,string cnt,string pct_underlinks,string cnt_running_total,string pct_running_total}
  ,self.cnt               := ut.fIntWithCommas(left.cnt)
  ,self.cnt_running_total := ut.fIntWithCommas(left.cnt_running_total)
  ,self                   := left
  ));

  // -- add match rank to summary table for top 20
  ds_summary_add_rank := join(ds_add_Summary ,ds_summary_table_top20_rank  ,trim(left.summary) = trim(right.summary) ,transform(
    {unsigned match_rank,string summary,unsigned cnt,recordof(left) - summary}
    ,self.match_rank  := right.match_rank
    ,self.cnt         := right.cnt
    ,self             := left
  )  ,lookup)  : PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_summary_add_rank'   );

  // -- add rid. used for rolling up the match scores.
  mtch_score2  := project(ds_summary_add_rank,transform({unsigned rid,recordof(left)},self.rid := counter,self := left));

  // -- if we were to do multiple bow options and compare them?
  // ScoreModeType := ENUM(UNSIGNED1, Many=0, Most, All, Any);

  // -- reset the BOW score to the real BOW score for multiple different types(if score is lower than 600, Debug sets it to -9999 so you don't really know what the real score is). 
  mtch_score2_BOW_Most := project(mtch_score2 ,transform(recordof(left)  ,self.cnp_name_score := SALT311.MatchBagOfWords(left.left_cnp_name,left.right_cnp_name,46614,1)  ,self := left  ));
  mtch_score2_BOW_Many := project(mtch_score2 ,transform(recordof(left)  ,self.cnp_name_score := SALT311.MatchBagOfWords(left.left_cnp_name,left.right_cnp_name,46614,0)  ,self := left  ));
  mtch_score2_BOW_All  := project(mtch_score2 ,transform(recordof(left)  ,self.cnp_name_score := SALT311.MatchBagOfWords(left.left_cnp_name,left.right_cnp_name,46614,2)  ,self := left  ));
  mtch_score2_BOW_Any  := project(mtch_score2 ,transform(recordof(left)  ,self.cnp_name_score := SALT311.MatchBagOfWords(left.left_cnp_name,left.right_cnp_name,46614,3)  ,self := left  ));
  
  // -- examples of borderline BOW most matches(BOW score between 3 and 6)
  mtch_score2_BOW_Most_borderline := mtch_score2_BOW_Most(cnp_name_score between 300 and 599);
  
  // -- get longest common substrings
  mtch_score2_BOW_Most_add_common_substring := project(mtch_score2_BOW_Most(cnp_name_score < 600) ,transform({unsigned substring_size,recordof(left)},
    substring_info    := tools.Longest_Common_Substring(trim(left.left_company_name,left,right),trim(left.right_company_name,left,right));
    substring_size    := (unsigned)STD.Str.Extract( substring_info, 1 );
    self.substring_size := substring_size;
    self                := left;
 ));

  mtch_score2_BOW_Most_add_common_substring_biggest := project(topn(mtch_score2_BOW_Most_add_common_substring  ,300  ,-substring_size)  ,recordof(mtch_score2_BOW_Most));

  // -- get examples of different BOW types.
  ds_mtch_score2_Most_not_Many  := join(mtch_score2_BOW_Most  ,mtch_score2_BOW_Many   ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_Most_not_All   := join(mtch_score2_BOW_Most  ,mtch_score2_BOW_All    ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_Most_not_Any   := join(mtch_score2_BOW_Most  ,mtch_score2_BOW_Any    ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
    
  ds_mtch_score2_Many_not_Most  := join(mtch_score2_BOW_Many  ,mtch_score2_BOW_Most   ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_Many_not_All   := join(mtch_score2_BOW_Many  ,mtch_score2_BOW_All    ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_Many_not_Any   := join(mtch_score2_BOW_Many  ,mtch_score2_BOW_Any    ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);

  ds_mtch_score2_All_not_Most   := join(mtch_score2_BOW_All   ,mtch_score2_BOW_Most   ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_All_not_Many   := join(mtch_score2_BOW_All   ,mtch_score2_BOW_Many   ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_All_not_Any    := join(mtch_score2_BOW_All   ,mtch_score2_BOW_Any    ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
    
  ds_mtch_score2_Any_not_Most   := join(mtch_score2_BOW_Any   ,mtch_score2_BOW_Most   ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_Any_not_Many   := join(mtch_score2_BOW_Any   ,mtch_score2_BOW_Many   ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);
  ds_mtch_score2_Any_not_All    := join(mtch_score2_BOW_Any   ,mtch_score2_BOW_All    ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 and left.cnp_name_score >= 600 and right.cnp_name_score < 600  ,transform({recordof(left  )},self := left)  ,hash);

  // -- rollup the match scores
  ds_rollup_match_scores                      := tools.mac_Rollup_Match_Scores(mtch_score2                                        ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_BOW_Most_borderline  := tools.mac_Rollup_Match_Scores(mtch_score2_BOW_Most_borderline                    ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_biggest_substring    := tools.mac_Rollup_Match_Scores(mtch_score2_BOW_Most_add_common_substring_biggest  ,'(cnp_name|company_name_type_derived|company_name)');

  ds_rollup_match_scores_BOW_Most_borderline_slim := project(ds_rollup_match_scores_BOW_Most_borderline ,transform({unsigned match_rank,string summary,unsigned cnt,dataset(recordof(left.child)) child}
    ,self.child := left.child
    ,self       := left
  ));

  ds_rollup_match_scores_biggest_substring_slim := project(ds_rollup_match_scores_biggest_substring ,transform({unsigned match_rank,string summary,unsigned cnt,dataset(recordof(left.child)) child}
    ,self.child := left.child
    ,self       := left
  ));

  ds_rollup_match_scores_most           := tools.mac_Rollup_Match_Scores(mtch_score2_BOW_Most         ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_many           := tools.mac_Rollup_Match_Scores(mtch_score2_BOW_Many         ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_all            := tools.mac_Rollup_Match_Scores(mtch_score2_BOW_All          ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_any            := tools.mac_Rollup_Match_Scores(mtch_score2_BOW_Any          ,'(cnp_name|company_name_type_derived|company_name)');

  ds_rollup_match_scores_Most_not_Many  := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Most_not_Many ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_Most_not_All   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Most_not_All  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_Most_not_Any   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Most_not_Any  ,'(cnp_name|company_name_type_derived|company_name)');
                         
  ds_rollup_match_scores_Many_not_Most  := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Many_not_Most ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_Many_not_All   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Many_not_All  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_Many_not_Any   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Many_not_Any  ,'(cnp_name|company_name_type_derived|company_name)');
                         
  ds_rollup_match_scores_All_not_Most   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_All_not_Most  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_All_not_Many   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_All_not_Many  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_All_not_Any    := tools.mac_Rollup_Match_Scores(ds_mtch_score2_All_not_Any   ,'(cnp_name|company_name_type_derived|company_name)');
                         
  ds_rollup_match_scores_Any_not_Most   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Any_not_Most  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_Any_not_Many   := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Any_not_Many  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_match_scores_Any_not_All    := tools.mac_Rollup_Match_Scores(ds_mtch_score2_Any_not_All   ,'(cnp_name|company_name_type_derived|company_name)');

  // -- put the BOW differences side by side for easier viewing
  lay_rollup := {unsigned6 proxid1,unsigned6 proxid2  ,string child1_type,string child2_type,dataset(recordof(ds_rollup_match_scores.child)) child1,dataset(recordof(ds_rollup_match_scores.child)) child2};
  lay_rollup tsidebyside(recordof(ds_rollup_match_scores) l ,recordof(ds_rollup_match_scores) r,string ltype,string rtype) := 
  transform
    self.child1       := l.child    ;
    self.child2       := r.child   ;
    self.child1_type  := ltype;
    self.child2_type  := rtype;
    self              := l          ;
  end;

  ds_rollup_match_scores_Most_not_Many_side_by_side := join(ds_rollup_match_scores_Most_not_Many ,ds_rollup_match_scores_many ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Most','Many')  ,hash);
  ds_rollup_match_scores_Most_not_All_side_by_side  := join(ds_rollup_match_scores_Most_not_All  ,ds_rollup_match_scores_all  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Most','All' )  ,hash);
  ds_rollup_match_scores_Most_not_Any_side_by_side  := join(ds_rollup_match_scores_Most_not_Any  ,ds_rollup_match_scores_any  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Most','Any' )  ,hash);
                                                                                                  
  ds_rollup_match_scores_Many_not_Most_side_by_side := join(ds_rollup_match_scores_Many_not_Most ,ds_rollup_match_scores_most ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Many','Most')  ,hash);
  ds_rollup_match_scores_Many_not_All_side_by_side  := join(ds_rollup_match_scores_Many_not_All  ,ds_rollup_match_scores_all  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Many','All' )  ,hash);
  ds_rollup_match_scores_Many_not_Any_side_by_side  := join(ds_rollup_match_scores_Many_not_Any  ,ds_rollup_match_scores_any  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Many','Any' )  ,hash);
                                                                                                  
  ds_rollup_match_scores_All_not_Most_side_by_side  := join(ds_rollup_match_scores_All_not_Most  ,ds_rollup_match_scores_most ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'All' ,'Most')  ,hash);
  ds_rollup_match_scores_All_not_Many_side_by_side  := join(ds_rollup_match_scores_All_not_Many  ,ds_rollup_match_scores_many ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'All' ,'Many')  ,hash);
  ds_rollup_match_scores_All_not_Any_side_by_side   := join(ds_rollup_match_scores_All_not_Any   ,ds_rollup_match_scores_any  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'All' ,'Any' )  ,hash);
                                                                                                    
  ds_rollup_match_scores_Any_not_Most_side_by_side  := join(ds_rollup_match_scores_Any_not_Most  ,ds_rollup_match_scores_most ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Any' ,'Most')  ,hash);
  ds_rollup_match_scores_Any_not_Many_side_by_side  := join(ds_rollup_match_scores_Any_not_Many  ,ds_rollup_match_scores_many ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Any' ,'Many')  ,hash);
  ds_rollup_match_scores_Any_not_All_side_by_side   := join(ds_rollup_match_scores_Any_not_All   ,ds_rollup_match_scores_all  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,tsidebyside(left,right,'Any' ,'All' )  ,hash);

  // -- add summary and match rank to rolled up matches
  ds_rollup_match_scores_add_summary_prep := join(ds_rollup_match_scores  ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  
    ,transform({unsigned match_rank,string summary,unsigned cnt,dataset(recordof(left.child)) child,recordof(left) - child - match_rank - summary - cnt}
      ,self.summary     := right.summary
      ,self.match_rank  := right.match_rank
      ,self.cnt         := right.cnt
      ,self             := left
    )  
    ,hash)
   : PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_add_summary_prep'   );
   
// ------------------------------------------------------------------------------------------------------------------------------------------
lay_rec_child := {unsigned6 proxid ,string company_name,string address ,string active_corpkey  ,string active_duns ,string fein};
layspecs := RECORD
   string fieldname;
   string fieldvalue;
  END;
 
 lay_new_rollup := RECORD
  integer2 conf;
  unsigned8 match_rank;
  string summary;
  unsigned8 cnt;
  DATASET({ DATASET(layspecs) child, string score, string skipped }) scores;
  dataset(lay_rec_child)  recs;
end;
 
 // ds_rollup;
 
 // -- get address and name
 ds_get_address1 := join(pih  ,ds_rollup_match_scores_add_summary_prep  ,left.rcid = right.rcid1  ,transform({unsigned6 rcid2,lay_new_rollup}
    ,self.recs := dataset([{left.proxid ,left.cnp_name  ,Address.Addr1FromComponents(left.prim_range,'',left.prim_name,'','','',left.sec_range) + ' ' + Address.Addr2FromComponents(left.v_city_name,left.st,left.zip),left.active_corp_key,left.active_duns_number,left.company_fein}]  ,lay_rec_child)
    ,self.scores := right.child
    ,self      := right
 )  ,hash);
 
 ds_rollup_match_scores_add_summary := join(pih  ,ds_get_address1  ,left.rcid = right.rcid2  ,transform(lay_new_rollup
    ,self.recs := right.recs + dataset([{left.proxid  ,left.cnp_name ,Address.Addr1FromComponents(left.prim_range,'',left.prim_name,'','','',left.sec_range) + ' ' + Address.Addr2FromComponents(left.v_city_name,left.st,left.zip),left.active_corp_key,left.active_duns_number,left.company_fein}]  ,lay_rec_child)
    ,self.scores := right.scores(~exists(child(regexfind('(left_company_name|right_company_name|left_cnp_name_phonetic|right_cnp_name_phonetic)',trim(fieldname),nocase))) )
    ,self      := right
 )  ,hash)
   : PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_add_summary'   );
// ------------------------------------------------------------------------------------------------------------------------------------------
 
  lay_rollup_summary := {unsigned match_rank,string summary,unsigned cnt,recordof(ds_rollup_match_scores_Most_not_Many_side_by_side)};
  lay_rollup_summary tadd_summary(recordof(ds_rollup_match_scores_Most_not_Many_side_by_side) l ,recordof(ds_summary_add_rank) r) := 
  transform
      self.summary     := r.summary      ;
      self.match_rank  := r.match_rank   ;
      self.cnt         := r.cnt          ;
      self             := l               ;
  end;

  ds_rollup_match_scores_Most_not_Many_side_by_side_add_Summary  := join(ds_rollup_match_scores_Most_not_Many_side_by_side  ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Most_not_Many_side_by_side_add_Summary'   );
  ds_rollup_match_scores_Most_not_All_side_by_side_add_Summary   := join(ds_rollup_match_scores_Most_not_All_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Most_not_All_side_by_side_add_Summary'    );
  ds_rollup_match_scores_Most_not_Any_side_by_side_add_Summary   := join(ds_rollup_match_scores_Most_not_Any_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Most_not_Any_side_by_side_add_Summary'    );
                                                                                                                                                                                                                                                                                                                                                               
  ds_rollup_match_scores_Many_not_Most_side_by_side_add_Summary  := join(ds_rollup_match_scores_Many_not_Most_side_by_side  ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Many_not_Most_side_by_side_add_Summary'   );
  ds_rollup_match_scores_Many_not_All_side_by_side_add_Summary   := join(ds_rollup_match_scores_Many_not_All_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Many_not_All_side_by_side_add_Summary'    );
  ds_rollup_match_scores_Many_not_Any_side_by_side_add_Summary   := join(ds_rollup_match_scores_Many_not_Any_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Many_not_Any_side_by_side_add_Summary'    );
                                                                                                                                                                                                                                                                                                                                                               
  ds_rollup_match_scores_All_not_Most_side_by_side_add_Summary   := join(ds_rollup_match_scores_All_not_Most_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_All_not_Most_side_by_side_add_Summary'    );
  ds_rollup_match_scores_All_not_Many_side_by_side_add_Summary   := join(ds_rollup_match_scores_All_not_Many_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_All_not_Many_side_by_side_add_Summary'    );
  ds_rollup_match_scores_All_not_Any_side_by_side_add_Summary    := join(ds_rollup_match_scores_All_not_Any_side_by_side    ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_All_not_Any_side_by_side_add_Summary'     );
                                                                                                                                                                                                                                                                                                                                                               
  ds_rollup_match_scores_Any_not_Most_side_by_side_add_Summary   := join(ds_rollup_match_scores_Any_not_Most_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Any_not_Most_side_by_side_add_Summary'    );
  ds_rollup_match_scores_Any_not_Many_side_by_side_add_Summary   := join(ds_rollup_match_scores_Any_not_Many_side_by_side   ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Any_not_Many_side_by_side_add_Summary'    );
  ds_rollup_match_scores_Any_not_All_side_by_side_add_Summary    := join(ds_rollup_match_scores_Any_not_All_side_by_side    ,ds_summary_add_rank  ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2 ,tadd_summary(left,right)  ,hash): PERSIST('~persist::BIPV2_ProxID::_Underlinks::ds_rollup_match_scores_Any_not_All_side_by_side_add_Summary'     );

  // --------------------------------------

  ds_detailed_stats := dataset([
     {'Count Match_Rank_Number_1'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 1 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 1 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_2'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 2 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 2 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_3'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 3 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 3 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_4'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 4 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 4 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_5'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 5 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 5 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_6'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 6 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 6 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_7'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 7 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 7 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_8'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 8 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 8 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_9'                 ,count(ds_rollup_match_scores_add_summary(match_rank = 9 )           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 9 ,conf >= 30))}  
    ,{'Count Match_Rank_Number_10'                ,count(ds_rollup_match_scores_add_summary(match_rank = 10)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 10,conf >= 30))}  
    ,{'Count Match_Rank_Number_11'                ,count(ds_rollup_match_scores_add_summary(match_rank = 11)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 11,conf >= 30))}  
    ,{'Count Match_Rank_Number_12'                ,count(ds_rollup_match_scores_add_summary(match_rank = 12)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 12,conf >= 30))}  
    ,{'Count Match_Rank_Number_13'                ,count(ds_rollup_match_scores_add_summary(match_rank = 13)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 13,conf >= 30))}  
    ,{'Count Match_Rank_Number_14'                ,count(ds_rollup_match_scores_add_summary(match_rank = 14)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 14,conf >= 30))}  
    ,{'Count Match_Rank_Number_15'                ,count(ds_rollup_match_scores_add_summary(match_rank = 15)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 15,conf >= 30))}  
    ,{'Count Match_Rank_Number_16'                ,count(ds_rollup_match_scores_add_summary(match_rank = 16)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 16,conf >= 30))}  
    ,{'Count Match_Rank_Number_17'                ,count(ds_rollup_match_scores_add_summary(match_rank = 17)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 17,conf >= 30))}  
    ,{'Count Match_Rank_Number_18'                ,count(ds_rollup_match_scores_add_summary(match_rank = 18)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 18,conf >= 30))}  
    ,{'Count Match_Rank_Number_19'                ,count(ds_rollup_match_scores_add_summary(match_rank = 19)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 19,conf >= 30))}  
    ,{'Count Match_Rank_Number_20'                ,count(ds_rollup_match_scores_add_summary(match_rank = 20)           ) ,count(ds_rollup_match_scores_add_summary(match_rank = 20,conf >= 30))}  
    ,{'Count ds_mc                  '             ,count(ds_mc                                )}
    ,{'Count ds_base_table          '             ,count(ds_base_table                        )}
    ,{'Count ds_base_singletons     '             ,count(ds_base_singletons                   )}  
    ,{'Count ds_mc_add_cnts         '             ,count(ds_mc_add_cnts                       )}  
    ,{'Count ds_mc_singletons       '             ,count(ds_mc_singletons                     )}  
    ,{'Count ds_mc_table            '             ,count(ds_mc_table                          )}  
    ,{'Count ds_mc_table_under1000  '             ,count(ds_mc_table_under1000                )}  
    // ,{'Count ds_mc_table_over1000   '             ,count(ds_mc_table_over1000                 )}  
    ,{'Count ds_mc_under1000        '             ,count(ds_mc_under1000                      )}  
    // ,{'Count ds_mc_over1000         '             ,count(ds_mc_over1000                       )}  
    // ,{'Count ds_mc_over1000_prep    '             ,count(ds_mc_over1000_prep                  )}  
    ,{'Count ds_mc_singletons_prep  '             ,count(ds_mc_singletons_prep                )}  
    // ,{'Count ds_over1000_join       '             ,count(ds_over1000_join                     )}  
    ,{'Count ds_under1000_join      '             ,count(ds_under1000_join                    )}  
    ,{'Count ds_concat              '             ,count(ds_concat                            )}  
    ,{'Count key_spec               '             ,count(key_spec                             )}  
    ,{'Count ds_add_Summary'                      ,count(ds_add_Summary                       )}    
    ,{'Count ds_summary_table_good_top20'         ,count(ds_summary_table_good_top20          )}    
    ,{'Count ds_summary_table_top20_rank'         ,count(ds_summary_table_top20_rank          )}    
    ,{'Count ds_summary_add_rank'                 ,count(ds_summary_add_rank                  )}    
    
    ,{'Count key_att                '             ,count(key_att                              )}    
    ,{'Count ds_att                 '             ,count(ds_att                               )}    
    ,{'Count ds_prep_matches1       '             ,count(ds_prep_matches1                     )}     
    ,{'Count ds_prep_matches2       '             ,count(ds_prep_matches2                     )}     
    ,{'Count ds_match_join          '             ,count(ds_match_join                        )}    
    ,{'Count mtch_score2'                         ,count(mtch_score2                          )}
    ,{'Count ds_rollup_match_scores'              ,count(ds_rollup_match_scores               )}  
    ,{'Count ds_rollup_match_scores_add_summary'  ,count(ds_rollup_match_scores_add_summary   )}  

    ,{'Count ds_rollup_match_scores_Most_not_Many_side_by_side_add_Summary'  ,count(ds_rollup_match_scores_Most_not_Many_side_by_side_add_Summary   )}  
    ,{'Count ds_rollup_match_scores_Most_not_All_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_Most_not_All_side_by_side_add_Summary    )}  
    ,{'Count ds_rollup_match_scores_Most_not_Any_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_Most_not_Any_side_by_side_add_Summary    )}  
                                                                                                                                                 
    ,{'Count ds_rollup_match_scores_Many_not_Most_side_by_side_add_Summary'  ,count(ds_rollup_match_scores_Many_not_Most_side_by_side_add_Summary   )}  
    ,{'Count ds_rollup_match_scores_Many_not_All_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_Many_not_All_side_by_side_add_Summary    )}  
    ,{'Count ds_rollup_match_scores_Many_not_Any_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_Many_not_Any_side_by_side_add_Summary    )}  
                                                                                                                                                 
    ,{'Count ds_rollup_match_scores_All_not_Most_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_All_not_Most_side_by_side_add_Summary    )}  
    ,{'Count ds_rollup_match_scores_All_not_Many_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_All_not_Many_side_by_side_add_Summary    )}  
    ,{'Count ds_rollup_match_scores_All_not_Any_side_by_side_add_Summary  '  ,count(ds_rollup_match_scores_All_not_Any_side_by_side_add_Summary     )}  
                                                                                                                                                 
    ,{'Count ds_rollup_match_scores_Any_not_Most_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_Any_not_Most_side_by_side_add_Summary    )}  
    ,{'Count ds_rollup_match_scores_Any_not_Many_side_by_side_add_Summary '  ,count(ds_rollup_match_scores_Any_not_Many_side_by_side_add_Summary    )}  
    ,{'Count ds_rollup_match_scores_Any_not_All_side_by_side_add_Summary  '  ,count(ds_rollup_match_scores_Any_not_All_side_by_side_add_Summary     )}  
  ],{string statdescription,unsigned statvalue  ,unsigned cnt_above_threshold := 0});


  pct_singletons_match_another_cluster   := realformat((count_singletons_that_do_match_another_cluster     / count(table(ds_mc_singletons ,{proxid},proxid,merge))) * 100.0 ,6,2 );
  pct_singletons_nomatch_another_cluster := realformat((count_singletons_that_do_not_match_another_cluster / count(table(ds_mc_singletons ,{proxid},proxid,merge))) * 100.0 ,6,2 );


  ds_top10_addresses_with_most_proxids := project(topn(ds_mc_address_table2 ,10 ,-cnt)  ,transform({unsigned address_rank,recordof(left)},self.address_rank := counter,self := left));
  ds_top10_addresses_with_most_proxids_proxids := join(ds_ih_address_table1 ,ds_top10_addresses_with_most_proxids ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip
  ,transform({unsigned address_rank,unsigned cnt_proxids ,recordof(left)},self.cnt_proxids := right.cnt,self.address_rank := right.address_rank,self := left) 
  ,lookup);
  ds_top10_addresses_with_most_proxids_proxids2 := table(ds_top10_addresses_with_most_proxids_proxids ,{proxid,address_rank,cnt_proxids} ,proxid,address_rank,cnt_proxids ,merge);

  ds_top10_address_get_full_recs := join(ih ,ds_top10_addresses_with_most_proxids_proxids2  ,left.proxid = right.proxid ,transform({string address_rank,string cnt_proxids ,recordof(left)} ,self.cnt_proxids := (string)right.cnt_proxids,self.address_rank := (string)right.address_rank,self := left),keep(1),hash);

  ds_agg_top10_address_proxids_prep := BIPV2_Tools.Agg_Slim(ds_top10_address_get_full_recs ,proxid,100,pSet_Add_Fields := ['cnt_proxids','address_rank'],pACorpkeyField := active_corp_key);
  
  ds_agg_top10_address_proxids := project(ds_agg_top10_address_proxids_prep ,transform({unsigned address_rank,unsigned cnt_proxids ,recordof(left) - cnt_proxidss - address_ranks},self.address_rank := (unsigned)left.address_ranks[1].address_rank
  ,self.cnt_proxids := (unsigned)left.cnt_proxidss[1].cnt_proxids ,self := left))
  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_agg_top10_address_proxids');

  // -- do xlink append to find potential underlinks that way
  ds_base_xlink_prep := table(ih  ,{unsigned proxid_orig := proxid,BIPV2.IDlayouts.l_xlink_ids - proxid
  ,proxid
  ,company_name
  ,prim_range
  ,prim_name
  ,zip
  ,sec_range
  ,st
  ,company_phone
  ,company_fein
  // ,company_bdid 
  // ,company_url			
  //,contact_email		
  ,v_city_name			
  //,fname	
  //,mname						
  //,lname			
  //,contact_ssn			
  // ,source
  // ,source_record_id
  }  
  ,proxid
  ,company_name
  ,prim_range
  ,prim_name
  ,zip
  ,sec_range
  ,st
  ,company_phone
  ,company_fein
  // ,company_bdid 
  // ,company_url			
  //,contact_email		
  ,v_city_name			
  //,fname	
  //,mname						
  //,lname			
  //,contact_ssn			
  // ,source
  // ,source_record_id
  ,merge
  )
    : persist('~persist::BIPV2_ProxID::_Underlinks::ds_base_xlink_prep');

  lay_append    := recordof(ds_base_xlink_prep);

  Matchset      := ['A','F','P'];

  import ut, business_header,business_header_ss, address, BIPV2;
  Business_Header_SS.MAC_Match_Flex
  (
     ds_base_xlink_prep
    ,matchset
    ,company_name
    ,prim_range
    ,prim_name
    ,zip
    ,sec_range
    ,st
    ,company_phone
    ,company_fein
    ,company_bdid 
    ,lay_append
    ,FALSE
    ,BDID_score_field
    ,ds_new_xlink_append
    ,												
    ,												//score_threshold				= '75'
    ,												//pFileVersion						= '\'prod\''														// default to use prod version of superfiles
    ,												//pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
    ,[BIPV2.IDconstants.xlink_version_BIP]
    ,//company_url												//pURL										=	''
    ,//contact_email									
    ,v_city_name						//pCity									= ''	
    ,//fname	
    ,//mname												//pContact_mname					= ''
    ,//lname			
    ,//contact_ssn												//,contact_ssn					  = ''
    ,//source/*change to sub_source when available!*/												//,source					        = ''
    ,//source_record_id												//,source_record_id				= ''
  );

  // -- join xlink append dataset back to full file on deduped fields
  ds_new_xlink_append_persisted := join(ih  ,ds_new_xlink_append
  ,   left.proxid            = right.proxid_orig     
  and left.company_name      = right.company_name         
  and left.prim_range        = right.prim_range         
  and left.prim_name         = right.prim_name          
  and left.zip               = right.zip                   
  and left.sec_range         = right.sec_range          
  and left.st                = right.st                    
  and left.company_phone     = right.company_phone      
  and left.company_fein      = right.company_fein          
  // and left.company_bdid      = right.company_bdid       
  // and left.company_url			 = right.company_url			      
  // and left.contact_email		 = right.contact_email		   
  and left.v_city_name			 = right.v_city_name			      
  // and left.fname	           = right.fname	            
  // and left.mname						 = right.mname						      
  // and left.lname			       = right.lname			         
  // and left.contact_ssn			 = right.contact_ssn			       
  // and left.source            = right.source             
  // and left.source_record_id  = right.source_record_id      
                               
  ,transform({recordof(left),string proxid_orig},self.proxid_orig := (string)right.proxid_orig,self := right,self := left)  ,hash,keep(1)) 
  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_new_xlink_append_persisted');


  // -- Filter returned xlink dataset for only populated proxids, and those that differ from our IL proxid, get sample of 300
  xlink_proxid_diffs              := ds_new_xlink_append_persisted(proxid != 0,proxid != (unsigned6)proxid_orig);
  xlink_proxid_diffs_table        := table(xlink_proxid_diffs  ,{unsigned6 proxid1 := (unsigned6)proxid_orig,unsigned6 proxid2 := proxid}  ,proxid_orig,proxid ,merge);
  xlink_proxid_diffs_table_sample := enth(xlink_proxid_diffs_table,300);
  
  
  // -- Annotate those 300 matches and then rollup the scores
  ds_prep_xlink_matches2        := project(xlink_proxid_diffs_table_sample  ,transform(layout_matches ,self.proxid1 := left.proxid1,self.proxid2 := left.proxid2  ,self := []))   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_prep_xlink_matches2');
  ds_xlink_match_join1          := project(annotate_matches(ds_mc_table_dedup ,ds_prep_xlink_matches2 ,ds_att),transform({unsigned rid,recordof(left)},self.rid := counter,self := left))   : persist('~persist::BIPV2_ProxID::_Underlinks::ds_xlink_match_join1');
  ds_rollup_xlink_match_scores  := tools.mac_Rollup_Match_Scores(ds_xlink_match_join1                  ,'(cnp_name|company_name_type_derived|company_name)');
  ds_rollup_xlink_match_scores_slim := project(ds_rollup_xlink_match_scores ,transform({unsigned6 proxid1,unsigned6 proxid2,dataset(recordof(left.child)) child}
    ,self.child := left.child
    ,self       := left
  ));

// -----
  // -- Filter returned xlink dataset for only non-populated proxids, and then join to our match samples to find those orig proxids and what they want to join to.  this can find underlinking(ambiguous results)
  xlink_proxid_no_xlink_append              := ds_new_xlink_append_persisted(proxid = 0);
  xlink_proxid_no_xlink_append_table        := table(xlink_proxid_no_xlink_append  ,{unsigned6 proxid := (unsigned6)proxid_orig} ,(unsigned6)proxid_orig ,merge);
  xlink_proxid_no_xlink_append_table_sample := enth(xlink_proxid_no_xlink_append_table,300);
  
  
  // -- Annotate those 300 matches and then rollup the scores
  xlink_proxid_no_xlink_append_matches2   := join(mtch_score2_BOW_Most  ,xlink_proxid_no_xlink_append_table_sample ,left.proxid1 = right.proxid ,transform(left) ,lookup);
  ds_rollup_no_xlink_append_match_scores  := tools.mac_Rollup_Match_Scores(xlink_proxid_no_xlink_append_matches2                  ,'(cnp_name|company_name_type_derived|company_name)');

  ds_rollup_no_xlink_append_match_scores_slim := project(ds_rollup_no_xlink_append_match_scores ,transform({unsigned6 proxid1,unsigned6 proxid2,dataset(recordof(left.child)) child}
    ,self.child := left.child
    ,self       := left
  ));





  // -- aggregate samples of the xlink append
  ds_agg_xlink_append := BIPV2_Tools.Agg_Slim(ds_new_xlink_append_persisted ,proxid,100,pSet_Add_Fields := ['proxid_orig'],pACorpkeyField := active_corp_key)  : persist('~persist::BIPV2_ProxID::_Underlinks::ds_agg_xlink_append');

  ds_Overall_Underlink_Stats := dataset([
     {'Count Total Proxid Records'                                                                ,ut.fIntWithCommas(count(table(ih                                   ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ih                                       )    )}  
    ,{'Count Total Proxid Singletons'                                                             ,ut.fIntWithCommas(count(table(ds_base_singletons                   ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_base_singletons                       )    )}  
    ,{'Count Rejected'                                                                            ,ut.fIntWithCommas(count(table(ds_rejected_records                  ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_rejected_records                      )    )}  
    ,{'Count Unlinkable'                                                                          ,ut.fIntWithCommas(count(table(ds_unlinkable_records                ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_unlinkable_records                    )    )}  
    ,{'Count Rejected Singletons'                                                                 ,ut.fIntWithCommas(count(table(ds_rejected_singletons               ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_rejected_singletons                   )    )}  
    ,{'Count Unlinkable Singletons'                                                               ,ut.fIntWithCommas(count(table(ds_unlinkable_singletons             ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_unlinkable_singletons                 )    )}  
    ,{'Count Rejected Or Unlinkable Singletons'                                                   ,ut.fIntWithCommas(count(table(ds_unlinkable_or_rejected_singletons ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_unlinkable_or_rejected_singletons     )    )}  
    ,{'Count Match Candidates'                                                                    ,ut.fIntWithCommas(count(table(ds_mc                                ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_mc                                    )    )}  
    ,{'Count Match Candidates Singletons'                                                         ,ut.fIntWithCommas(count(table(ds_mc_singletons                     ,{proxid},proxid,merge))) ,ut.fIntWithCommas(count(ds_mc_singletons                         )    )}  
    ,{'Count Singletons that match another cluster on address(potential matches)'                 ,ut.fIntWithCommas(count_singletons_that_do_match_another_cluster                           ) + '(' + pct_singletons_match_another_cluster   + '%)' ,ut.fIntWithCommas(count_singletons_that_do_match_another_cluster      ) + '(' + pct_singletons_match_another_cluster   + '%)'}  
    ,{'Count Singletons that do not match another cluster on address(will never match)'           ,ut.fIntWithCommas(count_singletons_that_do_not_match_another_cluster                       ) + '(' + pct_singletons_nomatch_another_cluster + '%)' ,ut.fIntWithCommas(count_singletons_that_do_not_match_another_cluster  ) + '(' + pct_singletons_nomatch_another_cluster + '%)'}  

    ,{'Count Total Unique Addresses(in a perfect world, the number of proxids)'                   ,ut.fIntWithCommas(count(ds_ih_address_table2)) ,''}  
    ,{'Count Total Unique Addresses Match Candidates(in a perfect world, the number of proxids)'  ,ut.fIntWithCommas(count(ds_mc_address_table2)) ,''}  
    ,{'Count Total Potential Matches(Full File matches on address)'                               ,ut.fIntWithCommas(cnt_potential_matches)       ,''}  

    ,{'Count Xlink Append Proxids'                                                                ,ut.fIntWithCommas(count(table(ds_new_xlink_append_persisted(proxid != 0),{proxid},proxid,merge)))       ,ut.fIntWithCommas(count(ds_new_xlink_append_persisted(proxid != 0)))}  
    ,{'Count Xlink Append Proxids Differ From Internal Linking Proxids'                           ,ut.fIntWithCommas(count(table(ds_new_xlink_append_persisted(proxid != 0,proxid != (unsigned6)proxid_orig),{proxid},proxid,merge)))       ,ut.fIntWithCommas(count(ds_new_xlink_append_persisted(proxid != 0,proxid != (unsigned6)proxid_orig)))}  

  ],{string statdescription,string clusters ,string records});

  send_email := tools.Send_Email_CSV_Attachment(
     ds_Overall_Underlink_Stats 
    ,'BIPV2 Proxid Underlink Stats ' 
    ,'Please find the BIPV2 Proxid Underlink Stats for version ' + pversion + ' Attached.\nThis is a csv file that you can open in excel.'
    ,'BIPV2_Proxid_Underlink_Stats_' + pversion +'.csv'
    ,pEmail
    ,pversion
  );


  return_result := parallel(
     output(choosen(ds_summary_table_top20_rank_iter_out                  ,300) ,named('Top20_Underlink_Reasons'                 ) ,all)
    ,output(ds_Overall_Underlink_Stats                                          ,named('Overall_Underlink_Stats'                 )     )
    ,send_email
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 1 )   ,300) ,named('Number_1_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 2 )   ,300) ,named('Number_2_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 3 )   ,300) ,named('Number_3_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 4 )   ,300) ,named('Number_4_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 5 )   ,300) ,named('Number_5_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 6 )   ,300) ,named('Number_6_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 7 )   ,300) ,named('Number_7_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 8 )   ,300) ,named('Number_8_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 9 )   ,300) ,named('Number_9_Underlink_Reason_Match_Samples' ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 10)   ,300) ,named('Number_10_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 11)   ,300) ,named('Number_11_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 12)   ,300) ,named('Number_12_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 13)   ,300) ,named('Number_13_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 14)   ,300) ,named('Number_14_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 15)   ,300) ,named('Number_15_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 16)   ,300) ,named('Number_16_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 17)   ,300) ,named('Number_17_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 18)   ,300) ,named('Number_18_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 19)   ,300) ,named('Number_19_Underlink_Reason_Match_Samples') ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary(match_rank = 20)   ,300) ,named('Number_20_Underlink_Reason_Match_Samples') ,all)
    
    ,output('----------------------Samples of Xlink Append Differences------------------------------'  ,named('____________________'))
    ,output(enth(ds_rollup_xlink_match_scores_slim                       ,300     ) ,named('Xlink_append_Potential_Underlinks_Because_Diff_Proxid_Appended'     ) ,all)     
    ,output(enth(ds_rollup_no_xlink_append_match_scores_slim             ,300     ) ,named('Xlink_appends_Possible_Ambiguity_Because_No_Proxid_Appended'        ) ,all)     
    ,output(topn(ds_agg_xlink_append                                     ,300,-cnt) ,named('Xlink_appends_with_Most_IL_Proxids'                                 ) ,all)     

    ,output('----------------------BOW Many, Most, All & Any examples------------------------------'  ,named('_________'))
    ,output(enth(ds_rollup_match_scores_BOW_Most_borderline_slim                 ,300) ,named('BOW_Most_Borderlines_3_to_5_score') ,all)
    ,output(enth(ds_rollup_match_scores_biggest_substring_slim                   ,300) ,named('BOW_Most_Mismatches_With_Biggest_Common_Substrings') ,all)
    ,output(enth(ds_rollup_match_scores_Most_not_Many_side_by_side_add_Summary   ,300) ,named('BOW_Most_Not_Many_Examples') ,all)
    ,output(enth(ds_rollup_match_scores_Most_not_All_side_by_side_add_Summary    ,300) ,named('BOW_Most_Not_All_Examples' ) ,all)
    ,output(enth(ds_rollup_match_scores_Most_not_Any_side_by_side_add_Summary    ,300) ,named('BOW_Most_Not_Any_Examples' ) ,all)
                                                                              
    ,output(enth(ds_rollup_match_scores_Many_not_Most_side_by_side_add_Summary   ,300) ,named('BOW_Many_Not_Most_Examples') ,all)
    ,output(enth(ds_rollup_match_scores_Many_not_All_side_by_side_add_Summary    ,300) ,named('BOW_Many_Not_All_Examples' ) ,all)
    ,output(enth(ds_rollup_match_scores_Many_not_Any_side_by_side_add_Summary    ,300) ,named('BOW_Many_Not_Any_Examples' ) ,all)
                                                                              
    ,output(enth(ds_rollup_match_scores_All_not_Most_side_by_side_add_Summary    ,300) ,named('BOW_All_Not_Most_Examples') ,all)
    ,output(enth(ds_rollup_match_scores_All_not_Many_side_by_side_add_Summary    ,300) ,named('BOW_All_Not_Many_Examples' ) ,all)
    ,output(enth(ds_rollup_match_scores_All_not_Any_side_by_side_add_Summary     ,300) ,named('BOW_All_Not_Any_Examples' ) ,all)
                                                                              
    ,output(enth(ds_rollup_match_scores_Any_not_Most_side_by_side_add_Summary    ,300) ,named('BOW_Any_Not_Most_Examples') ,all)
    ,output(enth(ds_rollup_match_scores_Any_not_Many_side_by_side_add_Summary    ,300) ,named('BOW_Any_Not_Many_Examples' ) ,all)
    ,output(enth(ds_rollup_match_scores_Any_not_All_side_by_side_add_Summary     ,300) ,named('BOW_Any_Not_All_Examples' ) ,all)


    ,output('----------------------Samples of Singletons, Rejected & Unlinkable records------------------------------'  ,named('__________'))
    ,output(choosen(ds_base_singletons                                      ,300) ,named('Base_Singletons'                                             ) ,all)     
    ,output(choosen(ds_mc                                                   ,300) ,named('Match_Candidates'                                            ) ,all)     
    ,output(choosen(ds_rejected_records                                     ,300) ,named('Rejected_Records'                                            ) ,all)     
    ,output(choosen(ds_unlinkable_records                                   ,300) ,named('Unlinkable_Records'                                          ) ,all)     
    ,output(choosen(ds_mc_singletons                                        ,300) ,named('Match_Candidates_Singletons'                                 ) ,all)     
    ,output(choosen(ds_rejected_singletons                                  ,300) ,named('Rejected_Singletons'                                         ) ,all)     
    ,output(choosen(ds_unlinkable_singletons                                ,300) ,named('Unlinkable_Singletons'                                       ) ,all)     
    ,output(choosen(ds_unlinkable_or_rejected_singletons                    ,300) ,named('Unlinkable_Or_Rejected_Ringletons'                           ) ,all)     


    ,output('----------------------Samples of Addresses with Most Proxids------------------------------'  ,named('_______________'))
    ,output(topn(ds_ih_address_table2   ,300  ,-cnt) ,named('Top300_Addresses_with_Most_Proxids'   ) ,all)
    ,output(topn(ds_mc_address_table2   ,300  ,-cnt) ,named('Top300_Addresses_with_Most_Proxids_MC') ,all)

    ,output(topn(ds_agg_top10_address_proxids(address_rank = 1 )   ,300  ,-cnt) ,named('Number_1_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 2 )   ,300  ,-cnt) ,named('Number_2_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 3 )   ,300  ,-cnt) ,named('Number_3_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 4 )   ,300  ,-cnt) ,named('Number_4_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 5 )   ,300  ,-cnt) ,named('Number_5_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 6 )   ,300  ,-cnt) ,named('Number_6_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 7 )   ,300  ,-cnt) ,named('Number_7_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 8 )   ,300  ,-cnt) ,named('Number_8_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 9 )   ,300  ,-cnt) ,named('Number_9_Address_with_Most_Proxids') ,all)
    ,output(topn(ds_agg_top10_address_proxids(address_rank = 10)   ,300  ,-cnt) ,named('Number_10_Address_with_Most_Proxids') ,all)

    ,output('----------------------Other Stats and Samples------------------------------'  ,named('_____________'))
    ,output(ds_detailed_stats                                                   ,named('ds_detailed_stats'                       ))
    ,output(choosen(ds_match_join                                         ,300) ,named('ds_match_join'                           ) ,all)     
    ,output(choosen(ds_summary_table                                      ,300) ,named('ds_summary_table'                        ) ,all)     
    ,output(choosen(ds_summary_table_good                                 ,300) ,named('ds_summary_table_good'                   ) ,all)
    ,output(choosen(ds_summary_table_good_top20                           ,300) ,named('ds_summary_table_good_top20'             ) ,all)
    ,output(choosen(ds_summary_add_rank                                   ,300) ,named('ds_summary_add_rank'                     ) ,all)
    ,output(choosen(mtch_score2                                           ,300) ,named('mtch_score2'                             ) ,all)
    ,output(choosen(ds_rollup_match_scores                                ,300) ,named('ds_rollup_match_scores'                  ) ,all)
    ,output(choosen(ds_rollup_match_scores_add_summary                    ,300) ,named('ds_rollup_match_scores_add_summary'      ) ,all)

  );

  return return_result;
  
ENDMACRO;