/* BH-579 QA monitoring tool - Postlink and Entity stats 

entity stats:

  singletons by source: BIPV2_Strata.mac_Single_Multi_Sourced_IDS
  total ids by source : BIPV2_Strata.mac_Single_Multi_Sourced_IDS
  new ids by source   : clusters that contain source and did not exist in father file
  matches by source   : new records with did < rid, or existing records that have new did < father did

ID 	    Src Description 	Stat 	                  Stat Value 
Proxid	ADLEQ 	          New ID's by source 	    0
Proxid	ADLEQ 	          Matches by Source 	    0
Proxid	ADLEQ 	          Singletons by Source 	  0
Proxid	ADLEQ 	          Total ID's by source	  0

*/
import ut,bipv2,wk_ut,BIPV2_Findlinks,BIPV2_Postprocess,std;

EXPORT proc_PostProcess_Stats(

   pversion        = 'bipv2.KeySuffix'
  ,pBase           = 'bipv2.CommonBase.DS_Built'
  ,pFather         = 'bipv2.CommonBase.DS_Base'
  ,pPowidWuid      = '\'\''  
  ,pHrchyWuid      = '\'\''
  ,pSegStatsWuid   = '\'\''
	,pIsTesting	     = 'tools._Constants.isdataland'

   // string                           pversion        = bipv2.KeySuffix
  // ,dataset(bipv2.CommonBase.layout) pBase           = bipv2.CommonBase.DS_Built
  // ,dataset(bipv2.CommonBase.layout) pFather         = bipv2.CommonBase.DS_Base
	// ,boolean                          pOverwrite	    = false
	// ,boolean                          pIsTesting	    = tools._Constants.isdataland
  // ,string                           pPowidWuid      = trim(sort(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid,'completed')(job = 'BIPV2_POWID '                          + pversion + ' PostProcess' ),-wuid)[1].wuid)
  // ,string                           pHrchyWuid      = trim(sort(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid,'completed')(job = 'BIPV2_Build.build_hrchy  '             + pversion                  ),-wuid)[1].wuid)
  // ,string                           pSegStatsWuid   = trim(sort(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid,'completed')(job = 'BIPV2_PostProcess.proc_segmentation '  + pversion                  ),-wuid)[1].wuid)

) :=
functionmacro

  import ut,bipv2,wk_ut,BIPV2_Findlinks,BIPV2_Postprocess,std,Workman;

  currentdate  := (STRING8)Std.Date.Today();         
  highwuid1    := 'W' + currentdate + '-999999';

  PowidWuid_prep      := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_POWID '                          + pversion + ' PostProcess' )),-wuid)[1].wuid);
  HrchyWuid_prep      := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_Build.build_hrchy  '             + pversion                  )),-wuid)[1].wuid);
  SegStatsWuid_prep   := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_PostProcess.proc_segmentation '  + pversion                  )),-wuid)[1].wuid);

  PowidWuid     := if(trim(pPowidWuid   )  != '' ,pPowidWuid    ,PowidWuid_prep   );
  HrchyWuid     := if(trim(pHrchyWuid   )  != '' ,pHrchyWuid    ,HrchyWuid_prep   );
  SegStatsWuid  := if(trim(pSegStatsWuid)  != '' ,pSegStatsWuid ,SegStatsWuid_prep);

  proxid_entity_stats         := BIPV2_QA_Tool.mac_entity_stats(pversion,pBase,pFather,proxid,pIsTesting);
  seleid_entity_stats         := BIPV2_QA_Tool.mac_entity_stats(pversion,pBase,pFather,seleid,pIsTesting);

  layout_persistence_stats    :=  {string40 cluster_type  ,string60 stat_desc ,unsigned6 stat_value:=0};
  
  ds_seleid_persistence_stats := Workman.get_DS_Result(PowidWuid ,'Result 6'  ,layout_persistence_stats); // 'W20181111-151136' BIPV2_POWID._proc_powid(,'2','20181101').updateSuperfiles(,BIPV2_Files . files_powid_down . DS_BASE) 
  ds_proxid_persistence_stats := Workman.get_DS_Result(HrchyWuid ,'Result 10' ,layout_persistence_stats); // 'W20181109-065601' BIPV2_Build.build_hrchy('20181101' ,,,,,false,,false  ).runIter;

  proxid_postlink_stats       := BIPV2_QA_Tool.mac_PostLink_Stats(ds_proxid_persistence_stats ,proxid ,pversion ,pBase  ,SegStatsWuid,pIsTesting); // 'W20181112-192118-2' BIPV2_PostProcess.proc_segmentation('20181101',pPopulateStatus := false).run;
  seleid_postlink_stats       := BIPV2_QA_Tool.mac_PostLink_Stats(ds_seleid_persistence_stats ,seleid ,pversion ,pBase  ,SegStatsWuid,pIsTesting); // 'W20181112-192118-2' BIPV2_PostProcess.proc_segmentation('20181101',pPopulateStatus := false).run;

  return sequential(
    output(PowidWuid     ,named('PowidWuid'   ))
   ,output(HrchyWuid     ,named('HrchyWuid'   ))
   ,output(SegStatsWuid  ,named('SegStatsWuid'))
   ,parallel(
   #IF(pIsTesting = false)
      proxid_entity_stats
     ,seleid_entity_stats
     ,proxid_postlink_stats
     ,seleid_postlink_stats
   #ELSE
      output(proxid_entity_stats    ,named('proxid_entity_stats'  ),all)
     ,output(seleid_entity_stats    ,named('seleid_entity_stats'  ),all)
     ,output(proxid_postlink_stats  ,named('proxid_postlink_stats'),all)
     ,output(seleid_postlink_stats  ,named('seleid_postlink_stats'),all)
   #END
  ));
  
endmacro;