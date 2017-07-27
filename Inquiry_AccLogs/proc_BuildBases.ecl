/*2011-06-14T12:16:37Z (cguyton)
C:\Documents and Settings\cguyton\Application Data\LexisNexis\querybuilder\cguyton\logs_esp\Inquiry_AccLogs\proc_BuildBases\2011-06-14T12_16_37Z.ecl
*/
import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export 	proc_buildbases(string param_version = '') := function

#Workunit('name','Inquiry Tracking Daily Build')

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
					: persist('~persist::inquiry_tracking::mbs::daily');

Clean := Inquiry_AccLogs.fnCleanFunctions.clean_and_parse(Parsed) 
: persist('~persist::inquiry_tracking::cleaned::daily')
;

/*  Clean := dataset('~persist::inquiry_tracking::cleaned::daily', inquiry_acclogs.layout_in_common, thor);  */


Appends := Inquiry_AccLogs.fnUpdateAppends(Clean)
 : persist('~persist::inquiry_tracking::appends::daily')
 ; 

/* Appends := dataset('~persist::inquiry_tracking::appends::daily', inquiry_acclogs.layout_in_common, thor); */

ReadyForOutputAccurint := inquiry_acclogs.fnMapCommon_Accurint('ACCURINT').ready_file(Appends);
ReadyForOutputCustom := inquiry_acclogs.fnMapCommon_Accurint('CUSTOM').ready_file(Appends);
ReadyForOutputBanko := inquiry_acclogs.fnMapCommon_Banko.ready_file(Appends);
ReadyForOutputBatch := inquiry_acclogs.fnMapCommon_Batch.ready_file(appends);
ReadyForOutputBatchR3 := inquiry_acclogs.fnMapCommon_BatchR3.ready_file(appends);
ReadyForOutputRiskwise := inquiry_acclogs.fnMapCommon_Riskwise.ready_file(appends);

