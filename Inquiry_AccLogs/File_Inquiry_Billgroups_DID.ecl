import doxie, Data_Services, risk_indicators;

EXPORT File_Inquiry_Billgroups_DID() := MODULE

// same base file filtering as the Inquiry_AccLogs.Key_Inquiry_DID

File_Inquiry_MBS_USA := Inquiry_AccLogs.fn_NonFCRABaseUSAfilter('history');
df := File_Inquiry_MBS_USA(bus_intel.industry <> '' and person_q.Appended_ADL > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
						~(mbs.company_id = '1446154' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201303' and '201304') and //TEMPORARY
											 ~(mbs.company_id = '1590195' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201304' and '201304') and //TEMPORARY
											 ~((mbs.company_id = '1534586' or mbs.global_company_id = '16952912') and search_info.function_description = 'FRAUDPOINT' and search_info.datetime[..6] between '201301' and '201302') and //TEMPORARY
 											 ~(mbs.company_id = '1015303' and search_info.datetime[..8] between '20160121' and '20160908') and											 
												~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
												~search_info.function_description[1..4]='FCRA' and
												~search_info.function_description[1..8]='RISKVIEW' AND
											 mbs.company_id + mbs.global_company_id <> '');


// add the filtering we do at runtime in the shell for this pre-calculated key
isFCRA := false;

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

EXPORT file := //DATASET(Data_Services.foreign_logs+'thor100_21::out::inquiry_acclogs::inquiry_billgroups_did', RECORDOF(create_file), THOR);
DATASET(Data_Services.foreign_logs+'thor_data::base::inql::nonfcra::weekly::qa::billgroups_did', RECORDOF(create_file), THOR);
END;
