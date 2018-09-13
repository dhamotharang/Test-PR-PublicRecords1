import BIPV2_PostProcess,BIPv2_HRCHY,BIPV2_Best,BIPv2_Relative,BizLinkFull,tools,wk_ut,tools,bipv2;

// -- Should add space usage and cleanup to dataland eventually!!!!

// -- promote all files and keys to qa versions
export Promote2QA(
   pversion                = 'Bipv2.KeySuffix'
  ,pShouldUpdateDOPS       = 'true'
  ,pShouldDoOtherClusters  = 'true'
  ,pPerformCleanup         = 'true'
  ,pShouldDoDataland       = 'true'
  ,pShouldCheckfullKeys    = 'true'
  ,pShouldCheckWeeklyKeys  = 'true'
) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;

  Promote2QAonDataland    := '#workunit(\'name\',\'BIPV2_Build.Promote2QA @version@\');\nBIPV2_Build.Promote2QA(\n\n   pversion         := \'@version@\'\n  ,pShouldUpdateDOPS       := false\n  ,pPerformCleanup := true);';
	KickPromote2QADataland	:= wk_ut.mac_ChainWuids(Promote2QAonDataland,1,1,pversion,,wk_ut._Constants.Esp2Hthor(wk_ut._Constants.DevEsp),pESP := wk_ut._Constants.DevEsp,pOutputEcl := false,pUniqueOutput := 'Promote2QAOnDataland',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Promote2QA'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );  //kick off on dataland

  cluster44 := tools.fun_Groupname('44');
  cluster36 := tools.fun_Groupname('36');

  email                 := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland and pShouldUpdateDOPS);
  UpdateFullKeysDops    := email.BIPV2FullKeys.Roxie    ;
  UpdateWeeklyKeysDops  := email.BIPV2WeeklyKeys.Roxie  ;
  CheckDatalandKeys     := email.BIPV2DatalandKeys.Roxie;
  outputdatalandkeys    := BIPV2_Build.BIPV2FullKeys_Package(pversion,false).outputpackage;
  outputBIPV2Fullkeys    := BIPV2_Build.BIPV2FullKeys_Package(pversion,false).outputpackage;
  outputBIPV2Weeklykeys    := BIPV2_Build.BIPV2WeeklyKeys_Package(pversion,false).outputpackage;
  
  f_out :=   BIPV2_Files.files_CommonBase.filePrefix  + pversion;
  
  dataland_names := BIPV2_Build.keynames(pversion).BIPV2FullKeys + BIPV2_Build.keynames(pversion).BIPV2WeeklyKeys + BIPV2.Filenames(pversion).Common_Base.dall_filenames;
  
  return 
  iff(Tools._Constants.isdataland = false
    ,sequential(
       if(pShouldCheckfullKeys    = true ,outputBIPV2Fullkeys   )
      ,if(pShouldCheckWeeklyKeys  = true ,outputBIPV2Weeklykeys )
       // BIPV2.CommonBase.updateSuperfiles(f_out) //update base file
      ,BIPV2_Build.Promote(pversion,,,false,BIPV2.Filenames(pversion).Common_Base.dall_filenames).new2base  //update commonbase file
      ,BIPV2_Build.Promote(pversion,,,false,BIPV2.Filenames(pversion).Common_Base.dall_filenames).built2qa  //update commonbase file
      ,BIPV2_Build.Promote().Built2QA //this includes everything
      ,UpdateFullKeysDops
      ,UpdateWeeklyKeysDops
      ,iff(pShouldDoOtherClusters = true  ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster44).Built2QA )
      ,iff(pShouldDoOtherClusters = true  ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster36).Built2QA )
      ,if(pShouldDoDataland ,KickPromote2QADataland)
      // ,BIPV2_Build.Build_Space_Usage(pversion,pType := 2)
      ,iff(pShouldDoOtherClusters = true and pPerformCleanup = true ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster44,pDelete := true).Cleanup  )
      ,iff(pShouldDoOtherClusters = true and pPerformCleanup = true ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster36,pDelete := true).Cleanup  )
      ,iff(pPerformCleanup        = true                            ,BIPV2_Build.Promote(,'^(?!.*?(wkhistory|precision|space|dashboard).*).*$',pDelete := true).Cleanup )
      // ,BIPV2_Build.Build_Space_Usage(pversion,pType := 3)
    )
    ,sequential(
       // BIPV2.CommonBase.updateSuperfiles(f_out) //update base file
       outputdatalandkeys //check to make sure all keys are built and match the code first before promoting them to qa
      ,BIPV2_Build.Promote(pversion,'',,,dataland_names).new2Built  //just in case they weren't added to built
      ,BIPV2_Build.Promote(,'',,,dataland_names).Built2QA
      // ,BIPV2_Build.Promote(pversion,,,false,BIPV2.Filenames(pversion).Common_Base.dall_filenames).built2qa //update commonbase file
      // ,BIPV2_Build.Promote(pversion,,,false,BIPV2.Filenames(pversion).Common_Base.dall_filenames).new2Base //update commonbase file
      ,CheckDatalandKeys
      // ,outputBIPV2Fullkeys
      ,iff(pPerformCleanup = true  ,BIPV2_Build.Promote(,'',,,dataland_names,pDelete := true).Cleanup  )
    )
  );

endmacro;