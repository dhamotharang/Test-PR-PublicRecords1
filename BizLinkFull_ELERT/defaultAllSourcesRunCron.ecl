// Builder window code for executing header ELERT workflow using CRON
IMPORT _Control AS pkgControl;
IMPORT STD AS pkgSTD;

EXPORT defaultAllSourcesRunCron := MODULE 

    #OPTION('multiplePersistInstances', BizLinkFull_ELERT.modConstants.bMPIFlag);
    sInVersion  := pkgSTD.Str.Filter(pkgSTD.Date.SecondsToString(pkgSTD.Date.CurrentSeconds()), '0123456789');// <-- UPDATE ME (and run this on hthor only!)
    sDescription := 'Roxie vs. Thor All Sources';
    sRerunID    := '';
    iNumSamples := 25000;
    iExpireTime := 30; 
    sSamplesFileName := '';
    bBaseline      := FALSE;
    bIsTest := TRUE;
    sInPrefix := '~thor::bizlinkfull::elert::all_sources::';
    ssConstantValues := ['\'\'','\'qa\''];
    sProfiles := 'BizLinkFull_ELERT.modProfiles.dProfileAllDefault';
    ssIdAppendThorCall  := ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendThor','BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendThor'];
    ssIdAppendRoxieCall  := ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendRoxie','BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendRoxie'];
    ssIdFunctionsCall  := ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdFunctions','BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdFunctions'];
    ssMMFCall      		:= ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperMMF','BizLinkFull_ELERT.modCallFunctions.fCallWrapperMMF'];
    ssRoxieServices := ['BizLinkFull_ELERT.svcappendorigservice','BizLinkFull_ELERT.svcappendnewservice'];
    sHyperLinkProfile  := 'BizLinkFull_ELERT.modHyperlinkProfiles.dProfiles';
    dDebugInput1 := '';
    dDebugInput2 := '';
    sEmailTo := '';
    bRunProdVsLocal := FALSE;
    bIsStatsProxidLevel := TRUE;
    #WORKUNIT('name','BizLinkFull ELERT '+sDescription);
    
    ///// MAIN RUN /////
    EXPORT runJob := BizLinkFull_ELERT.macMaster(
        sInVersion,
        sRerunID,
        iNumSamples,
        iExpireTime,
        sSamplesFileName,
        bBaseline,
        ssConstantValues,
        sProfiles,
        ssIdAppendThorCall,
        ssIdAppendRoxieCall,
        ssIdFunctionsCall,
        ssMMFCall,
        sHyperLinkProfile,
        BizLinkFull_ELERT.modConstants.sPrimaryQueue,
        BizLinkFull_ELERT.modConstants.sSecondaryQueue,
        BizLinkFull_ELERT.modConstants.bOutECL,         // outECL: just output ECL, don't execute anything
        dDebugInput1,
        dDebugInput2,
        sInPrefix,
        bIsTest,
        sEmailTo,
        BizLinkFull_ELERT.modConstants.bUseForeignFiles,
        BizLinkFull_ELERT.modConstants.iDefaultSamples4External,
        bRunProdVsLocal,
        bIsStatsProxidLevel,

        // ----- Steps -----
        TRUE,   // bDoGenerateSamples: Get latest samples from the different sources
        TRUE,   // bRunTestsOrig: Run the samples through the "baseline" code
        TRUE,   // bRunTestsNew: Run the samples through the "New" Code
        TRUE    // bGenerateStats: Genrate Stats using the most recent results from ORIG and NEW superfiles
    )
    : SUCCESS(pkgSTD.System.Email.SendEmail(BizLinkFull_ELERT.modConstants.sEmailNotify,
    'COMPLETED: BizLinkFull ELERT ('+pkgControl.ThisEnvironment.ESP_IPAddress+' '+WORKUNIT+')',
    '')),
    FAILURE(pkgSTD.System.Email.SendEmail(BizLinkFull_ELERT.modConstants.sEmailNotify,
    'FAILED: BizLinkFull ELERT ('+pkgControl.ThisEnvironment.ESP_IPAddress+' '+WORKUNIT+')',
    FAILMESSAGE));
END;