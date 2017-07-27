import BIPV2, tools,riskwise,wk_ut,BIPV2_Strata;

EXPORT Build_weekly_keys(
   string   pversion    = BIPV2.KeySuffix
  ,boolean  pInBIPBuild = false
  ,boolean  pPromote2QA = true
) :=
module

  export BuildLinkIds                   := tools.macf_writeindex('BIPV2_Build.key_contact_linkids.key         ,keynames(pversion).contact_linkids.new'      );
  export BuildDirLinkIdsOutsideBIPBuild := tools.macf_writeindex('BIPV2_Build.key_directories_linkids.key     ,keynames(pversion).directories_linkids.new'  );  //uses qa supers
  export BuildDirLinkIdsInsideBIPBuild  := tools.macf_writeindex('BIPV2_Build.key_directories_linkids.kbuilt  ,keynames(pversion).directories_linkids.new'  );  //uses built supers

  export BuildDirLinkIds := if(pInBIPBuild  ,BuildDirLinkIdsInsideBIPBuild  ,BuildDirLinkIdsOutsideBIPBuild);
  
  shared keyfilt        := 'directories_linkids|contact_linkids';
  export promote2built  := promote(pversion,keyfilt).new2built;

  //Get file items for orbit, send email including them to make easier to populate item list in orbit instance
  fileitems         := wk_ut.get_StringFilesRead(workunit,'base|keybuild|temp|biz');  
  SendOrbitItemList := BIPV2_Build.Send_Emails(pversion,pBuildName := 'BIPV2 Weekly Keys Orbit Item List',pBuildMessage := fileitems).BIPV2WeeklyKeys.BuildNote;
  
  export buildall := 
  sequential(
     BuildLinkIds
    ,promote2built
    ,BuildDirLinkIds // uses contact key
    ,promote2built
    ,SendOrbitItemList
    ,BIPV2_Strata.mac_check_sources(pversion)
    ,BIPV2_Strata.mac_Compare_BH_To_BIP_Ids(pversion)
    ,if(pPromote2QA = true  ,sequential(Promote(pversion,keyfilt).Built2QA,send_emails(pversion).BIPV2WeeklyKeys.Roxie,Promote(pversion,keyfilt,pdelete := true).cleanup))
  ) : FAILURE(send_emails(pversion).BIPV2WeeklyKeys.buildfailure);

end;