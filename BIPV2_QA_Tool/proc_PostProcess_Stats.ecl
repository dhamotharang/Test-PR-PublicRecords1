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
  ,pEmpidWuid      = '\'\''  
	,pIsTesting	     = 'tools._Constants.isdataland'  // if true, just output the stats to the workunit, do not write to files or add to superfiles.  if false, do normal writes to files and superfiles.
	,pDoProxid	     = 'true'  
	,pDoSeleid	     = 'true'  
	,pDoPowid	       = 'true'  
	,pDoEmpid 	     = 'true'  

) :=
functionmacro

  import ut,bipv2,wk_ut,BIPV2_Findlinks,BIPV2_Postprocess,std,Workman,BIPV2_QA_Tool;

  currentdate  := (STRING8)Std.Date.Today();         
  highwuid1    := 'W' + currentdate + '-999999';

  PowidWuid_prep      := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_POWID '                          + pversion + ' PostProcess' )),-wuid)[1].wuid);
  HrchyWuid_prep      := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_Build.build_hrchy  '             + pversion                  )),-wuid)[1].wuid);
  SegStatsWuid_prep   := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_PostProcess.proc_segmentation '  + pversion                  )),-wuid)[1].wuid);
  EmpidWuid_prep      := trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid1,'completed')(job = 'BIPV2_EmpID '                          + pversion + ' PostProcess' )),-wuid)[1].wuid);

  PowidWuid     := if(trim(pPowidWuid   )  != '' ,pPowidWuid    ,PowidWuid_prep   );
  HrchyWuid     := if(trim(pHrchyWuid   )  != '' ,pHrchyWuid    ,HrchyWuid_prep   );
  SegStatsWuid  := if(trim(pSegStatsWuid)  != '' ,pSegStatsWuid ,SegStatsWuid_prep);
  EmpidWuid     := if(trim(pEmpidWuid   )  != '' ,pEmpidWuid    ,EmpidWuid_prep   );

  proxid_entity_stats         := BIPV2_QA_Tool.mac_entity_stats(pversion,pBase,pFather,proxid,pIsTesting);
  seleid_entity_stats         := BIPV2_QA_Tool.mac_entity_stats(pversion,pBase,pFather,seleid,pIsTesting);
  powid_entity_stats          := BIPV2_QA_Tool.mac_entity_stats(pversion,pBase,pFather,powid ,pIsTesting);
  empid_entity_stats          := BIPV2_QA_Tool.mac_entity_stats(pversion,pBase,pFather,empid ,pIsTesting);

  layout_persistence_stats    :=  {string40 cluster_type  ,string60 stat_desc ,unsigned6 stat_value:=0};
  
  ds_seleid_persistence_stats := Workman.get_DS_Result(PowidWuid ,'Result 6'  ,layout_persistence_stats); // 'W20181111-151136' BIPV2_POWID._proc_powid(,'2','20181101').updateSuperfiles(,BIPV2_Files . files_powid_down . DS_BASE) 
  ds_proxid_persistence_stats := Workman.get_DS_Result(HrchyWuid ,'Result 10' ,layout_persistence_stats); // 'W20181109-065601' BIPV2_Build.build_hrchy('20181101' ,,,,,false,,false  ).runIter;
  ds_powid_persistence_stats  := Workman.get_DS_Result(PowidWuid ,'Result 3'  ,layout_persistence_stats); // 'W20181111-151136' BIPV2_POWID._proc_powid(,'2','20181101').updateSuperfiles(,BIPV2_Files . files_powid_down . DS_BASE) 
  ds_empid_persistence_stats  := Workman.get_DS_Result(EmpidWuid ,'Result 3'  ,layout_persistence_stats); // 'W20181111-151136' BIPV2_POWID._proc_powid(,'2','20181101').updateSuperfiles(,BIPV2_Files . files_powid_down . DS_BASE) 

  proxid_postlink_stats       := BIPV2_QA_Tool.mac_PostLink_Stats(ds_proxid_persistence_stats ,proxid ,pversion ,pBase  ,SegStatsWuid,pIsTesting); // 'W20181112-192118-2' BIPV2_PostProcess.proc_segmentation('20181101',pPopulateStatus := false).run;
  seleid_postlink_stats       := BIPV2_QA_Tool.mac_PostLink_Stats(ds_seleid_persistence_stats ,seleid ,pversion ,pBase  ,SegStatsWuid,pIsTesting); // 'W20181112-192118-2' BIPV2_PostProcess.proc_segmentation('20181101',pPopulateStatus := false).run;
  powid_postlink_stats        := BIPV2_QA_Tool.mac_PostLink_Stats(ds_powid_persistence_stats  ,powid  ,pversion ,pBase  ,SegStatsWuid,pIsTesting); // 'W20181112-192118-2' BIPV2_PostProcess.proc_segmentation('20181101',pPopulateStatus := false).run;
  empid_postlink_stats        := BIPV2_QA_Tool.mac_PostLink_Stats(ds_empid_persistence_stats  ,empid  ,pversion ,pBase  ,SegStatsWuid,pIsTesting); // 'W20181112-192118-2' BIPV2_PostProcess.proc_segmentation('20181101',pPopulateStatus := false).run;

	// ds_powid_persistence_stats  :=  BIPV2_Strata.PersistenceStats(ds_powid_down ,the_father ,rcid,seleid) : independent;   

  // import BIPV2_QA_Tool;
	// ds_empid_persistence_stats   :=  BIPV2_Strata.PersistenceStats(pBase      ,pFather ,rcid,empid ) : independent;

	empid_persistence_record_stats     := BIPV2_QA_Tool.mac_persistence_records_stats(ds_empid_persistence_stats ,'empid' ,pversion,not pIsTesting);
  empid_persistence_cluster_stats    := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_empid_persistence_stats ,'empid' ,pversion,not pIsTesting);

  return sequential(
    output(PowidWuid     ,named('PowidWuid'   ))
   ,output(HrchyWuid     ,named('HrchyWuid'   ))
   ,output(SegStatsWuid  ,named('SegStatsWuid'))
   ,output(EmpidWuid     ,named('EmpidWuid'   ))
   ,parallel(
      output(pversion ,named('pversion'))
   #IF(pIsTesting = false)
     #IF(pDoProxid = true) ,proxid_entity_stats              #END
     #IF(pDoSeleid = true) ,seleid_entity_stats              #END
     #IF(pDoPowid  = true) ,powid_entity_stats               #END
     #IF(pDoEmpid  = true) ,empid_entity_stats               #END
     #IF(pDoProxid = true) ,proxid_postlink_stats            #END
     #IF(pDoSeleid = true) ,seleid_postlink_stats            #END
     #IF(pDoPowid  = true) ,powid_postlink_stats             #END
     #IF(pDoEmpid  = true) ,empid_postlink_stats             #END
     // #IF(pDoEmpid  = true) ,empid_persistence_record_stats   #END //DONE IN EMPID POSTPROCESS
     // #IF(pDoEmpid  = true) ,empid_persistence_cluster_stats  #END //DONE IN EMPID POSTPROCESS
   #ELSE
     #IF(pDoProxid = true) ,output(proxid_entity_stats               ,named('proxid_entity_stats'            ),all)   #END
     #IF(pDoSeleid = true) ,output(seleid_entity_stats               ,named('seleid_entity_stats'            ),all)   #END
     #IF(pDoPowid  = true) ,output(powid_entity_stats                ,named('powid_entity_stats'             ),all)   #END
     #IF(pDoEmpid  = true) ,output(empid_entity_stats                ,named('empid_entity_stats'             ),all)   #END
                      
     #IF(pDoProxid = true) ,output(proxid_postlink_stats             ,named('proxid_postlink_stats'          ),all)   #END
     #IF(pDoSeleid = true) ,output(seleid_postlink_stats             ,named('seleid_postlink_stats'          ),all)   #END
     #IF(pDoPowid  = true) ,output(powid_postlink_stats              ,named('powid_postlink_stats'           ),all)   #END
     #IF(pDoEmpid  = true) ,output(empid_postlink_stats              ,named('empid_postlink_stats'           ),all)   #END
     // #IF(pDoEmpid  = true) ,output(empid_persistence_record_stats    ,named('empid_persistence_record_stats' ),all)   #END //DONE IN EMPID POSTPROCESS
     // #IF(pDoEmpid  = true) ,output(empid_persistence_cluster_stats   ,named('empid_persistence_cluster_stats'),all)   #END //DONE IN EMPID POSTPROCESS
   #END
  ));
  
endmacro;