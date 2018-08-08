import BIPV2, tools,riskwise,wk_ut,BIPV2_Strata;

EXPORT Build_weekly_keys(
   string   pversion    = BIPV2.KeySuffix
  ,boolean  pInBIPBuild = false
  ,boolean  pPromote2QA = true
  ,string   pWuid       = workunit
	,string	  pEmail_List = BIPV2_Build.mod_email.emailList
  ,boolean  pIsDataland = BIPV2_Build._Constants().IsDataland
) :=
module

  export BuildLinkids_dataset           := tools.macf_WriteFile (filenames(pversion).contact_linkids.new      ,BIPV2_Build.key_contact_linkids.dkeybuild    );
  export BuildLinkIds                   := tools.macf_writeindex('BIPV2_Build.key_contact_linkids.key         ,keynames(pversion).contact_linkids.new'      );
  export BuildDirLinkIdsOutsideBIPBuild := tools.macf_writeindex('BIPV2_Build.key_directories_linkids.key     ,keynames(pversion).directories_linkids.new'  );  //uses qa supers
  export BuildDirLinkIdsInsideBIPBuild  := tools.macf_writeindex('BIPV2_Build.key_directories_linkids.kbuilt  ,keynames(pversion).directories_linkids.new'  );  //uses built supers

  export BuildDirLinkIds    := if(pInBIPBuild  ,BuildDirLinkIdsInsideBIPBuild  ,BuildDirLinkIdsOutsideBIPBuild);
  
  shared keyfilt            := '(directories_linkids|contact_linkids)';
  
  shared keyfiltcont        := 'contact_linkids';
  export promote2builtcont  := promote(pversion,keyfiltcont).new2built;

  shared keyfiltdir         := 'directories_linkids';
  export promote2builtdir   := promote(pversion,keyfiltdir).new2built;

  shared regexfilterout := '^(?!.*?(base::paw::|header_wa_w|source_ingest::data|biz_preferred|bizlinkfull|bipv2::internal_linking|persist::bip_contacts|directories_linkids|contact_linkids|hpccinternal|bipv2_ingest).*)'
                          + '.*?(base|keybuild|temp|biz).*$';

  //Get file items for orbit, send email including them to make easier to populate item list in orbit instance
  export SendOrbitItemList  := wk_ut.Strata_Orbit_Item_list(pWuid,'BIPV2','Weekly_Keys'  ,pversion ,pEmailNotifyList := pEmail_List     ,pFileRegex := regexfilterout,pIsTesting := false);
  
  export buildall := 
  sequential(
     BuildLinkids_dataset
    ,BuildLinkIds
    ,promote2builtcont
    ,BuildDirLinkIds // uses contact key
    ,promote2builtdir
    ,if(pIsDataland = false ,SendOrbitItemList                                )
    ,if(pIsDataland = false ,BIPV2_Strata.mac_check_sources         (pversion))
    ,if(pIsDataland = false ,BIPV2_Strata.mac_Compare_BH_To_BIP_Ids (pversion))
    ,if(pPromote2QA = true  ,sequential(Promote(pversion,keyfilt).Built2QA,send_emails(pversion).BIPV2WeeklyKeys.Roxie,Promote(pversion,keyfilt,pdelete := true).cleanup))
  ) : FAILURE(send_emails(pversion).BIPV2WeeklyKeys.buildfailure);

end;