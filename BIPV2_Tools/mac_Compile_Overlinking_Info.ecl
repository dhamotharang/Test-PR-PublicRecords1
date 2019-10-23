/*
  probably have to use cnt of complete mismatches(i can know this from the specificites) and/or the score. say if there is over 10 complete mismatches.
  could have different levels.  over 50, 40-50, etc.  and/or just sort descending and pick the top worst 300.
  1. aggregate the cluster per ID passed in.  limit child datasets to 100 for speed
  2. dedup file, join to key(need to pass this in too) to get bow field, and then do the join as below to get the bow scores within the clusters.
     using the specificity for each field involved in the match, figure out if it is a complete mismatch.
  3. join 1 to 2 to patch the scores onto the clusters.
  4. tune the avg score, range and cnt below threshold to find the worst overlinking
  5. output overlinking samples.
  6. should slice and dice them by fein, duns, etc?  will this help find overlinking?  should I use some modification of how did this link to provide more info?

  key layout:
  cnt(can be count of cnp_names, cnt of mismatched cnp_name, count of feins, cnt of corpkey, cnt of duns, etc.)
  all of those except the mismatched cnp_names can be gleaned from the aggregate macro using a limit of 1 for speed.
  cnt ,ID       ,count_description      ,ID value.
  50  ,'proxid' ,'mismatched cnp_names' ,1234 
  100 ,'lgid3'  ,'feins'                ,1234 
  10  ,'proxid' ,'corpkeys'             ,5678    
  

*/
EXPORT mac_Compile_Overlinking_Info(

   pID              = 'proxid'
  ,pDataset         = 'bipv2.CommonBase.ds_base'
  ,pBOW_field       = 'cnp_name'
  ,pBOW_Index       = 'BIPV2_proxid.specificities(BIPV2_proxid.In_DOT_Base).cnp_name_values_index'
  ,pBOW_Function    = 'SALT30.MatchBagOfWords'
  ,pBOW_Mode        = '46614'
  ,pBOW_Score_Mode  = '1'
  ,pName_Force      = 'BIPV2_ProxID.Config.cnp_name_Force'
  ,pHyphen_Match_function   = 'SALT37.HyphenMatch'
  ,pHyphen_Match_min_len    = '1'

) :=
functionmacro

    import bipv2_proxid,bipv2,salt30,BIPV2_Tools,tools;

//    #UNIQUENAME(BOW_RAW_Left_Field )
//    #UNIQUENAME(BOW_RAW_Right_Field)
//    
//    #SET(BOW_RAW_Left_Field  ,trim(#TEXT(pBOW_field),all) + '_left' )
//    #SET(BOW_RAW_Right_Field ,trim(#TEXT(pBOW_field),all) + '_right')

    ds_base := pDataset  ;
    key_bow := pBOW_Index;

    ds_agg_all := BIPV2_Tools.AggregateProxidElements(ds_base  ,pID,1,false,false,true) //limit to one because i just want the counts. also speeds it up
