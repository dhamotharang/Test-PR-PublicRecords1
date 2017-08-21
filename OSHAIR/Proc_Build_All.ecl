import _Control, RoxieKeyBuild, orbit_report, _validate, Orbit3;

export Proc_Build_All(string filedate, string version) := function

process_date := if(_validate.date.fIsValid((string) version[1..8]) and 
													 _validate.date.fIsValid((string) version[1..8],_validate.date.rules.DateInPast)
														, (string) version[1..8]
														, ERROR('Error: Version must be a valid date and cannot be a future date, but can have a letter appended: ' + version)
														);
											 
spray_files 				:= OSHAIR.spray_OSHAIR_inputfile(filedate);
clean_data 					:= OSHAIR.Clean_OSHAIR_data(version, process_date)	: FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com','Oshair Build Failure/CLEAN DATA: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
create_super_files 	:= oshair.Proc_Build_Super_Files(version) : FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com','Oshair Build Failure/CREATE SUPERFILES: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
build_keys 					:= OSHAIR.proc_build_OSHAIR_keys(version) : FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com','Oshair Build Failure/BUILD KEYS: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
boolean_build 			:= OSHAIR.Proc_Build_Boolean_Keys(version): FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com','Oshair Build Failure/BUILD BOOLEAN KEYS: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
promote_input 			:= OSHAIR.Proc_Promote_Input(filedate): FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com','Oshair Build Failure/PROMOTE INPUT: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));
qa_samples     			:= OSHAIR.Proc_QA_Samples(version, process_date): FAILURE(FileServices.SendEmail('cguyton@seisint.com; charlene.ros@lexisnexisrisk.com','Oshair Build Failure/QA SAMPLES: ' + version +' - '+ Thorlib.WUID(),FAILMESSAGE));

orbit_report.oshair_stats(getretval);

OSHAIR.Out_File_OSHAIR_Stats_Population(oshair.file_out_inspection_cleaned_both
                                        ,oshair.file_out_accident_cleaned
																				,oshair.file_out_hazardous_substance_cleaned
																				,oshair.file_out_optional_info_cleaned
																				,oshair.file_out_program_cleaned
																				,oshair.file_out_related_activity_cleaned
																				,oshair.file_out_violations_cleaned
																				,filedate
																				,do_STRATA);

dops_update := RoxieKeyBuild.updateversion('OshairKeys', version, _Control.MyInfo.EmailAddressNotify,,'N|B'); 

//Update ORBIT
	orbitUpdate := Orbit3.proc_Orbit3_CreateBuild('OSHAIR',filedate,'N|B'); 
	
return sequential(process_date, 
									spray_files,
									clean_data,
									create_super_files,
									build_keys,
									boolean_build,
									promote_input,
									dops_update,
									qa_samples,
									do_STRATA,
									orbitUpdate,
									getretval
									 );

end;

