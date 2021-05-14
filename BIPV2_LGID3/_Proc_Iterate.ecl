import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID;
//have to fix keys attribute too
EXPORT _Proc_Iterate(
   piteration
  ,pversion         = 'BIPV2.KeySuffix'
  ,pInfile          = 'BIPV2_LGID3.In_LGID3'
  ,pMatchThreshold  = 'BIPV2_LGID3.Config.MatchThreshold'
  ,pIsTesting       = 'false'
) := 
functionmacro
    
  import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID,BIPV2_QA_Tool;
  
  InFile            := pInfile;
  
  f_hist(string istr)	:= BIPv2_Files.files_lgid3.FILE_SALT_POSSIBLE_MATCH + '::' + pversion + '::it' + istr ;
  f_out (string istr)	:= BIPV2_Files.files_lgid3.FILE_SALT_OP             + '::' + pversion + '::it' + istr ;

  possibleMatches := output(BIPV2_LGID3.matches(InFile).PossibleMatches,,f_hist(piteration),overwrite,compressed);
  saltMod         := BIPV2_LGID3.Proc_Iterate(piteration, InFile, f_out(''));
  linking         := parallel(saltmod.DoAllAgain, possibleMatches);

	/* ---------------------- SALT History ------------------------------- */
	updateLinkHist   	:= BIPv2_Files.files_lgid3.updateLinkHist(f_hist(piteration));
		
	/* ---------------------- Review Samples ----------------------------- */
	outputReviewSamples := BIPV2_LGID3._Samples(InFile).out;

	/* ---------------------- Take Action -------------------------------- */
  ds_lgid3              := pInfile    ;
  ds_commonbase         := bipv2.CommonBase.ds_base (seleid = 46640408) : persist('~persist::lbentley::LNK::324::ds_filtered44');
  ds_commonbase_rcids   := table(ds_commonbase  ,{rcid});
  ds_lgid3_rcids        := join(ds_lgid3  ,ds_commonbase_rcids  ,left.rcid = right.rcid ,transform(left)  ,lookup);
  ds_agg_LNK197_lgids   := join(ds_lgid3  ,table(ds_lgid3_rcids,{lgid3},lgid3,merge)  ,left.lgid3 = right.lgid3 ,transform(left)  ,lookup);
  output_lnk_197        := output(BIPV2_LGID3._AggLgid3s(ds_agg_LNK197_lgids) ,named('ds_agg_LNK197_lgids'),all);

  import BIPV2_QA_Tool;
  lgid3_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,lgid3 ,pversion  ,piteration  ,BIPV2_LGID3.Config.MatchThreshold ,'BIPV2_LGID3');

  // -- Run Iteration
  updateBuilding(string fname=f_out(piteration)) := BIPv2_Files.files_lgid3.updateBuilding(fname);
  
  runIter := sequential(
     linking
    ,outputReviewSamples
    ,updateBuilding()
    ,updateLinkHist
    ,BIPV2_LGID3._Lgid3Changes(piteration,pversion, InFile).out
    // ,output_lnk_197
    ,lgid3_iteration_stats
  )
    : SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'LGID3')),
      FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'LGID3'));

	return runIter;
  
ENDmacro;
