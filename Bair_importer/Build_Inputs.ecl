EXPORT Build_Inputs(
	string pBuildName,//aurorapd_EVENT_input_prep
	string pFileVersion,//20151224_091102003_2
	string dtImport,//20151224
	string pAgency,//263
	string pFileType,//EVENT
	string pFileExtension//  XML
) := MODULE

	EXPORT build_events(event_mo_filename, event_mo_layout, event_mo_format, 
									    event_persons_filename, event_persons_layout, event_persons_format,
											event_vehicles_filename, event_vehicles_layout, event_vehicles_format) := FUNCTIONMACRO

		#uniquename(EVENT_MO_input)
		#uniquename(EVENT_PERSONS_input)
		#uniquename(EVENT_VEHICLES_input)
		
		#uniquename(FileExtension)
		%FileExtension% := pFileExtension;
		
		// STD.File.GetSuperFileSubCount(bair_importer.Filenames().lInputTemplateEVENT_VEHICLES_CSV);
		
		cnt := nothor(STD.File.GetSuperFileSubCount(event_vehicles_filename));
		
		%EVENT_MO_input% := dataset(event_mo_filename,event_mo_layout,#EXPAND(event_mo_format));
		%EVENT_PERSONS_input% := dataset(event_persons_filename, event_persons_layout, #EXPAND(event_persons_format));
		%EVENT_VEHICLES_input% := if(cnt = 0, dataset([],event_vehicles_layout), dataset(event_vehicles_filename, event_vehicles_layout, #EXPAND(event_vehicles_format)));
		EVENT_MO_add_input  := %EVENT_MO_input%(STD.Str.ToUpperCase(action) = 'ADD');
		EVENT_MO_delete_input := %EVENT_MO_input%(STD.Str.ToUpperCase(action) = 'DELETE'); 		
		//GET DATA FROM XML FILES
		filename:= pBuildName+'_'+pFileVersion;
		geo_addresses := bair_importer.Geocode.MAC_GeoEvent( filename,EVENT_MO_add_input,%EVENT_PERSONS_input%,%EVENT_VEHICLES_input%,  pAgency );
		mos_ext:= bair_importer.Update_Input.MAC_EventMosExt( EVENT_MO_add_input, pAgency, geo_addresses);
		persons_ext := bair_importer.Update_Input.MAC_EventPersonsExt(%EVENT_PERSONS_input%, pFileVersion, geo_addresses);
		vehicles_ext:= bair_importer.Update_Input.MAC_EventVehiclesExt(%EVENT_VEHICLES_input%, pFileVersion, geo_addresses);
		//Finals
		mos:= bair_importer.Update_Input.MAC_EventMos(mos_ext(DoNotImport=FALSE) );
		mos_udf:= bair_importer.Update_Input.MAC_EventMosUDF( mos_ext(DoNotImport=FALSE) );
		persons:= bair_importer.Update_Input.MAC_EventPersons(persons_ext);
		persons_udf:= bair_importer.Update_Input.MAC_EventPersonsUDF( persons_ext );
		vehicles:= bair_importer.Update_Input.MAC_EventVehicles( vehicles_ext);
		mos_deletes:= bair_importer.Update_Input.MAC_deletes_events(EVENT_MO_delete_input);
		//mos_do_not_import:= mos_ext(DoNotImport=TRUE);
		//RUN STATS
		Bair.MAC_IMPORT_Summary(mos_ext, bair_importer._Constants.file_types[1], filename, dtImport, mo_outrec);
		Bair.MAC_IMPORT_Summary(persons_ext, bair_importer._Constants.file_types[2], filename, dtImport, persons_outrec);
		Bair.MAC_IMPORT_Summary(vehicles_ext, bair_importer._Constants.file_types[3], filename, dtImport, vehicle_outrec);
		//Bair.MAC_IMPORT_Summary(mos_deletes, bair_importer._Constants.file_types[4], filename, dtImport, mos_deletes_outrec);
		Stats_Event := bair_importer.Build_Base.MAC_Build_Stats_Event( mo_outrec,persons_outrec,vehicle_outrec );
		Orbit_Builds := dataset([{filename}],bair_importer.layouts.orbitbuilds_layout);
		
		MO  := bair_importer.Validate_Input.fn_GetMORecordID();
		PER := bair_importer.Validate_Input.fn_GetPersonRecordID();
		//Bair.MAC_IMPORT_Summary(bair_importer.files(pFileVersion).event_delete, _Constants.file_types[4], filename, dtImport, deletes_outrec);

		//WRITE FILES
		RETURN 
		sequential(
			 bair_importer.Build_Base.MAC_Build_Input(geo_addresses, bair_importer.layouts.address_cache, bair_importer.Filenames(pFileVersion).baseLNAddressCache.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.address_cache_built,bair_importer._Constants.address_cache_filter,false);
			 bair_importer.Build_Base.MAC_Build_Input(mos, bair.layouts.event_dbo_mo_In,bair_importer.Filenames(pFileVersion).baseEventMO.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_mo_built, bair_importer._Constants.event_filter, true),
			 bair_importer.Build_Base.MAC_Build_Input(mos_udf, bair.layouts.event_dbo_mo_udf_In,bair_importer.Filenames(pFileVersion).baseEventMOUDF.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_mo_udf_built, bair_importer._Constants.event_udf_filter, true ),
			 bair_importer.Build_Base.MAC_Build_Input(persons, bair.layouts.event_dbo_persons_In,bair_importer.Filenames(pFileVersion).baseEventPersons.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_persons_built, bair_importer._Constants.event_filter, true ),
			 bair_importer.Build_Base.MAC_Build_Input(persons_udf, bair.layouts.event_dbo_persons_udf_In, bair_importer.Filenames(pFileVersion).baseEventPersonsUDF.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_persons_udf_built,bair_importer._Constants.event_udf_filter,true),
			 bair_importer.Build_Base.MAC_Build_Input(vehicles,bair.layouts.event_dbo_vehicle_In, bair_importer.Filenames(pFileVersion).baseEventVehicles.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_vehicles_built, bair_importer._Constants.event_filter, true ), 
			 bair_importer.Build_Base.MAC_Build_Input(mos_deletes, bair.layouts.Agency_Deletes,bair_importer.Filenames(pFileVersion).baseDeletes.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.deletes_built,bair_importer._Constants.delete_filter,true ), 
			 bair_importer.Build_Base.MAC_Build_Input(Stats_Event, bair.raidsReport_Layout.raidsReportRec, bair_importer.Filenames(pFileVersion).baseStatsReport.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_stats_built,bair_importer._Constants.event_stats_filter,false),
			 bair_importer.Build_Base.MAC_Build_Input(Orbit_Builds,bair_importer.layouts.orbitbuilds_layout,bair_importer.Filenames(pFileVersion).baseOrbitBuilds.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.orbitbuilds_built, bair_importer._Constants.orbitbuilds_filter,false),
			 bair_importer.Validate_Input.fn_SetRecordID_RAIDS(
										max(max(mos_ext,mos_ext.recordID_RAIDS),MO)
									 ,max(max(persons_ext,persons_ext.recordID_RAIDS),PER)
									 ,pFileVersion);
			 Bair_Importer.Promote.Promote_Event(pFileVersion).buildfiles,
		);
	ENDMACRO;

	EXPORT build_cfs(cfs_filename, cfs_layout, cfs_format, 
									 officers_filename, officers_layout, officer_format):=FUNCTIONMACRO

		#uniquename(CFS_input)
		#uniquename(CFSOFFICERS_input)
		
		#uniquename(FileExtension)
		%FileExtension% := pFileExtension;
		
		%CFS_input% := dataset(cfs_filename,cfs_layout,#EXPAND(cfs_format));
		%CFSOFFICERS_input% := dataset(officers_filename, officers_layout, #EXPAND(officer_format));

		filename:= pBuildName+'_'+pFileVersion;
		CFS_add_input  := %CFS_input%(STD.Str.ToUpperCase(action) = 'ADD');
		CFS_delete_input := %CFS_input%(STD.Str.ToUpperCase(action) = 'DELETE'); 
		//GET DATA FROM XML FILES
		geo_addresses := bair_importer.Geocode.MAC_GeoCFS(filename,CFS_add_input, pAgency);
		cfs_ext:= bair_importer.Update_Input.MAC_Cfs_Ext(CFS_add_input,%CFSOFFICERS_input%,pFileType, pAgency,geo_addresses);
		//Finals
		cfs:= bair_importer.Update_Input.MAC_Cfs(cfs_ext(initial_DoNotImport=FALSE AND final_DoNotImport=FALSE));
		officers := bair_importer.Update_Input.MAC_Cfs_officers(%CFSOFFICERS_input%, pFileType);
		cfs_do_not_import:= cfs_ext(initial_DoNotImport=TRUE or final_DoNotImport=TRUE);
		cfs_deletes := bair_importer.Update_Input.MAC_deletes_cfs(CFS_delete_input);
		//RUN STATS
		Bair.MAC_IMPORT_Summary(cfs_ext(initial_DoNotImport=FALSE AND final_DoNotImport=FALSE) , bair_importer._Constants.file_types[5], filename, dtImport, cfs_outrec);
		Orbit_Builds := dataset([{filename}],bair_importer.layouts.orbitbuilds_layout);
		//BUILD INPUTS
		RETURN
		sequential(
			bair_importer.Build_Base.MAC_Build_Input(geo_addresses, bair_importer.layouts.address_cache, bair_importer.Filenames(pFileVersion).baseLNAddressCache.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.address_cache_built,bair_importer._Constants.address_cache_filter,false),
			bair_importer.Build_Base.MAC_Build_Input(cfs, bair.layouts.cfs_dbo_cfs_2_In, bair_importer.Filenames(pFileVersion).baseCFS.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.cfs_built, bair_importer._Constants.cfs_filter, true),
			bair_importer.Build_Base.MAC_Build_Input(officers, bair.layouts.cfs_dbo_cfs_officers_2_In,bair_importer.Filenames(pFileVersion).baseCFSOfficers.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.cfs_officers_built, bair_importer._Constants.cfs_filter,true),
			//CREATE DELETES
			bair_importer.Build_Base.MAC_Build_Input(cfs_deletes, bair.layouts.Agency_Deletes, bair_importer.Filenames(pFileVersion).baseDeletes.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.deletes_built,bair_importer._Constants.delete_filter,true),
			//WRITE STATS
			bair_importer.Build_Base.MAC_Build_Input(cfs_outrec, bair.raidsReport_Layout.raidsReportRec, bair_importer.Filenames(pFileVersion).baseStatsReport.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_stats_built, bair_importer._Constants.event_stats_filter, false),
			//GROUP ORBIT BUILDS
			bair_importer.Build_Base.MAC_Build_Input(Orbit_Builds, bair_importer.layouts.orbitbuilds_layout, bair_importer.Filenames(pFileVersion).baseOrbitBuilds.new, bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.orbitbuilds_built, bair_importer._Constants.orbitbuilds_filter, false),
			Bair_Importer.Promote.Promote_CFS(pFileVersion).buildfiles,
		);

	ENDMACRO;
	EXPORT build_crash() := MODULE
		filename := pBuildName+'_'+pFileVersion;
		//GET DATA FROM XML FILES
		geo_crash:= DEDUP(bair_importer.Geocode.MAC_GeoCrash(filename,pFileVersion,pAgency)):INDEPENDENT;
		crash_ext:= bair_importer.Update_Input.MAC_Crash_Ext(filename,pFileVersion,pAgency,geo_crash);
		crash:= bair_importer.Update_Input.MAC_Crash(crash_ext);
		crash_persons := bair_importer.Update_Input.MAC_Crash_Persons(filename,pFileVersion,pAgency);
		crash_vehicles:= bair_importer.Update_Input.MAC_Crash_Vehicles(filename,pFileVersion,pAgency);
		crash_deletes:= bair_importer.Update_Input.MAC_deletes_crash(filename,pFileVersion,pAgency);
		//RUN STATS
		Bair.MAC_IMPORT_Summary(crash_ext , _Constants.file_types[8], filename, dtImport, crash_outrec);
		Orbit_Builds := dataset([{filename}],bair_importer.layouts.orbitbuilds_layout);

		//BUILD INPUTS
		EXPORT Build_Crash :=
		 sequential(
				bair_importer.Build_Base.MAC_Build_Input(geo_crash,bair_importer.layouts.address_cache,bair_importer.Filenames(pFileVersion).baseLNAddressCache.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.address_cache_built,bair_importer._Constants.address_cache_filter,false);
				bair_importer.Build_Base.MAC_Build_Input(crash, bair.layouts.crash_dbo_crash_In,bair_importer.Filenames(pFileVersion).baseCrash.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.crash_built,bair_importer._Constants.crash_filter,true),
				bair_importer.Build_Base.MAC_Build_Input(crash_persons, bair.layouts.crash_dbo_person_In,bair_importer.Filenames(pFileVersion).baseCrashPersons.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.crash_person_built,bair_importer._Constants.crash_filter ,true),
				bair_importer.Build_Base.MAC_Build_Input(crash_vehicles,bair.layouts.crash_dbo_vehicle_In,bair_importer.Filenames(pFileVersion).baseCrashVehicles.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.crash_vehicle_built,bair_importer._Constants.crash_filter ,true),
				//CREATE DELETES
				bair_importer.Build_Base.MAC_Build_Input(crash_deletes, bair.layouts.Agency_Deletes,bair_importer.Filenames(pFileVersion).baseDeletes.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.deletes_built,bair_importer._Constants.delete_filter ,true),
				//WRITE STATS
				bair_importer.Build_Base.MAC_Build_Input(crash_outrec,bair.raidsReport_Layout.raidsReportRec,bair_importer.Filenames(pFileVersion).baseStatsReport.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_stats_built,bair_importer._Constants.event_stats_filter,false),
				//GROUP ORBIT BUILDS
				bair_importer.Build_Base.MAC_Build_Input(Orbit_Builds,bair_importer.layouts.orbitbuilds_layout,bair_importer.Filenames(pFileVersion).baseOrbitBuilds.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.orbitbuilds_built,bair_importer._Constants.orbitbuilds_filter,false),
				Bair_Importer.Promote.Promote_Crash(pFileVersion).buildfiles,
		);
	END;
	EXPORT build_lpr(LPR_filename, LPR_layout, LPR_format) := FUNCTIONMACRO

		#uniquename(LPR_input)
		%LPR_input% := dataset(LPR_filename,LPR_layout,#EXPAND(LPR_format));

		filename:= pBuildName+'_'+pFileVersion;

		//GET DATA FROM XML FILES
		lpr_ext:=bair_importer.Update_Input.MAC_Lpr_Ext(%LPR_input%, pFileType,pAgency);
		lpr:=  bair_importer.Update_Input.MAC_Lpr(lpr_ext);
		Orbit_Builds := dataset([{filename}],bair_importer.layouts.orbitbuilds_layout);

		//BUILD INPUTS
		RETURN sequential(
			bair_importer.Build_Base.MAC_Build_Input(lpr, bair.layouts.lpr_dbo_LicensePlate_In,bair_importer.Filenames(pFileVersion).baseLPR.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.lpr_built,bair_importer._Constants.lpr_filter,true),
			bair_importer.Build_Base.MAC_Build_Input(Orbit_Builds,bair_importer.layouts.orbitbuilds_layout,bair_importer.Filenames(pFileVersion).baseOrbitBuilds.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.orbitbuilds_built,bair_importer._Constants.orbitbuilds_filter,false),
			Bair_Importer.Promote.Promote_LPR(pFileVersion).buildfiles,
		);
	ENDMACRO;
	
	EXPORT build_offenders() := MODULE
		filename:= pBuildName+'_'+pFileVersion;
		//GET DATA FROM XML FILES
		geo_offenders:=DEDUP( bair_importer.Geocode.MAC_GeoOffender(filename,pFileVersion,pAgency) ):INDEPENDENT;
		offenders_ext:= bair_importer.Update_Input.MAC_Offender_Ext(filename,pFileVersion,pAgency,geo_offenders);
		offenders:= bair_importer.Update_Input.MAC_Offender(offenders_ext);
		classifications:= bair_importer.Update_Input.MAC_Offender_Class(filename,pFileVersion,pAgency);
		pictures:= bair_importer.Update_Input.MAC_Offender_Picture(filename,pFileVersion,pAgency);
		offender_deletes:= bair_importer.Update_Input.MAC_deletes_offenders(filename,pFileVersion,pAgency);
		//RUN STATS
		Bair.MAC_IMPORT_Summary(offenders_ext , _Constants.file_types[14], filename, dtImport, offenders_outrec);
		Orbit_Builds := dataset([{filename}],bair_importer.layouts.orbitbuilds_layout);

		//BUILD INPUTS
		EXPORT Build_Offenders :=
		 sequential(
			 bair_importer.Build_Base.MAC_Build_Input(geo_offenders,bair_importer.layouts.address_cache,bair_importer.Filenames(pFileVersion).baseLNAddressCache.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.address_cache_built,bair_importer._Constants.address_cache_filter,false);
			 bair_importer.Build_Base.MAC_Build_Input(offenders,bair.layouts.Offenders_dbo_offender_In,bair_importer.Filenames(pFileVersion).baseOffenders.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.offender_built,bair_importer._Constants.offenders_filter,true),
			 bair_importer.Build_Base.MAC_Build_Input(classifications,bair.layouts.Offenders_dbo_offender_classification_In,bair_importer.Filenames(pFileVersion).baseOffendersClassification.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.offender_class_built,bair_importer._Constants.offenders_filter,true),
			 bair_importer.Build_Base.MAC_Build_Input(pictures,bair.layouts.Offenders_dbo_offender_picture_In,bair_importer.Filenames(pFileVersion).baseOffendersPicture.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.offender_pic_built,bair_importer._Constants.offenders_filter ,true),
			 bair_importer.Build_Base.MAC_Build_Input(offender_deletes,bair.layouts.Agency_Deletes,bair_importer.Filenames(pFileVersion).baseDeletes.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.deletes_built,bair_importer._Constants.delete_filter ,true),
			 bair_importer.Build_Base.MAC_Build_Input(offenders_outrec,bair.raidsReport_Layout.raidsReportRec,bair_importer.Filenames(pFileVersion).baseStatsReport.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.event_stats_built,bair_importer._Constants.event_stats_filter,false),
			 //GROUP ORBIT BUILDS
			 bair_importer.Build_Base.MAC_Build_Input(Orbit_Builds,bair_importer.layouts.orbitbuilds_layout,bair_importer.Filenames(pFileVersion).baseOrbitBuilds.new,bair_importer._Dataset().thor_cluster_files + bair_importer._Constants.orbitbuilds_built,bair_importer._Constants.orbitbuilds_filter,false),
			 Bair_Importer.Promote.Promote_Offender(pFileVersion).buildfiles,
		);
	END;


	EXPORT Update_Daily_input := map (
		pFileType = 'EVENT' =>  if(
				pFileExtension = 'XML',
					build_events(Filenames().lInputTemplateEVENT_XML, layouts.SprayedEventMos_XML, 			_constants.xml_event_mo_format,
											 Filenames().lInputTemplateEVENT_XML, layouts.SprayedEventPersons_XML,	_constants.xml_event_persons_format,
											 Filenames().lInputTemplateEVENT_XML, layouts.SprayedEventVehicles_XML,	_constants.xml_event_vehicles_format),
					build_events(Filenames().lInputTemplateEVENT_MO_CSV, 			layouts.SprayedEventMos_CSV,			  _constants.csv_format,
											 Filenames().lInputTemplateEVENT_PERSONS_CSV, 	layouts.SprayedEventPersons_CSV,	_constants.csv_format,
											 Filenames().lInputTemplateEVENT_VEHICLES_CSV, layouts.SprayedEventVehicles_CSV,	_constants.csv_format)
		),
		//build_events().Build_Events,
		pFileType = 'CFS'=>  if(
				pFileExtension = 'XML',
					build_cfs(Filenames().lInputTemplateCFS_XML, layouts.SprayedCFS_XML, _constants.xml_cfs_format,
										Filenames().lInputTemplateCFS_XML, layouts.SprayedCFSOfficers_XML, _constants.xml_cfs_officers_format),
					build_cfs(Filenames().lInputTemplateCFS_CSV, layouts.SprayedCFS_CSV, _constants.csv_format,
										Filenames().lInputTemplateCFSOFFICERS_CSV, layouts.SprayedCFSOfficers_CSV,_constants.csv_format)
		),
		pFileType = 'CRASH' =>  build_crash().Build_Crash,
		pFileType = 'LPR'=> if(
				pFileExtension = 'XML',
					build_lpr(Filenames().lInputTemplateLPR_XML, layouts.SprayedLPR_XML, _constants.xml_lpr_format),
					build_lpr(Filenames().lInputTemplateLPR_CSV, layouts.SprayedLPR_CSV, _constants.csv_format)
		),
		pFileType = 'OFFENDER' =>build_offenders().Build_Offenders
	);

END; 
