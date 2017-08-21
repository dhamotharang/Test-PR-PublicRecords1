IMPORT Inquiry_Acclogs;

EXPORT proc_CreateBaseFile(BOOLEAN build_base = TRUE, BOOLEAN build_intermediate = TRUE, BOOLEAN build_accbase = TRUE) := FUNCTION

parsed_out	:= DISTRIBUTE(score_logs.fn_ParseXML, HASH(transaction_id));

dedupFile		:= DEDUP(SORT(parsed_out + DISTRIBUTE(score_logs.Files_Base.File, HASH(transaction_id)), 
													transaction_id, LOCAL), transaction_id, LOCAL);
													
fileexists := nothor(fileservices.fileexists('~thor_data400::out::'+workunit+'::acclogs_scoring'));
															
CreateBaseFile := IF(build_base and ~fileexists,
																SEQUENTIAL(
																	OUTPUT(TABLE(CHOOSEN(parsed_out, 20), {transaction_id, datetime}), NAMED('Sample_Transaction_Records'));
																	OUTPUT(dedupFile,,'~thor_data400::out::'+workunit+'::acclogs_scoring', thor, __compressed__, overwrite, named('acclogs_scoring')),
																	fileservices.promotesuperfilelist(['~thor_data400::base::acclogs_scoring',
																																		 '~thor_data400::base::acclogs_scoring_father'],
																																		// '~thor_data400::base::acclogs_scoring_grandfather'],
																																		 '~thor_data400::out::'+workunit+'::acclogs_scoring',true)),
																	OUTPUT('Base File Exists', NAMED('_')));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

parsed_out2	:= DISTRIBUTE(score_logs.fn_ParseXML_Intermediate, HASH(transaction_id));

dedupFile2		:= DEDUP(SORT(parsed_out2 + DISTRIBUTE(score_logs.Files_Base.Intermediate, HASH(transaction_id)), 
													transaction_id, LOCAL), transaction_id, LOCAL);

fileexists2 := nothor(fileservices.fileexists('~thor_data400::out::'+workunit+'::acclogs_scoring_intermediate'));

CreateIntermediateBaseFile := if(build_intermediate and ~fileexists2,
																sequential(
																	OUTPUT(TABLE(CHOOSEN(parsed_out2, 20), {transaction_id, datetime}), NAMED('Sample_Intermediate_Records'));
																	output(dedupFile2,,'~thor_data400::out::'+workunit+'::acclogs_scoring::intermediate', thor, __compressed__, overwrite, named('intermediate')),
																	fileservices.promotesuperfilelist(['~thor_data400::base::acclogs_scoring::intermediate',
																																		 '~thor_data400::base::acclogs_scoring::intermediate_father'],
																																		// '~thor_data400::base::acclogs_scoring::intermediate_grandfather'],
																																		 '~thor_data400::out::'+workunit+'::acclogs_scoring::intermediate',true)),
																	output('Intermediate Base File Exists', named('__')));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inputNFR := Score_Logs.Files.NonFCRA_Logs_Riskwise;
inputNFA := Score_Logs.Files.NonFCRA_Logs_Custom + Score_Logs.Files.NonFCRA_Logs_Accurint;
inputFR := Score_Logs.Files.FCRA_Logs_Riskwise;

cleanDateTime(STRING datetime) := FUNCTION
	dt := Inquiry_AccLogs.fncleanfunctions.tDateAdded(datetime);
	tm := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(dt);
	RETURN tm;
END;


