import VersionControl,strata;

export proc_build_strata(

	 string																			pversion
	,boolean																		pOverwrite						= false
	,boolean																		pUseOtherEnvironment	= false
	,boolean																		pShouldSendToStrata		= true
	,dataset(Layout_Business_Header_Base			)	pInput								= Files(,pUseOtherEnvironment).Base.Business_Headers.built
	,dataset(Layout_Business_Contact_Full_new	)	pCont									= Files(,pUseOtherEnvironment).Base.Business_Contacts.built
	,dataset(Layout_Business_Relative					)	pRel									= Files(,pUseOtherEnvironment).base.business_relatives.built
	,dataset(Layout_BH_Best										)	pBest									= Files(,pUseOtherEnvironment).base.Business_Header_Best.built
	,dataset(Layout_BH_Super_Group						)	pGroup								= Files(,pUseOtherEnvironment).base.Super_Group.built
	,dataset(Layout_BDL2											)	pBDL2									= Files(,pUseOtherEnvironment).base.BDL2.built									

) :=
module

	shared mstat := Strata_Population_Stats(pUseOtherEnvironment,pInput,pCont,pRel,pBest,pGroup,pBDL2);

	//bc
	strata.createXMLStats(mstat.dContNoGrouping				,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildContNoGrouping_Strata					,'No Grouping'	,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dContSource						,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildContSource_Strata							,'Source'				,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dContState						,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildContState_Strata							,'State'				,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dContRectype					,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildContRectype_Strata						,'Record_Type'	,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dContfrom_hdr					,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildContfrom_hdr_Strata						,'from_hdr'			,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dUniqueContNoGrouping	,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildUniqueContNoGrouping_Strata		,'No Grouping'	,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dUniqueContSource			,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildUniqueContSource_Strata				,'Source'				,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dUniqueContState			,'BusinessContacts'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildUniqueContState_Strata				,'State'				,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBaseNoGrouping				,'BusinessHeaders'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildBaseNoGrouping_Strata					,'No Grouping'	,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBaseSource						,'BusinessHeaders'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildBaseSource_Strata							,'Source'				,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBaseState						,'BusinessHeaders'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildBaseState_Strata							,'State'				,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dUniqueBaseNoGrouping	,'BusinessHeaders'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildUniqueBaseNoGrouping_Strata		,'No Grouping'	,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dUniqueBaseSource			,'BusinessHeaders'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildUniqueBaseSource_Strata				,'Source'				,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dUniqueBaseState			,'BusinessHeaders'		,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildUniqueBaseState_Strata				,'State'				,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBestNoGrouping				,'BusinessBest'				,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuilddBestNoGrouping_Strata				,'No Grouping'	,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBestState						,'BusinessBest'				,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuilddBestState_Strata							,'State'				,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBestUniquesNoGrouping,'BusinessBest'				,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuilddBestUniquesNoGrouping_Strata	,'No Grouping'	,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBestUniquesState			,'BusinessBest'				,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuilddBestUniquesState_Strata			,'State'				,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dGroups								,'BusinessSuperGroup'	,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildGroups_Strata									,'No Grouping'	,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dGroupUniques					,'BusinessSuperGroup'	,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildGroupUniques_Strata						,'No Grouping'	,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBDL2									,'BusinessBDL2'				,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildBDL2_Strata										,'No Grouping'	,'Population'	,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dBDL2Uniques					,'BusinessBDL2'				,'Base'	,pversion	,email_notificaton_lists.buildsuccess	,BuildBDL2Uniques_Strata						,'No Grouping'	,'Uniques'		,true,pShouldSendToStrata);
	strata.createXMLStats(mstat.dRel									,'BusinessRelativesV2','data'	,pversion	,email_notificaton_lists.buildsuccess	,BuildRel_Strata										,'View'					,'Population'	,true,pShouldSendToStrata);

	export BuildContNoGrouping_Strata_withcheck					:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'No Grouping'	,'Population'	) or pOverwrite	,BuildContNoGrouping_Strata					);
	export BuildContSource_Strata_withcheck							:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'Source'				,'Population'	) or pOverwrite	,BuildContSource_Strata							);
	export BuildContState_Strata_withcheck							:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'State'				,'Population'	) or pOverwrite	,BuildContState_Strata							);
	export BuildContRectype_Strata_withcheck						:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'Record_Type'	,'Population'	) or pOverwrite	,BuildContRectype_Strata						);
	export BuildContfrom_hdr_Strata_withcheck						:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'from_hdr'			,'Population'	) or pOverwrite	,BuildContfrom_hdr_Strata						);
	export BuildUniqueContNoGrouping_Strata_withcheck		:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'No Grouping'	,'Uniques'		) or pOverwrite	,BuildUniqueContNoGrouping_Strata		);
	export BuildUniqueContSource_Strata_withcheck				:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'Source'				,'Uniques'		) or pOverwrite	,BuildUniqueContSource_Strata				);
	export BuildUniqueContState_Strata_withcheck				:= if(not VersionControl.fHasStrataBeenRun('BusinessContacts'			,'Base'	,pversion	,'State'				,'Uniques'		) or pOverwrite	,BuildUniqueContState_Strata				);
	export BuildBaseNoGrouping_Strata_withcheck					:= if(not VersionControl.fHasStrataBeenRun('BusinessHeaders'			,'Base'	,pversion	,'No Grouping'	,'Population'	) or pOverwrite	,BuildBaseNoGrouping_Strata					);
	export BuildBaseSource_Strata_withcheck							:= if(not VersionControl.fHasStrataBeenRun('BusinessHeaders'			,'Base'	,pversion	,'Source'				,'Population'	) or pOverwrite	,BuildBaseSource_Strata							);
	export BuildBaseState_Strata_withcheck							:= if(not VersionControl.fHasStrataBeenRun('BusinessHeaders'			,'Base'	,pversion	,'State'				,'Population'	) or pOverwrite	,BuildBaseState_Strata							);
	export BuildUniqueBaseNoGrouping_Strata_withcheck		:= if(not VersionControl.fHasStrataBeenRun('BusinessHeaders'			,'Base'	,pversion	,'No Grouping'	,'Uniques'		) or pOverwrite	,BuildUniqueBaseNoGrouping_Strata		);
	export BuildUniqueBaseSource_Strata_withcheck				:= if(not VersionControl.fHasStrataBeenRun('BusinessHeaders'			,'Base'	,pversion	,'Source'				,'Uniques'		) or pOverwrite	,BuildUniqueBaseSource_Strata				);
	export BuildUniqueBaseState_Strata_withcheck				:= if(not VersionControl.fHasStrataBeenRun('BusinessHeaders'			,'Base'	,pversion	,'State'				,'Uniques'		) or pOverwrite	,BuildUniqueBaseState_Strata				);
	export BuilddBestNoGrouping_Strata_withcheck				:= if(not VersionControl.fHasStrataBeenRun('BusinessBest'					,'Base'	,pversion	,'No Grouping'	,'Population'	) or pOverwrite	,BuilddBestNoGrouping_Strata				);
	export BuilddBestState_Strata_withcheck							:= if(not VersionControl.fHasStrataBeenRun('BusinessBest'					,'Base'	,pversion	,'State'				,'Population'	) or pOverwrite	,BuilddBestState_Strata							);
	export BuilddBestUniquesNoGrouping_Strata_withcheck	:= if(not VersionControl.fHasStrataBeenRun('BusinessBest'					,'Base'	,pversion	,'No Grouping'	,'Uniques'		) or pOverwrite	,BuilddBestUniquesNoGrouping_Strata	);
	export BuilddBestUniquesState_Strata_withcheck			:= if(not VersionControl.fHasStrataBeenRun('BusinessBest'					,'Base'	,pversion	,'State'				,'Uniques'		) or pOverwrite	,BuilddBestUniquesState_Strata			);
	export BuildGroups_Strata_withcheck									:= if(not VersionControl.fHasStrataBeenRun('BusinessSuperGroup'		,'Base'	,pversion	,'No Grouping'	,'Population'	) or pOverwrite	,BuildGroups_Strata									);
	export BuildGroupUniques_Strata_withcheck						:= if(not VersionControl.fHasStrataBeenRun('BusinessSuperGroup'		,'Base'	,pversion	,'No Grouping'	,'Uniques'		) or pOverwrite	,BuildGroupUniques_Strata						);
	export BuildBDL2_Strata_withcheck										:= if(not VersionControl.fHasStrataBeenRun('BusinessBDL2'					,'Base'	,pversion	,'No Grouping'	,'Population'	) or pOverwrite	,BuildBDL2_Strata										);
	export BuildBDL2Uniques_Strata_withcheck						:= if(not VersionControl.fHasStrataBeenRun('BusinessBDL2'					,'Base'	,pversion	,'No Grouping'	,'Uniques'		) or pOverwrite	,BuildBDL2Uniques_Strata						);
	export BuildRel_Strata_withcheck										:= if(not VersionControl.fHasStrataBeenRun('BusinessRelativesV2'	,'data'	,pversion	,'view'					,'Population'	) or pOverwrite	,BuildRel_Strata										);
   
	export biz_contacts := parallel(
		 BuildContNoGrouping_Strata_withcheck			
	  ,BuildContSource_Strata_withcheck					
	  ,BuildContState_Strata_withcheck						
	  ,BuildContRectype_Strata_withcheck					
	  ,BuildContfrom_hdr_Strata_withcheck				
	  ,BuildUniqueContNoGrouping_Strata_withcheck
	  ,BuildUniqueContSource_Strata_withcheck		
		,BuildUniqueContState_Strata_withcheck			
	);

	export biz_header := parallel(
		 BuildBaseNoGrouping_Strata_withcheck			
    ,BuildBaseSource_Strata_withcheck					
    ,BuildBaseState_Strata_withcheck						
    ,BuildUniqueBaseNoGrouping_Strata_withcheck
    ,BuildUniqueBaseSource_Strata_withcheck		
    ,BuildUniqueBaseState_Strata_withcheck			
	);

	export biz_best := parallel(
		 BuilddBestNoGrouping_Strata_withcheck				
    ,BuilddBestState_Strata_withcheck						
    ,BuilddBestUniquesNoGrouping_Strata_withcheck
    ,BuilddBestUniquesState_Strata_withcheck			
	);

	export biz_group := parallel(
		 BuildGroups_Strata_withcheck			
    ,BuildGroupUniques_Strata_withcheck
	);

	export biz_bdl := parallel(
		 BuildBDL2_Strata_withcheck				
    ,BuildBDL2Uniques_Strata_withcheck	
	);

	export biz_rel := parallel(
		 BuildRel_Strata_withcheck				
	);

	full_build := 
	sequential(
		 biz_contacts
		,biz_header
		,biz_best
		,biz_group
		,biz_bdl
		,biz_rel
	);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Business_Header.proc_build_strata attribute')
	);
		
end;