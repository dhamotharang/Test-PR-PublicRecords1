/*
  take both match sample keys
  dedup them on %lID2%, -conf, %lID1% to get the lowest %lID1% for the highest confidence match to %lID2%
  those are most likely the actual matches.
  then do the rolling up so we have the child dataset + the conf, %lID1%, %lID2% fields for both.
  then, i can join them together to get samples of the diffs
    %lID1% and %lID2% equal each other, but conf is different.  two child datasets, one for both
    %lID1% equals, but %lID2% is different.  4 child datasets, two for salt30, two for salt37 showing the differences
    
  example wuids:
   W20181015-111957  -- lgid3 without an attribute file
   W20181008-162946  -- proxid with an attribute file


*/


import tools,std;

EXPORT mac_Validate_Internal_Linking(

   pMatchSampleKey_old                  //Match sample debug index
  ,pMatchCandidatesKey_old              //Match Candidates key
  ,pSpecificitiesKey_old                //Match Candidates key
  ,pAttributeMatchesKey_old             //Match Candidates key
  ,pInFile_old                          //Infile for matching(BIPV2_ProxID.In_DOT_Base).  use the fully qualified name, i.e. BIPV2_ProxID.In_DOT_Base instead of a variable
  ,pThreshold_old                       //threshold for your matching
  ,pModule_old

  ,pMatchSampleKey_new                  //Match sample debug index
  ,pMatchCandidatesKey_new              //Match Candidates key
  ,pSpecificitiesKey_new                //Match Candidates key
  ,pAttributeMatchesKey_new             //Match Candidates key
  ,pInFile_new                          //Infile for matching(BIPV2_ProxID.In_DOT_Base)
  ,pThreshold_new                       //threshold for your matching
  ,pModule_new

  ,pID                                //Internal linking id(proxid, dotid, bdid, did, etc)
  ,pOutput_Debug                = 'false'
  ,pOutput_Breakdown_Also       = 'false' // if true, will further breakdown the stats for new only matches and old only matches.  Takes longer, maybe up to an hour
  
) :=
functionmacro

  #uniquename(lID )
  #uniquename(lID1)
  #uniquename(lID2)
  #uniquename(katt_old_)
  #uniquename(katt_new_)
  
  #SET(lID  ,trim(#TEXT(pID)))
  #SET(lID1 ,trim(#TEXT(pID)) + '1')
  #SET(lID2 ,trim(#TEXT(pID)) + '2')

  #IF(trim(#TEXT(pAttributeMatchesKey_old)) not in ['','\'\'']) // if we have attribute key
    #SET(katt_old_  ,#TEXT(pAttributeMatchesKey_old))
  #ELSE
    #SET(katt_old_  ,pAttributeMatchesKey_old)
  #END
  
  #IF(trim(#TEXT(pAttributeMatchesKey_new)) not in ['','\'\'']) // if we have attribute key
    #SET(katt_new_  ,#TEXT(pAttributeMatchesKey_new))
  #ELSE
    #SET(katt_new_  ,pAttributeMatchesKey_new)
  #END


  // pInFile_old                  := pInFile_old                ;
  kmtch_old                   := pMatchSampleKey_old        ;
  kcand_old                   := pMatchCandidatesKey_old    ;
  katt_old                    := pAttributeMatchesKey_old   ;
  kspec_old                   := pSpecificitiesKey_old      ;

  // pInFile_new                  := pInFile_new                ;
  kmtch_new                   := pMatchSampleKey_new        ;
  kcand_new                   := pMatchCandidatesKey_new    ;
  katt_new                    := pAttributeMatchesKey_new   ;
  kspec_new                   := pSpecificitiesKey_new      ;

  kmtch_old_above_threshold := kmtch_old(conf >= pThreshold_old);
  kmtch_new_above_threshold := kmtch_new(conf >= pThreshold_new);

  // -- do the rollup first, then do these joins
  kcand_old_prep  := project(kcand_old ,transform(pModule_old.match_candidates(pInFile_old).layout_candidates,self := left,self := []) );
  kcand_new_prep  := project(kcand_new ,transform(pModule_new.match_candidates(pInFile_new).layout_candidates,self := left,self := []) );

  ds_same_matches           := join(kmtch_old_above_threshold ,kmtch_new_above_threshold ,left.%lID1% = right.%lID1% and left.%lID2% = right.%lID2% and left.conf  = right.conf ,transform(left ),hash            );
  ds_same_matches_diff_conf := join(kmtch_old_above_threshold ,kmtch_new_above_threshold ,left.%lID1% = right.%lID1% and left.%lID2% = right.%lID2% and left.conf != right.conf ,transform(left ),hash            );
  ds_old_only_matches       := join(kmtch_old_above_threshold ,kmtch_new_above_threshold ,left.%lID1% = right.%lID1% and left.%lID2% = right.%lID2%                             ,transform(left ),hash,left  only );
  ds_new_only_matches       := join(kmtch_old_above_threshold ,kmtch_new_above_threshold ,left.%lID1% = right.%lID1% and left.%lID2% = right.%lID2%                             ,transform(right),hash,right only );

  // -- now grab samples from each of the above joins.  start with 100
  // -- and then normalize them out.  then join them to kmtch and kcand to get the sample records from those keys
  // -- then i can pass them through these macros
  ds_same_matches_sample            := enth(ds_same_matches                  ,300); 
  ds_same_matches_diff_conf_sample  := enth(ds_same_matches_diff_conf        ,300); 
  ds_old_only_matches_sample        := enth(ds_old_only_matches              ,300); 
  ds_new_only_matches_sample        := enth(ds_new_only_matches              ,300); 

  sample_id1 := ds_same_matches_sample[1].%lID1%;
  sample_id2 := ds_same_matches_sample[1].%lID2%;

  sample_id1_diff_conf := ds_same_matches_diff_conf_sample[1].%lID1%;
  sample_id2_diff_conf := ds_same_matches_diff_conf_sample[1].%lID2%;

  // -- and then normalize them out.  then join them to kmtch and kcand to get the sample records from those keys
  ds_same_matches_sample_norm             := normalize(ds_same_matches_sample            ,2  ,transform({unsigned6 %lID%},self.%lID% := if(counter = 1  ,left.%lID1% ,left.%lID2%)));
  ds_same_matches_diff_conf_sample_norm   := normalize(ds_same_matches_diff_conf_sample  ,2  ,transform({unsigned6 %lID%},self.%lID% := if(counter = 1  ,left.%lID1% ,left.%lID2%)));
  ds_old_only_matches_sample_norm         := normalize(ds_old_only_matches_sample        ,2  ,transform({unsigned6 %lID%},self.%lID% := if(counter = 1  ,left.%lID1% ,left.%lID2%)));
  ds_new_only_matches_sample_norm         := normalize(ds_new_only_matches_sample        ,2  ,transform({unsigned6 %lID%},self.%lID% := if(counter = 1  ,left.%lID1% ,left.%lID2%)));

  set_sample_same_matches_IDs           := set(ds_same_matches_sample_norm              ,%lID%);
  set_sample_same_matches_diff_conf_IDs := set(ds_same_matches_diff_conf_sample_norm    ,%lID%);
  set_sample_old_only_IDs               := set(ds_old_only_matches_sample_norm          ,%lID%);
  set_sample_new_only_IDs               := set(ds_new_only_matches_sample_norm          ,%lID%);

  // -- spec is the same for all of them, only one record
  kspec_old_prep          := PROJECT(kspec_old,pModule_old.Layout_Specificities.R);
  kspec_new_prep          := PROJECT(kspec_new,pModule_new.Layout_Specificities.R);

  // -- same matches
  kmtch_old_same_matches_sample  := kmtch_old_above_threshold(%lID1% in set_sample_same_matches_IDs,%lID2% in set_sample_same_matches_IDs);
  kcand_old_same_matches_sample  := kcand_old_prep (%lID% in set_sample_same_matches_IDs);
  #IF(trim(%'katt_old_'%) not in ['','\'\''])
  katt_old_same_matches_sample   := project(katt_old(%lID1% in set_sample_same_matches_IDs,%lID2% in set_sample_same_matches_IDs),pModule_old.Match_Candidates(pInFile_old).layout_attribute_matches);
  #ELSE
  katt_old_same_matches_sample   := '';
  #END
  kmtch_new_same_matches_sample  := kmtch_new_above_threshold(%lID1% in set_sample_same_matches_IDs,%lID2% in set_sample_same_matches_IDs);
  kcand_new_same_matches_sample  := kcand_new_prep (%lID% in set_sample_same_matches_IDs);
  #IF(trim(%'katt_new_'%) not in ['','\'\''])
  katt_new_same_matches_sample   := project(katt_new(%lID1% in set_sample_same_matches_IDs,%lID2% in set_sample_same_matches_IDs),pModule_new.Match_Candidates(pInFile_new).layout_attribute_matches);
  #ELSE
  katt_new_same_matches_sample   := '';
  #END

  kmtch_new_same_matches_sample_debug  := kmtch_new_above_threshold (%lID1% = sample_id1,%lID2% = sample_id2);
  kcand_new_same_matches_sample_debug  := kcand_new_prep            (%lID% in [sample_id1,sample_id2]);


  ds_rollup_old_same_matches            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_sample  ,kcand_old_same_matches_sample  ,kspec_old_prep ,katt_old_same_matches_sample  ,pInFile_old ,%lID% ,rcid ,'.*' ,false  ,false  ,'' );
  ds_rollup_new_same_matches            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_sample  ,kcand_new_same_matches_sample  ,kspec_new_prep ,katt_new_same_matches_sample  ,pInFile_new ,%lID% ,rcid ,'.*' ,false  ,false  ,'' );
  ds_side_by_side_same_matches_matches  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_same_matches ,ds_rollup_new_same_matches  ,%lID%);

  ds_rollup_old_same_matches_debug            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_sample_debug  ,kcand_old_same_matches_sample  ,kspec_old_prep ,katt_old_same_matches_sample  ,pInFile_old ,%lID% ,rcid ,'.*' ,false  ,true  ,'_Rollup_Old_matches_debug' );
  ds_rollup_new_same_matches_debug            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_sample_debug  ,kcand_new_same_matches_sample  ,kspec_new_prep ,katt_new_same_matches_sample  ,pInFile_new ,%lID% ,rcid ,'.*' ,false  ,true  ,'_Rollup_new_matches_debug' );
  ds_side_by_side_same_matches_matches_debug  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_same_matches_debug ,ds_rollup_new_same_matches_debug  ,%lID%);

  // -- same matches, different confidence
  kmtch_old_same_matches_diff_conf_sample  := kmtch_old_above_threshold(%lID1% in set_sample_same_matches_diff_conf_IDs,%lID2% in set_sample_same_matches_diff_conf_IDs);
  kcand_old_same_matches_diff_conf_sample  := kcand_old_prep (%lID% in set_sample_same_matches_diff_conf_IDs);
  #IF(trim(%'katt_old_'%) not in ['','\'\''])
  katt_old_same_matches_diff_conf_sample   := project(katt_old(%lID1% in set_sample_same_matches_diff_conf_IDs,%lID2% in set_sample_same_matches_diff_conf_IDs),pModule_old.Match_Candidates(pInFile_old).layout_attribute_matches);
  #ELSE
  katt_old_same_matches_diff_conf_sample   := '';
  #END

  kmtch_new_same_matches_diff_conf_sample  := kmtch_new_above_threshold(%lID1% in set_sample_same_matches_diff_conf_IDs,%lID2% in set_sample_same_matches_diff_conf_IDs);
  kcand_new_same_matches_diff_conf_sample  := kcand_new_prep (%lID% in set_sample_same_matches_diff_conf_IDs);
  #IF(trim(%'katt_new_'%) not in ['','\'\''])
  katt_new_same_matches_diff_conf_sample   := project(katt_new(%lID1% in set_sample_same_matches_diff_conf_IDs,%lID2% in set_sample_same_matches_diff_conf_IDs),pModule_new.Match_Candidates(pInFile_new).layout_attribute_matches);
  #ELSE
  katt_new_same_matches_diff_conf_sample   := '';
  #END

  kmtch_new_same_matches_diff_conf_sample_debug  := kmtch_new_above_threshold (%lID1% = sample_id1_diff_conf,%lID2% = sample_id2_diff_conf);
  kcand_new_same_matches_diff_conf_sample_debug  := kcand_new_prep            (%lID% in [sample_id1_diff_conf,sample_id2_diff_conf]);

  ds_rollup_old_same_matches_diff_conf            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_diff_conf_sample  ,kcand_old_same_matches_diff_conf_sample  ,kspec_old_prep ,katt_old_same_matches_diff_conf_sample  ,pInFile_old ,%lID% ,rcid ,'.*' ,false  ,false  ,'' );
  ds_rollup_new_same_matches_diff_conf            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_diff_conf_sample  ,kcand_new_same_matches_diff_conf_sample  ,kspec_new_prep ,katt_new_same_matches_diff_conf_sample  ,pInFile_new ,%lID% ,rcid ,'.*' ,false	,false  ,'' );
  ds_side_by_side_same_matches_diff_conf_matches  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_same_matches_diff_conf ,ds_rollup_new_same_matches_diff_conf  ,%lID%);

  ds_rollup_old_same_matches_diff_conf_debug            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_diff_conf_sample_debug  ,kcand_old_same_matches_diff_conf_sample  ,kspec_old_prep ,katt_old_same_matches_diff_conf_sample  ,pInFile_old ,%lID% ,rcid ,'.*' ,false  ,true  ,'_Rollup_Old_DIFF_CONF_debug' );
  ds_rollup_new_same_matches_diff_conf_debug            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_same_matches_diff_conf_sample_debug  ,kcand_new_same_matches_diff_conf_sample  ,kspec_new_prep ,katt_new_same_matches_diff_conf_sample  ,pInFile_new ,%lID% ,rcid ,'.*' ,false  ,true  ,'_Rollup_new_DIFF_CONF_debug' );
  ds_side_by_side_same_matches__diff_conf_debug  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_same_matches_diff_conf_debug ,ds_rollup_new_same_matches_diff_conf_debug  ,%lID%);

  // -- old only matches
  kmtch_old_old_only_sample  := kmtch_old_above_threshold(%lID1% in set_sample_old_only_IDs,%lID2% in set_sample_old_only_IDs);
  kcand_old_old_only_sample  := kcand_old_prep (%lID% in set_sample_old_only_IDs);
  #IF(trim(%'katt_old_'%) not in ['','\'\''])
  katt_old_old_only_sample    := project(katt_old(%lID1% in set_sample_old_only_IDs,%lID2% in set_sample_old_only_IDs),pModule_old.Match_Candidates(pInFile_old).layout_attribute_matches);
  katt_old_old_only           := project(katt_old,pModule_old.Match_Candidates(pInFile_old).layout_attribute_matches);
  #ELSE
  katt_old_old_only_sample    := '';
  katt_old_old_only           := '';
  #END

  kmtch_new_old_only_sample  := kmtch_new_above_threshold(%lID1% in set_sample_old_only_IDs,%lID2% in set_sample_old_only_IDs);
  kcand_new_old_only_sample  := kcand_new_prep (%lID% in set_sample_old_only_IDs);
  #IF(trim(%'katt_new_'%) not in ['','\'\''])
  katt_new_old_only_sample    := project(katt_new(%lID1% in set_sample_old_only_IDs,%lID2% in set_sample_old_only_IDs),pModule_new.Match_Candidates(pInFile_new).layout_attribute_matches);
  katt_new_old_only           := project(katt_new,pModule_new.Match_Candidates(pInFile_new).layout_attribute_matches);
  #ELSE
  katt_new_old_only_sample    := '';
  katt_new_old_only           := '';
  #END

  ds_rollup_old_old_only            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_old_old_only_sample  ,kcand_old_old_only_sample  ,kspec_old_prep ,katt_old_old_only_sample  ,pInFile_old ,%lID% ,rcid ,'.*' ,false ,false ,'' );
  ds_rollup_new_old_only            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_old_old_only_sample  ,kcand_new_old_only_sample  ,kspec_new_prep ,katt_new_old_only_sample  ,pInFile_new ,%lID% ,rcid ,'.*' ,false ,false ,'' );
  ds_side_by_side_old_only_matches  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_old_only ,ds_rollup_new_old_only  ,%lID%);

  ds_rollup_old_old_only_full       := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( ds_old_only_matches  ,kcand_old_prep  ,kspec_old_prep ,katt_old_old_only  ,pInFile_old ,%lID% ,rcid ,'.*' ,false ,false ,'' );
  ds_rollup_new_old_only_full       := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( ds_old_only_matches  ,kcand_new_prep  ,kspec_new_prep ,katt_new_old_only  ,pInFile_new ,%lID% ,rcid ,'.*' ,false ,false ,'' );
  ds_side_by_side_old_only_matches_full  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_old_only_full ,ds_rollup_new_old_only_full  ,%lID%);

  // -- new only matches
  kmtch_old_new_only_sample  := kmtch_old_above_threshold(%lID1% in set_sample_new_only_IDs,%lID2% in set_sample_new_only_IDs);
  kcand_old_new_only_sample  := kcand_old_prep (%lID% in set_sample_new_only_IDs);
  #IF(trim(%'katt_old_'%) not in ['','\'\''])
  katt_old_new_only_sample   := project(katt_old(%lID1% in set_sample_new_only_IDs,%lID2% in set_sample_new_only_IDs),pModule_old.Match_Candidates(pInFile_old).layout_attribute_matches);
  #ELSE
  katt_old_new_only_sample   := '';
  #END

  kmtch_new_new_only_sample  := kmtch_new_above_threshold(%lID1% in set_sample_new_only_IDs,%lID2% in set_sample_new_only_IDs);
  kcand_new_new_only_sample  := kcand_new_prep (%lID% in set_sample_new_only_IDs);
  #IF(trim(%'katt_new_'%) not in ['','\'\''])
  katt_new_new_only_sample   := project(katt_new(%lID1% in set_sample_new_only_IDs,%lID2% in set_sample_new_only_IDs),pModule_new.Match_Candidates(pInFile_new).layout_attribute_matches);
  #ELSE
  katt_new_new_only_sample   := '';
  #END

  ds_rollup_old_new_only            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_new_only_sample  ,kcand_old_new_only_sample  ,kspec_old_prep ,katt_old_new_only_sample  ,pInFile_old ,%lID% ,rcid ,'.*' ,false ,false  ,'' );
  ds_rollup_new_new_only            := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( kmtch_new_new_only_sample  ,kcand_new_new_only_sample  ,kspec_new_prep ,katt_new_new_only_sample  ,pInFile_new ,%lID% ,rcid ,'.*' ,false ,false  ,'' );
  ds_side_by_side_new_only_matches  := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_new_only ,ds_rollup_new_new_only  ,%lID%);

  ds_rollup_old_new_only_full             := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( ds_new_only_matches  ,kcand_old_prep  ,kspec_old_prep ,katt_old_old_only  ,pInFile_old ,%lID% ,rcid ,'.*' ,false ,false ,'' );
  ds_rollup_new_new_only_full             := SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores( ds_new_only_matches  ,kcand_new_prep  ,kspec_new_prep ,katt_new_old_only  ,pInFile_new ,%lID% ,rcid ,'.*' ,false ,false ,'' );
  ds_side_by_side_new_only_matches_full   := SALT_REGRESSION_TESTING.mac_join_matches(ds_rollup_old_new_only_full ,ds_rollup_new_new_only_full  ,%lID%);

  output_debug := parallel(
     output(kmtch_old_above_threshold                 (%lID1% = sample_id1,%lID2% = sample_id2) ,named('DEBUG_kmtch_old_above_threshold'                 ),all)
    ,output(kmtch_new_above_threshold                 (%lID1% = sample_id1,%lID2% = sample_id2) ,named('DEBUG_kmtch_new_above_threshold'                 ),all)
    ,output(kcand_old_prep                            (%lID% in [sample_id1,sample_id2])        ,named('DEBUG_kcand_old_prep'                            ),all)
    ,output(kcand_new_prep                            (%lID% in [sample_id1,sample_id2])        ,named('DEBUG_kcand_new_prep'                            ),all)
    ,output(ds_same_matches                           (%lID1% = sample_id1,%lID2% = sample_id2) ,named('DEBUG_ds_same_matches'                           ),all)
    ,output(ds_same_matches_sample                    (%lID1% = sample_id1,%lID2% = sample_id2) ,named('DEBUG_ds_same_matches_sample'                    ),all)
    ,output(ds_same_matches_sample_norm               (%lID% in [sample_id1,sample_id2])        ,named('DEBUG_ds_same_matches_sample_norm'               ),all)
    ,output(ds_rollup_old_same_matches_debug                                                    ,named('DEBUG_ds_rollup_old_same_matches_debug'          ),all)
    ,output(ds_rollup_new_same_matches_debug                                                    ,named('DEBUG_ds_rollup_new_same_matches_debug'          ),all)
    ,output(ds_side_by_side_same_matches_matches_debug                                          ,named('DEBUG_ds_side_by_side_same_matches_matches_debug'),all)  

    ,output(ds_same_matches_diff_conf                           (%lID1% = sample_id1_diff_conf,%lID2% = sample_id2_diff_conf) ,named('DEBUG_ds_same_matches_DIFF_CONF'                           ),all)
    ,output(ds_same_matches_diff_conf_sample                    (%lID1% = sample_id1_diff_conf,%lID2% = sample_id2_diff_conf) ,named('DEBUG_ds_same_matches_sample_DIFF_CONF'                    ),all)
    ,output(ds_same_matches_diff_conf_sample_norm               (%lID% in [sample_id1_diff_conf,sample_id2_diff_conf])        ,named('DEBUG_ds_same_matches_sample_norm_DIFF_CONF'               ),all)
    ,output(ds_rollup_old_same_matches_diff_conf_debug                                        ,named('DEBUG_ds_rollup_old_same_matches_debug_DIFF_CONF'          ),all)
    ,output(ds_rollup_new_same_matches_diff_conf_debug                                        ,named('DEBUG_ds_rollup_new_same_matches_debug_DIFF_CONF'          ),all)
    ,output(ds_side_by_side_same_matches__diff_conf_debug                                     ,named('DEBUG_ds_side_by_side_same_matches_matches_debug_DIFF_CONF'),all)  

  );

  Lost_matches_above_threshold := ds_side_by_side_old_only_matches_full(exists(salt_new(exists(child(fieldname = 'conf',(integer)fieldvalue >= pThreshold_new))) ));
  Lost_matches_below_threshold := ds_side_by_side_old_only_matches_full(exists(salt_new(exists(child(fieldname = 'conf',(integer)fieldvalue <  pThreshold_new))) ));
  
  Gained_matches_above_threshold := ds_side_by_side_new_only_matches_full(exists(salt_old(exists(child(fieldname = 'conf',(integer)fieldvalue >= pThreshold_old))) ));
  Gained_matches_below_threshold := ds_side_by_side_new_only_matches_full(exists(salt_old(exists(child(fieldname = 'conf',(integer)fieldvalue <  pThreshold_old))) ));

  ds_stats := dataset([
     {'Total Old Match Sample Key                                             ' ,count(kmtch_old                          )}
    ,{'Total New Match Sample Key                                             ' ,count(kmtch_new                          )}
    ,{'Total Good Old Matches                                                 ' ,count(kmtch_old_above_threshold          )}
    ,{'Total Good New Matches                                                 ' ,count(kmtch_new_above_threshold          )}
    ,{'Total Identical Matches With Same Score                                ' ,count(ds_same_matches                    )}
    ,{'Total Identical Matches With Different Score                           ' ,count(ds_same_matches_diff_conf          )}
                                      
    ,{'Total Lost Matches(Old Only Matches)                                   ' ,count(ds_old_only_matches                )}
#IF(pOutput_Breakdown_Also = true)
    ,{'Total Lost Matches(Old Only Matches), New is Above Threshold           ' ,count(Lost_matches_above_threshold       )}
    ,{'Total Lost Matches(Old Only Matches), New is Below Threshold           ' ,count(Lost_matches_below_threshold       )}
#END
    ,{'Total Gained Matches(New Only Matches)                                 ' ,count(ds_new_only_matches                )}
#IF(pOutput_Breakdown_Also = true)
    ,{'Total Gained Matches(New Only Matches), Old is Above Threshold         ' ,count(Gained_matches_above_threshold     )}
    ,{'Total Gained Matches(New Only Matches), Old is Below Threshold         ' ,count(Gained_matches_below_threshold     )}
#END
  ],{string stat,unsigned stat_value});

  return parallel(
     output('---------------------------------------------------'       ,named('SALT_REGRESSION_TESTING_mac_Validate_Internal_Linking_Start'))
    ,output(ds_stats                                                    ,named('Validate_Internal_Linking_Stats'                            ))
    ,output(enth(ds_side_by_side_same_matches_matches             ,300) ,named('Sample_Identical_Matches'                                   ),all)
    ,output(enth(ds_side_by_side_same_matches_diff_conf_matches   ,300) ,named('Sample_Identical_Matches_With_Different_Score'              ),all)
    ,output(enth(ds_side_by_side_old_only_matches                 ,300) ,named('Sample_Lost_Matches'                                        ),all)
    ,output(enth(ds_side_by_side_new_only_matches                 ,300) ,named('Sample_Gained_Matches'                                      ),all)
#IF(pOutput_Breakdown_Also = true)
    ,output(enth(Lost_matches_above_threshold                     ,300) ,named('Sample_Lost_Matches_above_threshold'                        ),all)
    ,output(enth(Lost_matches_below_threshold                     ,300) ,named('Sample_Lost_Matches_below_threshold'                        ),all)
    ,output(enth(Gained_matches_above_threshold                   ,300) ,named('Sample_Gained_Matches_above_threshold'                      ),all)
    ,output(enth(Gained_matches_below_threshold                   ,300) ,named('Sample_Gained_Matches_below_threshold'                      ),all)
#END
    #IF(pOutput_Debug = true)
    ,output_debug
    #END
    ,output('---------------------------------------------------'      ,named('SALT_REGRESSION_TESTING_mac_Validate_Internal_Linking_END'   ))
 );
  
endmacro;