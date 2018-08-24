IMPORT LN_PropertyV2_Fast,STD, RoxieKeyBuild,AVM_V2, _Control,Std, PromoteSupers;
#OPTION('multiplePersistInstances',FALSE);

EXPORT proc0_build_all(string8 process_date, boolean isFast, string emailRecipients) := FUNCTION

REPORT_BEFORE := LN_PropertyV2_Fast.buildAssist_report_superFiles_contents(process_date,'before');
PREP_NEW_DATA := sequential(LN_PropertyV2_Fast.proc2Prep(process_date,isFast)
													 ,LN_PropertyV2_Fast.verify_ln_fares_id_are_unique.in_prep_not_yet_in_base(process_date));

REPORT__AFTER := LN_PropertyV2_Fast.buildAssist_report_superFiles_contents(process_date,'after');

BUILD____BASE := sequential(LN_PropertyV2_Fast.proc3Enhance(process_date,isFast)
													 ,LN_PropertyV2_Fast.verify_ln_fares_id_are_unique.in_base_file
													 ,LN_PropertyV2_Fast.verify_compare_latest_base_files(isFast,process_date));

BUILD____KEYS := sequential(LN_PropertyV2_Fast.proc4channel(process_date,isFast)
													 ,LN_PropertyV2_Fast.verify_compare_latest_keys(isFast)); 
     
														LN_PropertyV2_Fast.proc_build_stats(process_date, zDoStatsReference, isFast);
BUILD__STRATA := sequential(zDoStatsReference);


							// UPDATE___DOPS: checkDopsDeploymentMonitor
							matchingWorkunits := 	nothor(STD.System.Workunit.WorkunitList('', NAMED jobname := 'property build dops deployment monitor'));
							propertyDopsDeploymentMonitorIsRunning := count(matchingWorkunits	(state in ['wait', 'running']))>0;
							checkDopsDeploymentMonitor := if (propertyDopsDeploymentMonitorIsRunning,output('Monitor is running - we`re good :-)')
								,sequential(output('MONITOR IS NOT RUNNING >:('),LN_PropertyV2_Fast.JobInfo.updateViaEmail('Dops Deployment Monitor'
											+' is NOT Running. Please run code from LN_PropertyV2_Fast.BWR_Monitor_Build_Dops_Deployment.','ATTENTION!!')));

BUILD_SCRUBS	:= sequential(parallel(LN_PropertyV2_Fast.fn_scrubsPlus_Assessor('O', process_date),  LN_PropertyV2_Fast.fn_scrubsPlus_deed('O', process_date)),
														parallel(LN_PropertyV2_Fast.fn_scrubsPlus_Assessor('F', process_date),  LN_PropertyV2_Fast.fn_scrubsPlus_deed('F', process_date)));

UPDATE___DOPS	:= sequential(checkDopsDeploymentMonitor
													 ,LN_PropertyV2_Fast.build_information(isFast).set_qa_version(process_date));
														 
UPDT_AVM_DOPS	:=	parallel(	RoxieKeyBuild.updateversion('AVMV2Keys'			, process_date,  'sudhir.kasavajjala@lexisnexis.com',,'N'),
														RoxieKeyBuild.updateversion('FCRA_AVMV2Keys', process_date,  'sudhir.kasavajjala@lexisnexis.com',,'F'));

BUILD_QA_SMPL	:= 	LN_PropertyV2_Fast.New_records_sample(process_date,isFast);

// Jira SLP-1
ECLSpecificty := '#option(\'multiplePersistInstances\',FALSE);\n'
								+'#workunit(\'protect\', \'true\');\n'
								+'#workunit(\'name\', \'property.InsuranceKeybuild '+process_date+'\');\n'
								+'SpecMod:= InsuranceHeader_Property_Transactions_DeedsMortgages.specificities(InsuranceHeader_Property_Transactions_DeedsMortgages.In_PROPERTY_TRANSACTION);\n'
								+'SpecMod.Build;\n';
SubmitSpecificty := _Control.fSubmitNewWorkunit(ECLSpecificty, 'thor400_44_eclcc');

//Jira DF-11862
ECLClearbase := '#option(\'multiplePersistInstances\',FALSE);\n'
								+'#workunit(\'name\', \'property.clearbase '+process_date+'\');\n'
								+'BaseFileInUseByDelta := IF(FileServices.FileExists(\'~thor::property_base_being_written_by_delta\'),true,false);\n'
								+'ReadyToClearBaseFile := IF(NOT(BaseFileInUseByDelta),notify(\'Ok_To_Clear_Property_Fast_Base\',\'*\'));\n'
								+'SubmitClearBaseFile  := LN_PropertyV2_Fast.clear_base_fast_previous_deltas(\''+process_date+'\');\n'
								+'LaunchCron           := sequential(ReadyToClearBaseFile,\n'
								+'																	 output(ut.getTimeDate()[1..10]+\' \'+ut.getTimeDate()[11..],named(\'Last_Checked\')),\n'
								+'																	 output(BaseFileInUseByDelta,named(\'Base_Being_Written\')));\n'
								+'LaunchEvent          := sequential(SubmitClearBaseFile,fail(\'Base Fast Cleared, Not an error\'));\n'
								+'LaunchCron : when(cron (\'45 0-23/1 * * 1-5\'));\n'
								+'LaunchEvent: when(event(\'Ok_To_Clear_Property_Fast_Base\',\'*\'),count(1));\n';
