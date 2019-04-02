import BIPV2_Build, BIPV2_DotID, BIPV2_ProxID, BIPV2_Entity, bipv2, ut,BizLinkFull,tools;

export proc_build_all(

   pversion               = 'BIPV2.KeySuffix'        
  ,pDotStartIteration     = '\'\''  //start where it left off last build
  ,pProxStartIteration    = '\'\''
  ,pLgid3StartIteration   = '\'\''
  ,pPowDownStartIteration = '1'  
  ,pPowStartIteration     = '\'\''
  ,pEmpDownStartIteration = '1'
  ,pEmpStartIteration     = '\'\''
  ,pDotNumIterations      = '3'
  ,pProxNumIterations     = '2'
  ,pProxMj6NumIterations  = '3'
  ,pProxPostNumIterations = '3'
  ,pLgid3NumIterations    = '15'
  ,pPowDownNumIterations  = '2'
  ,pPowNumIterations      = '2'
  ,pEmpDownNumIterations  = '6'
  ,pEmpNumIterations  		= '3'
  ,pPromote2QA            = 'false'
  ,pdoDotidInit           = 'true'
  ,pdoDotidSpecs          = 'false'
  ,pdoDotidIters          = 'true'
  ,pdoDotidPost           = 'true'
  ,pdoProxidpatch         = 'true'
  ,pdoProxidSpecs         = 'true'
  ,pdoProxidMj6Preprocess = 'true'
  ,pdoProxidMj6Specs      = 'true'
  ,pdoProxidMj6Iters      = 'true'
  ,pdoProxidMj6PostProcess= 'true'
  ,pdoLgid3Init           = 'true'
  ,pdoLgid3Specs          = 'true'
  ,pdoLgid3Iters          = 'true'
  ,pdoLgid3Post           = 'true'
  ,pdoPowDownInit         = 'true'
  ,pdoPowDownSpecs        = 'true'
  ,pdoPowInit             = 'true'
  ,pdoPowSpecs            = 'true'
  ,pdoPowIters            = 'true'
  ,pdoPowPost             = 'true'
  ,pdoEmpDownInit         = 'true'
  ,pdoEmpInit             = 'true'
  ,pdoEmpSpecs            = 'true'
  ,pdoEmpIters            = 'true'
  ,pdoEmpPost             = 'true'

  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipSpaceUsage        = 'false'
  ,pSkipCleanup           = 'false'
  ,pSkipSourceIngest      = 'false'
  ,pSkipPrepIngest        = 'false'
  ,pSkipRunIngest         = 'false'
  ,pSkipDOT               = 'false'
  ,pSkipProx              = 'false'
  ,pSkipProxMj6           = 'false'
  ,pSkipProxPost          = 'false'
  ,pSkipHierarchy         = 'false'
  ,pSkipLgid3             = 'false'
  ,pSkipPowDown           = 'false'
  ,pSkipPow               = 'false'
  ,pSkipEmpDown           = 'false'
  ,pSkipEmp               = 'false'
  ,pSkipCommonBase        = 'false'
  ,pSkipXlink             = 'false'
  ,pSkipCopyXlinkKeys     = 'false'
  ,pSkipXlinkValidation   = 'false'
  ,pSkipXlinkSample       = 'false'
  ,pSkipWeeklyKeys        = 'false'
  ,pSkipBest              = 'false'
  ,pSkipIndustry          = 'false'
  ,pSkipMisckeys          = 'false'
  ,pSkipQASamples         = 'false'
  ,pSkipSegStats          = 'false'
  ,pSkipStrata            = 'false'
  ,pSkipOverlinking       = 'false'
  ,pSkipSeleidRelative    = 'false'
  ,pSkipCDWBuild          = 'false'
  ,pSkipXAppend           = 'false'
  ,pSkipDataCard          = 'false'
  ,pSkipDashboard         = 'false'
  ,pSkipCopyOtherKeys     = 'false'
  ,pSkipRenameKeys        = 'false'
  ,pSkipVerifyKeys        = 'false'
  ,pSkipUpdateDOPS        = 'false'
  ,pSkipDOTSpecsPost      = 'false'
  ,pSkipSeleRelSpecsPost  = 'false'
  ,pOmitDisposition       = '' // NOTE: Set to 'preserve' or 'ghost' to recover from a missing source in the ingest file
  // ,pOmitDisposition       = 'preserve' // temporary, until MO Corps and MS Corps problems are resolved  

  ,pRenameKeysFilter      = '\'bipv2_proxid|strnbrname|bipv2_relative|biz_preferred\''

  ,pDotFilenameForProx        = '\'\'' //'BIPV2_Files.files_dotid.FILE_BASE'  //default is to start where we left off
  ,pInputFilenameForProxMj6   = 'BIPV2_Proxid.filenames().out.built' //'BIPV2_Files.files_dotid.FILE_BASE'  //default is to start where we left off
  ,pInputFilenameForProxPost  = 'bipv2_proxid_mj6._filenames().out.built' //'BIPV2_Files.files_dotid.FILE_BASE'  //default is to start where we left off
  ,pCompileTest               = 'false'   
) := 
functionmacro
    
    import BIPV2_Build, BIPV2_DotID, BIPV2_ProxID, BIPV2_Entity, bipv2, ut,BizLinkFull,tools;    

    // -- Cleanup the previous build -- this needs to expand to more files
    // notdeleteversion  := regexfind('[[:digit:]]+',pversion,0,nocase);  //do this so we don't delete any files from a rebuild--may want to keep those until the next build for research purposes.
    // CleanupLastBuild  := BIPV2_Build.Promote(,'^(?!.*?(wkhistory|precision|space).*).*$',pDelete := true,pIncludeBuiltDelete := true,pCleanupFilter := '^(?!.*?' + notdeleteversion + '.*).*$').Cleanup; //cleanup last build's iterations

    // -- Update DOPS
    keyversion                := if(pPromote2QA  ,'qa','built');    
		email                     := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland and pPromote2QA and not pSkipUpdateDOPS ,pUseVersion := keyversion);
    UpdateBIPV2FullKeysDops   := email.BIPV2FullKeys.Roxie;
    UpdateBIPV2WeeklyKeysDops := email.BIPV2WeeklyKeys.Roxie;
    
    // -- Split the build after CommonBase into 4 threads(wuids), then wait for them to finish
    xlinkCondition  := pSkipXlink = false or pSkipCopyXlinkKeys = false or pSkipXlinkValidation = false or pSkipXlinkSample = false or pSkipWeeklyKeys = false;
    bestCondition   := pSkipBest  = false or pSkipIndustry      = false or pSkipMisckeys    = false;
    
    XlinkStuffWuid  := if(xlinkCondition                                                                  ,BIPV2_Build.proc_Kickoff_Phase_2(pversion,pSkipXlink,pSkipCopyXlinkKeys,pSkipXlinkValidation ,pSkipXlinkSample,pSkipWeeklyKeys  ,true               ,true         ,true          ,true           ,true           ,true         ,true             ,true                 ,'XlinkStuff'                      ,,pCompileTest),'');
    BestWuid        := if(bestCondition                                                                   ,BIPV2_Build.proc_Kickoff_Phase_2(pversion,true      ,true              ,true                 ,true            ,true             ,pSkipBest          ,pSkipIndustry,pSkipMisckeys ,pSkipQASamples ,true           ,true         ,true             ,true                 ,'BestAndMiscKeys'                 ,,pCompileTest),'');
    StatsWuid       := if(pSkipSegStats       = false or pSkipStrata = false or pSkipOverlinking = false  ,BIPV2_Build.proc_Kickoff_Phase_2(pversion,true      ,true              ,true                 ,true            ,true             ,true               ,true         ,true          ,true           ,pSkipSegStats  ,pSkipStrata  ,pSkipOverlinking ,true                 ,'Stats'                           ,,pCompileTest),'');
    RelativesWuid   := if(pSkipSeleidRelative = false                                                     ,BIPV2_Build.proc_Kickoff_Phase_2(pversion,true      ,true              ,true                 ,true            ,true             ,true               ,true         ,true          ,true           ,true           ,true         ,true             ,pSkipSeleidRelative  ,'SeleidRelative'                  ,,pCompileTest),'');

    Wait4Threads    := if(XlinkStuffWuid != '' or BestWuid != '' or StatsWuid != '' or RelativesWuid != ''   ,wk_ut.Wait4Workunits([XlinkStuffWuid,BestWuid,StatsWuid,RelativesWuid],'1',pversion,'Wait4Wuids',,BIPV2_Build.mod_email.emailList));
    
    // -- Total up the workunit timings
    // OutputThisWuidTimings      := output(wk_ut.get_Workunits_ds(workunit,pversion,'1'),named('Workunits'),EXTEND);
    get_wuidsTotal             := dataset('~bipv2_build::qa::workunit_history',wk_ut.layouts.wks_slim,thor); //get workunit info for All wuids
    get_wuids_filttotal        := get_wuidsTotal(regexfind(pversion,version,nocase),not regexfind('^.*?total$',trim(name),nocase));  //remove subtotals
    sumsecondstotal            := sum(get_wuids_filttotal,Total_Time_secs);
    totalthortimetotal         := wk_ut.ConvertSecs2ReadableTime(sumsecondstotal);
    outputSumTimingstotal      := sequential(
                                     tools.macf_WriteFile('~bipv2_build::' + pversion + '::workunit_history::Total',dataset([{'Total','','','','','','','',pversion,totalthortimetotal,sumsecondstotal,totalthortimetotal,sumsecondstotal}],wk_ut.layouts.wks_slim),false,false,true)
                                    ,std.file.addsuperfile('~bipv2_build::qa::workunit_history','~bipv2_build::' + pversion + '::workunit_history::Total')
                                  );

    // -- figure out start iterations for proxid mj6 & proxid post
    ProxMj6StartIteration    :=  pProxStartIteration   + pProxNumIterations   ;
    ProxPostStartIteration   :=  ProxMj6StartIteration + pProxMj6NumIterations;
    
    // -- Do Postprocess, dotid specs and seleid relative specs
    DotSpecsWuid              := if(pSkipDOTSpecsPost     = false   ,BIPV2_Build.proc_Kickoff_PostProcess(bipv2.KeySuffix ,pSkipDOTSpecsPost  ,true                 ,'DotidSpecificities'           ),'');
    SeleidRelativeSpecsWuid   := if(pSkipSeleRelSpecsPost = false   ,BIPV2_Build.proc_Kickoff_PostProcess(bipv2.KeySuffix ,true               ,pSkipSeleRelSpecsPost,'SeleidRelativesSpecificities' ),'');

    Wait4PostProcessThreads   := if(DotSpecsWuid != '' or SeleidRelativeSpecsWuid != '' ,wk_ut.Wait4Workunits([DotSpecsWuid,SeleidRelativeSpecsWuid],'1',pversion,'Wait4PostProcessWuids',,BIPV2_Build.mod_email.emailList));

		doit := sequential(

       output(pversion, named('Build_Date'))
      // ,BIPV2_Build.proc_Watch_This_Workunit (pversion,workunit) //watch this workunit, in case it fails in some weird way it will still email me.
      ,output(BIPV2_Build.files().workunit_history.qa(regexfind(pversion,version,nocase)),named('Workunits'),overwrite)
      ,if(pSkipSpaceUsage    = false ,BIPV2_Build.proc_Space_Usage          (pversion,pType := 1))
      ,if(pSkipCleanup       = false ,BIPV2_Build.proc_cleanup              (pversion)           )
      ,if(pSkipSourceIngest  = false ,BIPV2_Build.proc_Source_Ingest        (pversion)           )
      ,if(pSkipPrepIngest    = false ,BIPV2_Build.proc_ingest               ().prepIngest(pversion)           )
      ,if(pSkipRunIngest     = false ,BIPV2_Build.proc_ingest               ().runIngest(pversion,pOmitDisposition)           )
      ,if(pSkipDOT           = false ,BIPV2_Build.proc_dotid                ().MultIter_run (pDotStartIteration     ,pDotNumIterations      ,pdoDotidInit ,pdoDotidSpecs  ,pdoDotidIters  ,pdoDotidPost                                                                    ,,,,,,pCompileTest ))
      ,if(pSkipProx          = false ,BIPV2_Build.proc_proxid                               (pProxStartIteration    ,pProxNumIterations     ,pversion     ,                                     ,,pDotFilenameForProx       ,,pdoProxidSpecs                               ,,,,,,pCompileTest ))
      ,if(pSkipProxMj6       = false ,BIPV2_Build.proc_proxid_mj6                           ( '' ,pProxMj6NumIterations  ,pversion     ,pdoProxidMj6Preprocess,pdoProxidMj6Specs, pdoProxidMj6Iters,pdoProxidMj6PostProcess,,,pInputFilenameForProxMj6     ,,,pCompileTest ))            
      ,if(pSkipProxPost      = false ,BIPV2_Build.proc_proxid                               ( '' ,pProxPostNumIterations ,pversion     ,'bipv2_proxid_mj6._files().out.built',,pInputFilenameForProxPost ,,false             ,,,'ProxidPost'               ,,,pCompileTest ))
      ,if(pSkipHierarchy     = false ,BIPV2_Build.proc_hrchy                (pversion                                                                                                                   ))
      ,if(pSkipLgid3         = false ,BIPV2_Build.proc_lgid3                ().MultIter_run (pLgid3StartIteration   ,pLgid3NumIterations  ,pdoLgid3Init  ,pdoLgid3Specs   ,pdoLgid3Iters  ,pdoLgid3Post ,pversion     ,,pCompileTest  ))
      ,if(pSkipPowDown       = false ,BIPV2_Build.proc_powid_down           ().MultIter_run (pPowDownStartIteration ,pPowDownNumIterations,pdoPowDownInit,pdoPowDownSpecs                                         ,,,,,,pCompileTest  )) 
      ,if(pSkipPow           = false ,BIPV2_Build.proc_powid                ().MultIter_run (pPowStartIteration     ,pPowNumIterations    ,pdoPowInit    ,pdoPowSpecs     ,pdoPowIters    ,pdoPowPost              ,,,,,pCompileTest  ))
      ,if(pSkipEmpDown       = false ,BIPV2_Build.proc_empid_down           ().MultIter_run (pEmpDownStartIteration ,pEmpDownNumIterations,pdoEmpDownInit                                                       ,,,,,,,,pCompileTest  ))
      ,if(pSkipEmp           = false ,BIPV2_Build.proc_empid                ().MultIter_run (pEmpStartIteration     ,pEmpNumIterations    ,pdoEmpInit    ,pdoEmpSpecs     ,pdoEmpIters    ,pdoEmpPost              ,,,,,pCompileTest  ))
      ,if(pSkipCommonBase    = false ,BIPV2_Build.proc_CommonBase           ()                                                                                                                           )
      
      ,Wait4Threads
      
      // -- Now do Post process stuff.  All keys have been built so do some housekeeping, copying, renaming, promoting(if requested), verifying, and updating DOPS(if requested)


      ,if(pSkipCDWBuild      = false ,BIPV2_Build.proc_CDW_Files              (pversion                                                                                                     )) // do Build CDW
      // ,if(pSkipXAppend       = false ,BIPV2_Build.proc_External_Append_Testing(pversion                                                                                                     )) // do external append testing
      ,if(pSkipDataCard      = false ,BIPV2_Build.proc_DataCard               (pversion                                                                                                     )) // do datacard
      ,if(pSkipDashboard     = false ,BIPV2_Build.proc_Dashboard              (pversion                                                                                                     )) // do dashboard
      ,if(pSkipRenameKeys    = false ,BIPV2_Build.proc_rename_BIPV2FullKeys   (pversion,pRenameKeysFilter,false,,'built')                                                                    ) //only rename bipv2_proxid,strnbrname & bipv2_relative, rest should be correct
      ,if(pSkipCopyOtherKeys = false ,BIPV2_Build.proc_copy_keys              (pversion ,'','','BestAndSeleRelative',true                                                                   )) // Copy the rest of the BIPV2FullKeys package to dataland
      ,if(pPromote2QA        = true  ,BIPV2_Build.proc_Promote2QA             (pversion)                                                                                                     )
      ,if(pSkipVerifyKeys    = false ,BIPV2_Build.BIPV2FullKeys_Package       (keyversion).outputpackage                                                                                     ) //double check that keys match layout
      ,UpdateBIPV2FullKeysDops  
      ,if(pSkipVerifyKeys    = false ,BIPV2_Build.BIPV2WeeklyKeys_Package     (keyversion).outputpackage                                                                                     )
      ,UpdateBIPV2WeeklyKeysDops
      ,Wait4PostProcessThreads
      // ,if(pSkipDOTSpecsPost     = false ,BIPV2_Build.proc_dotid().runSpecs())
      // ,if(pSkipSeleRelSpecsPost = false ,BIPV2_Build.proc_Seleid_relatives     (pversion,true,false,false       ))
      
      // ,OutputThisWuidTimings
      ,outputSumTimingstotal
      ,BIPV2_Build.proc_fullAndWeeklyKeys(pversion,false,false) // 
      
    )  
		:	FAILURE(email.BIPV2FullKeys.buildfailure);
						
   return doit;
   
endmacro;