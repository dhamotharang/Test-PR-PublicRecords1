IMPORT STD,_Control;
EXPORT _Constant := MODULE

	//FULL 			PS 	Keys Count - 22
	//DELTA 		PS 	Keys Count - 22
	//FULL 	NON PS 	Keys Count - 30
	//DELTA NON PS 	Keys Count - 34
	
	EXPORT DeltaKeysCnt 		:= 54;
	EXPORT ProdFullKeysCnt  := 53;
	EXPORT CertFullKeysCnt  := 53;
	
	EXPORT BaseSF := DATASET([
	 {'thor_data400::base::bair::agency_removed::dbo::agency_deletes::built'}
	,{'thor_data400::base::bair::agency_removed::dbo::agency_deletes::qa'}
	,{'thor_data400::base::bair::cfs::dbo::agencycfstypelookup::built'}
	,{'thor_data400::base::bair::cfs::dbo::agencycfstypelookup::qa'}
	,{'thor_data400::base::bair::classification::built'}
	,{'thor_data400::base::bair::classification::qa'}
	,{'thor_data400::base::bair::dbo::cfs::delta::built'}
	,{'thor_data400::base::bair::dbo::cfs::delta::qa'}
	,{'thor_data400::base::bair::dbo::crash::delta::built'}
	,{'thor_data400::base::bair::dbo::crash::delta::qa'}
	,{'thor_data400::base::bair::dbo::intel::delta::built'}
	,{'thor_data400::base::bair::dbo::intel::delta::qa'}
	,{'thor_data400::base::bair::dbo::licenseplateevent::delta::built'}
	,{'thor_data400::base::bair::dbo::licenseplateevent::delta::qa'}
	,{'thor_data400::base::bair::dbo::mo::delta::built'}
	,{'thor_data400::base::bair::dbo::mo::delta::qa'}
	,{'thor_data400::base::bair::dbo::offenders::delta::built'}
	,{'thor_data400::base::bair::dbo::offenders::delta::qa'}
	,{'thor_data400::base::bair::dbo::offenders_picture::delta::built'}
	,{'thor_data400::base::bair::dbo::offenders_picture::delta::qa'}
	,{'thor_data400::base::bair::dbo::persons::delta::built'}
	,{'thor_data400::base::bair::dbo::persons::delta::qa'}
	,{'thor_data400::base::bair::dbo::shotspotter::delta::built'}
	,{'thor_data400::base::bair::dbo::shotspotter::delta::qa'}
	,{'thor_data400::base::bair::dbo::vehicle::delta::built'}
	,{'thor_data400::base::bair::dbo::vehicle::delta::qa'}
	,{'thor_data400::base::bair::event::dbo::agencycrimetypelookup::built'}
	,{'thor_data400::base::bair::event::dbo::agencycrimetypelookup::qa'}
	,{'thor_data400::base::bair::event::dbo::data_provider::built'}
	,{'thor_data400::base::bair::event::dbo::data_provider::qa'}
	,{'thor_data400::base::bair::event::dbo::data_provider_import::built'}
	,{'thor_data400::base::bair::event::dbo::data_provider_import::qa'}
	,{'thor_data400::base::bair::event::dbo::data_provider_location::built'}
	,{'thor_data400::base::bair::event::dbo::data_provider_location::qa'}
	,{'thor_data400::base::bair::event::dbo::mo_udf::delta::built'}
	,{'thor_data400::base::bair::event::dbo::mo_udf::delta::qa'}
	,{'thor_data400::base::bair::event::dbo::persons_udf::delta::built'}
	,{'thor_data400::base::bair::event::dbo::persons_udf::delta::qa'}
	,{'thor_data400::base::bair::event::group_access::built'}
	,{'thor_data400::base::bair::event::group_access::qa'}
	,{'thor_data400::base::bair::event::import::address_lookup::built'}
	,{'thor_data400::base::bair::event::import::address_lookup::qa'}
	,{'thor_data400::base::bair::geohash::built'}
	,{'thor_data400::base::bair::geohash::delta::built'}
	,{'thor_data400::base::bair::geohash::delta::qa'}
	,{'thor_data400::base::bair::geohash::qa'}
	,{'thor_data400::base::bair::images::delta::built'}
	,{'thor_data400::base::bair::images::delta::qa'}
	,{'thor_data400::base::bair::notes::delta::built'}
	,{'thor_data400::base::bair::notes::delta::qa'}
	,{'thor_data400::key::bair::geohash::built'}
	,{'thor_data400::key::bair::geohash::qa'}
	,{'thor_data400::base::bair::geohash::lpr::built'}
	,{'thor_data400::base::bair::geohash::lpr::qa'}
	,{'thor_data400::base::bair::geohash::lpr::delta::built'}
	,{'thor_data400::base::bair::geohash::lpr::delta::qa'}
	,{'thor400_data::base::composite_public_safety_data_delta'}
	,{'thor400_data::base::composite_public_safety_data_curr_delta'}
	],{STRING supername});

	EXPORT CompositeSF := DATASET([
	 {'thor_data400::key::bair_composite::mo::delta::qa::eid'}
	,{'thor_data400::key::bair_composite::mo::delta::qa::phone'}
	,{'thor_data400::key::bair_composite::mo::v2::delta::qa::eid'}
	,{'thor_data400::key::bair_composite::mo::v2::delta::qa::phone'}
	,{'thor_data400::key::bair_composite::vehicle::delta::qa::wild'}
	,{'thor_data400::key::bair_composite::vehicle::delta::qa::model'}
	,{'thor_data400::key::bair_composite::vehicle::delta::qa::make'}
	,{'thor_data400::key::bair_composite::vehicle::delta::qa::body'}
	],{STRING supername});
	
	EXPORT packageSF := DATASET([
	 {'package::qa::bair-qa::flat::pkgfile'}
	,{'package::qa::bair-prod::flat::pkgfile'}
	,{'package::qa::bair-prod::xml::pkgfile'}
	,{'package::qa::bair-qa::xml::pkgfile'}
	],{STRING supername});

	EXPORT prepSF := DATASET([
	 {'thor_data400::in::prepped::cfs::dbo::cfs_2::built'}
	,{'thor_data400::in::prepped::cfs::dbo::cfs_officers_2::built'}
	,{'thor_data400::in::prepped::event::dbo::mo::built'}
	,{'thor_data400::in::prepped::event::dbo::mo_udf::built'}
	,{'thor_data400::in::prepped::event::dbo::persons::built'}
	,{'thor_data400::in::prepped::event::dbo::persons_udf::built'}
	,{'thor_data400::in::prepped::event::dbo::vehicles::built'}
	,{'thor_data400::in::prepped::crash::dbo::crash::built'}
	,{'thor_data400::in::prepped::crash::dbo::person::built'}
	,{'thor_data400::in::prepped::crash::dbo::vehicle::built'}
	,{'thor_data400::in::prepped::lpr::dbo::licenseplateevent::built'}
	,{'thor_data400::in::prepped::offenders::dbo::offender::built'}
	,{'thor_data400::in::prepped::offenders::dbo::offender_classification::built'}
	,{'thor_data400::in::prepped::offenders::dbo::offender_picture::built'}
	,{'thor_data400::in::prepped::deletes::built'}

	],{STRING supername});

								
	EXPORT baseCtrlSF  := DATASET([
	{'thor_data400::out::Bair_NewHeader_flag'},
	{'thor_data400::out::bair_nonbooleanfullbuilt_flag'},
	{'thor_data400::out::bair_booleanfullbuilt_flag'},
	{'thor_data400::out::bair_deltabuilt_vers'},
	{'thor_data400::out::bair_fullbuilt_vers'},
	{'thor_data400::out::bair_flush_vers'},
	{'thor_data400::out::Bair_LastFullPkg_flag'},
	{'thor_data400::out::bair_bldchkpt_delta'}
	],{STRING supername});
	
	EXPORT CompositeCtrlSF  := DATASET([
	{'thor_data400::out::bair_Sequence_flag'}
	],{STRING supername});
	
	EXPORT prepCtrlSF  := DATASET([
	 {'thor_data400::out::bair_recordid_raids'}
	,{'thor_data400::out::bair_geocoding_flag'}
	//,{'thor_data400::in::prepped::statsreport::built'}  -- REMOVED as per Oscar's Ok - 08/03/2016
	,{'thor_data400::in::prepped::orbitbuilds::built'}
	,{'thor_data400::out::bair_geocoding_log'}
	],{STRING supername});

	EXPORT prepByPeriodSF  := DATASET([
	{'thor_data400::in::prepped::ln_address_cache::built',4}
	],{STRING255 supername, INTEGER period});

	EXPORT byPeriodProcessTime := DATASET([
	 {1,000000}
	,{2,000000}
	,{2,120000}
	,{3,000000}
	,{3,080000}
	,{3,160000}
	,{4,000000}
	,{4,060000}
	,{4,120000}
	,{4,180000}
	,{6,000000}
	,{6,040000}
	,{6,080000}
	,{6,120000}
	,{6,160000}
	,{6,200000}
	],{INTEGER period, INTEGER processTime});

	EXPORT byPeriodSF_ProcTime_JOIN         :=JOIN(prepByPeriodSF, byPeriodProcessTime, LEFT.period=RIGHT.period );

	EXPORT manifest_layout := RECORD
		STRING30   buildName;
		STRING30   agencyBuildVersionIncluded;
		STRING30   version;
		STRING255  supername;
		STRING255  subname;
	END;	

	//2.1.1.10:7070 - DR DALI IP
	//1.1.1.74:7070 - PROD DALI IP
	SHARED daliServer := STD.System.Thorlib.Daliserver();
	EXPORT manifestToIP := if (_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1,'http://10.240.32.15:8010/FileSpray','http://10.240.160.19:8010/FileSpray');
	EXPORT copyFromIP   := if (_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1,'~foreign::'+_Control.IPAddress.bair_prod_dali+'::' ,'~foreign::'+_Control.IPAddress.bair_DR_dali+'::');
	EXPORT cronIP       := if (_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1,'10.240.160.19','10.240.32.15');
	EXPORT listFromIP   := if (_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1,_Control.IPAddress.bair_prod_dali,_Control.IPAddress.bair_DR_dali);
	EXPORT NotifyIP     := if (_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1,_Control.IPAddress.bair_prod_ESP,_Control.IPAddress.bair_DR_ESP);

	EXPORT bair_batchlz := if (_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1, _control.IPAddress.abair_batchlz01, _control.IPAddress.bair_batchlz01);
	
	rBairFiles := RECORD
		STRING  fileType;
		BOOLEAN  requiredFlag;
	END;

	EXPORT BairFiles := DATASET([ 
	{'agency_removed.dbo.agency_deletes',TRUE},
	{'cfs.dbo.agencycfstypelookup',TRUE},
	{'cfs.dbo.cfs_2',TRUE},
	{'cfs.dbo.cfs_officers_2',TRUE},
	{'crash.dbo.crash',TRUE},
	{'crash.dbo.person',TRUE},
	{'crash.dbo.vehicle',TRUE},
	{'event.dbo.agencycrimetypelookup',TRUE},
	{'event.dbo.data_provider',TRUE},
	{'event.dbo.data_provider_import',TRUE},
	{'event.dbo.data_provider_location',TRUE},
	{'event.dbo.mo',TRUE},
	{'event.dbo.mo_udf',TRUE},
	{'event.dbo.persons',TRUE},
	{'event.dbo.persons_udf',TRUE},
	{'event.dbo.vehicle',TRUE},
	{'event.import.address_lookup',TRUE},
	{'event.import.group_access',TRUE},
	{'gunop.dbo.shot_incident',TRUE},
	{'intel.dbo.entity',TRUE},
	{'intel.dbo.entity_notes',TRUE},
	{'intel.dbo.entity_photo',TRUE},
	{'intel.dbo.incident',TRUE},
	{'intel.dbo.incident_notes',TRUE},
	{'intel.dbo.reporting_officer',TRUE},
	{'intel.dbo.vehicle_notes',TRUE},
	{'lpr.dbo.licenseplateevent',TRUE},
	{'lpr.dbo.nightlyLPRDeletes',FALSE},
	{'offenders.dbo.classification',TRUE},
	{'offenders.dbo.offender',TRUE},
	{'offenders.dbo.offender_classification',TRUE},
	{'offenders.dbo.offender_picture',TRUE}
																	],rBairFiles);
						
	export max_execution_time := 3600000;
	export agencies_max_interval := 60;
	export timezone_diff := 400;
	
	EXPORT CFS_caller_addr                := 1;
	EXPORT CFS_complainant_addr           := 2;
	EXPORT CFS_Incident_addr              := 3;
	EXPORT Events_Mo_address_of_crime     := 4;
	EXPORT Events_Persons_persons_address := 6;
	EXPORT Events_Vehicle_vehicle_address := 8;
	EXPORT Offenders_                     := 10;
	EXPORT Crash_Incident                 := 11;
	EXPORT License_Plates                 := 12;
	EXPORT Crash_Person		                := 13;
	EXPORT Crash_Vehicle                  := 14;
END;