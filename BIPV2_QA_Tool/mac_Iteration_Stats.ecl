  /*
  -- Suppressions will probably be zero because, from Ayeesha:
  I think for BIP we don’t need this as we are going to have “run time record level suppressions” at query layer if suppression is urgent. 
*/
EXPORT mac_Iteration_Stats(
   pwuid
  ,pID
  ,pversion
  ,piteration
  ,pMatchThreshold
  ,pModule          
  ,pOutputFile      = 'true'
  ,pesp             = 'WorkMan._Config.LocalEsp'
  ,puseprod         = 'false'
) := 
functionmacro

  import Workman;
  
  lwuid  := pwuid;  //last prod iteration of proxid
  lmyesp := pesp;
  lID    := trim(#TEXT(pID));
  
  version_iter          := trim(pversion) + '_' + trim(piteration);
  lay_ConfidenceLevels  := {UNSIGNED2 Conf ;UNSIGNED MatchesFound  };

  MatchesPerformed        := WorkMan.get_Result           (lwuid,'MatchesPerformed'                                                 ,lmyesp);
  BasicMatchesPerformed   := WorkMan.get_Result           (lwuid,'BasicMatchesPerformed'                                            ,lmyesp);
  SlicesPerformed         := WorkMan.get_Result           (lwuid,'SlicesPerformed'                                                  ,lmyesp);
  PreClusterCount         := WorkMan.get_Result           (lwuid,'PreClusterCount.'     + lID                                       ,lmyesp);
  PostClusterCount        := WorkMan.get_Result           (lwuid,'PostClusterCount.'    + lID                                       ,lmyesp);
  IDsCreatedByCleave      := WorkMan.get_Result           (lwuid,lID                    + 'sCreatedByCleave'                        ,lmyesp);
  CandidateCleaves        := WorkMan.get_Ds_Result_XmlBlob(lwuid,'CandidateCleaves'                                                 ,lmyesp,5);
  PostClusters            := WorkMan.get_Ds_Result_XmlBlob(lwuid,'PostClusters'                                                     ,lmyesp,5);
  LinkBlockSplits         := WorkMan.get_Result           (lwuid,'LinkBlockSplits'                                                  ,lmyesp);                                                    
  ConfidenceLevels        := WorkMan.get_DS_Result        (lwuid,'ConfidenceLevels'                           ,lay_ConfidenceLevels ,lmyesp);                                                    

  // key_mtch_sample := pKeyMatchSample;
  // key_mtch_sample := pModule.pKeysAtt(,version_iter,puseprod).MatchSample;
  mtch_threshold  := pMatchThreshold;
  // mtch_threshold  := pModule.Config.MatchThreshold;

  // ds_low_confidence     := key_mtch_sample(conf between  mtch_threshold      and (mtch_threshold + 5 ));
  // ds_medium_confidence  := key_mtch_sample(conf between (mtch_threshold + 6) and (mtch_threshold + 10));
  // ds_high_confidence    := key_mtch_sample(conf >                                (mtch_threshold + 10));

  count_low_confidence      := (unsigned)sum(ConfidenceLevels(conf between  mtch_threshold      and (mtch_threshold + 5 )) ,matchesfound);
  count_medium_confidence   := (unsigned)sum(ConfidenceLevels(conf between (mtch_threshold + 6) and (mtch_threshold + 10)) ,matchesfound);
  count_high_confidence     := (unsigned)sum(ConfidenceLevels(conf >                                (mtch_threshold + 10)) ,matchesfound);

  cnt_ds_singletons     := (string)((unsigned)PostClusters(field_name = 'numberofclusters'  ,record_number = 1)[1].field_value);
  cnt_ds_nonsingletons  := (string)((unsigned)PostClusterCount - (unsigned)cnt_ds_singletons);
  
  cleavecandidates := (string)sum(CandidateCleaves  ,(unsigned)field_value);
  
  pct_convergence := trim(realformat(((real8)PreClusterCount - (real8)MatchesPerformed) / (real8)PreClusterCount * 100.0 ,6,2),all);
  LinkBlockSplits_string := (string)((unsigned)LinkBlockSplits);
  
  IDsCreatedByCleave_unsigned := (string)((unsigned)IDsCreatedByCleave);
  SlicesPerformed_string := (string)((unsigned)SlicesPerformed);
  
  ds_stats := dataset([

     {lID ,pversion  ,piteration ,'MatchesPerformed'                            ,MatchesPerformed             ,pModule}
    ,{lID ,pversion  ,piteration ,'BasicMatchesPerformed'                       ,BasicMatchesPerformed        ,pModule}
        
    ,{lID ,pversion  ,piteration ,'Singletons'                                  ,cnt_ds_singletons            ,pModule}
    ,{lID ,pversion  ,piteration ,'Nonsingletons'                               ,cnt_ds_nonsingletons         ,pModule}
        
    ,{lID ,pversion  ,piteration ,'Low Confidence(Threshold + 5)'               ,count_low_confidence         ,pModule}
    ,{lID ,pversion  ,piteration ,'Medium Confidence(Threshold + 6 to 10)'      ,count_medium_confidence      ,pModule}
    ,{lID ,pversion  ,piteration ,'High Confidence(Threshold > + 10)'           ,count_high_confidence        ,pModule}
      
    ,{lID ,pversion  ,piteration ,'CleaveCandidates'                            ,cleavecandidates             ,pModule}
    ,{lID ,pversion  ,piteration ,'ID\'sCreatedByCleave'                        ,IDsCreatedByCleave_unsigned  ,pModule}
    ,{lID ,pversion  ,piteration ,'ID\'sSliced'                                 ,SlicesPerformed_string       ,pModule}
    ,{lID ,pversion  ,piteration ,'LinkBlocks'                                  ,LinkBlockSplits_string       ,pModule}
    ,{lID ,pversion  ,piteration ,'Suppressions'                                ,'0'                          ,pModule}
    ,{lID ,pversion  ,piteration ,'PreClusterCount'                             ,PreClusterCount              ,pModule}
    ,{lID ,pversion  ,piteration ,'PostClusterCount'                            ,PostClusterCount             ,pModule}
    ,{lID ,pversion  ,piteration ,'Convergence %'                               ,pct_convergence              ,pModule}

  ],BIPV2_QA_Tool.Layouts.iteration_stats);

  // -- update the versioned internal linking file with this iteration
  #IF(pOutputFile = true)
  
      output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion,,pModule).Iteration_Stats.logical  ,ds_stats ,true,true);

    // #IF    (regexfind('bipv2_proxid_mj6'  ,trim(pModule)  ,nocase) = true)
      // output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion).Proxid_mj6_Iteration_Stats.logical  ,ds_stats ,true,true);
    // #ELSEIF(regexfind('bipv2_proxid'      ,trim(pModule)  ,nocase) = true)
      // output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion).Proxid_Iteration_Stats    .logical  ,ds_stats ,true,true);
    // #ELSEIF(regexfind('bipv2_lgid3'       ,trim(pModule)  ,nocase) = true)
      // output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion).Lgid3_Iteration_Stats     .logical  ,ds_stats ,true,true);

    // #ELSEIF(regexfind('bipv2_dotid'       ,trim(pModule)  ,nocase) = true)
      // output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion).dotid_Iteration_Stats     .logical  ,ds_stats ,true,true);
    // #ELSEIF(regexfind('bipv2_empid'       ,trim(pModule)  ,nocase) = true)
      // output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion).Lgid3_Iteration_Stats     .logical  ,ds_stats ,true,true);
    // #ELSEIF(regexfind('bipv2_powid'       ,trim(pModule)  ,nocase) = true)
      // output_file := WorkMan.Update_File(BIPV2_QA_Tool.Filenames(pversion).Lgid3_Iteration_Stats     .logical  ,ds_stats ,true,true);
    // #END
    
    return_result := sequential(
       output_file
      ,BIPV2_QA_Tool.Promote(pversion,pModule).new2built
      ,BIPV2_QA_Tool.Promote(pversion,pModule).built2qa   //they only want one set of iteration stats per build in this superfile
      ,BIPV2_QA_Tool.Promote(pversion,pModule,pClearSuperFirst := false).new2base  //I will put all iteration stats in this superfile for reference later
    );
    return return_result;
  #ELSE

    return ds_stats;
  #END
  
endmacro;