IMPORT tools, versioncontrol,bair,STD;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
  export inputEventMos_XML 						:= dataset(Filenames(pversion,pUseProd).lInputTemplateEVENT_XML				, layouts.SprayedEventMos_XML,								xml('EVENT_XML/MO_TABLE/MO'));
	export inputEventPersons_XML 				:= dataset(Filenames(pversion,pUseProd).lInputTemplateEVENT_XML				, layouts.SprayedEventPersons_XML,						xml('EVENT_XML/PERSONS_TABLE/PERSONS'));
	export inputEventVehicles_XML				:= dataset(Filenames(pversion,pUseProd).lInputTemplateEVENT_XML				, layouts.SprayedEventVehicles_XML,						xml('EVENT_XML/VEHICLE_TABLE/VEHICLE'));
  export inputEventMos_CSV 						:= dataset(Filenames(pversion,pUseProd).lInputTemplateEVENT_MO_CSV				, layouts.SprayedEventMos_CSV,						CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));
	export inputEventPersons_CSV 				:= dataset(Filenames(pversion,pUseProd).lInputTemplateEVENT_PERSONS_CSV		, layouts.SprayedEventPersons_CSV,				CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));
	export inputEventVehicles_CSV 			:= dataset(Filenames(pversion,pUseProd).lInputTemplateEVENT_VEHICLES_CSV	, layouts.SprayedEventVehicles_CSV,				CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));

	export inputCFS_XML 								:= dataset(Filenames(pversion,pUseProd).lInputTemplateCFS_XML					, layouts.SprayedCFS_XML,									xml('CFS_XML/CFS_TABLE/CFS'));
	export inputCFSOfficers_XML					:= dataset(Filenames(pversion,pUseProd).lInputTemplateCFS_XML					, layouts.SprayedCFSOfficers_XML,					xml('CFS_XML/OFFICER_TABLE/OFFICERS'));
	export inputCFS_CSV 								:= dataset(Filenames(pversion,pUseProd).lInputTemplateCFS_CSV					, layouts.SprayedCFS_CSV,									CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));
	export inputCFSOfficers_CSV					:= dataset(Filenames(pversion,pUseProd).lInputTemplateCFSOFFICERS_CSV	, layouts.SprayedCFSOfficers_CSV,					CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));
	export inputCrash 									:= dataset(Filenames(pversion,pUseProd).lInputTemplateCrash						, layouts.SprayedCrash,										xml('CRASH_XML/CRASH_TABLE/CRASH'));
	export inputCrashPersons						:= dataset(Filenames(pversion,pUseProd).lInputTemplateCrash						, layouts.SprayedCrashPersons,						xml('CRASH_XML/PERSON_TABLE/PERSON'));
	export inputCrashVehicle						:= dataset(Filenames(pversion,pUseProd).lInputTemplateCrash						, layouts.SprayedCrashVehicles,						xml('CRASH_XML/VEHICLE_TABLE/VEHICLE'));
	export inputOffender								:= dataset(Filenames(pversion,pUseProd).lInputTemplateOffender				, layouts.SprayedOffenders,								xml('OFFENDER_XML/OFFENDER_TABLE/OFFENDER'));
	export inputOffenderClassification	:= dataset(Filenames(pversion,pUseProd).lInputTemplateOffender				, layouts.SprayedOffendersClassification,	xml('OFFENDER_XML/CLASSIFICATION_TABLE/CLASSIFICATION'));
	export inputOffenderPicture					:= dataset(Filenames(pversion,pUseProd).lInputTemplateOffender				, layouts.SprayedOffendersPicture,				xml('OFFENDER_XML/PICTURE_TABLE/PICTURE'));
	export inputLPR_XML									:= dataset(Filenames(pversion,pUseProd).lInputTemplateLPR_XML					, layouts.SprayedLPR_XML,									xml('LPR_XML/LPR_TABLE/LPR'));
	export inputLPR_CSV									:= dataset(Filenames(pversion,pUseProd).lInputTemplateLPR_CSV					, layouts.SprayedLPR_CSV,									CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));
	//export LNAddressCache								:= dataset(Filenames(pversion,pUseProd).baseLNAddressCache						, layouts.address_cache,									thor,opt );
	
	export crash_add 			:= inputCrash(STD.Str.ToUpperCase(action) = 'ADD');
	export crash_delete 	:= inputCrash(STD.Str.ToUpperCase(action) = 'DELETE');
	export offender_add		:= inputOffender(STD.Str.ToUpperCase(action) = 'ADD');
	export offender_delete:= inputOffender(STD.Str.ToUpperCase(action) = 'DELETE');	
	
	
	export bair_sentinel_flag := 'thor_data400::out::bair_sentinel_flag';
	
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseEventMO,	bair.layouts.event_dbo_mo_In, BaseEventMO); 			
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseEventMOUDF,	bair.layouts.event_dbo_mo_udf_In, baseEventMOUDF); 			
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseEventPersons,	bair.layouts.event_dbo_persons_In, BaseEventPersons); 					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseEventPersonsUDF,	bair.layouts.event_dbo_persons_udf_In, baseEventPersonsUDF); 					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseEventVehicles,	bair.layouts.event_dbo_vehicle_In	, BaseEventVehicles); 	
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseCFS,	bair.layouts.cfs_dbo_cfs_2_In, BaseCFS); 					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseCFSOfficers,	bair.layouts.cfs_dbo_cfs_officers_2_In, BaseCFSOfficers); 					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseDeletes,	bair.layouts.Agency_Deletes	, BaseDeletes);					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseStatsReport,	Bair.raidsReport_Layout.raidsReportRec, BaseStatsReport);					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseOrbitBuilds,	bair_importer.layouts.orbitbuilds_layout, BaseOrbitBuilds);					
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseCrash,	Bair.layouts.crash_dbo_crash_In, baseCrash);		
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseCrashPersons,	Bair.layouts.crash_dbo_person_In, baseCrashPersons);						
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseCrashVehicles,	Bair.layouts.crash_dbo_vehicle_In, baseCrashVehicles);							
	versioncontrol.macBuildFileVersions(Filenames(pversion).baseLNAddressCache,	Bair_importer.layouts.address_cache, baseLNAddressCache); 											
					
END;

