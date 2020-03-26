/*2014-05-30T19:22:05Z (Wendy Ma)
bug# 155802
*/
/*2014-05-09T22:37:36Z (Wendy Ma)
additional healthcare account detection
*/
/*2014-05-08T02:36:59Z (cecelie guyton_logs)
sub market and other translation changes
*/
import doxie, ut, risk_indicators, data_services;

EXPORT File_FCRA_Inquiry_Billgroups_DID() := MODULE

fcra_base :=  (fnAddSource(inquiry_acclogs.File_FCRA_Riskwise_Logs_Common, 'RISKWISE') + 
							 fnAddSource(Inquiry_AccLogs.File_FCRA_BankoBatch_Logs_Common, 'BANKO BATCH') +
							 fnAddSource(Inquiry_AccLogs.File_FCRA_Batch_Logs_Common, 'BATCH') + 
							 fnAddSource(Inquiry_AccLogs.File_FCRA_ProdR3_Logs_Common, 'PROD R3') + 
							 fnAddSource(Inquiry_AccLogs.File_FCRA_Banko_Logs_Common, 'BANKO')+
							 fnAddSource(Inquiry_AccLogs.File_FCRA_accurint_Logs_Common, 'Accurint'))
														(~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags));
												
df := 				DISTRIBUTE(fcra_base(bus_intel.industry <> '' AND person_q.appended_adl > 0 AND
								TRIM(bus_intel.vertical)<>'' AND
								StringLib.StringToUpperCase(TRIM(search_info.function_description)) not in 
								['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
								HASH(person_q.appended_adl));
// add the filtering we do at runtime in the shell for this pre-calculated key
isFCRA := TRUE;

temp := record
	unsigned6 did;
	string20 company_id;  // TODO:  not sure how long this field is, but it needs to be a defined length to perform aggregates, please change it if 20 isn't long enough
	integer Inq_BillGroup_CountTotal;
	integer Inq_BillGroup_Count01;
	integer Inq_BillGroup_Count03;
	integer Inq_BillGroup_Count06;
	integer Inq_BillGroup_Count12;
	integer Inq_BillGroup_Count24;
end;

temp bocashell_filter(df le) := transform
	// these pre-calculated billgroup keys will always have history date = 999999
	historydate := risk_indicators.iid_constants.default_history_date;
	
	industry := trim(StringLib.StringToUpperCase(le.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(le.bus_intel.vertical));
	sub_market := trim(StringLib.StringToUpperCase(le.bus_intel.sub_market));
	func := trim(StringLib.StringToUpperCase(le.search_info.function_description));
	product_code := trim(le.search_info.product_code);
	logdate := le.search_info.datetime[1..8];
	
	/*is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

	function_is_ok := if(isfcra, func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions, func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(50));
	
	inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(historydate, logdate, isFCRA) and
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(le.bus_intel.use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;*/
								 
								 
	inquiry_hit := inquiry_acclogs.shell_constants.Valid_BillGroup_Inquiry(vertical, industry, func,logdate, historydate, 
                                           sub_market, le.bus_intel.use,product_code, le.Permissions.fcra_purpose, isFCRA, 50) ;


	agebucket := risk_indicators.iid_constants.age_bucket(logdate, historydate);
	
	self.Inq_BillGroup_CountTotal := if( inquiry_hit, 1, 0 );
	self.Inq_BillGroup_Count01 := if( inquiry_hit and ageBucket = 1,  1, 0 );
	self.Inq_BillGroup_Count03 := if( inquiry_hit and ageBucket between 1 and 3,  1, 0 );
	self.Inq_BillGroup_Count06 := if( inquiry_hit and ageBucket between 1 and 6,  1, 0 );
	self.Inq_BillGroup_Count12 := if( inquiry_hit and ageBucket between 1 and 12, 1, 0 );
	self.Inq_BillGroup_Count24 := if( inquiry_hit and ageBucket between 1 and 24, 1, 0 );
	self.did := le.person_q.appended_adl;
	self.company_id := le.mbs.company_id;
end;

// get rid of all records that aren't considered valid inquiry hits
valid_shell_inquiries := project(df, bocashell_filter(left))(Inq_BillGroup_CountTotal > 0);


// table first by DID and company to get counts Per company
did_billgroups_table := table(valid_shell_inquiries, {
	did, 
	company_id, 
	_Inq_BillGroup_CountTotal := count(group, Inq_BillGroup_CountTotal > 0),
	_Inq_BillGroup_Count01 := count(group, Inq_BillGroup_Count01 > 0),
	_Inq_BillGroup_Count03 := count(group, Inq_BillGroup_Count03 > 0),
	_Inq_BillGroup_Count06 := count(group, Inq_BillGroup_Count06 > 0),
	_Inq_BillGroup_Count12 := count(group, Inq_BillGroup_Count12 > 0),
	_Inq_BillGroup_Count24 := count(group, Inq_BillGroup_Count24 > 0),
	}, did, company_id);

// then table by DID to get counts of companies per DID
did_table := table(did_billgroups_table, {
	did, 
	total_inquiries := sum(group, _Inq_BillGroup_CountTotal),
	BillGroup_CountTotal := count(group, _Inq_BillGroup_CountTotal>0),
	BillGroup_Count01 := count(group, _Inq_BillGroup_Count01 > 0),
	BillGroup_Count03 := count(group, _Inq_BillGroup_Count03 > 0),
	BillGroup_Count06 := count(group, _Inq_BillGroup_Count06 > 0),
	BillGroup_Count12 := count(group, _Inq_BillGroup_Count12 > 0),
	BillGroup_Count24 := count(group, _Inq_BillGroup_Count24 > 0),
	}, did);

EXPORT create_file := did_table;

EXPORT file := /*DATASET(ut.foreign_fcra_logs + 'thor20_21::out::inquiry_acclogs::fcra::Inquiry_Billgroups_DID', RECORDOF(create_file), THOR);*/
dataset(Data_Services.foreign_prod + 'uspr::inql::fcra::base::weekly::qa::billgroups_did', RECORDOF(create_file), THOR);
	
END;