//      : persist('~persist::BIPV2_Tools::mac_Compile_Overlinking_Info.ds_agg_all');
    ;
    
    ds_base_slim_source     := table(ds_base ,{pID ,set of string sources := [source]} ,pID ,source  ,merge);
    ds_base_rollup_sources  := rollup(sort(distribute(ds_base_slim_source,pID),pID,sources[1],local) ,left.pID = right.pID ,transform(recordof(left),self.sources := left.sources + right.sources,self := left)  ,local);
    

    ds_base_slim_prep  := table(ds_base(trim(pBOW_field) != '') ,{pID ,pBOW_field} ,pID ,pBOW_field  ,merge);
    ds_base_slimmer    := table(ds_base_slim_prep ,{pID ,unsigned cnt := count(group)} ,pID   ,merge);
    ds_base_slim       := join(ds_base_slim_prep ,ds_base_slimmer  ,left.pID = right.pID ,transform({recordof(left) or recordof(right)},self := left,self := right)  ,hash);
    
    ds_get_bow_field := join(ds_base_slim  ,key_bow, left.pBOW_field = right.pBOW_field ,transform({string bow_field,real field_specificity,integer4 bow_spec,recordof(left)}
      ,self.bow_field         := (unsigned)(right.field_specificity * 100) +' '+ trim(right.word)
      ,self.field_specificity := right.field_specificity
      ,self.bow_spec          := (integer4)(right.field_specificity * 100)
      ,self                   := left
    ),hash);


  lay_scores_prep :=
  {
     unsigned6  pID
    ,string     cnp_name_left  
    ,string     cnp_name_right
    ,string     Annotated_BOW_Field_left  
    ,string     Annotated_BOW_Field_right 
    ,integer4   bow_spec_left
    ,integer4   bow_spec_right
    ,integer4   min_specificity 
    ,INTEGER4   match_score 
    ,UNSIGNED4  hyphenmatch_score 
    ,integer    substring_size
    ,string     substring
    ,real field_specificity_left
    ,real field_specificity_right
  };

  lay_scores :=
  {
     lay_scores_prep
    ,boolean    Is_above_Threshold 
    ,boolean    is_hyphen_match_good 
    ,unsigned   is_complete_salt_mismatch
    ,unsigned   is_substring_mismatch_lt3
    ,unsigned   is_substring_mismatch_lt4
    ,unsigned   is_substring_mismatch_lt5
    ,unsigned   is_complete_mismatch_lt3_strGT10
    ,unsigned   is_complete_mismatch_lt3
    ,unsigned   is_complete_mismatch_lt4
    ,unsigned   is_complete_mismatch_lt5
    ,boolean    is_overall_match
  };

    // -- split into two datasets, one that should join normally without a big skew, and one that will have a big skew
    ds_get_bow_field_lt1000 :=      ds_get_bow_field(cnt <= 1000);
    ds_get_bow_field_gt1000 := sort(ds_get_bow_field(cnt >  1000),pID);
    
    // -- expected big skew join is sorted first globally, then add nosort on regular non-hash join.
    // -- runs very quickly even though it is skewed.
    ds_calc_scores_prepgt1000 := join(
       ds_get_bow_field_gt1000
      ,ds_get_bow_field_gt1000
      ,left.pID = right.pID and left.bow_field != '' and right.bow_field != '' and left.bow_field > right.bow_field
      ,transform(
         lay_scores_prep
        , 
        self.cnp_name_left        := left.cnp_name;
        self.cnp_name_right       := right.cnp_name;
        self.Annotated_BOW_Field_left    := left.bow_field;
        self.Annotated_BOW_Field_right   := right.bow_field;
        self.bow_spec_left               := left.bow_spec;
        self.bow_spec_right              := right.bow_spec;
        self.field_specificity_left      := left.field_specificity;
        self.field_specificity_right     := right.field_specificity;
        self                             := left;
        self                             := [];
      )
      ,nosort
    );

    ds_calc_scores_prep1 := join(
       ds_get_bow_field_lt1000
      ,ds_get_bow_field_lt1000
      ,left.pID = right.pID and left.bow_field != '' and right.bow_field != '' and left.bow_field > right.bow_field
      ,transform(
         lay_scores_prep
        , 
        self.cnp_name_left        := left.cnp_name;
        self.cnp_name_right       := right.cnp_name;
        self.Annotated_BOW_Field_left    := left.bow_field;
        self.Annotated_BOW_Field_right   := right.bow_field;
        self.bow_spec_left               := left.bow_spec;
        self.bow_spec_right              := right.bow_spec;
        self.field_specificity_left      := left.field_specificity;
        self.field_specificity_right     := right.field_specificity;
        self                             := left;
        self                             := [];
      )
      ,hash
    );

    ds_calc_scores_prep := project(distribute(ds_calc_scores_prep1 + ds_calc_scores_prepgt1000)  ,transform(lay_scores_prep
        , substring_info    := tools.Longest_Common_Substring(trim(left.cnp_name_left,left,right),trim(left.cnp_name_right,left,right));

          substring_size      := (unsigned)STD.Str.Extract( substring_info, 1 );
          index_start_string1 := (unsigned)STD.Str.Extract( substring_info, 2 ) + 1;
          index_start_string2 := (unsigned)STD.Str.Extract( substring_info, 3 ) + 1;

          index_end_string1 := substring_size + index_start_string1 - 1;
          index_end_string2 := substring_size + index_start_string2 - 1;

          substring_1               := trim(left.cnp_name_left  ,left,right)[index_start_string1..index_end_string1];
          substring_2               := trim(left.cnp_name_right ,left,right)[index_start_string2..index_end_string2];

        // self.cnp_name_left        := left.cnp_name;
        // self.cnp_name_right       := right.cnp_name;
        // self.Annotated_BOW_Field_left    := left.bow_field;
        // self.Annotated_BOW_Field_right   := right.bow_field;
        // self.bow_spec_left               := left.bow_spec;
        // self.bow_spec_right              := right.bow_spec;
        self.match_score                 := pBOW_Function(trim(left.Annotated_BOW_Field_left),trim(left.Annotated_BOW_Field_right),pBOW_Mode,pBOW_Score_Mode);
        self.hyphenmatch_score           := pHyphen_Match_function(trim(left.Annotated_BOW_Field_left),trim(left.Annotated_BOW_Field_right),pHyphen_Match_min_len);
        self.min_specificity             := (integer4)(MIN(left.field_specificity_left,left.field_specificity_right) * 100);
        self.substring_size              := substring_size;
        self.substring                   := substring_1;
        self                             := left  
    ),local)
