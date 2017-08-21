import ut, Data_Services, address, aid, lib_stringlib, address, did_add, Business_Header_SS, Inquiry_AccLogs_Append;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header, zz_jbello;

export 	proc_buildbases(string param_version = '') := function

#Workunit('name','New Logs Thor Inquiry Tracking Daily Build')

////////////////////////// CREATE DAILY OUTPUT FILES
////////////////////////// Clean

version := if(param_version = '', ut.GetDate[1..8], param_version) : stored('Building_Version');

Parsed := 
					inquiry_acclogs.fnMapCommon_Accurint('ACCURINT').clean 
					+ 
					inquiry_acclogs.fnMapCommon_Accurint('CUSTOM').clean
					+
					inquiry_acclogs.fnMapCommon_Banko.clean
 					+
   				inquiry_acclogs.fnMapCommon_Batch.clean
					+
					inquiry_acclogs.fnMapCommon_BatchR3.clean //AKA Prod R3
					+
					inquiry_acclogs.fnMapCommon_Riskwise.clean
					+
					Inquiry_AccLogs.fnMapCommon_Bridger.clean
					+
					Inquiry_AccLogs.fnMapCommon_IDM.clean
					: persist('~persist::inquiry_tracking::mbs::daily');

//Parsed := dataset(Data_Services.foreign_logs+'persist::inquiry_tracking::mbs::daily', inquiry_acclogs.layout_in_common, thor);

Clean := Inquiry_AccLogs.fn_clean_and_parse(Parsed) : persist('~persist::inquiry_tracking::cleaned::daily');


// Clean := dataset('~persist::inquiry_tracking::cleaned::daily', inquiry_acclogs.layout_in_common, thor);


Appends := Inquiry_AccLogs_Append.FN_Append_IDs(Clean): persist('~persist::inquiry_tracking::appends::daily'); 

// Appends := dataset('~persist::inquiry_tracking::appends::daily', inquiry_acclogs.layout_in_common, thor);
/*
Appends_Filtered_ := Appends
											(
											 ~((company_id = '1534586' or global_company_id = '16952912') and function_description = 'FRAUDPOINT' and datetime[..6] between '201301' and '201302') and //TEMPORARY
											 ~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_VerticalFilter(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_IndustryFilter(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_Disable_Observation(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_Internal(allowflags) and 
											 ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allowflags) and
											 (orig_company_id <> '' or orig_global_company_id <> ''));*/

//append fraudpoint score by hitting batch service

daily_file_fraud_cnt := inquiry_acclogs.score_constants.daily_file_fraud_count;

inquiry_acclogs.mac_append_score(Appends, Appends_score, daily_file_fraud_cnt)

Appends_Filtered := Appends_score : persist('~persist::inquiry_tracking::appends_score::daily');
//Appends_Filtered:=dataset('~persist::inquiry_tracking::appends_score::daily__p2492301627',inquiry_acclogs.layout_in_common, thor);
ReadyForOutputAccurint 	:= inquiry_acclogs.fnMapCommon_Accurint('ACCURINT').ready_file(Appends_Filtered);
ReadyForOutputCustom 		:= inquiry_acclogs.fnMapCommon_Accurint('CUSTOM').ready_file(Appends_Filtered);
ReadyForOutputBanko 		:= inquiry_acclogs.fnMapCommon_Banko.ready_file(Appends_Filtered);
ReadyForOutputBatch 		:= inquiry_acclogs.fnMapCommon_Batch.ready_file(Appends_Filtered);
ReadyForOutputBatchR3 	:= inquiry_acclogs.fnMapCommon_BatchR3.ready_file(Appends_Filtered);
ReadyForOutputBridger 	:= inquiry_acclogs.fnMapCommon_Bridger.ready_file(Appends_Filtered);
ReadyForOutputRiskwise 	:= inquiry_acclogs.fnMapCommon_Riskwise.ready_file(Appends_Filtered);
ReadyForOutputIDM			 	:= inquiry_acclogs.fnMapCommon_IDM.ready_file(Appends_Filtered);
ReadyForOutputSBA       := inquiry_acclogs.fnMapCommon_SBA.ready_file;

