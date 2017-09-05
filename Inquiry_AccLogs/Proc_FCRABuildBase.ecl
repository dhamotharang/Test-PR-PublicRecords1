import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, Inquiry_AccLogs_Append;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export 	proc_fcrabuildbase(string param_version = '', boolean override_doreappend = false) := function

#Workunit('name','FCRA Inquiry Tracking Build')
#stored('did_add_force','thor');

Name := sort(nothor(fileservices.superfilecontents('~thor10_231::in::batch_acclogs')), -name)[1].name;
version := if(param_version = '', Name[stringlib.stringfind(Name, '::', 2) + 2 ..stringlib.stringfind(Name, '::', 3) -1], param_version) : independent;

Parsed := 
					inquiry_acclogs.fnMapCommon_fcra_prodr3.clean //new banko batch records
					+
					inquiry_acclogs.fnMapCommon_fcra_Accurint.clean
					+
					inquiry_acclogs.fnMapCommon_fcra_Banko.clean
					+
   				inquiry_acclogs.fnMapCommon_fcra_Batch.clean
					+
					inquiry_acclogs.fnMapCommon_fcra_Riskwise.clean
					: persist('~persist::inquiry_tracking::mbs')
					;

				
//Parsed := dataset('~persist::inquiry_tracking::mbs__p3676720492', inquiry_acclogs.layout_in_common, thor); 

Clean := Inquiry_AccLogs.fn_clean_and_parse(Parsed) 
: persist('~persist::inquiry_tracking::cleaned')
;

// Clean := dataset('~persist::inquiry_tracking::cleaned::daily', inquiry_acclogs.layout_in_common, thor); 

Appends := Inquiry_AccLogs_Append.FN_Append_IDs(Clean) 
 : persist('~persist::inquiry_tracking::appends')
 ; 

// Appends := dataset('~persist::inquiry_tracking::appends', inquiry_acclogs.Layout_In_Common, thor);

/*
Appends := Appends
											(
											 ~inquiry_acclogs.FnTranslations.is_VerticalFilter(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_IndustryFilter(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_Disable_Observation(allowflags) and
											 ~inquiry_acclogs.FnTranslations.is_Internal(allowflags) and 
											 (orig_company_id <> '' or orig_global_company_id <> ''));
											 
Filtered_Removals := Appends
											(
											 inquiry_acclogs.FnTranslations.is_VerticalFilter(allowflags) or
											 inquiry_acclogs.FnTranslations.is_IndustryFilter(allowflags) or
											 inquiry_acclogs.FnTranslations.is_Disable_Observation(allowflags) or
											 inquiry_acclogs.FnTranslations.is_Internal(allowflags) or 
											 (orig_company_id <> '' and orig_global_company_id <> ''));*/
  
ReAppendDay := override_doreappend or stringlib.stringtolowercase(ut.Weekday((unsigned8)ut.getdate)) in inquiry_acclogs.fnCleanFunctions.fcra_reappendday : independent;

ReadyForOutputAccurint := inquiry_acclogs.fnMapCommon_fcra_accurint.ready_file(Appends,, ReAppendDay);
ReadyForOutputBanko := inquiry_acclogs.fnMapCommon_fcra_Banko.ready_file(Appends,, ReAppendDay);
ReadyForOutputBatch := inquiry_acclogs.fnMapCommon_fcra_Batch.ready_file(Appends,, ReAppendDay);
ReadyForOutputBankoBatch := inquiry_acclogs.fnMapCommon_fcra_BankoBatch.ready_file;
ReadyForOutputBatchR3 := inquiry_acclogs.fnMapCommon_fcra_prodr3.ready_file(Appends,, ReAppendDay);
ReadyForOutputRiskwise := inquiry_acclogs.fnMapCommon_fcra_Riskwise.ready_file(Appends,, ReAppendDay);

processedFiles := nothor(workunitservices.WorkunitFilesRead(workunit)) + dataset([{'build version',version,'',''}], recordof(nothor(workunitservices.WorkunitFilesRead(workunit))));
mbs_prev_version := dataset('out::inquiry::processedfiles', recordof(nothor(workunitservices.WorkunitFilesRead(workunit))), thor, opt)(name = 'build version')[1].cluster; 
												 
