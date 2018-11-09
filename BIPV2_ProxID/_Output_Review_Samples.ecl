EXPORT _Output_Review_Samples(
   pMatchThreshold      = '30'
  ,pInfile              = 'BIPV2_ProxID.In_DOT_Base'
  ,pSetReviewers        = '[\'CM\',\'LB\',\'DW\',\'RP\',\'AL\',\'DS\',\'ZS\',\'JA\',\'AJ\',\'PW\']'
  ,pSamplesPerReviewer  = '15'
  ,pKeyversions         = '\'built\''
  ,pFractionAtThreshold = '.667'    //by default, 2/3 at threshold, 1/3 above
  ,pExtraMatchFilter    = '\'\''        //if you want to filter for only particular types of matches(i.e. 'company_inc_state_score <= 0' )
  ,pOutputEcl           = 'false' 
) :=
functionmacro

  import tools,BIPV2_ProxID;
  
  kmtch                   := BIPV2_ProxID.Keys(pInfile,pKeyversions).MatchSample ;
  kcand                   := BIPV2_ProxID.Keys(pInfile,pKeyversions).Candidates  ;
  outputReviewSamples     := Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID.In_DOT_Base,proxid,pMatchThreshold,pSamplesPerReviewer,pSetReviewers,pOutputEcl,pFractionAtThreshold,,pExtraMatchFilter);
  return outputReviewSamples;
  
endmacro;
