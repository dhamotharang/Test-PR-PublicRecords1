﻿import bipv2,bipv2_build,BIPV2_Files,BIPV2_DotID,wk_ut;
//version
lversion              := BIPV2.KeySuffix       ;
//Start iterations
DotStartIteration     := 196                   ;
ProxStartIteration    := 378                   ;
Lgid3StartIteration   := 304                   ;
PowDownStartIteration := 1                     ;
PowStartIteration     := 1                     ;
EmpDownStartIteration := 1                     ;
EmpStartIteration     := 1                     ;
//Number of iterations
DotNumIterations      := 3                     ;
ProxNumIterations     := 2                     ;
ProxMj6NumIterations  := 3                     ;
ProxPostNumIterations := 3                     ; //added 1 more iteration for more convergence 6/20/2017
Lgid3NumIterations    := 15                    ;//For S47, use 15 and will back to 8 after S47!!! change from 4 to 10 after 2/16/2016 BIP meeting. changed to 15 according to Vern's email 4/20/2016; change to 8 on 20161215
PowDownNumIterations  := 2                     ;
PowNumIterations      := 2                     ;
EmpDownNumIterations  := 6                     ;  //On 12/17/2015 BIP meeting, we agreed to +3 more iterations, so change from 3 to 6 
EmpNumIterations      := 3                     ;
//promote build to qa supers at end?
Promote2QA            := false                 ;
//do patches/specs?
doDotidInit           := true                  ;
doDotidSpecs          := false                 ;  //done at end normally, but keep this here in case need to do it before
doDotidIters          := true                  ;
doDotidPost           := true                  ;
doProxidpatch         := true                  ;
doProxidSpecs         := true                  ;
doProxidMj6Preprocess := true                  ;
doProxidMj6Specs      := true                  ;
doProxidMj6Iters      := true                  ;
doProxidMj6PostProcess:= true                  ;
doLgid3Init           := true                  ;
doLgid3Specs          := true                  ;
doLgid3Iters          := true                  ;
doLgid3Post           := true                  ;
doPowDownInit         := true                  ;
doPowDownSpecs        := true                  ;
doPowInit             := true                  ;
doPowSpecs            := true                  ;
doPowIters            := true                  ;
doPowPost             := true                  ;
doEmpDownInit         := true                  ;
doEmpInit             := true                  ;
doEmpSpecs            := true                  ;
doEmpIters            := true                  ;
doEmpPost             := true                  ;
//skip specific parts of build
SkipSpaceUsage        := false                ;
SkipCleanup           := SkipSpaceUsage       ;
SkipSourceIngest      := SkipCleanup          ;
SkipPrepIngest        := SkipSourceIngest     ;
SkipRunIngest         := SkipPrepIngest       ;
SkipDOT               := SkipRunIngest        ;
SkipProx              := SkipDOT              ;
SkipProxMj6           := SkipProx             ;
SkipProxPost          := SkipProxMj6          ;
SkipHierarchy         := SkipProxPost         ;
SkipLgid3             := SkipHierarchy        ;
SkipPowDown           := SkipLgid3            ;
SkipPow               := SkipPowDown          ;
SkipEmpDown           := SkipPow              ;
SkipEmp               := SkipEmpDown          ;
SkipCommonBase        := SkipEmp              ;
SkipXlink             := SkipCommonBase       ; // -- Thread 1
SkipCopyXlinkKeys     := SkipXlink            ; // --
SkipXlinkValidation   := SkipCopyXlinkKeys    ; // --
SkipXlinkSample       := SkipXlinkValidation  ; // --
SkipWeeklyKeys        := SkipXlinkSample      ; // --
SkipBest              := SkipWeeklyKeys       ; // -- Thread 2
SkipIndustry          := SkipBest             ; // --
SkipMisckeys          := SkipIndustry         ; // --
SkipSegStats          := SkipMisckeys         ; // -- Thread 3
SkipStrata            := SkipSegStats         ; // --
SkipOverlinking       := SkipStrata           ; // --
SkipSeleidRelative    := SkipOverlinking      ; // -- Thread 4
SkipCDWBuild          := SkipSeleidRelative   ; // -- back to Master
SkipXAppend           := SkipCDWBuild         ; //
SkipDataCard          := SkipXAppend          ;
SkipDashboard         := SkipDataCard         ;
SkipCopyOtherKeys     := SkipDashboard        ;
SkipRenameKeys        := SkipCopyOtherKeys    ;
SkipVerifyKeys        := SkipRenameKeys       ;
SkipUpdateDOPS        := SkipVerifyKeys       ;
SkipDOTSpecsPost      := SkipUpdateDOPS       ;
SkipSeleRelSpecsPost  := SkipDOTSpecsPost     ;
OmitDisposition       := 'preserve'            ;// NOTE: Set to 'preserve' or 'ghost' to recover from a missing source in the ingest file
RenameKeysFilter         := 'bipv2_proxid|strnbrname|bipv2_relative|biz_preferred'  ;
InputFilenameForProxMj6  := BIPV2_Proxid.filenames().out.built    ; //'BIPV2_Files.files_dotid.FILE_BASE'  //default is to start where we left off
InputFilenameForProxPost := bipv2_proxid_mj6._filenames().out.built ; //'BIPV2_Files.files_dotid.FILE_BASE'  //default is to start where we left off
#workunit('name'    ,'BIPV2 Full Build ' + lversion );
#workunit('priority','high'                         );
#workunit('protect' ,'true'                         );
BIPV2_Build.proc_build_all(
   pversion               := lversion
  ,pDotStartIteration     := DotStartIteration
  ,pProxStartIteration    := ProxStartIteration
  ,pLgid3StartIteration   := Lgid3StartIteration
  ,pPowDownStartIteration := PowDownStartIteration
  ,pPowStartIteration     := PowStartIteration
  ,pEmpDownStartIteration := EmpDownStartIteration
  ,pEmpStartIteration     := EmpStartIteration
  ,pDotNumIterations      := DotNumIterations
  ,pProxNumIterations     := ProxNumIterations
  ,pProxMj6NumIterations  := ProxMj6NumIterations
  ,pProxPostNumIterations := ProxPostNumIterations
  ,pLgid3NumIterations    := Lgid3NumIterations
  ,pPowDownNumIterations  := PowDownNumIterations
  ,pPowNumIterations      := PowNumIterations
  ,pEmpDownNumIterations  := EmpDownNumIterations
  ,pEmpNumIterations  		:= EmpNumIterations
  ,pPromote2QA            := Promote2QA
  ,pdoDotidInit           := doDotidInit
  ,pdoDotidSpecs          := doDotidSpecs
  ,pdoDotidIters          := doDotidIters
  ,pdoDotidPost           := doDotidPost
  ,pdoProxidpatch         := doProxidpatch
  ,pdoProxidSpecs         := doProxidSpecs
  ,pdoProxidMj6Preprocess := doProxidMj6Preprocess
  ,pdoProxidMj6Specs      := doProxidMj6Specs
  ,pdoProxidMj6Iters      := doProxidMj6Iters
  ,pdoProxidMj6PostProcess:= doProxidMj6PostProcess
  ,pdoLgid3Init           := doLgid3Init
  ,pdoLgid3Specs          := doLgid3Specs
  ,pdoLgid3Iters          := doLgid3Iters
  ,pdoLgid3Post           := doLgid3Post
  ,pdoPowDownInit         := doPowDownInit
  ,pdoPowDownSpecs        := doPowDownSpecs
  ,pdoPowInit             := doPowInit
  ,pdoPowSpecs            := doPowSpecs
  ,pdoPowIters            := doPowIters
  ,pdoPowPost             := doPowPost
  ,pdoEmpDownInit         := doEmpDownInit
  ,pdoEmpInit             := doEmpInit
  ,pdoEmpSpecs            := doEmpSpecs
  ,pdoEmpIters            := doEmpIters
  ,pdoEmpPost             := doEmpPost
  ,pSkipSpaceUsage        := SkipSpaceUsage
  ,pSkipCleanup           := SkipCleanup
  ,pSkipSourceIngest      := SkipSourceIngest
  ,pSkipPrepIngest        := SkipPrepIngest
  ,pSkipRunIngest         := SkipRunIngest
  ,pSkipDOT               := SkipDOT
  ,pSkipProx              := SkipProx
  ,pSkipProxMj6           := SkipProxMj6
  ,pSkipProxPost          := SkipProxPost
  ,pSkipHierarchy         := SkipHierarchy
  ,pSkipLgid3             := SkipLgid3
  ,pSkipPowDown           := SkipPowDown
  ,pSkipPow               := SkipPow
  ,pSkipEmpDown           := SkipEmpDown
  ,pSkipEmp               := SkipEmp
  ,pSkipCommonBase        := SkipCommonBase
  ,pSkipXlink             := SkipXlink
  ,pSkipCopyXlinkKeys     := SkipCopyXlinkKeys
  ,pSkipXlinkValidation   := SkipXlinkValidation
  ,pSkipXlinkSample       := SkipXlinkSample
  ,pSkipWeeklyKeys        := SkipWeeklyKeys
  ,pSkipBest              := SkipBest
  ,pSkipIndustry          := SkipIndustry
  ,pSkipMisckeys          := SkipMisckeys
  ,pSkipSegStats          := SkipSegStats
  ,pSkipStrata            := SkipStrata
  ,pSkipOverlinking       := SkipOverlinking
  ,pSkipSeleidRelative    := SkipSeleidRelative
  ,pSkipCDWBuild          := SkipCDWBuild
  ,pSkipXAppend           := SkipXAppend
  ,pSkipDataCard          := SkipDataCard
  ,pSkipDashboard         := SkipDashboard
  ,pSkipCopyOtherKeys     := SkipCopyOtherKeys
  ,pSkipRenameKeys        := SkipRenameKeys
  ,pSkipVerifyKeys        := SkipVerifyKeys
  ,pSkipUpdateDOPS        := SkipUpdateDOPS
  ,pSkipDOTSpecsPost      := SkipDOTSpecsPost
  ,pSkipSeleRelSpecsPost  := SkipSeleRelSpecsPost
  ,pOmitDisposition       := OmitDisposition
  ,pRenameKeysFilter          := RenameKeysFilter
  // ,pDotFilenameForProx        := DotFilenameForProx
  ,pInputFilenameForProxMj6   := InputFilenameForProxMj6
  ,pInputFilenameForProxPost  := InputFilenameForProxPost
);