trimInputNFR := TABLE(inputNFR, {STRING function_name := orig_function_name, STRING transaction_type := '', STRING source := 'NF', STRING datetime := cleanDateTime(orig_date_added), STRING transaction_id := orig_transaction_id, STRING billing_code := stringlib.stringfindreplace(orig_billing_code,'\\N',''), STRING login_id := orig_login_id, STRING customer_id := orig_company_id, STRING product_code := '2'});
trimInputNFA := TABLE(inputNFA, {STRING function_name := orig_function_name, STRING transaction_type := orig_transaction_type, STRING source := 'NF', STRING datetime := cleanDateTime(orig_dateadded), STRING transaction_id := orig_transaction_id, STRING billing_code := stringlib.stringfindreplace(orig_billing_code,'\\N',''), STRING login_id := orig_loginid, STRING customer_id := orig_company_id, STRING product_code := '1'});
trimInputFR := TABLE(inputFR,   {STRING function_name := orig_function_name, STRING transaction_type := '', STRING source := 'F',  STRING datetime := cleanDateTime(orig_date_added), STRING transaction_id := orig_transaction_id, STRING billing_code := stringlib.stringfindreplace(orig_billing_code,'\\N',''), STRING login_id := orig_login_id, STRING customer_id := orig_company_id, STRING product_code := '2'});

outBase1 := DISTRIBUTE(trimInputNFA + trimInputNFR + trimInputFR, hash(transaction_id));
outBase2 := PROJECT(outBase1, Score_logs.Layouts.Base_AccTransaction_Layout)+ DISTRIBUTE(Score_Logs.Files_Base.Transaction_IDs, HASH(transaction_id));
outBase  := DEDUP(sort(outBase2, transaction_id, LOCAL), transaction_id, LOCAL);

processed_files := NOTHOR(TABLE(WORKUNITservices.WORKUNITFilesRead(WORKUNIT), {name}));

fileexists3 := NOTHOR(fileservices.fileexists('~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::transaction_ids'));
fileexists4 := NOTHOR(fileservices.fileexists('~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::processed_files'));

CreateAccTransactionBaseFile := IF(build_accbase, 
																	SEQUENTIAL(
																		IF(~fileexists3,
																			SEQUENTIAL(
																				OUTPUT(outBase,,'~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::transaction_ids', thor, __compressed__, overwrite, named('transaction_ids')),
																				fileservices.promotesuperfilelist(['~thor_data400::out::acclogs_scoring::transaction_ids',
																																				 '~thor_data400::out::acclogs_scoring::transaction_ids_father'],
																																				// '~thor_data400::out::acclogs_scoring::transaction_ids_grandfather'],
																																				 '~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::transaction_ids',true)),
																				OUTPUT('Transaction ID File Exists', NAMED('___'))),
																		IF(~fileexists4,
																			SEQUENTIAL(
																				OUTPUT(processed_files,,'~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::processed_files', thor, __compressed__, overwrite),
																				fileservices.promotesuperfilelist(['~thor_data400::out::acclogs_scoring::processed_files',
																																				 '~thor_data400::out::acclogs_scoring::processed_files_father'],
																																				// '~thor_data400::out::acclogs_scoring::processed_files_grandfather'],
																																				 '~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::processed_files',true)),
																				OUTPUT('Processed Filelist Exists', NAMED('____')))
																			));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
																			
fn_MoveProcessedFiles(STRING ext) := FUNCTION
																				
	// clearsuper := fileservices.clearsuperfile('~thor_data400::in::score_tracking::'+ext+'::processed',true);
	addsuper := fileservices.addsuperfile('~thor_data400::in::score_tracking::'+ext+'::processed', '~thor_data400::in::score_tracking::'+ext,,true);
	clearsuperin := fileservices.clearsuperfile('~thor_data400::in::score_tracking::'+ext);

RETURN NOTHOR(SEQUENTIAL(/*clearsuper,*/addsuper,clearsuperin));
END;

MoveProcessedFiles := SEQUENTIAL(
																fn_MoveProcessedFiles('log_mbs_fcra_intermediate');
																fn_MoveProcessedFiles('log_mbs_fcra_transaction_online');
																fn_MoveProcessedFiles('log_mbs_intermediate');
																fn_MoveProcessedFiles('log_mbs_transaction_online')
															);

RETURN PARALLEL(CreateAccTransactionBaseFile, CreateBaseFile, CreateIntermediateBaseFile, MoveProcessedFiles);
END;