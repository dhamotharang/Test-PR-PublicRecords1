
EXPORT Build_Inputs := MODULE

	EXPORT build_events(string pVersion) := FUNCTION
		IMPORT STD;
																		 
		dtImport := (STRING8)Std.Date.Today();

		EVENT_MO_input := Files(pVersion).inputEventMos_CSV;
		EVENT_PERSONS_input := Files(pVersion).inputEventPersons_CSV;
		EVENT_VEHICLES_input := Files(pVersion).inputEventVehicles_CSV; 
		
		EVENT_MO_add_input  := EVENT_MO_input(STD.Str.ToUpperCase(action) = 'ADD');
		EVENT_MO_delete_input := EVENT_MO_input(STD.Str.ToUpperCase(action) = 'DELETE'); 		

		filename:= pVersion;
		geo_addresses := dedup(Geocode.MAC_GeoEvent( filename,EVENT_MO_add_input,EVENT_PERSONS_input,EVENT_VEHICLES_input ),ac_dataProviderID, ac_address,all):independent;
		mos_ext:= Update_Input.MAC_EventMosExt( EVENT_MO_add_input, geo_addresses);
		persons_ext := Update_Input.MAC_EventPersonsExt(EVENT_PERSONS_input, EVENT_MO_add_input, pVersion, geo_addresses);
		vehicles_ext:= Update_Input.MAC_EventVehiclesExt(EVENT_VEHICLES_input, EVENT_MO_add_input, pVersion, geo_addresses);

		mos:= Update_Input.MAC_EventMos(mos_ext(DoNotImport=FALSE) );
		mos_udf:= Update_Input.MAC_EventMosUDF( mos_ext(DoNotImport=FALSE) );
		persons:= Update_Input.MAC_EventPersons(persons_ext);
		persons_udf:= Update_Input.MAC_EventPersonsUDF( persons_ext );
		vehicles:= Update_Input.MAC_EventVehicles( vehicles_ext);
		mos_deletes:= Update_Input.MAC_deletes_events(EVENT_MO_delete_input);

		Bair.MAC_IMPORT_Summary(mos_ext, _Constants.file_types[1], filename, dtImport, mo_outrec);
		Bair.MAC_IMPORT_Summary(persons_ext, _Constants.file_types[2], filename, dtImport, persons_outrec);
		Bair.MAC_IMPORT_Summary(vehicles_ext, _Constants.file_types[3], filename, dtImport, vehicle_outrec);

		Stats_Event := Build_Base.MAC_Build_Stats_Event( mo_outrec,persons_outrec,vehicle_outrec );
		
		MO  := Validate_Input.fn_GetMORecordID();
		PER := Validate_Input.fn_GetPersonRecordID();

		//BUILD INPUTS
		RETURN 
		sequential(
			 Build_Base.MAC_Build_Input(mos, bair.layouts.event_dbo_mo_In,Filenames(pVersion).baseEventMO.new, _Dataset().thor_cluster_files + _Constants.event_mo_built, _Constants.event_filter, true),
			 Build_Base.MAC_Build_Input(mos_udf, bair.layouts.event_dbo_mo_udf_In,Filenames(pVersion).baseEventMOUDF.new,_Dataset().thor_cluster_files + _Constants.event_mo_udf_built, _Constants.event_udf_filter, true ),
			 Build_Base.MAC_Build_Input(persons, bair.layouts.event_dbo_persons_In,Filenames(pVersion).baseEventPersons.new,_Dataset().thor_cluster_files + _Constants.event_persons_built, _Constants.event_filter, true ),
			 Build_Base.MAC_Build_Input(persons_udf, bair.layouts.event_dbo_persons_udf_In, Filenames(pVersion).baseEventPersonsUDF.new,_Dataset().thor_cluster_files + _Constants.event_persons_udf_built,_Constants.event_udf_filter,true),
			 Build_Base.MAC_Build_Input(vehicles,bair.layouts.event_dbo_vehicle_In, Filenames(pVersion).baseEventVehicles.new,_Dataset().thor_cluster_files + _Constants.event_vehicles_built, _Constants.event_filter, true ), 

			 BuildNewLogicalFile(Filenames(pVersion).baseEventLNAddressCache.new, geo_addresses, false),
			 BuildNewLogicalFile(Filenames(pVersion).baseEventDeletes.new, mos_deletes, false),
			 BuildNewLogicalFile(Filenames(pVersion).baseEventStatsReport.new, Stats_Event, false),
			 
			 Validate_Input.fn_SetRecordID_RAIDS(
										max(max(mos_ext,mos_ext.recordID_RAIDS),MO)
									 ,max(max(persons_ext,persons_ext.recordID_RAIDS),PER)
									 ,pVersion),
									 
			 Promote.Promote_Event(pVersion).buildfiles.New2Built,
			 Promote.Promote_Event(pVersion).buildfiles.Built2QA,
		);
	END;

	EXPORT build_cfs(string pVersion):=FUNCTION
		IMPORT STD;

		dtImport := (STRING8)Std.Date.Today();
																 
		CFS_input := Files(pVersion).inputCFS_CSV;
		CFSOFFICERS_input := Files(pVersion).inputCFSOfficers_CSV;

		filename:= pVersion;
		CFS_add_input  := CFS_input(STD.Str.ToUpperCase(action) = 'ADD');
		CFS_delete_input := CFS_input(STD.Str.ToUpperCase(action) = 'DELETE'); 
		geo_addresses := dedup(Geocode.MAC_GeoCFS(filename,CFS_add_input),ac_dataProviderID, ac_address,all):independent;
		cfs_ext:= Update_Input.MAC_Cfs_Ext(CFS_add_input,CFSOFFICERS_input,geo_addresses);
		cfs:= Update_Input.MAC_Cfs(cfs_ext(initial_DoNotImport=FALSE AND final_DoNotImport=FALSE));
		officers := Update_Input.MAC_Cfs_officers(CFSOFFICERS_input);
		cfs_do_not_import:= cfs_ext(initial_DoNotImport=TRUE or final_DoNotImport=TRUE);
		cfs_deletes := Update_Input.MAC_deletes_cfs(CFS_delete_input);
		Bair.MAC_IMPORT_Summary(cfs_ext(initial_DoNotImport=FALSE AND final_DoNotImport=FALSE) , _Constants.file_types[5], filename, dtImport, cfs_outrec);

		//BUILD INPUTS
		RETURN
		sequential(
			Build_Base.MAC_Build_Input(cfs, bair.layouts.cfs_dbo_cfs_2_In, Filenames(pVersion).baseCFS.new, _Dataset().thor_cluster_files + _Constants.cfs_built, _Constants.cfs_filter, true),
			Build_Base.MAC_Build_Input(officers, bair.layouts.cfs_dbo_cfs_officers_2_In,Filenames(pVersion).baseCFSOfficers.new, _Dataset().thor_cluster_files + _Constants.cfs_officers_built, _Constants.cfs_filter,true),
			
			BuildNewLogicalFile(Filenames(pVersion).baseCFSLNAddressCache.new, geo_addresses, false),
			BuildNewLogicalFile(Filenames(pVersion).baseCFSDeletes.new, cfs_deletes, false),
			BuildNewLogicalFile(Filenames(pVersion).baseCFSStatsReport.new, cfs_outrec, false),

			Promote.Promote_CFS(pVersion).buildfiles.New2Built,
			Promote.Promote_CFS(pVersion).buildfiles.Built2QA,
		);

	END;
	EXPORT build_crash(string pVersion) := FUNCTION
		IMPORT STD;									

		CRASH_input := Files(pVersion).inputCrash_CSV;
		CRASH_PERSONS_input := Files(pVersion).inputCrashPersons_CSV;
		CRASH_VEHICLES_input := Files(pVersion).inputCrashVehicle_CSV;
					
		CRASH_add_input  := CRASH_input(STD.Str.ToUpperCase(action) = 'ADD');
		CRASH_delete_input := CRASH_input(STD.Str.ToUpperCase(action) = 'DELETE'); 	
		
		filename := pVersion;
		geo_crash:= DEDUP(Geocode.MAC_GeoCrash(filename,CRASH_add_input),ac_dataproviderID, ac_address,all):independent;
		crash_ext:= Update_Input.MAC_Crash_Ext(CRASH_add_input,geo_crash);
		crash:= Update_Input.MAC_Crash(crash_ext);
		crash_persons := Update_Input.MAC_Crash_Persons(CRASH_PERSONS_input);
		crash_vehicles:= Update_Input.MAC_Crash_Vehicles(CRASH_VEHICLES_input);
		crash_deletes:= Update_Input.MAC_deletes_crash(CRASH_delete_input);
		dtImport := (STRING8)Std.Date.Today();
		Bair.MAC_IMPORT_Summary(crash_ext , _Constants.file_types[8], filename, dtImport, crash_outrec);

		//BUILD INPUTS
		return sequential(
				Build_Base.MAC_Build_Input(crash, bair.layouts.crash_dbo_crash_In,Filenames(pVersion).baseCrash.new,_Dataset().thor_cluster_files + _Constants.crash_built,_Constants.crash_filter,true),
				Build_Base.MAC_Build_Input(crash_persons, bair.layouts.crash_dbo_person_In,Filenames(pVersion).baseCrashPersons.new,_Dataset().thor_cluster_files + _Constants.crash_person_built,_Constants.crash_filter ,true),
				Build_Base.MAC_Build_Input(crash_vehicles,bair.layouts.crash_dbo_vehicle_In,Filenames(pVersion).baseCrashVehicles.new,_Dataset().thor_cluster_files + _Constants.crash_vehicle_built,_Constants.crash_filter ,true),
				
				BuildNewLogicalFile(Filenames(pVersion).baseCrashLNAddressCache.new, geo_crash, false),
				BuildNewLogicalFile(Filenames(pVersion).baseCrashDeletes.new, crash_deletes, false),
				BuildNewLogicalFile(Filenames(pVersion).baseCrashStatsReport.new, crash_outrec, false),

				Promote.Promote_Crash(pVersion).buildfiles.New2Built,
				Promote.Promote_Crash(pVersion).buildfiles.Built2QA,
		);
	END;
	EXPORT build_lpr(string pVersion) := FUNCTION
		IMPORT STD;

		LPR_input := Files(pVersion).inputLPR_CSV;
		
		filename:= pVersion;

		lpr_ext:=Update_Input.MAC_Lpr_Ext(LPR_input);
		lpr:=  Update_Input.MAC_Lpr(lpr_ext);

		//BUILD INPUTS
		RETURN sequential(
			Build_Base.MAC_Build_Input(lpr, bair.layouts.lpr_dbo_LicensePlate_In,Filenames(pVersion).baseLPR.new,_Dataset().thor_cluster_files + _Constants.lpr_built,_Constants.lpr_filter,true),
			
			Promote.Promote_LPR(pVersion).buildfiles.New2Built,
			Promote.Promote_LPR(pVersion).buildfiles.Built2QA,
		);
	END;
	
	EXPORT build_offenders(string pVersion) := FUNCTION
		IMPORT STD;									

		OFFENDER_input := Files(pVersion).inputOffender_CSV;
		CLASSIFICATION__input := Files(pVersion).inputOffenderClass_CSV;
		PICTURES_input := Files(pVersion).inputOffenderPicture_CSV;
		
		OFFENDER_add_input  := OFFENDER_input(STD.Str.ToUpperCase(action) = 'ADD');
		OFFENDER_delete_input := OFFENDER_input(STD.Str.ToUpperCase(action) = 'DELETE');
		
		filename:= pVersion;

		geo_offenders:=DEDUP( Geocode.MAC_GeoOffender(filename,OFFENDER_add_input ), all ):INDEPENDENT;
		offenders_ext:= Update_Input.MAC_Offender_Ext(OFFENDER_add_input,geo_offenders);		
		offenders:= Update_Input.MAC_Offender(offenders_ext);
		classifications:= Update_Input.MAC_Offender_Class(CLASSIFICATION__input);
		pictures:= Update_Input.MAC_Offender_Picture(PICTURES_input);
		offender_deletes:= Update_Input.MAC_deletes_offenders(OFFENDER_delete_input);
		dtImport := (STRING8)Std.Date.Today();
		Bair.MAC_IMPORT_Summary(offenders_ext , _Constants.file_types[14], filename, dtImport, offenders_outrec);

		//BUILD INPUTS
		RETURN
		 sequential(
			 Build_Base.MAC_Build_Input(offenders,bair.layouts.Offenders_dbo_offender_In,Filenames(pVersion).baseOffenders.new,_Dataset().thor_cluster_files + _Constants.offender_built,_Constants.offenders_filter,true),
			 Build_Base.MAC_Build_Input(classifications,bair.layouts.Offenders_dbo_offender_classification_In,Filenames(pVersion).baseOffendersClassification.new,_Dataset().thor_cluster_files + _Constants.offender_class_built,_Constants.offenders_filter,true),
			 Build_Base.MAC_Build_Input(pictures,bair.layouts.Offenders_dbo_offender_picture_In,Filenames(pVersion).baseOffendersPicture.new,_Dataset().thor_cluster_files + _Constants.offender_pic_built,_Constants.offenders_filter ,true),
			 
			 BuildNewLogicalFile(Filenames(pVersion).baseOffendersLNAddressCache.new, geo_offenders, false),
			 BuildNewLogicalFile(Filenames(pVersion).baseOffendersDeletes.new, offender_deletes, false),
			 BuildNewLogicalFile(Filenames(pVersion).baseOffendersStatsReport.new, offenders_outrec, false),
			 
			 Promote.Promote_Offender(pVersion).buildfiles.New2Built,
			 Promote.Promote_Offender(pVersion).buildfiles.Built2QA,
		);
	END;
	
	EXPORT build_commons(string pVersion) := FUNCTION
		
		deletes 	:= files(pVersion).BaseEventDeletes.new + files(pVersion).BaseCFSDeletes.new + files(pVersion).BaseCrashDeletes.new + files(pVersion).BaseOffendersDeletes.new; 
		stats 		:= files(pVersion).BaseEventStatsReport.new + files(pVersion).BaseCFSStatsReport.new + files(pVersion).BaseCrashStatsReport.new + files(pVersion).BaseOffendersStatsReport.new;
		
		new_addresses := files(pVersion).baseEventLNAddressCache.new 
											+ files(pVersion).baseCFSLNAddressCache.new 
											+ files(pVersion).baseCrashLNAddressCache.new 
											+ files(pVersion).baseOffendersLNAddressCache.new;
											
		sort_addresses 	:= sort	( new_addresses	, ac_dataProviderID, ac_address );		
		dedup_addreses 	:= dedup( sort_addresses, ac_dataProviderID, ac_address);
		
		geo_logs  :=
			files(pVersion).baseEventGeocodingLog.new + 
			files(pVersion).baseCFSGeocodingLog.new + 
			files(pVersion).baseCrashGeocodingLog.new + 
			files(pVersion).baseOffendersGeocodingLog.new;
		
		SumRec:=RECORD
			unsigned8 datetime := MAX(GROUP,geo_logs.datetime);
			geo_logs.file;
			unsigned4 counts:=SUM(GROUP,geo_logs.counts);
		END;

		geo_log:= TABLE(geo_logs, SumRec,file);
		
		
		RETURN
			sequential(
				Build_Base.MAC_Build_Input(dedup_addreses(ac_originated != 'OFFLINE'), layouts.address_cache, Filenames(pVersion).baseLNAddressCache.new, _Dataset().thor_cluster_files + _Constants.address_cache_built,	_Constants.address_cache_filter, false);
				Build_Base.MAC_Build_Input(stats, bair.raidsReport_Layout.raidsReportRec,	Filenames(pVersion).baseStatsReport.new, _Dataset().thor_cluster_files + _Constants.event_stats_built, _Constants.event_stats_filter, false),
				Build_Base.MAC_Build_Input(deletes, bair.layouts.Agency_Deletes, Filenames(pVersion).baseDeletes.new, _Dataset().thor_cluster_files + _Constants.deletes_built, _Constants.delete_filter , true),
				Build_Base.MAC_Build_Input_Log(geo_log,	layouts.geocoding_log, Filenames(pVersion).baseGeocodingLog.new, _Dataset().thor_cluster_files + _Constants.geocodingLog_built,	_Constants.geocodingLog_filter , false),

				Promote.Promote_Common(pVersion).buildfiles.New2Built,
				Promote.Promote_Common(pVersion).buildfiles.Built2QA,
			);
	END;

END; 

