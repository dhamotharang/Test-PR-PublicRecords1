import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export 	proc_fcrabuildbase(string param_version = '') := function

#Workunit('name','FCRA Inquiry Tracking Build')


version := if(param_version = '', ut.GetDate[1..8], param_version) : global;

RunDayOfWeek := stringlib.stringtolowercase(ut.Weekday((unsigned8)version)) not in ['saturday','sunday'];

// Bad File?
// When coming across a bad file with too many bytes in a row an easy way to find it is to do a count group on each individual file by a non-unique field

Parsed := 
					inquiry_acclogs.fnMapCommon_fcra_prodr3.clean //new banko batch records
					+
					inquiry_acclogs.fnMapCommon_fcra_Banko.clean
					+
   				inquiry_acclogs.fnMapCommon_fcra_Batch.clean
					+
					inquiry_acclogs.fnMapCommon_fcra_Riskwise.clean
					: persist('~persist::inquiry_tracking::mbs');

Clean := Inquiry_AccLogs.fnCleanFunctions.clean_and_parse(Parsed) 
: persist('~persist::inquiry_tracking::cleaned')
;

 // Clean := dataset('~persist::inquiry_tracking::cleaned::daily', inquiry_acclogs.layout_in_common, thor); 


Appends := Inquiry_AccLogs.fnUpdateAppends(Clean) 
 : persist('~persist::inquiry_tracking::appends')
 ; 
 
// Appends := dataset('~persist::inquiry_tracking::appends', inquiry_acclogs.Layout_In_Common, thor); 
  
ReadyForOutputBanko := inquiry_acclogs.fnMapCommon_fcra_Banko.ready_file(Appends);
ReadyForOutputBatch := inquiry_acclogs.fnMapCommon_fcra_Batch.ready_file(appends);
ReadyForOutputBankoBatch := inquiry_acclogs.fnMapCommon_fcra_BankoBatch.ready_file;
ReadyForOutputBatchR3 := inquiry_acclogs.fnMapCommon_fcra_prodr3.ready_file(appends);
ReadyForOutputRiskwise := inquiry_acclogs.fnMapCommon_fcra_Riskwise.ready_file(appends);

processedFiles := workunitservices.WorkunitFilesRead(workunit) + dataset([{'build version',version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit)));
mbs_prev_version := dataset('out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor, opt)(name = 'build version')[1].cluster; 

ReAppendDay := stringlib.stringtolowercase(ut.Weekday((unsigned8)ut.getdate)) in ['friday'] : independent;
												 
buildall := 
		sequential(
				parallel(
					output(ReadyForOutputBanko,,'out::inquiry::'+version+'::banko', overwrite, __compressed__);
					output(ReadyForOutputBatch,,'out::inquiry::'+version+'::batch', overwrite, __compressed__);
					if(reAppendDay,output(ReadyForOutputBankoBatch,,'out::inquiry::'+version+'::banko_batch', overwrite, __compressed__)); 
					output(ReadyForOutputBatchR3,,'out::inquiry::'+version+'::prodr3', overwrite, __compressed__);
					output(ReadyForOutputRiskwise,,'out::inquiry::'+version+'::riskwise', overwrite, __compressed__));
				output(ProcessedFiles,,'out::inquiry::processedfiles', overwrite));
				
fnMovePreprocess(string version, string source_file) := sequential(
	fileservices.addsuperfile('~thor10_231::in::'+source_file+'_acclogs',
																		 '~thor10_231::in::'+source_file+'_acclogs_preprocess',,true);	
	fileservices.clearsuperfile('~thor10_231::in::'+source_file+'_acclogs_preprocess'));
																		 
				
fnMovePostprocess(string version, string source_file) := 
	fileservices.promotesuperfilelist(['~thor10_231::in::'+source_file+'_acclogs',
																		 '~thor10_231::in::'+source_file+'_acclogs_processed']);	

fnMove(string version, string source_file) := if(~ReAppendDay, 
								fileservices.addsuperfile('~thor10_231::base::'+source_file+'_acclogs_common','out::inquiry::'+version+'::'+source_file),
								fileservices.promotesuperfilelist(['~thor10_231::base::'+source_file+'_acclogs_common',
																									'~thor10_231::base::'+source_file+'_acclogs_common_father',
																									'~thor10_231::base::'+source_file+'_acclogs_common_grandfather'],
																										'out::inquiry::'+version+'::'+source_file,true));


moveallpreprocess := parallel(
							fnMovePreprocess(version, 'banko'),
							fnMovePreprocess(version, 'batch'),
  						// fnMovePreprocess(version, 'banko_batch'),
							fnMovePreprocess(version, 'prodr3'),
							fnMovePreprocess(version, 'riskwise')
							);

moveallpostprocess := parallel(
							fnMovePostprocess(version, 'banko'),
							fnMovePostprocess(version, 'batch'),
  						// fnMovePostprocess(version, 'banko_batch'),
							fnMovePostprocess(version, 'prodr3'),
							fnMovePostprocess(version, 'riskwise')
							);
							
moveall := parallel(
							fnMove(version, 'banko'),
							fnMove(version, 'batch'),
							if(reAppendDay, fnMove(version, 'banko_batch')),
							fnMove(version, 'prodr3'),
							fnMove(version, 'riskwise')
							);

return 
		if(RunDayOfWeek,
		sequential(
			moveallpreprocess,
			buildall, 
			moveall,
			moveallpostprocess)
		)
		;					
end;