previous_version := dataset('~thor100_21::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor)(name = 'build version')[1].cluster : stored('Previous_Version'); // previous build version is stored in processed files output
//mbs_new_records := Inquiry_AccLogs.File_MBS.File;//(current and datelastseen > previous_version);

buildall := 
				sequential(
				parallel(
					output(ReadyForOutputAccurint,,'~thor100_21::out::inquiry::'+version+'::accurint', overwrite, __compressed__);
					output(ReadyForOutputCustom,,'~thor100_21::out::inquiry::'+version+'::custom', overwrite, __compressed__);
					output(ReadyForOutputBanko,,'~thor100_21::out::inquiry::'+version+'::banko', overwrite, __compressed__);
					output(ReadyForOutputBatch,,'~thor100_21::out::inquiry::'+version+'::batch', overwrite, __compressed__);
					output(ReadyForOutputBatchR3,,'~thor100_21::out::inquiry::'+version+'::batchr3', overwrite, __compressed__);
					output(ReadyForOutputBridger,,'~thor100_21::out::inquiry::'+version+'::bridger', overwrite, __compressed__);
					output(ReadyForOutputIDM,,'~thor100_21::out::inquiry::'+version+'::idm_bls', overwrite, __compressed__);
				  output(ReadyForOutputSBA,,'~thor100_21::out::inquiry::'+version+'::SBA', overwrite, __compressed__);
					output(ReadyForOutputRiskwise,,'~thor100_21::out::inquiry::'+version+'::riskwise', overwrite, __compressed__))/*,
				 	
					output(Appends(
												 ((company_id = '1534586' or global_company_id = '16952912') and function_description = 'FRAUDPOINT' and datetime[..6] between '201301' and '201302') or //TEMPORARY
												  inquiry_acclogs.fnTranslations.is_SubMarketFilter(allowflags) or
													inquiry_acclogs.fnTranslations.is_IndustryFilter(allowflags) or
													inquiry_acclogs.fnTranslations.is_VerticalFilter(allowflags) or
													inquiry_acclogs.fnTranslations.is_Disable_Observation(allowflags) or
													inquiry_acclogs.fnTranslations.is_Internal(allowflags) or
													inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allowflags)),,'out::inquiry::'+version+'::filtered_out', overwrite, __compressed__, named('Disable_Observation_Or_Vertical_Filter'))*/
					);
					
/////////////// MBS BASE APPEND ON SPECIFIED DAY

		sc 			:= nothor(fileservices.superfilecontents('~thor100_21::out::inquiry_tracking::weekly_historical'))[1].name;
		findex 	:= stringlib.stringfind(sc, '::', 3)+2;
		lindex 	:= stringlib.stringfind(sc, '::', 4)-1;
history_version := sc[findex..lindex];

processedFiles := nothor(workunitservices.WorkunitFilesRead(workunit))+ 
									dataset([{'history build version',history_version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit))) +
									dataset([{'build version',version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit)));

/////////////// MOVE SUPERFILES
				
fnMovePreprocess(string version = '', string source_file) := 
sequential(
	nothor(fileservices.addsuperfile('~thor100_21::in::'+source_file+'_acclogs', '~thor100_21::in::'+source_file+'_acclogs_preprocess',,true));
	nothor(fileservices.clearsuperfile('~thor100_21::in::'+source_file+'_acclogs_preprocess')));

movepre := parallel(
						fnMovePreprocess(version, 'accurint'),//Request from Ayeesha's email on 20150724  
							fnMovePreprocess(version, 'banko'),
							fnMovePreprocess(version, 'batch'),
							fnMovePreprocess(version, 'batchr3'),
							fnMovePreprocess(version, 'bridger'),
							fnMovePreprocess(version, 'custom'),
							fnMovePreprocess(version, 'sba'),
							fnMovePreprocess(version, 'idm_bls'),
							fnMovePreprocess(version, 'riskwise'));
				
fnMoveProcessed(string version = '', string source_file) := 
sequential(
	 fileservices.addsuperfile('~thor100_21::in::'+source_file+'_acclogs_processed', '~thor100_21::in::'+source_file+'_acclogs',,true);
	 fileservices.clearsuperfile('~thor100_21::in::'+source_file+'_acclogs'));

movepost := parallel(
							fnMoveProcessed(version, 'accurint'),
							fnMoveProcessed(version, 'banko'),
							fnMoveProcessed(version, 'batch'),
							fnMoveProcessed(version, 'batchr3'),
							fnMoveProcessed(version, 'bridger'),
							fnMoveProcessed(version, 'custom'),
							fnMoveProcessed(version, 'idm_bls'),
							fnMoveProcessed(version, 'sba'),
							fnMoveProcessed(version, 'riskwise'));
							
fnMove(string version, string source_file) := parallel(
	nothor(fileservices.addsuperfile('~thor100_21::base::'+source_file+'_acclogs_common', '~thor100_21::out::inquiry::'+version+'::'+source_file)));

movebase := sequential(
						 parallel(
								fnMove(version, 'accurint'),
								fnMove(version, 'banko'),
								fnMove(version, 'batch'),
								fnMove(version, 'batchr3'),
								fnMove(version, 'bridger'),
								fnMove(version, 'custom'),
								fnMove(version, 'idm_bls'),
								fnMove(version, 'sba'),
								fnMove(version, 'riskwise'))
							);

Updates_Only := 
									inquiry_acclogs.File_Accurint_Logs_Common +
									inquiry_acclogs.File_Custom_Logs_Common +
									inquiry_acclogs.File_Banko_Logs_Common + 
									inquiry_acclogs.File_Riskwise_Logs_Common + 
									Inquiry_AccLogs.File_Batch_Logs_Common + 
									Inquiry_AccLogs.File_Bridger_Logs_Common + 
									Inquiry_AccLogs.File_IDM_Logs_Common + 
									Inquiry_AccLogs.File_BatchR3_Logs_Common;
New_Dates := 
								sort(table(Updates_Only,
										 {source, search_info.product_code, 
											yyyy := search_info.datetime[..4], 
											mm := search_info.datetime[5..6], 
											dd := search_info.datetime[7..8], 
											count_records := count(group)}, source, search_info.product_code, search_info.datetime[..8], few), record);
									
file_available_for_base_build := count(
	nothor(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::banko_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::batch_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::batchr3_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::bridger_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::custom_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::idm_bls_acclogs')) +
	nothor(fileservices.superfilecontents('~thor100_21::in::riskwise_acclogs'))) > 0;
	
return sequential(
            //zz_jbello.Build_All(version),  
					  Inquiry_AccLogs.File_MBS.CreateFile(version), //mbs recreation
					  movepre,    // input - from preprocess to input superfile 
					  if(file_available_for_base_build, // any files in the input superfile for processing? if so then build bases
									sequential(buildall   	// base - build individual base file
														,movebase   // base - move new base files into update weekly and base superfiles
														,movepost		// input - from input superfile to processed superfile 
														,output(ProcessedFiles,,'~thor100_21::out::inquiry::processedfiles', overwrite)
														,output(New_Dates,,'out::stats::new_dates', __compressed__, overwrite, named('New_Dates_In_Base_Files'))),
									OUTPUT('No New Files in all of the thor100_21::in::[sourcename]_acclogs', named('__NoNewFileWarning___'))
								/*,)
								
						OUTPUT('Create files for CrossRisk Analysis - Aju John, Vikram Dahrwan, Kapildev Kanyagundla', named('__StartFDNFiles__')),
							fileservices.addsuperfile('~thor100_21::out::inquiry::afi::filtered_out', '~thor100_21::out::inquiry::'+version+'::filtered_out'),
							OUTPUT(Appends,,'~thor100_21::in::inquiry::'+version+'::appends_all',overwrite,__compressed__, named('Appended_Cleaned_AllRecs')),
							fileservices.addsuperfile('~thor100_21::in::inquiry::afi::appends_all','~thor100_21::in::inquiry::'+version+'::appends_all')*/

						));
end;
