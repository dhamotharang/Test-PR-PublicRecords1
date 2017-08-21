import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module

 	export lInputTemplateEVENT_XML 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_xml' ;
	export lInputHistTemplateEVENT_XML	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_xml::history' ;

 	export lInputTemplateEVENT_MO_CSV 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_mo_csv' ;
	export lInputHistTemplateEVENT_MO_CSV				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_mo_csv::history' ;
 	export lInputTemplateEVENT_PERSONS_CSV 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_persons_csv' ;
	export lInputHistTemplateEVENT_PERSONS_CSV	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_persons_csv::history' ;
 	export lInputTemplateEVENT_VEHICLES_CSV 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_vehicle_csv' ;
	export lInputHistTemplateEVENT_VEHICLES_CSV	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::event_vehicle_csv::history' ;

 	export lInputTemplateCFS_XML 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_xml' ;	
	export lInputHistTemplateCFS_XML	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_xml::history' ;

	export lInputTemplateCFS_CSV							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_csv' ;	
	export lInputHistTemplateCFS_CSV					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_csv::history' ;	
	export lInputTemplateCFSOFFICERS_CSV			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_officers_csv' ;	
	export lInputHistTemplateCFSOFFICERS_CSV	:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::cfs_officers_csv::history' ;	

 	export lInputTemplateCrash 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_xml' ;
	export lInputHistTemplateCrash 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::crash_xml::history' ;
 	export lInputTemplateOffender				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_xml' ;
	export lInputHistTemplateOffender		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::offender_xml::history' ;
	
 	export lInputTemplateLPR_XML				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::lpr_xml' ;
	export lInputHistTemplateLPR_XML		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::lpr_xml::history' ;
	
	export lInputTemplateLPR_CSV				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::lpr_csv' ;
	export lInputHistTemplateLPR_CSV		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::rdi::lpr_csv::history' ;

	export lBaseTemplateEventMO					:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::mo::@version@';
	export baseEventMO  								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventMO,pversion);

	export lBaseTemplateEventMOUDF			:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::mo_udf::@version@';
	export baseEventMOUDF  							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventMOUDF,pversion);

	export lBaseTemplateEventPersons		:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::persons::@version@';
	export baseEventPersons							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventPersons,pversion);

	export lBaseTemplateEventPersonsUDF	:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::persons_udf::@version@';
	export baseEventPersonsUDF					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventPersonsUDF,pversion);

	export lBaseTemplateEventVehicles 	:= 	_Dataset().thor_cluster_files + 'in::prepped::event::dbo::vehicles::@version@';
	export baseEventVehicles						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateEventVehicles,pversion);
	
	export lBaseTemplateCFS 						:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::dbo::cfs_2::@version@';
	export baseCFS											:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFS,pversion);
	
	export lBaseTemplateCFSOfficers 		:= 	_Dataset().thor_cluster_files + 'in::prepped::cfs::dbo::cfs_officers_2::@version@';
	export baseCFSOfficers							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCFSOfficers,pversion);

	export lBaseTemplateCrash 					:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::dbo::crash::@version@';
	export baseCrash										:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrash,pversion);
	
	export lBaseTemplateCrashPersons		:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::dbo::person::@version@';
	export baseCrashPersons							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashPersons,pversion);

	export lBaseTemplateCrashVehicles		:= 	_Dataset().thor_cluster_files + 'in::prepped::crash::dbo::vehicle::@version@';
	export baseCrashVehicles						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateCrashVehicles,pversion);

	export lBaseTemplateOffenders				:= 	_Dataset().thor_cluster_files + 'in::prepped::offenders::dbo::offender::@version@';
	export baseOffenders								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffenders,pversion);

	export lBaseTemplateOffendersClassification	:= 	_Dataset().thor_cluster_files + 'in::prepped::offenders::dbo::offender_classification::@version@';
	export baseOffendersClassification					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersClassification,pversion);	
	
	export lBaseTemplateOffendersPicture				:= 	_Dataset().thor_cluster_files + 'in::prepped::offenders::dbo::offender_picture::@version@';
	export baseOffendersPicture									:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOffendersPicture,pversion);	
	
	export lBaseTemplateLPR						:= 	_Dataset().thor_cluster_files + 'in::prepped::lpr::dbo::licenseplateevent::@version@';
	export baseLPR										:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateLPR,pversion);	
	
	export lBaseTemplateDeletes 			:= 	_Dataset().thor_cluster_files + 'in::prepped::deletes::@version@';
	export baseDeletes								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateDeletes,pversion);
	
	export lBaseTemplateStatsReport		:= 	_Dataset().thor_cluster_files + 'in::prepped::statsreport::@version@';
	export baseStatsReport  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateStatsReport,pversion);

	export lBaseTemplateOrbitBuilds		:= 	_Dataset().thor_cluster_files + 'in::prepped::orbitbuilds::@version@';
	export baseOrbitBuilds  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateOrbitBuilds,pversion);

	export lBaseTemplateLNAddressCache	:= 	_Dataset().thor_cluster_files + 'in::prepped::ln_address_cache::@version@';
	export baseLNAddressCache  					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplateLNAddressCache,pversion);
	
	export baseEvent_dAll_filenames :=  
														baseEventMO.dAll_filenames 
													+ baseEventMOUDF.dAll_filenames
													+ baseEventPersons.dAll_filenames 
													+ baseEventPersonsUDF.dAll_filenames
													+ baseEventVehicles.dAll_filenames
													+ baseDeletes.dAll_filenames
													+ baseStatsReport.dAll_filenames
													+ baseOrbitBuilds.dAll_filenames
													+ baseLNAddressCache.dAll_filenames;
													
	export baseCFS_dAll_filenames	 :=  
														baseCFS.dAll_filenames 
													+ baseCFSOfficers.dAll_filenames
													+ baseDeletes.dAll_filenames
													+ baseStatsReport.dAll_filenames
													+ baseOrbitBuilds.dAll_filenames
													+ baseLNAddressCache.dAll_filenames;
													
	export baseCrash_dAll_filenames:=	
														baseCrash.dAll_filenames 
													+ baseCrashPersons.dAll_filenames
													+ baseCrashVehicles.dAll_filenames
													+ baseDeletes.dAll_filenames
													+ baseStatsReport.dAll_filenames
													+ baseOrbitBuilds.dAll_filenames
													+ baseLNAddressCache.dAll_filenames;
													
	export baseOffenders_dAll_filenames:=	
														baseOffenders.dAll_filenames
													+ baseOffendersClassification.dAll_filenames
													+ baseOffendersPicture.dAll_filenames
													+ baseDeletes.dAll_filenames
													+ baseStatsReport.dAll_filenames
													+ baseOrbitBuilds.dAll_filenames
													+ baseLNAddressCache.dAll_filenames;
													
	export baseLPR_dAll_filenames:=	
														baseLPR.dAll_filenames				
													+ baseDeletes.dAll_filenames
													+ baseStatsReport.dAll_filenames
													+ baseOrbitBuilds.dAll_filenames;

													
	export lBaseSentinelTemplate 			:= _Dataset().thor_cluster_files + 'out::bair_sentinel_flag';
	export lBaseRecordIdRaidsTemplate := _Dataset().thor_cluster_files + 'out::bair_recordid_raids';
end;
