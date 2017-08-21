import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export 	proc_BuildHistory:=function

#Workunit('name','Inquiry Tracking History Re-MBS Build');


/////////////// MBS BASE APPEND ON SPECIFIED DAY

latest_daily_version := dataset('~thor100_21::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor,opt)(name = 'build version')[1].cluster:independent;
									
		sc 			:= nothor(fileservices.superfilecontents('~thor100_21::out::inquiry_tracking::weekly_historical'))[1].name;
		findex 	:= stringlib.stringfind(sc, '::', 3)+2;

history_v := sc[findex..findex+7];

		scl 			:= nothor(fileservices.superfilecontents('~thor100_21::out::inquiry_acclogs::inquiry_billgroups_did')[1].name);
		findexl 	:= stringlib.stringfind(scl, '::', 3)+2;

Billgroup_v :=scl[findexl..findexl+7];

version:=IF(history_v=billgroup_v,latest_daily_version,history_v):independent;

inquiry_acclogs.File_MBSApp_base(version).Append(outMBSBaseAppend, '');
MisScoreMBSBaseAppend:=outMBSBaseAppend(fraudpoint_score='');
weekly_file_fraud_count:=inquiry_acclogs.score_constants.weekly_file_fraud_count;
inquiry_acclogs.mac_append_score(MisScoreMBSBaseAppend, Appends_score, weekly_file_fraud_count,false);

MBSBaseAppend:=outMBSBaseAppend(fraudpoint_score<>'')+Appends_score;


processedFiles := nothor(workunitservices.WorkunitFilesRead(workunit)) + 
									dataset([{'history build version',history_v,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit))) +
									dataset([{'build version',latest_daily_version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit))); // remove?

																		 
MBSCreateAndMove := 
					sequential(output(version, named('Version')),
					
										IF(history_v>Billgroup_v,output('Base file already exists'),
										                        sequential(output(MBSBaseAppend,,'~thor100_20::out::inquiry::'+version+'::mbs::append_previous', compressed),
										                                   nothor(fileservices.promotesuperfilelist(['~thor100_21::out::inquiry_tracking::weekly_historical', 
																														 '~thor100_21::out::inquiry_tracking::weekly_historical_father'],
																														 '~thor100_20::out::inquiry::'+version+'::mbs::append_previous',true)),			
																											 output(ProcessedFiles,,'~thor100_21::out::inquiry::processedfiles_history', overwrite),
																											 ));
											
								    IF(history_v>Billgroup_v,sequential(output(inquiry_acclogs.File_Inquiry_Billgroups_DID().Create_File,,'~thor100_21::out::inquiry_acclogs::'+version+'::inquiry_billgroups_did', overwrite, __compressed__),
																											 nothor(fileservices.promotesuperfilelist(['~thor100_21::out::inquiry_acclogs::inquiry_billgroups_did', 
																														 '~thor100_21::out::inquiry_acclogs::inquiry_billgroups_did_father'],
																														 '~thor100_21::out::inquiry_acclogs::'+version+'::inquiry_billgroups_did',true)))));
										
																										
										
										
return MBSCreateAndMove;
end; 