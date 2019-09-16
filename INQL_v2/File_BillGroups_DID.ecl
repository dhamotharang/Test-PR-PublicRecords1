Import inql_v2;
import doxie, ut, risk_indicators;

export File_BillGroups_DID(boolean isFCRA = true ) := function

base_history := Inql_v2.Files(isFCRA,false).Inql_Base.Built;

base_filtered :=  (base_history)
														(~Inql_v2.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
														 ~Inql_v2.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
														 ~Inql_v2.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
														 ~Inql_v2.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
														 ~Inql_v2.fnTranslations.is_Internal(allow_flags.allowflags) and
														 ~Inql_v2.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags));
												
df  := 				DISTRIBUTE(base_filtered(bus_intel.industry <> '' AND person_q.appended_adl > 0 AND
								TRIM(bus_intel.vertical)<>'' AND
								StringLib.StringToUpperCase(TRIM(search_info.function_description)) not in 
								['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
								HASH(person_q.appended_adl));

// add the filtering we do at runtime in the shell for this pre-calculated key

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
	
	inquiry_hit := inql_v2.shell_constants.Valid_BillGroup_Inquiry(vertical, industry, func,logdate, historydate, 
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

return did_table;



end;
