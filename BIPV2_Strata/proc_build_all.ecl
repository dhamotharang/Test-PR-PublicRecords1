import bipv2,bipv2_postprocess,strata,BIPV2_Build,tools,BIPV2_QA_Tool;

EXPORT proc_build_all(

   string                                               pversion
  ,dataset(BIPV2.CommonBase.layout                    ) pBase         = bipv2.CommonBase.DS_CLEAN
	,boolean													                    pOverwrite		= false
	,boolean													                    pIsTesting		= tools._Constants.isdataland
  ,boolean                                              pDoBiz        = false
  ,boolean                                              pDoDemo       = false
	,string 													                    pToday 		    = bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate//in case you want to run as of a date in the past.  default to date of newest data.


) :=
function

  // -- Biz Strata
  ProxidStats	:= BIPv2_PostProcess.segmentation(pBase, 'PROXID').stats;
  SeleidStats	:= BIPv2_PostProcess.segmentation(pBase, 'SELEID').stats;
  OrgidStats	:= BIPv2_PostProcess.segmentation(pBase, 'ORGID' ).stats;
  UltidStats 	:= BIPv2_PostProcess.segmentation(pBase, 'ULTID' ).stats;

  proxidbizstrata := BIPV2_PostProcess.fBusinessesConvert2Strata('PROXID' ,ProxidStats	,pBase);
  seleidbizstrata := BIPV2_PostProcess.fBusinessesConvert2Strata('SELE'   ,SeleidStats	,pBase);
  orgidbizstrata  := BIPV2_PostProcess.fBusinessesConvert2Strata('ORGID'  ,OrgidStats	  ,pBase);
  ultidbizstrata  := BIPV2_PostProcess.fBusinessesConvert2Strata('ULTID'  ,UltidStats 	,pBase);

  biz_stats := 
    dataset( [{ 'Total Records',	count(pBase),count(pBase) }],BIPV2_PostProcess.layouts.layout_Businesses)
    + proxidbizstrata
    + seleidbizstrata
    + orgidbizstrata 
    + ultidbizstrata 
    ;

	modProxV1 					:= BIPv2_PostProcess.segmentation(pBase ,'PROXID' ,pToday);
  modSeleV1 					:= BIPv2_PostProcess.segmentation(pBase ,'SELEID' ,pToday);
	modorgV1 					  := BIPv2_PostProcess.segmentation(pBase ,'ORGID'  ,pToday);		
	modultV1  			    := BIPv2_PostProcess.segmentation(pBase ,'ULTID'  ,pToday);

  // -- Demographics Strata
  ProxFieldstats  := fieldstats_prox  (pversion,pBase,modProxV1.result);
  SeleFieldstats  := fieldstats_sele  (pversion,pBase,modSeleV1.result);
  orgsFieldtats   := fieldstats_org   (pversion,pBase,modorgV1 .result);
  ultFieldstats   := fieldstats_ult   (pversion,pBase,modultV1 .result);
  
  ProxidDemoStats	:= BIPV2_PostProcess.fDemographicsConvert2Strata('PROXID' ,ProxFieldstats.active_fieldStats,ProxFieldstats.inactive_fieldStats,pBase );
  SeleidDemoStats	:= BIPV2_PostProcess.fDemographicsConvert2Strata('SELE'   ,SeleFieldstats.active_fieldStats,SeleFieldstats.inactive_fieldStats,pBase );
  OrgidDemoStats	:= BIPV2_PostProcess.fDemographicsConvert2Strata('ORGID'  ,orgsFieldtats .active_fieldStats,orgsFieldtats .inactive_fieldStats,pBase );
  UltidDemoStats 	:= BIPV2_PostProcess.fDemographicsConvert2Strata('ULTID'  ,ultFieldstats .active_fieldStats,ultFieldstats .inactive_fieldStats,pBase );
  
  Demo_stats := 
      ProxidDemoStats
    + SeleidDemoStats
    + OrgidDemoStats	
    + UltidDemoStats 
    ;  

  // -- Wrap up and Send to Strata
	BuildBizStrat 	:= Strata.macf_CreateXMLStats(biz_stats		,'BIPV2','Data'	,pversion	,BIPV2_Build.mod_email.emailList	,'stats' ,'USBusiness'	  ,pIsTesting,pOverwrite);
	BuildDemoStrata	:= Strata.macf_CreateXMLStats(Demo_stats	,'BIPV2','Data'	,pversion	,BIPV2_Build.mod_email.emailList	,'stats' ,'Demographics'  ,pIsTesting,pOverwrite);
  
  semail := bipv2_build.Send_Emails(pversion,pBuildName := 'BIPV2 Strata Stats').BIPV2FullKeys;

  returnresult :=  parallel(
     if(pDoBiz  = true  ,BuildBizStrat    )
    ,if(pDoDemo = true  ,BuildDemoStrata  )
    ,BIPV2_Strata.mac_Vanity_Lexid_VS_BIP_ID(pversion)
    ,BIPV2_Strata.mac_Single_Multi_Sourced_IDS(pversion)
    ,BIPV2_Strata.mac_Unique_Ids(pversion)
    ,BIPV2_QA_Tool.proc_PostProcess_Stats(pversion)
    ,semail.BuildSuccess
  ) : failure(semail.BuildFailure)
  ;

  return returnresult;
  
end;