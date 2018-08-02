﻿//make sure code for bwr_build_all is up-to-date, then run this. --NOT USED ANYMORE BECAUSE OF GIT.  MODIFY THE ITERATION START #S IN THIS ATTRIBUTE

import bipv2,wk_ut,_control,bipv2_build;

pversion    := BIPV2.KeySuffix                                      ;
cluster     := wk_ut._Constants.localhthor                          ;
OutputEcl   := false                                                ;
emails      := BIPV2_Build.mod_email.emailList                      ;

fbool(boolean pinput) := if(pinput = true,'true','false');

eclcodepre  := 
     '\'import bipv2,bipv2_build,BIPV2_Files,BIPV2_DotID,wk_ut;\\n\'\n'
 + '+ \'//version\\n\'\n'
 + '+ \'lversion              := BIPV2.KeySuffix       ;\\n\'\n'
 + '+ \'//Start iterations\\n\'\n'
 + '+ \'DotStartIteration     := 217                   ;\\n\'\n'
 + '+ \'ProxStartIteration    := 434                   ;\\n\'\n'
 + '+ \'Lgid3StartIteration   := 409                   ;\\n\'\n'
 + '+ \'PowDownStartIteration := 1                     ;\\n\'\n'
 + '+ \'PowStartIteration     := 1                     ;\\n\'\n'
 + '+ \'EmpDownStartIteration := 1                     ;\\n\'\n'
 + '+ \'EmpStartIteration     := 1                     ;\\n\'\n'
 + '+ \'//Number of iterations\\n\'\n'
 + '+ \'DotNumIterations      := 3                     ;\\n\'\n'
 + '+ \'ProxNumIterations     := 2                     ;\\n\'\n'
 + '+ \'ProxMj6NumIterations  := 3                     ;\\n\'\n'
 + '+ \'ProxPostNumIterations := 3                     ; //added 1 more iteration for more convergence 6/20/2017\\n\'\n'
 + '+ \'Lgid3NumIterations    := 15                    ;//For S47, use 15 and will back to 8 after S47!!! change from 4 to 10 after 2/16/2016 BIP meeting. changed to 15 according to Verns email 4/20/2016; change to 8 on 20161215\\n\'\n'
 + '+ \'PowDownNumIterations  := 2                     ;\\n\'\n'
 + '+ \'PowNumIterations      := 2                     ;\\n\'\n'
 + '+ \'EmpDownNumIterations  := 6                     ;  //On 12/17/2015 BIP meeting, we agreed to +3 more iterations, so change from 3 to 6 \\n\'\n'
 + '+ \'EmpNumIterations      := 3                     ;\\n\'\n'
 + '+ \'//promote build to qa supers at end?\\n\'\n'
 + '+ \'Promote2QA            := false                 ;\\n\'\n'
 + '+ \'//do patches/specs?\\n\'\n'
 + '+ \'doDotidInit           := true                  ;\\n\'\n'
 + '+ \'doDotidSpecs          := false                 ;  //done at end normally, but keep this here in case need to do it before\\n\'\n'
 + '+ \'doDotidIters          := true                  ;\\n\'\n'
 + '+ \'doDotidPost           := true                  ;\\n\'\n'
 + '+ \'doProxidpatch         := true                  ;\\n\'\n'
 + '+ \'doProxidSpecs         := true                  ;\\n\'\n'
 + '+ \'doProxidMj6Preprocess := true                  ;\\n\'\n'
 + '+ \'doProxidMj6Specs      := true                  ;\\n\'\n'
 + '+ \'doProxidMj6Iters      := true                  ;\\n\'\n'
 + '+ \'doProxidMj6PostProcess:= true                  ;\\n\'\n'
 + '+ \'doLgid3Init           := true                  ;\\n\'\n'
 + '+ \'doLgid3Specs          := true                  ;\\n\'\n'
 + '+ \'doLgid3Iters          := true                  ;\\n\'\n'
 + '+ \'doLgid3Post           := true                  ;\\n\'\n'
 + '+ \'doPowDownInit         := true                  ;\\n\'\n'
 + '+ \'doPowDownSpecs        := true                  ;\\n\'\n'
 + '+ \'doPowInit             := true                  ;\\n\'\n'
 + '+ \'doPowSpecs            := true                  ;\\n\'\n'
 + '+ \'doPowIters            := true                  ;\\n\'\n'
 + '+ \'doPowPost             := true                  ;\\n\'\n'
 + '+ \'doEmpDownInit         := true                  ;\\n\'\n'
 + '+ \'doEmpInit             := true                  ;\\n\'\n'
 + '+ \'doEmpSpecs            := true                  ;\\n\'\n'
 + '+ \'doEmpIters            := true                  ;\\n\'\n'
 + '+ \'doEmpPost             := true                  ;\\n\'\n'
 + '+ \'//skip specific parts of build\\n\'\n'
 + '+ \'SkipSpaceUsage        := false                ;\\n\'\n'
 + '+ \'SkipCleanup           := SkipSpaceUsage       ;\\n\'\n'
 + '+ \'SkipSourceIngest      := SkipCleanup          ;\\n\'\n'
 + '+ \'SkipPrepIngest        := SkipSourceIngest     ;\\n\'\n'
 + '+ \'SkipRunIngest         := SkipPrepIngest       ;\\n\'\n'
 + '+ \'SkipDOT               := SkipRunIngest        ;\\n\'\n'
 + '+ \'SkipProx              := SkipDOT              ;\\n\'\n'
 + '+ \'SkipProxMj6           := SkipProx             ;\\n\'\n'
 + '+ \'SkipProxPost          := SkipProxMj6          ;\\n\'\n'
 + '+ \'SkipHierarchy         := SkipProxPost         ;\\n\'\n'
 + '+ \'SkipLgid3             := SkipHierarchy        ;\\n\'\n'
 + '+ \'SkipPowDown           := SkipLgid3            ;\\n\'\n'
 + '+ \'SkipPow               := SkipPowDown          ;\\n\'\n'
 + '+ \'SkipEmpDown           := SkipPow              ;\\n\'\n'
 + '+ \'SkipEmp               := SkipEmpDown          ;\\n\'\n'
 + '+ \'SkipCommonBase        := SkipEmp              ;\\n\'\n'
 + '+ \'SkipXlink             := SkipCommonBase       ; // -- Thread 1\\n\'\n'
 + '+ \'SkipCopyXlinkKeys     := SkipXlink            ; // --\\n\'\n'
 + '+ \'SkipXlinkValidation   := SkipCopyXlinkKeys    ; // --\\n\'\n'
 + '+ \'SkipXlinkSample       := SkipXlinkValidation  ; // --\\n\'\n'
 + '+ \'SkipWeeklyKeys        := SkipXlinkSample      ; // --\\n\'\n'
 + '+ \'SkipBest              := SkipWeeklyKeys       ; // -- Thread 2\\n\'\n'
 + '+ \'SkipIndustry          := SkipBest             ; // --\\n\'\n'
 + '+ \'SkipMisckeys          := SkipIndustry         ; // --\\n\'\n'
 + '+ \'SkipSegStats          := SkipMisckeys         ; // -- Thread 3\\n\'\n'
 + '+ \'SkipStrata            := SkipSegStats         ; // --\\n\'\n'
 + '+ \'SkipOverlinking       := SkipStrata           ; // --\\n\'\n'
 + '+ \'SkipSeleidRelative    := SkipOverlinking      ; // -- Thread 4\\n\'\n'
 + '+ \'SkipCDWBuild          := SkipSeleidRelative   ; // -- back to Master\\n\'\n'
 + '+ \'SkipXAppend           := SkipCDWBuild         ; //\\n\'\n'
 + '+ \'SkipDataCard          := SkipXAppend          ;\\n\'\n'
 + '+ \'SkipDashboard         := SkipDataCard         ;\\n\'\n'
 + '+ \'SkipCopyOtherKeys     := SkipDashboard        ;\\n\'\n'
 + '+ \'SkipRenameKeys        := SkipCopyOtherKeys    ;\\n\'\n'
 + '+ \'SkipVerifyKeys        := SkipRenameKeys       ;\\n\'\n'
 + '+ \'SkipUpdateDOPS        := SkipVerifyKeys       ;\\n\'\n'
 + '+ \'SkipDOTSpecsPost      := SkipUpdateDOPS       ;\\n\'\n'
 + '+ \'SkipSeleRelSpecsPost  := SkipDOTSpecsPost     ;\\n\'\n'
 + '+ \'OmitDisposition       := \\\'preserve\\\'            ;// NOTE: Set to \\\'preserve\\\' or \\\'ghost\\\' to recover from a missing source in the ingest file\\n\'\n'
 + '+ \'RenameKeysFilter         := \\\'bipv2_proxid|strnbrname|bipv2_relative|biz_preferred\\\'  ;\\n\'\n'
 + '+ \'InputFilenameForProxMj6  := BIPV2_Proxid.filenames().out.built    ; //\\\'BIPV2_Files.files_dotid.FILE_BASE\\\'  //default is to start where we left off\\n\'\n'
 + '+ \'InputFilenameForProxPost := bipv2_proxid_mj6._filenames().out.built ; //\\\'BIPV2_Files.files_dotid.FILE_BASE\\\'  //default is to start where we left off\\n\'\n'
 + '+ \'#workunit(\\\'name\\\'    ,\\\'BIPV2 Full Build \\\' + lversion );\\n\'\n'
 + '+ \'#workunit(\\\'priority\\\',\\\'high\\\'                         );\\n\'\n'
 + '+ \'#workunit(\\\'protect\\\' ,\\\'true\\\'                         );\\n\'\n'
 + '+ \'BIPV2_Build.proc_build_all(\\n\'\n'
 + '+ \'   pversion               := lversion\\n\'\n'
 + '+ \'  ,pDotStartIteration     := DotStartIteration\\n\'\n'
 + '+ \'  ,pProxStartIteration    := ProxStartIteration\\n\'\n'
 + '+ \'  ,pLgid3StartIteration   := Lgid3StartIteration\\n\'\n'
 + '+ \'  ,pPowDownStartIteration := PowDownStartIteration\\n\'\n'
 + '+ \'  ,pPowStartIteration     := PowStartIteration\\n\'\n'
 + '+ \'  ,pEmpDownStartIteration := EmpDownStartIteration\\n\'\n'
 + '+ \'  ,pEmpStartIteration     := EmpStartIteration\\n\'\n'
 + '+ \'  ,pDotNumIterations      := DotNumIterations\\n\'\n'
 + '+ \'  ,pProxNumIterations     := ProxNumIterations\\n\'\n'
 + '+ \'  ,pProxMj6NumIterations  := ProxMj6NumIterations\\n\'\n'
 + '+ \'  ,pProxPostNumIterations := ProxPostNumIterations\\n\'\n'
 + '+ \'  ,pLgid3NumIterations    := Lgid3NumIterations\\n\'\n'
 + '+ \'  ,pPowDownNumIterations  := PowDownNumIterations\\n\'\n'
 + '+ \'  ,pPowNumIterations      := PowNumIterations\\n\'\n'
 + '+ \'  ,pEmpDownNumIterations  := EmpDownNumIterations\\n\'\n'
 + '+ \'  ,pEmpNumIterations  		:= EmpNumIterations\\n\'\n'
 + '+ \'  ,pPromote2QA            := Promote2QA\\n\'\n'
 + '+ \'  ,pdoDotidInit           := doDotidInit\\n\'\n'
 + '+ \'  ,pdoDotidSpecs          := doDotidSpecs\\n\'\n'
 + '+ \'  ,pdoDotidIters          := doDotidIters\\n\'\n'
 + '+ \'  ,pdoDotidPost           := doDotidPost\\n\'\n'
 + '+ \'  ,pdoProxidpatch         := doProxidpatch\\n\'\n'
 + '+ \'  ,pdoProxidSpecs         := doProxidSpecs\\n\'\n'
 + '+ \'  ,pdoProxidMj6Preprocess := doProxidMj6Preprocess\\n\'\n'
 + '+ \'  ,pdoProxidMj6Specs      := doProxidMj6Specs\\n\'\n'
 + '+ \'  ,pdoProxidMj6Iters      := doProxidMj6Iters\\n\'\n'
 + '+ \'  ,pdoProxidMj6PostProcess:= doProxidMj6PostProcess\\n\'\n'
 + '+ \'  ,pdoLgid3Init           := doLgid3Init\\n\'\n'
 + '+ \'  ,pdoLgid3Specs          := doLgid3Specs\\n\'\n'
 + '+ \'  ,pdoLgid3Iters          := doLgid3Iters\\n\'\n'
 + '+ \'  ,pdoLgid3Post           := doLgid3Post\\n\'\n'
 + '+ \'  ,pdoPowDownInit         := doPowDownInit\\n\'\n'
 + '+ \'  ,pdoPowDownSpecs        := doPowDownSpecs\\n\'\n'
 + '+ \'  ,pdoPowInit             := doPowInit\\n\'\n'
 + '+ \'  ,pdoPowSpecs            := doPowSpecs\\n\'\n'
 + '+ \'  ,pdoPowIters            := doPowIters\\n\'\n'
 + '+ \'  ,pdoPowPost             := doPowPost\\n\'\n'
 + '+ \'  ,pdoEmpDownInit         := doEmpDownInit\\n\'\n'
 + '+ \'  ,pdoEmpInit             := doEmpInit\\n\'\n'
 + '+ \'  ,pdoEmpSpecs            := doEmpSpecs\\n\'\n'
 + '+ \'  ,pdoEmpIters            := doEmpIters\\n\'\n'
 + '+ \'  ,pdoEmpPost             := doEmpPost\\n\'\n'
 + '+ \'  ,pSkipSpaceUsage        := SkipSpaceUsage\\n\'\n'
 + '+ \'  ,pSkipCleanup           := SkipCleanup\\n\'\n'
 + '+ \'  ,pSkipSourceIngest      := SkipSourceIngest\\n\'\n'
 + '+ \'  ,pSkipPrepIngest        := SkipPrepIngest\\n\'\n'
 + '+ \'  ,pSkipRunIngest         := SkipRunIngest\\n\'\n'
 + '+ \'  ,pSkipDOT               := SkipDOT\\n\'\n'
 + '+ \'  ,pSkipProx              := SkipProx\\n\'\n'
 + '+ \'  ,pSkipProxMj6           := SkipProxMj6\\n\'\n'
 + '+ \'  ,pSkipProxPost          := SkipProxPost\\n\'\n'
 + '+ \'  ,pSkipHierarchy         := SkipHierarchy\\n\'\n'
 + '+ \'  ,pSkipLgid3             := SkipLgid3\\n\'\n'
 + '+ \'  ,pSkipPowDown           := SkipPowDown\\n\'\n'
 + '+ \'  ,pSkipPow               := SkipPow\\n\'\n'
 + '+ \'  ,pSkipEmpDown           := SkipEmpDown\\n\'\n'
 + '+ \'  ,pSkipEmp               := SkipEmp\\n\'\n'
 + '+ \'  ,pSkipCommonBase        := SkipCommonBase\\n\'\n'
 + '+ \'  ,pSkipXlink             := SkipXlink\\n\'\n'
 + '+ \'  ,pSkipCopyXlinkKeys     := SkipCopyXlinkKeys\\n\'\n'
 + '+ \'  ,pSkipXlinkValidation   := SkipXlinkValidation\\n\'\n'
 + '+ \'  ,pSkipXlinkSample       := SkipXlinkSample\\n\'\n'
 + '+ \'  ,pSkipWeeklyKeys        := SkipWeeklyKeys\\n\'\n'
 + '+ \'  ,pSkipBest              := SkipBest\\n\'\n'
 + '+ \'  ,pSkipIndustry          := SkipIndustry\\n\'\n'
 + '+ \'  ,pSkipMisckeys          := SkipMisckeys\\n\'\n'
 + '+ \'  ,pSkipSegStats          := SkipSegStats\\n\'\n'
 + '+ \'  ,pSkipStrata            := SkipStrata\\n\'\n'
 + '+ \'  ,pSkipOverlinking       := SkipOverlinking\\n\'\n'
 + '+ \'  ,pSkipSeleidRelative    := SkipSeleidRelative\\n\'\n'
 + '+ \'  ,pSkipCDWBuild          := SkipCDWBuild\\n\'\n'
 + '+ \'  ,pSkipXAppend           := SkipXAppend\\n\'\n'
 + '+ \'  ,pSkipDataCard          := SkipDataCard\\n\'\n'
 + '+ \'  ,pSkipDashboard         := SkipDashboard\\n\'\n'
 + '+ \'  ,pSkipCopyOtherKeys     := SkipCopyOtherKeys\\n\'\n'
 + '+ \'  ,pSkipRenameKeys        := SkipRenameKeys\\n\'\n'
 + '+ \'  ,pSkipVerifyKeys        := SkipVerifyKeys\\n\'\n'
 + '+ \'  ,pSkipUpdateDOPS        := SkipUpdateDOPS\\n\'\n'
 + '+ \'  ,pSkipDOTSpecsPost      := SkipDOTSpecsPost\\n\'\n'
 + '+ \'  ,pSkipSeleRelSpecsPost  := SkipSeleRelSpecsPost\\n\'\n'
 + '+ \'  ,pOmitDisposition       := OmitDisposition\\n\'\n'
 + '+ \'  ,pRenameKeysFilter          := RenameKeysFilter\\n\'\n'
 + '+ \'  // ,pDotFilenameForProx        := DotFilenameForProx\\n\'\n'
 + '+ \'  ,pInputFilenameForProxMj6   := InputFilenameForProxMj6\\n\'\n'
 + '+ \'  ,pInputFilenameForProxPost  := InputFilenameForProxPost\\n\'\n'
 + '+ \');\\n\'\n'
  ;
