import versioncontrol, _control, ut, tools, std, did_add, nac;

export Build_All_Mockup(string pBuildname, string version, boolean pUseProd = false, boolean pUseDelta = false) := function

	// Spraying
	STRING36  	oLogin			:= Bair.Bair_Orbit.login.creds		: INDEPENDENT	;
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'Spraying');
	Bair.Orbit_Module_Candidates.fn_updateDailyFileStatus(pBuildName,version,'','Spraying',oLogin);
	// wl:=nothor(WorkunitServices.WorkunitList('',jobname:='Bair as Ingenix Build*'))(state in ['blocked','running','wait']);
	// version := ut.GetDate : global;
	
	// if(exists(wl),fail('Bair as Ingenix Build is running'));
	
	// spray_  			:= VersionControl.fSprayInputFiles(fSpray(version,pUseProd));
	Bair.Orbit_Module_Candidates.fn_updateDailyFileStatus(pBuildName,version,'','Sprayed',oLogin);
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'Sprayed');
	
	// CreatingKeys
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'CreatingKeys');
	
	Bair.Orbit_Module_Candidates.fn_updateDailyFileStatus(pBuildName,version,'Person','CreatingKeys',oLogin);
	Bair.Orbit_Module_Candidates.fn_updateDailyFileStatus(pBuildName,version,'Vehicle','CreatingKeys',oLogin);
	
	// cfs_delta			:= bair._Dataset(pUseProd).thor_cluster_files + 'base::' + bair._Dataset().name + '::dbo::cfs::delta::built';
	// mo_delta			:= bair._Dataset(pUseProd).thor_cluster_files + 'base::' + bair._Dataset().name + '::dbo::mo::delta::built';
	// per_delta			:= bair._Dataset(pUseProd).thor_cluster_files + 'base::' + bair._Dataset().name + '::dbo::persons::delta::built';
	// veh_delta			:= bair._Dataset(pUseProd).thor_cluster_files + 'base::' + bair._Dataset().name + '::dbo::vehicle::delta::built';
	// lpr_delta			:= bair._Dataset(pUseProd).thor_cluster_files + 'base::' + bair._Dataset().name + '::dbo::licenseplateevent::delta::built';
	
	// ProdVer				:= did_add.get_EnvVariable('header_build_version')[1..8];
	// flag					:= dataset(bair.Superfile_List().Flag,{string8 Prod_Ver},flat,opt);
	// NewHeader 		:= if(nothor(fileservices.fileExists(bair.Superfile_List().Flag)),ProdVer <> flag[1].Prod_Ver,true);

	// BuildBase			:= parallel(				
										// bair.Build_Base.build_base_cfs(version,pUseProd,pUseDelta,NewHeader).cfs_all,
										// bair.Build_Base.build_base_mo(version,pUseProd,pUseDelta,NewHeader).mo_all,
										// bair.Build_Base.build_base_persons(version,pUseProd,pUseDelta,NewHeader).persons_all,
										// bair.Build_Base.build_base_vehicle(version,pUseProd,pUseDelta,NewHeader).vehicle_all,
										// bair.Build_Base.build_base_group_access(version,pUseProd,false,NewHeader).group_access_all,
										// bair.Build_Base.build_base_intel(version,pUseProd,false,NewHeader).intel_all,
										// bair.Build_Base.build_base_offenders(version,pUseProd,false,NewHeader).offenders_all,
										// bair.Build_Base.build_base_crash(version,pUseProd,false,NewHeader).crash_all,
										// bair.Build_Base.build_base_LPR(version,pUseProd,pUseDelta,NewHeader).LPR_all,
										// bair.Build_Base.build_base_Shotspotter(version,false,false,NewHeader).Shotspotter_all,
										// );	
	// BuildKeys			:= parallel(
										// bair.Build_Keys.Build_Keys_Cfs(version,pUseProd,pUseDelta).Cfs_All,
										// bair.Build_Keys.Build_Keys_mo(version,pUseProd,pUseDelta).mo_All,
										// bair.Build_Keys.Build_Keys_persons(version,pUseProd,pUseDelta).persons_All,
										// bair.Build_Keys.Build_Keys_vehicle(version,pUseProd,pUseDelta).vehicle_All,
										// bair.Build_Keys.Build_Keys_group_access(version,pUseProd,false).group_access_All,								
										// bair.Build_Keys.Build_Keys_Intel(version,pUseProd,false).Intel_All,
										// bair.Build_Keys.Build_Keys_Offenders(version,pUseProd,false).Offenders_All,							
										// bair.Build_Keys.Build_Keys_Crash(version,pUseProd,false).Crash_All,
										// bair.Build_Keys.Build_Keys_LPR(version,pUseProd,pUseDelta).LPR_All,
										// bair.Build_Keys.Build_Keys_Shotspotter(version,pUseProd,false).Shotspotter_All,
										// bair.Build_Keys.Build_Keys_Notes(version,pUseProd,false).Notes_All
										// );
	// PromoteFiles	:= parallel(
										// bair.Promote.Promote_cfs(version,pUseProd,pUseDelta).buildfiles.Built2QA,
										// bair.Promote.Promote_mo(version,pUseProd,pUseDelta).buildfiles.Built2QA,
										// bair.Promote.Promote_persons(version,pUseProd,pUseDelta).buildfiles.Built2QA,
										// bair.Promote.Promote_vehicle(version,pUseProd,pUseDelta).buildfiles.Built2QA,
										// bair.Promote.Promote_group_access(version,pUseProd,false).buildfiles.Built2QA,
										// bair.Promote.Promote_intel(version,pUseProd,false).buildfiles.Built2QA,
										// bair.Promote.Promote_offenders(version,pUseProd,false).buildfiles.Built2QA,
										// bair.Promote.Promote_crash(version,pUseProd,false).buildfiles.Built2QA,
										// bair.Promote.Promote_LPR(version,pUseProd,pUseDelta).buildfiles.Built2QA,
										// bair.Promote.Promote_Shotspotter(version,pUseProd,false).buildfiles.Built2QA,
										// bair.Promote.Promote_Notes(version,pUseProd,false).buildfiles.Built2QA,
										// );
	// ClearDeltaBaseFiles := sequential(
									//Full Update on 7th day
									// FileServices.StartSuperFileTransaction(),
										// FileServices.RemoveOwnedSubFiles(cfs_delta,true),
										// FileServices.ClearSuperFile(cfs_delta),
										// FileServices.RemoveOwnedSubFiles(mo_delta,true),
										// FileServices.ClearSuperFile(mo_delta),
										// FileServices.RemoveOwnedSubFiles(per_delta,true),
										// FileServices.ClearSuperFile(per_delta),
										// FileServices.RemoveOwnedSubFiles(veh_delta,true),
										// FileServices.ClearSuperFile(veh_delta),
										// FileServices.RemoveOwnedSubFiles(lpr_delta,true),
										// FileServices.ClearSuperFile(lpr_delta),
									// FileServices.FinishSuperFileTransaction()
										// );
										
	// ClearInputFiles := sequential(
									// FileServices.StartSuperFileTransaction(),								
										// FileServices.AddSuperFile(Filenames(version,pUseProd).cfs_dbo_cfs_2_lInputHistTemplate,  Filenames(version,pUseProd).cfs_dbo_cfs_2_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).cfs_dbo_cfs_officers_2_lInputHistTemplate,  Filenames(version,pUseProd).cfs_dbo_cfs_officers_2_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_mo_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_mo_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_persons_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_persons_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_vehicle_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_vehicle_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_import_group_access_lInputHistTemplate,  Filenames(version,pUseProd).event_import_group_access_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_mo_udf_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_mo_udf_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_persons_udf_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_persons_udf_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_data_provider_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_data_provider_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).event_dbo_data_provider_location_lInputHistTemplate,  Filenames(version,pUseProd).event_dbo_data_provider_location_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_entity_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_entity_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_entity_notes_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_entity_notes_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_incident_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_incident_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_incident_notes_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_incident_notes_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_reporting_officer_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_reporting_officer_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_vehicle_notes_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_vehicle_notes_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).intel_dbo_entity_photo_lInputHistTemplate,  Filenames(version,pUseProd).intel_dbo_entity_photo_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).offenders_dbo_classification_lInputHistTemplate,  Filenames(version,pUseProd).offenders_dbo_classification_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).offenders_dbo_offender_classification_lInputHistTemplate,  Filenames(version,pUseProd).offenders_dbo_offender_classification_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).offenders_dbo_offender_lInputHistTemplate,  Filenames(version,pUseProd).offenders_dbo_offender_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).offenders_dbo_person_lInputHistTemplate,  Filenames(version,pUseProd).offenders_dbo_person_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).crash_dbo_crash_lInputHistTemplate,  Filenames(version,pUseProd).crash_dbo_crash_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).crash_dbo_person_lInputHistTemplate,  Filenames(version,pUseProd).crash_dbo_person_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).crash_dbo_vehicle_lInputHistTemplate,  Filenames(version,pUseProd).crash_dbo_vehicle_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).lpr_dbo_licenseplateevent_lInputHistTemplate,  Filenames(version,pUseProd).lpr_dbo_licenseplateevent_lInputTemplate,,true),
										// FileServices.AddSuperFile(Filenames(version,pUseProd).gunop_dbo_shot_incident_lInputHistTemplate,  Filenames(version,pUseProd).gunop_dbo_shot_incident_lInputTemplate,,true),									
									
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).cfs_dbo_cfs_2_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).cfs_dbo_cfs_officers_2_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_mo_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_vehicle_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_persons_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_mo_udf_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_persons_udf_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_data_provider_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).event_dbo_data_provider_location_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_entity_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_entity_notes_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_incident_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_incident_notes_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_reporting_officer_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_vehicle_notes_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).intel_dbo_entity_photo_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).offenders_dbo_classification_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).offenders_dbo_offender_classification_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).offenders_dbo_offender_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).offenders_dbo_person_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).crash_dbo_crash_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).crash_dbo_person_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).crash_dbo_vehicle_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).lpr_dbo_licenseplateevent_lInputTemplate,true),
										// FileServices.RemoveOwnedSubFiles(Filenames(version,pUseProd).gunop_dbo_shot_incident_lInputTemplate,true),
									
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).cfs_dbo_cfs_2_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).cfs_dbo_cfs_officers_2_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_mo_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_vehicle_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_persons_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_mo_udf_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_persons_udf_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_data_provider_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).event_dbo_data_provider_location_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_entity_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_entity_notes_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_incident_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_incident_notes_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_reporting_officer_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_vehicle_notes_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).intel_dbo_entity_photo_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).offenders_dbo_classification_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).offenders_dbo_offender_classification_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).offenders_dbo_offender_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).offenders_dbo_person_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).crash_dbo_crash_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).crash_dbo_person_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).crash_dbo_vehicle_lInputTemplate),	
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).lpr_dbo_licenseplateevent_lInputTemplate),
										// FileServices.ClearSuperFile(Filenames(version,pUseProd).gunop_dbo_shot_incident_lInputTemplate),
									// FileServices.FinishSuperFileTransaction()
										// );
	
	// ut.MAC_SF_BuildProcess(Build_base(version),Superfile_List().Base, BuildBase ,2,,true,pVersion:=version);

	// NewVer				:= dataset([{ProdVer}],{string8 Prod_Ver});
	// ut.MAC_SF_BuildProcess(NewVer,bair.Superfile_List().Flag, PostIt ,2,,true,pVersion:=version);
	
	// Build_Bair		:= if(NewHeader and pUseDelta = false
											// ,sequential(
														// output('New Header in Prod.  Full File Will ADL', named('NewHeader_true'))
														// ,BuildBase
														// ,ClearDeltaBaseFiles
														// ,PostIt)
											// ,sequential(
														// output('No New Header in Prod.  Only New Data Will ADL',named('NewHeader_false'))
														// ,BuildBase)
											// );
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'KeysCreated');										
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'Deploying');							
	// built := 	sequential(
							//Spray all input files
							// spray_,
							//Build base Files
							// Build_Bair,
   						// all the base files have been built, now the keys can be built (in any order or simultaneously)
   						// BuildKeys,
   						// after the keys have been built, the files can be moved to the appropriate superfiles
   						// PromoteFiles,						
							// Bair.BWR_Build_RTree_GeoHash.Build_RTree_GeoHash(version, pUseProd, 2), //for geohash
						// parallel(
								// Promote.Promote_GeoHash(version, pUseProd).buildfiles.New2Built;
								// Promote.Promote_Geohash(version,pUseProd).buildfiles.Built2QA,
							// ),						
						// Build_Strata(version,pUseProd).all,
						//Archive processed files in history
							// ClearInputFiles,
							// if(pUseDelta = false, ClearDeltaBaseFiles),
							// ClearDeltaBaseFiles,
						// );// : success(Send_Email(version,pUseProd).BuildSuccess), failure(send_email(version,pUseProd).BuildFailure);
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'Deployed');	
	bair.BAIR_Orbit.UpdateDailyBuildStatus(pBuildname,version,'Built');	
	built := 'BuildName: ' + pBuildname + ', Version: ' +  version + ' | Build Successed';
	return built;
end;