buildall := 
		sequential(
				output(ReAppendDay, named('Is_Reappend_Day')),
				output(version, named('Version')),
				parallel(
				  output(ReadyForOutputAccurint,,'out::inquiry::'+version+'::Accurint', overwrite, __compressed__)
					,output(ReadyForOutputBatchR3,,'out::inquiry::'+version+'::prodr3', overwrite, __compressed__)
					,output(ReadyForOutputBanko,,'out::inquiry::'+version+'::banko', overwrite, __compressed__)
					,if(reAppendDay,output(ReadyForOutputBankoBatch,,'out::inquiry::'+version+'::banko_batch', overwrite, __compressed__))
					,output(ReadyForOutputRiskwise,,'out::inquiry::'+version+'::riskwise', overwrite, __compressed__)
					,output(ReadyForOutputBatch,,'out::inquiry::'+version+'::batch', overwrite, __compressed__)
					//,output(Filtered_Removals,,'out::inquiry::'+version+'::removals', overwrite, __compressed__)
					);
				output(ProcessedFiles,,'out::inquiry::processedfiles', overwrite));
				
fnMovePreprocess(string version, string source_file) := sequential(
	nothor(fileservices.addsuperfile('~thor10_231::in::'+source_file+'_acclogs',
														'~thor10_231::in::'+source_file+'_acclogs_preprocess',,true));	
	nothor(fileservices.clearsuperfile('~thor10_231::in::'+source_file+'_acclogs_preprocess')));
																		 
				
fnMovePostprocess(string version, string source_file) := 
	SEQUENTIAL(nothor(fileservices.clearsuperfile('~thor10_231::in::'+source_file+'_acclogs_processed')),
							nothor(fileservices.promotesuperfilelist(['~thor10_231::in::'+source_file+'_acclogs',
																		 '~thor10_231::in::'+source_file+'_acclogs_processed'])));	

fnMove(string version, string source_file) := if(~ReAppendDay, 
								nothor(fileservices.addsuperfile('~thor10_231::base::'+source_file+'_acclogs_common','out::inquiry::'+version+'::'+source_file)),
								nothor(fileservices.promotesuperfilelist(['~thor10_231::base::'+source_file+'_acclogs_common',
																									'~thor10_231::base::'+source_file+'_acclogs_common_father',
																									'~thor10_231::base::'+source_file+'_acclogs_common_grandfather'],
																										'out::inquiry::'+version+'::'+source_file,true)));


moveallpreprocess := parallel(
							fnMovePreprocess(version, 'Accurint'),
							fnMovePreprocess(version, 'banko'),
							fnMovePreprocess(version, 'batch'),
/*   						// fnMovePreprocess(version, 'banko_batch'), */
							fnMovePreprocess(version, 'prodr3'),
							fnMovePreprocess(version, 'riskwise')
							);

moveallpostprocess := parallel(
			        fnMovePostprocess(version, 'Accurint'),
							fnMovePostprocess(version, 'banko'),
							fnMovePostprocess(version, 'batch'),
/*   						// fnMovePostprocess(version, 'banko_batch'), */
							fnMovePostprocess(version, 'prodr3'),
							fnMovePostprocess(version, 'riskwise')
							);
							
moveall := parallel(
              fnMove( version, 'Accurint'),
							fnMove( version, 'banko'),
							fnMove(version, 'batch'),
							if(reAppendDay, fnMove(version, 'banko_batch')),
							fnMove(version, 'prodr3'),
							fnMove(version, 'riskwise')
							);

BillgroupsCreateAndMove := 
					if(ReAppendDay,
													sequential(
													/* output billgroups file */
													output(inquiry_acclogs.File_FCRA_Inquiry_Billgroups_DID().Create_File,,'~thor20_21::out::inquiry_acclogs::fcra::'+version+'::inquiry_billgroups_did', overwrite, __compressed__),
													/* promote billgroups base file */
													nothor(fileservices.promotesuperfilelist(['~thor20_21::out::inquiry_acclogs::fcra::inquiry_billgroups_did', 
																														 '~thor20_21::out::inquiry_acclogs::fcra::inquiry_billgroups_did_father',
																														 '~thor20_21::out::inquiry_acclogs::fcra::inquiry_billgroups_did_grandfather'],
																														 '~thor20_21::out::inquiry_acclogs::fcra::'+version+'::inquiry_billgroups_did',true)))
																										    
						);
						
FCRA_Weekly_STATs :=  if(ReAppendDay,Inquiry_AccLogs._SCH_FCRAComprehensiveStats);

return sequential(
			moveallpreprocess,
			buildall,
		 moveall,
			moveallpostprocess,
			BillgroupsCreateAndMove,
			FCRA_Weekly_STATs
			);
					
end;
//6,546,546,380