// -- add parent wuid link
eclcode     := eclcodepre
              ;

kickeclcode := 'kickBuild := wk_ut.mac_ChainWuids(' + eclcode + ',1,1,\'' + pversion + '\',,\'' + cluster + '\',pOutputEcl := ' + fbool(OutputEcl) + ',pUniqueOutput := \'BIPV2_FULL_BUILD\',pNotifyEmails := \'' + emails + '\'\n'
+ '    ,pOutputFilename   := \'~bipv2_build::@version@::workunit_history::proc_build_all\'\n'
+ '    ,pOutputSuperfile  := \'~bipv2_build::qa::workunit_history\'\n' 
+ '    ,pSummaryFilename  := \'~bipv2_build::@version@::summary_report::proc_build_all\'\n'
+ '    ,pSummarySuperfile := \'~bipv2_build::qa::summary_report::proc_build_all\'\n'                                                 
+ ');\n'
+ 'kickBuild;'
;

kick_Wuid	  := wk_ut.CreateWuid(kickeclcode,cluster);
wuid_link   := '<a href="http://' + wk_ut._Constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + kick_Wuid + '#/stub/Summary">Child Workunit</a>';

output(kick_Wuid  ,named('Child_Wuid'       ));
output(wuid_link  ,named('Child_Wuid__html' ));
