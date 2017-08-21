IMPORT tools, versioncontrol,bair,STD;

EXPORT Files(STRING pVersion = '', boolean pUseProd = false) := MODULE

  export inputEventMos_CSV 						:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateEVENT_MO_CSV , layouts.SprayedEventMos_CSV, _Constants.event_linkflags);
	export inputEventPersons_CSV 				:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateEVENT_PERSONS_CSV , layouts.SprayedEventPersons_CSV, _Constants.event_linkflags);
	export inputEventVehicles_CSV 			:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateEVENT_VEHICLES_CSV , layouts.SprayedEventVehicles_CSV, _Constants.event_linkflags);;
	export inputCFS_CSV 								:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateCFS_CSV , layouts.SprayedCFS_CSV, _Constants.cfs_linkflags);
	export inputCFSOfficers_CSV					:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateCFSOFFICERS_CSV , layouts.SprayedCFSOfficers_CSV, _Constants.cfsOfficers_linkflags);
	export inputCrash_CSV 							:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateCrash_CSV , layouts.SprayedCrash_CSV, _Constants.crash_linkflags ); 
	export inputCrashPersons_CSV				:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateCrash_Persons_CSV , layouts.SprayedCrashPersons_CSV, _Constants.crash_linkflags); 				
	export inputCrashVehicle_CSV				:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateCrash_Vehicles_CSV , layouts.SprayedCrashVehicles_CSV, _Constants.crash_linkflags); 
	export inputOffender_CSV						:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateOffender_CSV , layouts.SprayedOffenders_CSV, _Constants.offender_linkflags); 
	export inputOffenderClass_CSV				:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateClassification_CSV , layouts.SprayedClassification_CSV, _Constants.offender_linkflags); 
	export inputOffenderPicture_CSV			:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplatePictures_CSV , layouts.SprayedPictures_CSV, _Constants.offender_linkflags); 
	export inputLPR_CSV									:= Build_Base.MAC_Dedup_Input(Filenames().lInputTemplateLPR_CSV , layouts.SprayedLPR_CSV, _Constants.lpr_linkflags); 

	export manifest := sort(dataset(Filenames(pVersion).manifest, layouts.manifest, thor, opt),field1);
	
	export bair_sentinel_flag := 'thor_data400::out::bair_sentinel_flag';
	
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseDeletes, bair.layouts.Agency_Deletes	, BaseDeletes);		
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseEventDeletes, bair.layouts.Agency_Deletes	, BaseEventDeletes);					
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCFSDeletes, bair.layouts.Agency_Deletes	, BaseCFSDeletes);					
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCrashDeletes, bair.layouts.Agency_Deletes	, BaseCrashDeletes);					
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseOffendersDeletes, bair.layouts.Agency_Deletes	, BaseOffendersDeletes);					

	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseStatsReport, Bair.raidsReport_Layout.raidsReportRec, BaseStatsReport);
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseEventStatsReport,	Bair.raidsReport_Layout.raidsReportRec, BaseEventStatsReport);
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCFSStatsReport, Bair.raidsReport_Layout.raidsReportRec, BaseCFSStatsReport);					
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCrashStatsReport,	Bair.raidsReport_Layout.raidsReportRec, BaseCrashStatsReport);					
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseOffendersStatsReport,	Bair.raidsReport_Layout.raidsReportRec, BaseOffendersStatsReport);					

	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseLNAddressCache, layouts.address_cache, baseLNAddressCache);
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseEventLNAddressCache, layouts.address_cache, baseEventLNAddressCache); 											
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCFSLNAddressCache, layouts.address_cache, baseCFSLNAddressCache); 											
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCrashLNAddressCache, layouts.address_cache, baseCrashLNAddressCache); 											
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseOffendersLNAddressCache, layouts.address_cache, baseOffendersLNAddressCache); 											
	
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseGeocodingLog, layouts.geocoding_log, baseGeocodingLog);
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseEventGeocodingLog, layouts.geocoding_log, baseEventGeocodingLog); 											
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCFSGeocodingLog, layouts.geocoding_log, baseCFSGeocodingLog); 											
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseCrashGeocodingLog, layouts.geocoding_log, baseCrashGeocodingLog); 											
	versioncontrol.macBuildFileVersions(Filenames(pVersion).baseOffendersGeocodingLog, layouts.geocoding_log, baseOffendersGeocodingLog);											

	
					
END;

