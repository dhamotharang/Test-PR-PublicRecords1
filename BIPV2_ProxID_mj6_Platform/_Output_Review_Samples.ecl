EXPORT _Output_Review_Samples(
   pMatchThreshold      = '0'
  ,pInfile              = 'BIPV2_ProxID_mj6_PlatForm.In_DOT_Base'
  ,pSetReviewers        = '[\'CM\',\'LB\',\'TL\',\'JL\',\'FN\',\'DW\',\'SS\']'
  ,pSamplesPerReviewer  = '15'
  ,pKeyversions         = '\'built\''
  ,pFractionAtThreshold = '.667'    //by default, 2/3 at threshold, 1/3 above
  ,pExtraMatchFilter    = '\'\''        //if you want to filter for only particular types of matches(i.e. 'company_inc_state_score <= 0' )
) :=
functionmacro

  import tools,BIPV2_ProxID_mj6_PlatForm;
  
  kmtch                   := BIPV2_ProxID_mj6_PlatForm.Keys(pInfile,pKeyversions).MatchSample ;
  kcand                   := BIPV2_ProxID_mj6_PlatForm.Keys(pInfile,pKeyversions).Candidates  ;
  outputReviewSamples     := Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID_mj6_PlatForm.In_DOT_Base,proxid,pMatchThreshold,pSamplesPerReviewer,pSetReviewers,,pFractionAtThreshold,,pExtraMatchFilter);
  return outputReviewSamples;
  
endmacro;
