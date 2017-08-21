IMPORT Inquiry_Acclogs;

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

outBase1 := trimInputNFA + trimInputNFR + trimInputFR;
outBase2 := DISTRIBUTE(PROJECT(outBase1, Score_logs.Layouts.Base_Transaction_Layout)+Score_Logs.Files_Base.Transaction_IDs, hash(transaction_id));
outBase  := DEDUP(sort(outBase2, transaction_id, LOCAL), transaction_id, LOCAL);

processed_files := NOTHOR(TABLE(WORKUNITservices.WORKUNITFilesRead(WORKUNIT), {name}));

build_file := SEQUENTIAL(
								IF(~fileservices.fileexists('~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::transaction_ids'),
									SEQUENTIAL(
										OUTPUT(outBase,,'~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::transaction_ids', thor, __compressed__, overwrite),
										fileservices.promotesuperfilelist(['~thor_data400::out::acclogs_scoring::transaction_ids',
																										 '~thor_data400::out::acclogs_scoring::transaction_ids_father',
																										 '~thor_data400::out::acclogs_scoring::transaction_ids_grandfather'],
																										 '~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::transaction_ids',,true)),
										OUTPUT('Transaction ID File Exists', NAMED('___'))),
								IF(~fileservices.fileexists('~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::processed_files'),
									SEQUENTIAL(
										OUTPUT(processed_files,,'~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::processed_files', thor, __compressed__, overwrite),
										fileservices.promotesuperfilelist(['~thor_data400::out::acclogs_scoring::processed_files',
																										 '~thor_data400::out::acclogs_scoring::processed_files_father',
																										 '~thor_data400::out::acclogs_scoring::processed_files_grandfather'],
																										 '~thor_data400::out::'+WORKUNIT+'::acclogs_scoring::processed_files',,true)),
										OUTPUT('Processed Filelist Exists', NAMED('____')))
									);
									
EXPORT proc_CreateTransactionIDFile := build_file;