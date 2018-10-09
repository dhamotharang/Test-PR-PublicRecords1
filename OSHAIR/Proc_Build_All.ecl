import _Control, RoxieKeyBuild, orbit_report, _validate, Orbit3, dops;

export Proc_Build_All(string filedate, string version) := function

	process_date 				:= if(_validate.date.fIsValid((string) version[1..8]) and 
														_validate.date.fIsValid((string) version[1..8],_validate.date.rules.DateInPast)
														, (string) version[1..8]
														, ERROR('Error: Version must be a valid date and cannot be a future date, but can have a letter appended: ' + version)
													 );
																				 
	spray_files 				:= oshair.spray_oshair_inputfile(filedate);
	clean_data 					:= oshair.clean_oshair_data(version, process_date):FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com; darren.knowles@lexisnexisrisk.com','Oshair Build Failure/CLEAN DATA: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
	build_keys 					:= oshair.proc_build_oshair_keys(version):FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com; darren.knowles@lexisnexisrisk.com','Oshair Build Failure/BUILD KEYS: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
	boolean_build 			:= oshair.proc_build_boolean_keys(version):FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com; darren.knowles@lexisnexisrisk.com','Oshair Build Failure/BUILD BOOLEAN KEYS: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
	qa_samples     			:= oshair.proc_qa_samples:FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com; darren.knowles@lexisnexisrisk.com','Oshair Build Failure/QA SAMPLES: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));

	orbit_report.oshair_stats(getretval);
	
	oshair.out_file_oshair_stats_population(oshair.file_out_inspection_cleaned_both
																					,oshair.file_out_accident_cleaned
																					,oshair.file_out_hazardous_substance_cleaned
																					,oshair.file_out_optional_info_cleaned
																					,oshair.file_out_program_cleaned
																					,oshair.file_out_related_activity_cleaned
																					,oshair.file_out_violations_cleaned
																					,filedate
																					,do_strata);

	//Update DOPS
	dops_update :=dops.updateversion('OshairKeys', version, _Control.MyInfo.EmailAddressNotify + ';darren.knowles@lexisnexisrisk.com',,'N|B'); 

	//Update ORBIT
	// Changed from CreateBuild to use CreateBuild_AddItem so that it adds the item at build time
	orbitUpdate := Orbit3.proc_Orbit3_CreateBuild_AddItem('OSHAIR',filedate,'N|B');
	return sequential(process_date, 
										spray_files,
										oshair.promote(filedate).Inputfiles.Sprayed2Using,
										clean_data,
										// Generate the other OSHA base files 
										oshair.normalize_child_datasets(version, process_date),
										oshair.promote(version).buildfiles.new2built,
										build_keys,
										boolean_build,
										dops_update,
										qa_samples,
										do_STRATA,
										orbitUpdate,
										getretval,
										oshair.promote(version).buildfiles.built2Qa,									
										oshair.promote(filedate).Inputfiles.Using2used
								   );

end;