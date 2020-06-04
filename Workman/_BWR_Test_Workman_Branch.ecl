/*
ecltext := 'output(90);';
	
ds_debug := dataset([
   {'Insurance-branch'        ,'BH-756'}
  ,{'Insurance-URL'           ,'https://gitlab.ins.risk.regn.net/BentleLA/Insurance.git'}
  
],WsWorkunits.Layouts.DebugValues);

WsWorkunits.Create_Wuid_Raw(ecltext ,'thor50_dev_eclcc' ,  ,,ds_debug);
*/
/*
ds_debug := dataset([
   {'Boca-branch'        ,'LBP-183'}
  ,{'Boca-URL'           ,'https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git'}
  
],WsWorkunits.Layouts.DebugValues);
*/
myecl := 
  '#workunit(\'name\',\'bipv2_proxid @version@-@iteration@ workman test\');\n'
+ 'setpreclustercount  := [392933809 ,382870103  ,381654002  ,381326072  ,381147324];\n'
+ 'setmatchesperformed := [6265107   ,1032750    ,346601     ,192764     ,117560   ];\n'
+ 'setconvergence      := [98.406    ,99.730     ,99.909     ,99.949     ,99.969   ];\n'
+ 'output(setpreclustercount [@iteration@]  ,named(\'PreClusterCount\'));\n'
+ 'output(setmatchesperformed[@iteration@]  ,named(\'MatchesPerformed\'));\n'
+ 'output(setconvergence     [@iteration@]  ,named(\'Convergence\'));\n'
// + 'iff(@iteration@ = 2  ,fail(\'Just fail for testing\'));  '                                         
;


#workunit('name','Workman override LBP-183 branch test');
WorkMan.mac_Workman(
   myecl                                                                                              //pECL
  ,'20200210'                                                                                         //pversion
  ,WorkMan._Config.Groupname('50')                                                                 //pcluster
  ,''                                                                                                 //pStartIteration
  ,1                                                                                                   //pNumMaxIterations 
  ,                                                                                                   //pNumMinIterations
  ,'~workman_testing::@version@::bipv2_proxid'                                                         //pOutputFilename      = '\'\''
  ,'~workman_testing::qa::bipv2_proxid'                                                                //pOutputSuperfile     = '\'\''
  ,['MatchesPerformed','PreClusterCount']                                                             //pSetResults            
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.91)'    //pStopCondition               
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']                           //pSetNameCalculations
  ,'bipv2_proxid'
  // ,WorkMan._Config.LocalEsp
  ,pPollingFrequency := '1'
  ,pCompileOnly := false
  // ,pDebugValues := 'dataset([{\'Boca-branch\',\'LBP-183\'},{\'Boca-URL\',\'https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git\'}],WsWorkunits.Layouts.DebugValues)'
  // ,pDebugValues := #TEXT(dataset([{'Boca-branch','LBP-183'},{'Boca-URL','https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git'}],WsWorkunits.Layouts.DebugValues))  //DOES NOT WORK.  #TEXT messes up the parameter order even when it is correct.  Just manually make it a string
);


// WorkMan.CreateWuid(myecl  ,WorkMan._Config.Groupname('50')  ,,,#EXPAND(#TEXT(dataset([{'Boca-branch','LBP-183'},{'Boca-URL','https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git'}],WsWorkunits.Layouts.DebugValues))));