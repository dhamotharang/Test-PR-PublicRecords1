﻿//make sure code for bwr_build_all is up-to-date, then run this. --NOT USED ANYMORE BECAUSE OF GIT.  MODIFY THE ITERATION START #S IN THIS ATTRIBUTE

import bipv2,wk_ut,_control,bipv2_build;

pversion    := BIPV2.KeySuffix                                      ;
cluster     := wk_ut._Constants.localhthor                          ;
OutputEcl   := false                                                ;
emails      := BIPV2_Build.mod_email.emailList                      ;

fbool(boolean pinput) := if(pinput = true,'true','false');

eclcodepre  := 
   'import bipv2,bipv2_build,BIPV2_Files,BIPV2_DotID,wk_ut;\n'
 + '//version\n'
 + 'lversion              := BIPV2.KeySuffix       ;\n'
 + '//Start iterations\n'
 + 'DotStartIteration     := 196                   ;\n'
 + 'ProxStartIteration    := 378                   ;\n'
 + 'Lgid3StartIteration   := 304                   ;\n'
 + 'PowDownStartIteration := 1                     ;\n'
 + 'PowStartIteration     := 1                     ;\n'
 + 'EmpDownStartIteration := 1                     ;\n'
 + 'EmpStartIteration     := 1                     ;\n'
 + '//Number of iterations\n'
 + 'DotNumIterations      := 3                     ;\n'
 + 'ProxNumIterations     := 2                     ;\n'
 + 'ProxMj6NumIterations  := 3                     ;\n'
 + 'ProxPostNumIterations := 3                     ; //added 1 more iteration for more convergence 6/20/2017\n'
 + 'Lgid3NumIterations    := 15                    ;//For S47, use 15 and will back to 8 after S47!!! change from 4 to 10 after 2/16/2016 BIP meeting. changed to 15 according to Vern\'s email 4/20/2016; change to 8 on 20161215\n'
 + 'PowDownNumIterations  := 2                     ;\n'
 + 'PowNumIterations      := 2                     ;\n'
 + 'EmpDownNumIterations  := 6                     ;  //On 12/17/2015 BIP meeting, we agreed to +3 more iterations, so change from 3 to 6 \n'
 + 'EmpNumIterations      := 3                     ;\n'
 + '//promote build to qa supers at end?\n'
 + 'Promote2QA            := false                 ;\n'
 + '//do patches/specs?\n'
 + 'doDotidInit           := true                  ;\n'
 + 'doDotidSpecs          := false                 ;  //done at end normally, but keep this here in case need to do it before\n'
 + 'doDotidIters          := true                  ;\n'
 + 'doDotidPost           := true                  ;\n'
 + 'doProxidpatch         := true                  ;\n'
 + 'doProxidSpecs         := true                  ;\n'
 + 'doProxidMj6Preprocess := true                  ;\n'
 + 'doProxidMj6Specs      := true                  ;\n'
 + 'doProxidMj6Iters      := true                  ;\n'
 + 'doProxidMj6PostProcess:= true                  ;\n'
 + 'doLgid3Init           := true                  ;\n'
 + 'doLgid3Specs          := true                  ;\n'
 + 'doLgid3Iters          := true                  ;\n'
 + 'doLgid3Post           := true                  ;\n'
 + 'doPowDownInit         := true                  ;\n'
 + 'doPowDownSpecs        := true                  ;\n'
 + 'doPowInit             := true                  ;\n'
 + 'doPowSpecs            := true                  ;\n'
 + 'doPowIters            := true                  ;\n'
 + 'doPowPost             := true                  ;\n'
 + 'doEmpDownInit         := true                  ;\n'
 + 'doEmpInit             := true                  ;\n'
 + 'doEmpSpecs            := true                  ;\n'
 + 'doEmpIters            := true                  ;\n'
 + 'doEmpPost             := true                  ;\n'
 + '//skip specific parts of build\n'
 + 'SkipSpaceUsage        := false                ;\n'
 + 'SkipCleanup           := SkipSpaceUsage       ;\n'
 + 'SkipSourceIngest      := SkipCleanup          ;\n'
 + 'SkipPrepIngest        := SkipSourceIngest     ;\n'
 + 'SkipRunIngest         := SkipPrepIngest       ;\n'
 + 'SkipDOT               := SkipRunIngest        ;\n'
 + 'SkipProx              := SkipDOT              ;\n'
 + 'SkipProxMj6           := SkipProx             ;\n'
 + 'SkipProxPost          := SkipProxMj6          ;\n'
 + 'SkipHierarchy         := SkipProxPost         ;\n'
 + 'SkipLgid3             := SkipHierarchy        ;\n'
 + 'SkipPowDown           := SkipLgid3            ;\n'
 + 'SkipPow               := SkipPowDown          ;\n'
 + 'SkipEmpDown           := SkipPow              ;\n'
 + 'SkipEmp               := SkipEmpDown          ;\n'
 + 'SkipCommonBase        := SkipEmp              ;\n'
 + 'SkipXlink             := SkipCommonBase       ; // -- Thread 1\n'
 + 'SkipCopyXlinkKeys     := SkipXlink            ; // --\n'
 + 'SkipXlinkValidation   := SkipCopyXlinkKeys    ; // --\n'
 + 'SkipXlinkSample       := SkipXlinkValidation  ; // --\n'
 + 'SkipWeeklyKeys        := SkipXlinkSample      ; // --\n'
 + 'SkipBest              := SkipWeeklyKeys       ; // -- Thread 2\n'
 + 'SkipIndustry          := SkipBest             ; // --\n'
 + 'SkipMisckeys          := SkipIndustry         ; // --\n'
 + 'SkipSegStats          := SkipMisckeys         ; // -- Thread 3\n'
 + 'SkipStrata            := SkipSegStats         ; // --\n'
 + 'SkipOverlinking       := SkipStrata           ; // --\n'
 + 'SkipSeleidRelative    := SkipOverlinking      ; // -- Thread 4\n'
 + 'SkipCDWBuild          := SkipSeleidRelative   ; // -- back to Master\n'
 + 'SkipXAppend           := SkipCDWBuild         ; //\n'
 + 'SkipDataCard          := SkipXAppend          ;\n'
 + 'SkipDashboard         := SkipDataCard         ;\n'
 + 'SkipCopyOtherKeys     := SkipDashboard        ;\n'
 + 'SkipRenameKeys        := SkipCopyOtherKeys    ;\n'
 + 'SkipVerifyKeys        := SkipRenameKeys       ;\n'
 + 'SkipUpdateDOPS        := SkipVerifyKeys       ;\n'
 + 'SkipDOTSpecsPost      := SkipUpdateDOPS       ;\n'
 + 'SkipSeleRelSpecsPost  := SkipDOTSpecsPost     ;\n'
 + 'OmitDisposition       := \'preserve\'            ;// NOTE: Set to \'preserve\' or \'ghost\' to recover from a missing source in the ingest file\n'
 + 'RenameKeysFilter         := \'bipv2_proxid|strnbrname|bipv2_relative|biz_preferred\'  ;\n'
 + 'InputFilenameForProxMj6  := BIPV2_Proxid.filenames().out.built    ; //\'BIPV2_Files.files_dotid.FILE_BASE\'  //default is to start where we left off\n'
 + 'InputFilenameForProxPost := bipv2_proxid_mj6._filenames().out.built ; //\'BIPV2_Files.files_dotid.FILE_BASE\'  //default is to start where we left off\n'
 + '#workunit(\'name\'    ,\'BIPV2 Full Build \' + lversion );\n'
 + '#workunit(\'priority\',\'high\'                         );\n'
 + '#workunit(\'protect\' ,\'true\'                         );\n'
 + 'BIPV2_Build.proc_build_all(\n'
 + '   pversion               := lversion\n'
 + '  ,pDotStartIteration     := DotStartIteration\n'
 + '  ,pProxStartIteration    := ProxStartIteration\n'
 + '  ,pLgid3StartIteration   := Lgid3StartIteration\n'
 + '  ,pPowDownStartIteration := PowDownStartIteration\n'
 + '  ,pPowStartIteration     := PowStartIteration\n'
 + '  ,pEmpDownStartIteration := EmpDownStartIteration\n'
 + '  ,pEmpStartIteration     := EmpStartIteration\n'
 + '  ,pDotNumIterations      := DotNumIterations\n'
 + '  ,pProxNumIterations     := ProxNumIterations\n'
 + '  ,pProxMj6NumIterations  := ProxMj6NumIterations\n'
 + '  ,pProxPostNumIterations := ProxPostNumIterations\n'
 + '  ,pLgid3NumIterations    := Lgid3NumIterations\n'
 + '  ,pPowDownNumIterations  := PowDownNumIterations\n'
 + '  ,pPowNumIterations      := PowNumIterations\n'
 + '  ,pEmpDownNumIterations  := EmpDownNumIterations\n'
 + '  ,pEmpNumIterations  		:= EmpNumIterations\n'
 + '  ,pPromote2QA            := Promote2QA\n'
 + '  ,pdoDotidInit           := doDotidInit\n'
 + '  ,pdoDotidSpecs          := doDotidSpecs\n'
 + '  ,pdoDotidIters          := doDotidIters\n'
 + '  ,pdoDotidPost           := doDotidPost\n'
 + '  ,pdoProxidpatch         := doProxidpatch\n'
 + '  ,pdoProxidSpecs         := doProxidSpecs\n'
 + '  ,pdoProxidMj6Preprocess := doProxidMj6Preprocess\n'
 + '  ,pdoProxidMj6Specs      := doProxidMj6Specs\n'
 + '  ,pdoProxidMj6Iters      := doProxidMj6Iters\n'
 + '  ,pdoProxidMj6PostProcess:= doProxidMj6PostProcess\n'
 + '  ,pdoLgid3Init           := doLgid3Init\n'
 + '  ,pdoLgid3Specs          := doLgid3Specs\n'
 + '  ,pdoLgid3Iters          := doLgid3Iters\n'
 + '  ,pdoLgid3Post           := doLgid3Post\n'
 + '  ,pdoPowDownInit         := doPowDownInit\n'
 + '  ,pdoPowDownSpecs        := doPowDownSpecs\n'
 + '  ,pdoPowInit             := doPowInit\n'
 + '  ,pdoPowSpecs            := doPowSpecs\n'
 + '  ,pdoPowIters            := doPowIters\n'
 + '  ,pdoPowPost             := doPowPost\n'
 + '  ,pdoEmpDownInit         := doEmpDownInit\n'
 + '  ,pdoEmpInit             := doEmpInit\n'
 + '  ,pdoEmpSpecs            := doEmpSpecs\n'
 + '  ,pdoEmpIters            := doEmpIters\n'
 + '  ,pdoEmpPost             := doEmpPost\n'
 + '  ,pSkipSpaceUsage        := SkipSpaceUsage\n'
 + '  ,pSkipCleanup           := SkipCleanup\n'
 + '  ,pSkipSourceIngest      := SkipSourceIngest\n'
 + '  ,pSkipPrepIngest        := SkipPrepIngest\n'
 + '  ,pSkipRunIngest         := SkipRunIngest\n'
 + '  ,pSkipDOT               := SkipDOT\n'
 + '  ,pSkipProx              := SkipProx\n'
 + '  ,pSkipProxMj6           := SkipProxMj6\n'
 + '  ,pSkipProxPost          := SkipProxPost\n'
 + '  ,pSkipHierarchy         := SkipHierarchy\n'
 + '  ,pSkipLgid3             := SkipLgid3\n'
 + '  ,pSkipPowDown           := SkipPowDown\n'
 + '  ,pSkipPow               := SkipPow\n'
 + '  ,pSkipEmpDown           := SkipEmpDown\n'
 + '  ,pSkipEmp               := SkipEmp\n'
 + '  ,pSkipCommonBase        := SkipCommonBase\n'
 + '  ,pSkipXlink             := SkipXlink\n'
 + '  ,pSkipCopyXlinkKeys     := SkipCopyXlinkKeys\n'
 + '  ,pSkipXlinkValidation   := SkipXlinkValidation\n'
 + '  ,pSkipXlinkSample       := SkipXlinkSample\n'
 + '  ,pSkipWeeklyKeys        := SkipWeeklyKeys\n'
 + '  ,pSkipBest              := SkipBest\n'
 + '  ,pSkipIndustry          := SkipIndustry\n'
 + '  ,pSkipMisckeys          := SkipMisckeys\n'
 + '  ,pSkipSegStats          := SkipSegStats\n'
 + '  ,pSkipStrata            := SkipStrata\n'
 + '  ,pSkipOverlinking       := SkipOverlinking\n'
 + '  ,pSkipSeleidRelative    := SkipSeleidRelative\n'
 + '  ,pSkipCDWBuild          := SkipCDWBuild\n'
 + '  ,pSkipXAppend           := SkipXAppend\n'
 + '  ,pSkipDataCard          := SkipDataCard\n'
 + '  ,pSkipDashboard         := SkipDashboard\n'
 + '  ,pSkipCopyOtherKeys     := SkipCopyOtherKeys\n'
 + '  ,pSkipRenameKeys        := SkipRenameKeys\n'
 + '  ,pSkipVerifyKeys        := SkipVerifyKeys\n'
 + '  ,pSkipUpdateDOPS        := SkipUpdateDOPS\n'
 + '  ,pSkipDOTSpecsPost      := SkipDOTSpecsPost\n'
 + '  ,pSkipSeleRelSpecsPost  := SkipSeleRelSpecsPost\n'
 + '  ,pOmitDisposition       := OmitDisposition\n'
 + '  ,pRenameKeysFilter          := RenameKeysFilter\n'
 + '  // ,pDotFilenameForProx        := DotFilenameForProx\n'
 + '  ,pInputFilenameForProxMj6   := InputFilenameForProxMj6\n'
 + '  ,pInputFilenameForProxPost  := InputFilenameForProxPost\n'
 + ');'
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
