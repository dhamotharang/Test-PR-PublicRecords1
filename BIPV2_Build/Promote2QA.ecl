import BIPV2_PostProcess,BIPv2_HRCHY,BIPV2_Best,BIPv2_Relative,BizLinkFull,tools,wk_ut,tools,bipv2;

// -- Should add space usage and cleanup to dataland eventually!!!!

// -- promote all files and keys to qa versions
export Promote2QA(
   pversion                = 'Bipv2.KeySuffix'
  ,pShouldUpdateDOPS       = 'true'
  ,pShouldDoOtherClusters  = 'true'
  ,pPerformCleanup         = 'true'
  ,pShouldDoDataland       = 'true'
) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;

  Promote2QAonDataland    := '#workunit(\'name\',\'BIPV2_Build.Promote2QA @version@\');\nBIPV2_Build.Promote2QA(\n\n   pversion         := \'@version@\'\n  ,pShouldUpdateDOPS       := false\n  ,pPerformCleanup := true);';
//  Promote2QAonDataland    := 'output(80);';
	KickPromote2QADataland	:= wk_ut.mac_ChainWuids(Promote2QAonDataland,1,1,pversion,,wk_ut._Constants.Esp2Hthor(wk_ut._Constants.DevEsp),pESP := wk_ut._Constants.DevEsp,pOutputEcl := false,pUniqueOutput := 'Promote2QAOnDataland',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Promote2QA'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );  //kick off on dataland

  cluster20 := tools.fun_Groupname('20');
  cluster92 := tools.fun_Groupname('92');
  cluster30 := tools.fun_Groupname('30');
  cluster60 := tools.fun_Groupname('60');

  email                 := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland and pShouldUpdateDOPS);
  UpdateFullKeysDops    := email.BIPV2FullKeys.Roxie    ;
  UpdateWeeklyKeysDops  := email.BIPV2WeeklyKeys.Roxie  ;
  CheckDatalandKeys     := email.BIPV2DatalandKeys.Roxie;
  outputdatalandkeys    := BIPV2_Build.DatalandKeys_Package(pversion,false).outputpackage;
  
  return 
  iff(Tools._Constants.isdataland = false
    ,sequential(
       BIPV2_Build.Promote().Built2QA //this includes everything
      ,UpdateFullKeysDops
      ,UpdateWeeklyKeysDops
      ,iff(pShouldDoOtherClusters = true  ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster20).Built2QA )
      ,iff(pShouldDoOtherClusters = true  ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster92).Built2QA )
      ,iff(pShouldDoOtherClusters = true  ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster30).Built2QA )
      ,iff(pShouldDoOtherClusters = true  ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster60).Built2QA )
      ,if(pShouldDoDataland ,KickPromote2QADataland)
      // ,BIPV2_Build.Build_Space_Usage(pversion,pType := 2)
      ,iff(pShouldDoOtherClusters = true and pPerformCleanup = true ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster20,pDelete := true).Cleanup  ) 
      ,iff(pShouldDoOtherClusters = true and pPerformCleanup = true ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster92,pDelete := true).Cleanup  )
      ,iff(pShouldDoOtherClusters = true and pPerformCleanup = true ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster30,pDelete := true).Cleanup  )
      ,iff(pShouldDoOtherClusters = true and pPerformCleanup = true ,BizLinkFull.Promote(,'bizlinkfull',pCluster := cluster60,pDelete := true).Cleanup  )
      ,iff(pPerformCleanup        = true                            ,BIPV2_Build.Promote(,'^(?!.*?(wkhistory|precision|space|dashboard).*).*$',pDelete := true).Cleanup )
      // ,BIPV2_Build.Build_Space_Usage(pversion,pType := 3)
    )
    ,sequential(
       BIPV2_Build.Promote(pversion,'bizlinkfull|bipv2_seleid_relative|bipv2_best').new2Built  //just in case they weren't added to built
      ,BIPV2_Build.Promote(,'bizlinkfull|bipv2_seleid_relative|bipv2_best').Built2QA
      ,CheckDatalandKeys
      ,outputdatalandkeys
      ,iff(pPerformCleanup = true  ,BIPV2_Build.Promote(,'bizlinkfull|bipv2_seleid_relative|bipv2_best',pDelete := true).Cleanup  )
    )
  );

endmacro;