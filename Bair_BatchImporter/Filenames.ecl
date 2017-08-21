import versioncontrol,tools;

export Filenames(string pVersion = '', boolean pUseProd = false) := module
	export lInputTemplateManifest 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::manifest_csv' ;
	export lInputHistTemplateManifest						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::manifest_csv::history' ;
 	export lInputTemplateEVENT_MO_CSV 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_mo_csv' ;
	export lInputHistTemplateEVENT_MO_CSV				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_mo_csv::history' ;
 	export lInputTemplateEVENT_PERSONS_CSV 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_persons_csv' ;
	export lInputHistTemplateEVENT_PERSONS_CSV	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_persons_csv::history' ;
 	export lInputTemplateEVENT_VEHICLES_CSV 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_vehicle_csv' ;
	export lInputHistTemplateEVENT_VEHICLES_CSV	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_vehicle_csv::history' ;
	export lInputTemplateCFS_CSV								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_csv' ;	
	export lInputHistTemplateCFS_CSV						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_csv::history' ;	
	export lInputTemplateCFSOFFICERS_CSV				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_officers_csv' ;	
	export lInputHistTemplateCFSOFFICERS_CSV		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_officers_csv::history' ;	
 	export lInputTemplateCRASH_CSV 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_csv';
	export lInputHistTemplateCRASH_CSV					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_csv::history' ;
 	export lInputTemplateCRASH_PERSONS_CSV 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_person_csv';
	export lInputHistTemplateCRASH_PERSONS_CSV 	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_person_csv::history' ;
 	export lInputTemplateCRASH_VEHICLES_CSV 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_vehicle_csv';
	export lInputHistTemplateCRASH_VEHICLES_CSV := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_vehicle_csv::history' ;
 	export lInputTemplateOffender_CSV 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_csv' ;
	export lInputHistTemplateOffender_CSV 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_csv::history' ;
 	export lInputTemplateClassification_CSV 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_classification_csv' ;
	export lInputHistTemplateClassification_CSV := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_classification_csv::history' ;
 	export lInputTemplatePictures_CSV 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_picture_csv' ;
	export lInputHistTemplatePictures_CSV 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_picture_csv::history' ;
	export lInputTemplateLPR_CSV								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::lpr_csv' ;
	export lInputHistTemplateLPR_CSV						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::lpr_csv::history' ;

	export lBaseTemplateEventMO					:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::mo::@version@';
	export baseEventMO  								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventMO,pVersion);

	export lBaseTemplateEventMOUDF			:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::mo_udf::@version@';
	export baseEventMOUDF  							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventMOUDF,pVersion);

	export lBaseTemplateEventPersons		:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::persons::@version@';
	export baseEventPersons							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventPersons,pVersion);

	export lBaseTemplateEventPersonsUDF	:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::persons_udf::@version@';
	export baseEventPersonsUDF					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventPersonsUDF,pVersion);

	export lBaseTemplateEventVehicles 	:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::vehicles::@version@';
	export baseEventVehicles						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventVehicles,pVersion);
	
	export lBaseTemplateCFS 						:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::dbo::cfs_2::@version@';
	export baseCFS											:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFS,pVersion);
	
	export lBaseTemplateCFSOfficers 		:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::dbo::cfs_officers_2::@version@';
	export baseCFSOfficers							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFSOfficers,pVersion);

	export lBaseTemplateCrash 					:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::dbo::crash::@version@';
	export baseCrash										:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrash,pVersion);
	
	export lBaseTemplateCrashPersons		:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::dbo::person::@version@';
	export baseCrashPersons							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashPersons,pVersion);

	export lBaseTemplateCrashVehicles		:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::dbo::vehicle::@version@';
	export baseCrashVehicles						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashVehicles,pVersion);

	export lBaseTemplateOffenders				:= 	_Dataset().thor_cluster_files + 'in::prepped::offenders::dbo::offender::@version@';
	export baseOffenders								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffenders,pVersion);

	export lBaseTemplateOffendersClassification	:= 	_Dataset().thor_cluster_files + 'in::prepped::offenders::dbo::offender_classification::@version@';
	export baseOffendersClassification					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersClassification,pVersion);	
	
	export lBaseTemplateOffendersPicture				:= 	_Dataset().thor_cluster_files + 'in::prepped::offenders::dbo::offender_picture::@version@';
	export baseOffendersPicture									:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersPicture,pVersion);	
	
	export lBaseTemplateLPR						:= 	_Dataset().thor_cluster_files + 'in::prepped::lpr::dbo::licenseplateevent::@version@';
	export baseLPR										:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateLPR,pVersion);	
	
	export lBaseTemplateDeletes 			:= 	_Dataset().thor_cluster_files + 'in::prepped::deletes::@version@';
	export baseDeletes								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateDeletes,pVersion);

	export lBaseTemplateEventDeletes 			:= 	_Dataset().thor_cluster_files + 'in::prepped::event::deletes::@version@';
	export baseEventDeletes								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventDeletes,pVersion);

	export lBaseTemplateCFSDeletes 			:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::deletes::@version@';
	export baseCFSDeletes								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFSDeletes,pVersion);

	export lBaseTemplateCrashDeletes 			:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::deletes::@version@';
	export baseCrashDeletes								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashDeletes,pVersion);
	
	export lBaseTemplateOffendersDeletes 			:= 	_Dataset().thor_cluster_files + 'in::prepped::offender::deletes::@version@';
	export baseOffendersDeletes								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersDeletes,pVersion);

	export lBaseTemplateStatsReport		:= 	_Dataset().thor_cluster_files + 'in::prepped::statsreport::@version@';
	export baseStatsReport  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateStatsReport,pVersion);
	
	export lBaseTemplateEventStatsReport		:= 	_Dataset().thor_cluster_files + 'in::prepped::event::statsreport::@version@';
	export baseEventStatsReport  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventStatsReport,pVersion);

	export lBaseTemplateCFSStatsReport		:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::statsreport::@version@';
	export baseCFSStatsReport  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFSStatsReport,pVersion);
	
	export lBaseTemplateCrashStatsReport		:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::statsreport::@version@';
	export baseCrashStatsReport  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashStatsReport,pVersion);

	export lBaseTemplateOffendersStatsReport		:= 	_Dataset().thor_cluster_files + 'in::prepped::offender::statsreport::@version@';
	export baseOffendersStatsReport  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersStatsReport,pVersion);

	export lBaseTemplateLNAddressCache	:= 	_Dataset().thor_cluster_files + 'in::prepped::ln_address_cache::@version@';
	export baseLNAddressCache  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateLNAddressCache,pVersion);
	
	export lBaseTemplateEventLNAddressCache	:= 	_Dataset().thor_cluster_files + 'in::prepped::event::ln_address_cache::@version@';
	export baseEventLNAddressCache  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventLNAddressCache,pVersion);

	export lBaseTemplateCFSLNAddressCache	:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::ln_address_cache::@version@';
	export baseCFSLNAddressCache  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFSLNAddressCache,pVersion);
	
	export lBaseTemplateCrashLNAddressCache	:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::ln_address_cache::@version@';
	export baseCrashLNAddressCache  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashLNAddressCache,pVersion);

	export lBaseTemplateOffendersLNAddressCache	:= 	_Dataset().thor_cluster_files + 'in::prepped::offender::ln_address_cache::@version@';
	export baseOffendersLNAddressCache  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersLNAddressCache,pVersion);

	export lBaseTemplateGeocodingLog	:= 	_Dataset().thor_cluster_files + 'out::geocoding_log::@version@';
	export baseGeocodingLog  				:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateGeocodingLog,pVersion);

	export lBaseTemplateEventGeocodingLog	:= 	_Dataset().thor_cluster_files + 'out::event::geocoding_log::@version@';
	export baseEventGeocodingLog  				:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventGeocodingLog,pVersion);

	export lBaseTemplateCFSGeocodingLog	:= 	_Dataset().thor_cluster_files + 'out::cfs::geocoding_log::@version@';
	export baseCFSGeocodingLog  				:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFSGeocodingLog,pVersion);

	export lBaseTemplateCrashGeocodingLog	:= 	_Dataset().thor_cluster_files + 'out::crash::geocoding_log::@version@';
	export baseCrashGeocodingLog  				:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashGeocodingLog,pVersion);

	export lBaseTemplateOffenderGeocodingLog	:= 	_Dataset().thor_cluster_files + 'out::offender::geocoding_log::@version@';
	export baseOffendersGeocodingLog  				:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffenderGeocodingLog,pVersion);
		
	export baseEvent_dAll_filenames :=  
														baseEventMO.dAll_filenames 
													+ baseEventMOUDF.dAll_filenames
													+ baseEventPersons.dAll_filenames 
													+ baseEventPersonsUDF.dAll_filenames
													+ baseEventVehicles.dAll_filenames
													+ baseEventDeletes.dAll_filenames
													+ baseEventStatsReport.dAll_filenames
													+ baseEventLNAddressCache.dAll_filenames
													+ baseEventGeocodingLog.dAll_filenames;
													
	export baseCFS_dAll_filenames	 :=  
														baseCFS.dAll_filenames 
													+ baseCFSOfficers.dAll_filenames
													+ baseCFSDeletes.dAll_filenames
													+ baseCFSStatsReport.dAll_filenames
													+ baseCFSLNAddressCache.dAll_filenames
													+ baseCFSGeocodingLog.dAll_filenames;
													
	export baseCrash_dAll_filenames:=	
														baseCrash.dAll_filenames 
													+ baseCrashPersons.dAll_filenames
													+ baseCrashVehicles.dAll_filenames
													+ baseCrashDeletes.dAll_filenames
													+ baseCrashStatsReport.dAll_filenames
													+ baseCrashLNAddressCache.dAll_filenames
												  + baseCrashGeocodingLog.dAll_filenames;
													
	export baseOffenders_dAll_filenames:=	
														baseOffenders.dAll_filenames
													+ baseOffendersClassification.dAll_filenames
													+ baseOffendersPicture.dAll_filenames
													+ baseOffendersDeletes.dAll_filenames
													+ baseOffendersStatsReport.dAll_filenames
													+ baseOffendersLNAddressCache.dAll_filenames
													+ baseOffendersGeocodingLog.dAll_filenames;
													
	export baseLPR_dAll_filenames:=	
														baseLPR.dAll_filenames;

	export baseCommon_dAll_filenames:=	
														baseDeletes.dAll_filenames
													+ baseStatsReport.dAll_filenames
													+ baseLNAddressCache.dAll_filenames
													+ baseGeocodingLog.dAll_filenames;
												
	export lBaseSentinelTemplate 			:= _Dataset().thor_cluster_files + 'out::bair_sentinel_flag';
	export lBaseRecordIdRaidsTemplate := _Dataset().thor_cluster_files + 'out::bair_recordid_raids';
	
	export manifest := _Dataset().thor_cluster_files + 'in::bair::rdi::manifest_csv::'+pVersion;
end;