processedFiles := workunitservices.WorkunitFilesRead(workunit) + dataset([{'build version',version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit)));
previous_version := dataset('~thor10_11::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor)(name = 'build version')[1].cluster : stored('Previous_Version'); // previous build version is stored in processed files output
mbs_new_records := Inquiry_AccLogs.File_MBS.File(current and datelastseen > previous_version);


buildall := 
				sequential(
				parallel(
					output(ReadyForOutputAccurint,,'~thor10_11::out::inquiry::'+version+'::accurint', overwrite, __compressed__);
					output(ReadyForOutputCustom,,'~thor10_11::out::inquiry::'+version+'::custom', overwrite, __compressed__);
					output(ReadyForOutputBanko,,'~thor10_11::out::inquiry::'+version+'::banko', overwrite, __compressed__);
					output(ReadyForOutputBatch,,'~thor10_11::out::inquiry::'+version+'::batch', overwrite, __compressed__);
					output(ReadyForOutputBatchR3,,'~thor10_11::out::inquiry::'+version+'::batchr3', overwrite, __compressed__);
					output(ReadyForOutputRiskwise,,'~thor10_11::out::inquiry::'+version+'::riskwise', overwrite, __compressed__)),
					output(ProcessedFiles,,'~thor10_11::out::inquiry::processedfiles', overwrite));

/////////////// MBS BASE APPEND ON SPECIFIED DAY

Chosen_Day := ['FRIDAY'];

DayOfRotation := stringlib.stringtouppercase(ut.Weekday((unsigned)ut.GetDate)) in Chosen_Day : independent;

inquiry_acclogs.File_MBSApp_base(version).Append(outMBSBaseAppend, '');

MBSCreateAndMove := 
					if(dayofrotation,
													sequential(
													output(outMBSBaseAppend,,'~thor10_11::out::inquiry::'+version+'::mbs::append_previous', overwrite, __compressed__),
													fileservices.promotesuperfilelist(['~thor10_11::out::inquiry_tracking::weekly_historical', 
																														 '~thor10_11::out::inquiry_tracking::weekly_historical_father'],
																														 '~thor10_11::out::inquiry::'+version+'::mbs::append_previous',true))
																														 )
																														 ;

/////////////// MOVE SUPERFILES
				
fnMovePreprocess(string version = '', string source_file) := 
sequential(
	fileservices.addsuperfile('~thor10_11::in::'+source_file+'_acclogs', '~thor10_11::in::'+source_file+'_acclogs_preprocess',,true);
	fileservices.clearsuperfile('~thor10_11::in::'+source_file+'_acclogs_preprocess'));

movepre := parallel(
							fnMovePreprocess(version, 'accurint'),
							fnMovePreprocess(version, 'banko'),
							fnMovePreprocess(version, 'batch'),
							fnMovePreprocess(version, 'batchr3'),
							fnMovePreprocess(version, 'custom'),
							fnMovePreprocess(version, 'riskwise'));
				
fnMoveProcessed(string version = '', string source_file) := 
	fileservices.promotesuperfilelist(['~thor10_11::in::'+source_file+'_acclogs',
																		'~thor10_11::in::'+source_file+'_acclogs_processed']);

movepost := parallel(
							fnMoveProcessed(version, 'accurint'),
							fnMoveProcessed(version, 'banko'),
							fnMoveProcessed(version, 'batch'),
							fnMoveProcessed(version, 'batchr3'),
							fnMoveProcessed(version, 'custom'),
							fnMoveProcessed(version, 'riskwise'));
							
fnMove(string version, string source_file) := sequential(
	if(dayofrotation, fileservices.clearsuperfile('~thor10_11::base::'+source_file+'_acclogs_common')),
	fileservices.addsuperfile('~thor10_11::base::'+source_file+'_acclogs_common', '~thor10_11::out::inquiry::'+version+'::'+source_file),
	fileservices.addsuperfile('~thor10_11::out::inquiry_tracking::weekly_updates', '~thor10_11::out::inquiry::'+version+'::'+source_file));

movebase := sequential(
						if(DayOfRotation, fileservices.promotesuperfilelist(['~thor10_11::out::inquiry_tracking::weekly_updates',
																																 '~thor10_11::out::inquiry_tracking::weekly_updates_father'],,true)),
					 parallel(
							fnMove(version, 'accurint'),
							fnMove(version, 'banko'),
							fnMove(version, 'batch'),
							fnMove(version, 'batchr3'),
							fnMove(version, 'custom'),
							fnMove(version, 'riskwise')
							)
							);

Updates_Only := 
									fnAddSource(inquiry_acclogs.File_Accurint_Logs_Common, 'ACCURINT') +
									fnAddSource(inquiry_acclogs.File_Custom_Logs_Common, 'CUSTOM') +
									fnAddSource(inquiry_acclogs.File_Banko_Logs_Common, 'BANKO') + 
									// fnAddSource(inquiry_acclogs.File_BankoBatch_Logs_Common, 'BANKO BATCH') + 
									fnAddSource(inquiry_acclogs.File_Riskwise_Logs_Common, 'RISKWISE') + 
									fnAddSource(Inquiry_AccLogs.File_Batch_Logs_Common, 'BATCH') + 
									fnAddSource(Inquiry_AccLogs.File_BatchR3_Logs_Common, 'BATCHR3');
New_Dates := 
								sort(table(Updates_Only,
										 {source, search_info.product_code, 
											yyyy := search_info.datetime[..4], 
											mm := search_info.datetime[5..6], 
											dd := search_info.datetime[7..8], 
											count_records := count(group)}, source, search_info.product_code, search_info.datetime[..8], few), record);

return sequential(
						Inquiry_AccLogs.File_MBS.CreateFile(version) //mbs recreation
						,MBSCreateAndMove // reappend previous mbs files
						,movepre // from preprocess to normal input superfile 
						,buildall  // build individual base file
						,movebase  // move base files into update weekly and base superfiles
						,movepost 	//weekend reserved for prod DID process
						,output(New_Dates,,'out::stats::new_dates', __compressed__, overwrite)
						);
end;