//        : persist('~persist::BIPV2_Tools::mac_Compile_Overlinking_Info.ds_calc_scores_prep_' + #TEXT(pID));
    ;
  /* original
    // -- get scores for name matches within pID
    ds_calc_scores_prep := join(
       ds_get_bow_field
      ,ds_get_bow_field
      ,left.pID = right.pID and left.bow_field != '' and right.bow_field != '' and left.bow_field > right.bow_field
      ,transform(
         lay_scores_prep
        , substring_info    := tools.Longest_Common_Substring(trim(left.cnp_name,left,right),trim(right.cnp_name,left,right));

          substring_size      := (unsigned)STD.Str.Extract( substring_info, 1 );
          index_start_string1 := (unsigned)STD.Str.Extract( substring_info, 2 ) + 1;
          index_start_string2 := (unsigned)STD.Str.Extract( substring_info, 3 ) + 1;

          index_end_string1 := substring_size + index_start_string1 - 1;
          index_end_string2 := substring_size + index_start_string2 - 1;

          substring_1               := trim(left.cnp_name,left,right)[index_start_string1..index_end_string1];
          substring_2               := trim(right.cnp_name,left,right)[index_start_string2..index_end_string2];

        self.cnp_name_left        := left.cnp_name;
        self.cnp_name_right       := right.cnp_name;
        self.Annotated_BOW_Field_left    := left.bow_field;
        self.Annotated_BOW_Field_right   := right.bow_field;
        self.bow_spec_left               := left.bow_spec;
        self.bow_spec_right              := right.bow_spec;
        self.match_score                 := pBOW_Function(trim(left.bow_field),trim(right.bow_field),pBOW_Mode,pBOW_Score_Mode);
        self.hyphenmatch_score           := SALT30.HyphenMatch(trim(left.bow_field),trim(right.bow_field),1);
        self.min_specificity             := (integer4)(MIN(left.field_specificity,right.field_specificity) * 100);
        self.substring_size              := substring_size;
        self.substring                   := substring_1;
        self                             := left
      )
      ,hash
    )
      : persist('~persist::BIPV2_Tools::mac_Compile_Overlinking_Info.ds_calc_scores_prep');
  */


    ds_calc_scores := project(ds_calc_scores_prep ,transform(
       lay_scores
      , self.Is_above_Threshold          := left.match_score >= pName_Force * 100;
        self.is_hyphen_match_good        :=       left.hyphenmatch_score <=1 
                                             and left.min_specificity >= pName_Force * 100;
        self.is_substring_mismatch_lt3   := if(left.substring_size < 3  ,1 ,0);
        self.is_substring_mismatch_lt4   := if(left.substring_size < 4  ,1 ,0);
        self.is_substring_mismatch_lt5   := if(left.substring_size < 5  ,1 ,0);
        self.is_complete_salt_mismatch        := if(      left.match_score          = -min(left.bow_spec_left ,left.bow_spec_right) 
                                                      and self.is_hyphen_match_good = false 
                                                // and (       left.substring_size < 4 
                                                      // and ~(left.substring_size = 3 and left.substring_contains_space = true)
                                                    // )
                                                 ,1 ,0);  //complete mismatch will take the lower specificity of the two
                                                 
        self.is_complete_mismatch_lt3_strGT10 := if((self.is_complete_salt_mismatch + self.is_substring_mismatch_lt3) = 2 and length(trim(left.cnp_name_left)) >= 10 ,1  ,0);
        self.is_complete_mismatch_lt3    := if((self.is_complete_salt_mismatch + self.is_substring_mismatch_lt3) = 2  ,1  ,0);
        self.is_complete_mismatch_lt4    := if((self.is_complete_salt_mismatch + self.is_substring_mismatch_lt4) = 2  ,1  ,0);
        self.is_complete_mismatch_lt5    := if((self.is_complete_salt_mismatch + self.is_substring_mismatch_lt5) = 2  ,1  ,0);
        self.is_overall_match            := self.Is_above_Threshold or self.is_hyphen_match_good;
        self                             := left
    ));


    // -- aggregate scores per ID
    ds_agg_scores := table(ds_calc_scores ,{pID 
                                          ,unsigned cnt_salt_mismatches           := sum(group,is_complete_salt_mismatch)
                                          ,unsigned cnt_substring_mismatch_lt3    := sum(group,is_substring_mismatch_lt3)
                                          ,unsigned cnt_substring_mismatch_lt4    := sum(group,is_substring_mismatch_lt4)
                                          ,unsigned cnt_substring_mismatch_lt5    := sum(group,is_substring_mismatch_lt5)
                                          ,unsigned cnt_complete_mismatch_lt3_strGT10    := sum(group,is_complete_mismatch_lt3_strGT10)
                                          ,unsigned cnt_complete_mismatch_lt3    := sum(group,is_complete_mismatch_lt3)
                                          ,unsigned cnt_complete_mismatch_lt4    := sum(group,is_complete_mismatch_lt4)
                                          ,unsigned cnt_complete_mismatch_lt5    := sum(group,is_complete_mismatch_lt5)
                                          ,unsigned cnt_overall_matches           := sum(group,if(is_overall_match = true ,1  ,0))
                                          } 
                                          ,pID  ,merge);

    // cnt ,ID       ,count_description      ,ID value.
    // 50  ,'proxid' ,'mismatched cnp_names' ,1234 
    // 100 ,'lgid3'  ,'feins'                ,1234 
    // 10  ,'proxid' ,'corpkeys'             ,5678    

    #IF(trim(STD.Str.ToUpperCase(#TEXT(pID))) = 'SELEID' )
      ds_agg_all_slim := table(ds_agg_all ,{pID   ,unsigned6 orgid := orgids[1].orgid ,unsigned6 ultid := ultids[1].ultid
    #ELSE
      ds_agg_all_slim := table(ds_agg_all ,{pID ,unsigned6 seleid := seleids[1].seleid  ,unsigned6 orgid := orgids[1].orgid ,unsigned6 ultid := ultids[1].ultid
    #END
    ,unsigned count_all  := count_cnp_name_raws + count_a_dunss+ count_a_entnums+ count_a_corpkeys+ count_feins+ count_sbfe_ids + count_addresss + count_company_phones 
    ,unsigned count_keys := count_a_dunss+ count_a_entnums+ count_a_corpkeys+ count_feins+ count_sbfe_ids 
    ,count_cnp_name_raws  ,count_a_dunss  ,count_a_entnums        ,count_a_corpkeys ,count_feins
    ,count_sbfe_ids   ,count_vl_ids   ,count_source_record_ids,count_addresss   ,count_company_phones 
    ,count_dotids #IF(#TEXT(pID) not in ['proxid']) ,count_proxids  #END
    });
    cnp_name_counts_norm := table(ds_agg_all_slim  ,{count_cnp_name_raws} ,count_cnp_name_raws ,merge);
    cnp_name_counts_norm_map := project(sort(cnp_name_counts_norm,count_cnp_name_raws)  ,transform(
    {recordof(left),unsigned mapped_cnp_name_cnt}
    ,self := left
    ,self.mapped_cnp_name_cnt := counter
    ));
    max_cnp_names := max(cnp_name_counts_norm_map,mapped_cnp_name_cnt);
    ds_agg_all_slim_prep := join(ds_agg_all_slim  ,cnp_name_counts_norm_map ,left.count_cnp_name_raws = right.count_cnp_name_raws 
    ,transform({recordof(left) or recordof(right)}
    ,self := left
    ,self := right
    )
    ,hash);
    
    result_prep := join(ds_agg_all_slim_prep ,ds_agg_scores  ,left.pID = right.pID ,transform({unsigned6 pID,real8 diff_cnp_names_score,string pctile_cnp_names,string pct_bow_mismatches, string pct_bow_mismatches_lt3 ,recordof(left) - pID or recordof(right) - pID}
    ,self := left
    ,self := right
    ,self.pctile_cnp_names        := realformat(left.mapped_cnp_name_cnt / max_cnp_names * 100.0 ,10,4)
    ,self.pct_bow_mismatches      := realformat(right.cnt_salt_mismatches                / ((left.count_cnp_name_raws - 1)*(1+(left.count_cnp_name_raws - 1))/2 ) * 100.0,10,4)
    ,self.pct_bow_mismatches_lt3  := realformat(right.cnt_complete_mismatch_lt3_strgt10  / ((left.count_cnp_name_raws - 1)*(1+(left.count_cnp_name_raws - 1))/2 ) * 100.0,10,4)
    ,self.diff_cnp_names_score    := (real8)self.pct_bow_mismatches_lt3 * (real8)self.pctile_cnp_names * ln(right.cnt_complete_mismatch_lt3_strgt10) // add multiplier to weight lots of cnp_names higher
    )  ,left outer,hash);
   
    max_diff_cnp_names_score := max(result_prep ,diff_cnp_names_score);
    
    // -- stats on max cnp_names each sbfe_id contains,// and how many bow mismatches they have
    ds_sbfe_slim := table(pDataset(mdr.sourcetools.SourceIsBusiness_Credit(source),trim(vl_id) != ''),{pID,string sbfe_id := vl_id,cnp_name}  ,pID,vl_id,cnp_name ,merge);
    ds_sbfe_cnt_cnp_names := table(ds_sbfe_slim ,{pID,sbfe_id ,unsigned cnt := count(group)}  ,pID,sbfe_id ,merge);
    ds_sbfe_cnt_cnp_names_max := table(ds_sbfe_cnt_cnp_names ,{pID,unsigned cnt := max(group,cnt)}  ,pID ,merge);
   
    // -- stats on max cnp_names per fein
    ds_sbfe_fein_slim := table(pDataset(mdr.sourcetools.SourceIsBusiness_Credit(source),(unsigned)company_fein != 0),{pID,company_fein,cnp_name}  ,pID,company_fein,cnp_name ,merge);
    ds_sbfe_fein_cnt_cnp_names := table(ds_sbfe_fein_slim ,{pID,company_fein ,unsigned cnt := count(group)}  ,pID,company_fein ,merge);
    ds_sbfe_fein_cnt_cnp_names_max := table(ds_sbfe_fein_cnt_cnp_names ,{pID,unsigned cnt := max(group,cnt)}  ,pID ,merge);

    // -- D&B fein -- counts on number of feins within a cluster grouped by cnp_name
    ds_dnb_fein_slim := table(pDataset(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != ''),{pID,cnp_name,company_fein}  ,pID,cnp_name,company_fein ,merge);
    ds_dnb_fein_cnt_cnp_names := table(ds_dnb_fein_slim ,{pID,cnp_name ,unsigned cnt := count(group)}  ,pID,cnp_name ,merge);
    ds_dnb_fein_cnt_feins_max := table(ds_dnb_fein_cnt_cnp_names ,{pID,unsigned cnt := max(group,cnt)}  ,pID ,merge);

    ds_dnb_fein_old_slim := table(pDataset(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old'  ,trim(duns_number) != ''),{pID});
    ds_total_bad_dnb_fein_recs_per_proxid := table(ds_dnb_fein_old_slim  ,{pID,unsigned cnt := count(group)} ,pID ,merge);

    //-- manish wants to count the number of cnp_names and feins per duns_number within a cluster(presumable from D&B fein)
    ds_dnb_fein_duns_slim               := table(pDataset(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old',trim(duns_number) != ''),{pID,duns_number,cnp_name,company_fein}  ,pID,duns_number,cnp_name,company_fein ,merge);
    ds_dnb_fein_cnt_cnp_names_per_duns  := table(table(ds_dnb_fein_duns_slim ,{pID,duns_number,cnp_name    } ,pID,duns_number,cnp_name     ,merge),{pID,duns_number,unsigned cnt_cnp_names := count(group)},pID,duns_number ,merge);
    ds_dnb_fein_cnt_feins_per_duns      := table(table(ds_dnb_fein_duns_slim ,{pID,duns_number,company_fein} ,pID,duns_number,company_fein ,merge),{pID,duns_number,unsigned cnt_feins     := count(group)},pID,company_fein,merge);
    ds_dnb_fein_duns_join               := join(ds_dnb_fein_cnt_cnp_names_per_duns,ds_dnb_fein_cnt_feins_per_duns ,left.pID = right.pID and left.duns_number = right.duns_number,transform({recordof(left) or recordof(right)},self := right,self := left),hash);
    ds_dnb_fein_duns_cnt_max            := table(ds_dnb_fein_duns_join ,{pID ,unsigned cnt_cnp_names := max(group,cnt_cnp_names),unsigned cnt_feins := max(group,cnt_feins)}  ,pID ,merge);


    // -- D&B fein -- counts on number of feins grouped by cnp_name and address regardless of cluster
    ds_dnb_fein_slim_nocluster      := table(pDataset(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old'  ,trim(duns_number) != '') ,{cnp_name,prim_range,prim_name,v_city_name,st,zip,company_fein}  ,cnp_name,prim_range,prim_name,v_city_name,st,zip,company_fein ,merge);
    ds_dnb_fein_cnt_feins_nocluster := table(ds_dnb_fein_slim_nocluster ,{cnp_name,prim_range,prim_name,v_city_name,st,zip ,unsigned cnt := count(group)}  ,cnp_name,prim_range,prim_name,v_city_name,st,zip ,merge);
    ds_dnb_fein_slim_nocluster2      := table(pDataset(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old'  ,trim(duns_number) != '') ,{pID,cnp_name,prim_range,prim_name,v_city_name,st,zip}  ,pID,cnp_name,prim_range,prim_name,v_city_name,st,zip ,merge);
    ds_dnb_fein_cnt_feins_nocluster_id := join(ds_dnb_fein_slim_nocluster2  ,ds_dnb_fein_cnt_feins_nocluster  ,left.cnp_name = right.cnp_name and left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip
                                          ,transform({ds_dnb_fein_slim_nocluster2.pID,unsigned cnt_feins},self.cnt_feins := right.cnt,self := left)    ,hash);
    ds_dnb_fein_cnt_feins_nocluster_ids := table(ds_dnb_fein_cnt_feins_nocluster_id ,{pID,unsigned cnt := max(group,cnt_feins)} ,pID,merge);
    
    ds_result_add_sbfe := join(result_prep  ,ds_sbfe_cnt_cnp_names_max  ,left.pID = right.pID ,transform({unsigned6 pID,dataset({string stat,unsigned cnt}) ds_misc_stats,recordof(left) - pID}
      ,self.ds_misc_stats := dataset([{'Max cnp_names per sbfe_id',right.cnt}],{string stat,unsigned cnt})
      ,self               := left
    ) ,left outer,hash);
    
    ds_result_add_dnb_fein := join(ds_result_add_sbfe  ,ds_dnb_fein_cnt_feins_max  ,left.pID = right.pID ,transform(recordof(left)
      ,self.ds_misc_stats := left.ds_misc_stats + dataset([{'Max feins per cnp_name from D&B fein',right.cnt}],{string stat,unsigned cnt})
      ,self               := left
    ) ,left outer,hash);

    ds_result_add_sbfe_fein := join(ds_result_add_dnb_fein  ,ds_sbfe_fein_cnt_cnp_names_max  ,left.pID = right.pID ,transform(recordof(left)
      ,self.ds_misc_stats := left.ds_misc_stats + dataset([{'Max cnp_names per fein from SBFE',right.cnt}],{string stat,unsigned cnt})
      ,self               := left
    ) ,left outer,hash);

    ds_result_add_dnb_fein_old := join(ds_result_add_sbfe_fein  ,ds_total_bad_dnb_fein_recs_per_proxid  ,left.pID = right.pID ,transform(recordof(left)
      ,self.ds_misc_stats := left.ds_misc_stats + dataset([{'Count Old D&B Fein mismapped records in cluster',right.cnt}],{string stat,unsigned cnt})
      ,self               := left
    ) ,left outer,hash);

    ds_result_add_dnb_fein_nocluster := join(ds_result_add_dnb_fein_old  ,ds_dnb_fein_cnt_feins_nocluster_ids  ,left.pID = right.pID ,transform(recordof(left)
      ,self.ds_misc_stats := left.ds_misc_stats + dataset([{'Max feins per cnp_name, address from D&B fein regardless of cluster',right.cnt}],{string stat,unsigned cnt})
      ,self               := left
    ) ,left outer,hash);

    //manish wants to count the number of cnp_names and feins per duns_number within a cluster(presumable from D&B fein)
    ds_result_add_dnb_fein_duns_count_max := join(ds_result_add_dnb_fein_nocluster  ,ds_dnb_fein_duns_cnt_max  ,left.pID = right.pID ,transform(recordof(left)
      ,self.ds_misc_stats := left.ds_misc_stats 
                            + dataset([{'Max feins per duns_number'     ,right.cnt_feins    }],{string stat,unsigned cnt})
                            + dataset([{'Max cnp_names per duns_number' ,right.cnt_cnp_names}],{string stat,unsigned cnt})
      ,self               := left
    ) ,left outer,hash);
    
    ds_result_add_sources := join(ds_result_add_dnb_fein_duns_count_max ,ds_base_rollup_sources ,left.pID = right.pID ,transform({recordof(left),set of string sources},self.sources := right.sources,self := left) ,hash);
    
    result := project(ds_result_add_sources  ,transform({unsigned6 pID,string pctile_diff_cnp_names ,recordof(left) - pID}
      ,self.pctile_diff_cnp_names := realformat(left.diff_cnp_names_score / max_diff_cnp_names_score * 100.0  ,10,4)
      ,self := left
    ));
    
    // pct_bow_mismatches_lt3
//    34% looks ok
//    39% looks ok
//    73% bad           93%
//    27% ok
//    25% ok
//    36% ok
//    60% bad
//    27% ok
//    36% maybe bad
//    42% questionable
//    38% bad
  /*
    potential overlinked clusters
    by fein
    by corpkey
    by duns
    by all godkeys
    by all godkeys plus cnp_names
    by mismatched company names
    by all unique entities
    more detailed overlinking info
    
  */
   output_debug := parallel(
       // output(count   (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 1)) ,named('count_is_complete_mismatch_proxid_41686893'     ),all)
      // ,output(count   (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 0)) ,named('count_not_complete_mismatch_proxid_41686893'     ),all)

      // ,output(topn    (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 1) ,500  , proxid  ) ,named('is_complete_mismatch_asc_proxid_41686893'     ),all)
      // ,output(topn    (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 1) ,500  ,-proxid  ) ,named('is_complete_mismatch_desc_proxid_41686893'    ),all)
      // ,output(choosen (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 1) ,500            ) ,named('is_complete_mismatch_choosen_proxid_41686893' ),all)
      // ,output(enth    (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 1) ,500            ) ,named('is_complete_mismatch_enth_proxid_41686893'    ),all)
      // ,output('-------------------------------------------------------------'  ,named('______________________'))
      // ,output(topn    (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 0) ,500  , proxid  ) ,named('not_complete_mismatch_asc_proxid_41686893'    ),all)
      // ,output(topn    (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 0) ,500  ,-proxid  ) ,named('not_complete_mismatch_desc_proxid_41686893'   ),all)
      // ,output(choosen (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 0) ,500            ) ,named('not_complete_mismatch_choosen_proxid_41686893'),all)
      // ,output(enth    (ds_calc_scores(proxid = 41686893,is_complete_mismatch_lt3 = 0) ,500            ) ,named('not_complete_mismatch_enth_proxid_41686893'   ),all)
      // ,output('-------------------------------------------------------------'  ,named('________________________'))

      output('Examples of Complete SALT BOW mismatches sorted Descending by longest common subtring size'  ,named('_'))
      ,output(topn    (ds_calc_scores(is_complete_salt_mismatch = 1     ) ,500  ,-substring_size              ) ,named('complete_BOW_mismatches_'   + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_complete_salt_mismatch = 1     ) ,500  , substring_size              ) ,named('complete_salt_mismatch_asc_substring_size'    + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_hyphen_match_good      = false ) ,500  ,-substring_size              ) ,named('complete_hyphen_mismatch_desc_substring_size' + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_hyphen_match_good      = false ) ,500  , substring_size              ) ,named('complete_hyphen_mismatch_asc_substring_size'  + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_substring_mismatch_lt3 = 1     ) ,500  , is_complete_salt_mismatch   ) ,named('substring_lt_3_asc_salt_mistmatch'            + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_substring_mismatch_lt4 = 1     ) ,500  , is_complete_salt_mismatch   ) ,named('substring_lt_4_asc_salt_mistmatch'            + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_substring_mismatch_lt5 = 1     ) ,500  , is_complete_salt_mismatch   ) ,named('substring_lt_5_asc_salt_mistmatch'            + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_substring_mismatch_lt3 = 1     ) ,500  ,-is_complete_salt_mismatch   ) ,named('substring_lt_3_desc_salt_mistmatch'           + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_substring_mismatch_lt4 = 1     ) ,500  ,-is_complete_salt_mismatch   ) ,named('substring_lt_4_desc_salt_mistmatch'           + #TEXT(pID)),all)
      // ,output(topn    (ds_calc_scores(is_substring_mismatch_lt5 = 1     ) ,500  ,-is_complete_salt_mismatch   ) ,named('substring_lt_5_desc_salt_mistmatch'           + #TEXT(pID)),all)

   );
//  end;  //end of module

    return when(result,output_debug);
  
endmacro;
/*
  ds_agg_scores := table(ds_calc_scores ,{
     pID  
    ,unsigned cnt                 := count(group)
    ,unsigned cnt_below_threshold := sum(group,if(Is_above_Threshold = false,1,0))  
    ,unsigned cnt_above_threshold := sum(group,if(Is_above_Threshold = true ,1,0)) 
    ,string10 pct_below_threshold := realformat((real8)(sum(group,if(Is_above_Threshold = false,1,0)) / count(group)) ,8,2)
    ,string10 pct_above_threshold := realformat((real8)(sum(group,if(Is_above_Threshold = true ,1,0)) / count(group)) ,8,2) 
    ,INTEGER4 min_score           := min(group,match_score)//range of scores
    ,INTEGER4 max_score           := max(group,match_score)//range of scores
    ,real8    mean_score          := ave(group,match_score) // ,is_hyphen_match_good   => pName_Force * 100 //hyphen match good = match at lowest confidence
    // -- help from HealthCare_Provider_Header_Common.mac_AggregateStats
    ,real8    var0                := SUM(group, POWER(mean_score - match_score, 2))                                             
    ,real8    var                 := IF(cnt = 0, 0, var0 / cnt) 
    ,real8    stdev               := SQRT(var); // 1-sigma value
    ,real8    deviations          := SQRT(POWER(mean_score - match_score, 2)/cnt)/stdev
    ,unsigned score_range         := max_score - min_score

  } ,pID   ,merge);

  ds_agg_scores_add := project(ds_agg_scores  ,transform({recordof(left),real8 var0,real8    var,real8    stdev,real8    deviations,unsigned score_range}
    ,self.var0                := POWER(left.mean_score - left.match_score, 2)                                            
    ,self.var                 := IF(cnt = 0, 0, var0 / cnt) 
    ,self.stdev               := SQRT(var); // 1-sigma value
    ,self.deviations          := SQRT(POWER(mean_score - match_score, 2)/cnt)/stdev
    ,self.score_range         := max_score - min_score

  
  ));
*/