SubmitClearBase	:= _Control.fSubmitNewWorkunit(ECLClearbase, 'thor400_44_eclcc');

mostcurrentlog	:= sort(LN_PropertyV2_Fast.BuildLogger.file,-version)[1];

//ppr extract to run monthly

PromoteSupers.MAC_SF_BuildProcess(LN_PropertyV2.create_ppr_extract,'~thor_data400::out::ln_propertyv2::ppr_extract',ppr_extract,2,,true,process_date);
												 
																
run_all := sequential(  LN_PropertyV2_Fast.fn_reset_raw_files,
												REPORT_BEFORE, 
												// DF-17330 - Run prep process only on delta builds, to take advantage of the continuos delta and not delay new records
												if(isfast,sequential(
																		// In order to allow continuous delta it must check if build is writting prep file
																		output(dataset([{(STRING8)Std.Date.Today()}],{string8 filedate}),,'~thor::property_prep_being_written_by_build',overwrite),
																		PREP_NEW_DATA, 
																		if(FileServices.FileExists('~thor::property_prep_being_written_by_build'),
																							FileServices.Deletelogicalfile('~thor::property_prep_being_written_by_build')),
																		LN_PropertyV2_Fast.JobInfo.updateViaEmail('Prep Job completed. Ok to srpay more files.')),
																		sequential(
																							LN_PropertyV2_Fast.BuildLogger.update(process_date,'prep_start_date',mostcurrentlog.prep_start_date),
																							LN_PropertyV2_Fast.BuildLogger.update(process_date,'update_type','FULL'),
																							LN_PropertyV2_Fast.BuildLogger.update(process_date,'prep_end_date',mostcurrentlog.prep_start_date),
																							LN_PropertyV2_Fast.JobInfo.updateViaEmail('Full build, prep Job bypassed. Ok to srpay more files.'))),
												REPORT__AFTER, 
												// In order to allow continuous delta it must check if delta build is writting base file
												if(isfast,output(dataset([{(STRING8)Std.Date.Today()}],{string8 filedate}),,'~thor::property_base_being_written_by_delta',overwrite)),
												BUILD____BASE, LN_PropertyV2_Fast.JobInfo.updateViaEmail('Base file build completed.'),
												BUILD____KEYS, LN_PropertyV2_Fast.JobInfo.updateViaEmail('Keys build completed.'),
												BUILD__STRATA, LN_PropertyV2_Fast.JobInfo.updateViaEmail('Strata reports generated'),
												BUILD_SCRUBS,  LN_PropertyV2_Fast.JobInfo.updateViaEmail('Scrubs reports generated'),
												BUILD_QA_SMPL,					
												UPDATE___DOPS, 
												if(isfast and FileServices.FileExists('~thor::property_base_being_written_by_delta'),
																		FileServices.Deletelogicalfile('~thor::property_base_being_written_by_delta')),
												if(NOT(isFast),AVM_V2.Proc_Build_File_and_Keys(process_date)),
												if(NOT(isFast),UPDT_AVM_DOPS),
												LN_PropertyV2_Fast.JobInfo.updateViaEmail('ALL DONE :-) Please check DOPS, update Orbit and notify QA'),
												if(isFast and FileServices.FileExists('~thor::property_full_waiting_for_property_delta') ,
												             Sequential(
												                      FileServices.Deletelogicalfile('~thor::property_full_waiting_for_property_delta'),
																							notify('Property_full_build_waiting_for_delta','*'),
																							LN_PropertyV2_Fast.JobInfo.updateViaEmail('Full build is triggered as  delta build finished')	
																							),
																							
																						LN_PropertyV2_Fast.JobInfo.updateViaEmail('Full build is not waiting for delta to finish')
													 ),
												// When full build finisshes it needs to clear deltas already added to the full, it runs until file available to clear
												if(NOT(isFast),sequential(SubmitClearBase,SubmitSpecificty)),
												//ppr extract build process -- 20170310
												if(isFast , sequential(ppr_extract , LN_PropertyV2_Fast.JobInfo.updateViaEmail ( 'PPR Extract file built success') ))
											);
											
RETURN LN_PropertyV2_Fast.JobInfo.RunActionAndUpdateViaEmail(run_all,emailRecipients); 
END;