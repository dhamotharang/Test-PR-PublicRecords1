import _Control, Gateway, PersonContext, risk_indicators, iesp, ut;
onThor := _Control.Environment.OnThor;

// this function will be used by every FCRA transaction coming in from a scoring product.  
// Search PersonContext.GetPersonContext by LexID to find out if the consumer has any disputes on file.  
// Eventually PersonContext will also contain information about security freeze, fraud alert, id theft flag as well

EXPORT checkPersonContext(grouped DATASET(risk_indicators.layout_output) input_with_DID, 
		DATASET (Gateway.Layouts.Config) gateways, integer BSversion=1) := function

URL := gateways(stringlib.StringToLowerCase(trim(servicename))=gateway.constants.ServiceName.delta_personcontext)[1].url;

PCkeys := project(ungroup(input_with_DID), transform(PersonContext.Layouts.Layout_PCSearchKey, 
	self.LexID := (string)left.did, 
	// don't care about recID1,2,3,or 4  we are just searching person context by LexID
	self := [];  
	));

PersonContext.Layouts.Layout_PCRequest prepRequest() := transform
 SELF.deltabaseURL     := URL;
 self.searchBy.keys := PCkeys;
 self := [];
end;

dsRequest := DATASET ([prepRequest()]);
// GetPersonContext accpets just a row now instead of a dataset, so use dsRequest[1]
dsResponse := PersonContext.GetPersonContext(dsRequest[1]);

// go back to limiting the results to just 100 records per LexID.  Just used dedup instead of TopN which didn't work in batch mode
dsResponseRecords_roxie := dedup(
	sort(dsResponse[1].records, dsResponse[1].records.LexID, -(integer) stringLib.StringFilter(dsResponse[1].records.dateadded[1..10], '0123456789'), dsResponse[1].records.statementID), 
	dsResponse[1].records.LexID, keep(iesp.Constants.MAX_CONSUMER_STATEMENTS));

// When running on thor, GetPersonContext takes in multiple rows of data and returns multiple rows of data, instead of using child datasets like the roxie version in order to avoid errors 
dsResponseRecords_thor := DEDUP(SORT(PersonContext.GetPersonContext_thor(PCKeys), LexID, -(integer) stringLib.StringFilter(dateadded[1..10], '0123456789'), statementID), LexID, keep(iesp.Constants.MAX_CONSUMER_STATEMENTS)) ;

#IF(onThor)
	dsResponseRecords := dsResponseRecords_thor;
#ELSE
	dsResponseRecords := dsResponseRecords_roxie;
#END

temp_statements := record
	unsigned LexID;
	boolean ConsumerStatement;
	boolean dispute_on_file;
	Risk_Indicators.Layout_Overrides;
	dataset(Risk_Indicators.Layouts.tmp_Consumer_Statements) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
end;
	
PersonContext_transformed := project(dsResponseRecords(searchStatus=personContext.Constants.statusCodes.ResultsFound), 
	transform(temp_statements,	
		self.LexID := (unsigned)left.LexID;
		
		lexid := left.lexid;
		statementid := left.statementid;
		statementtype := left.recordtype;
		content := left.content;
		datagroup := left.datagroup;
		
// 2016-06-01 19:27:32   
		ts_year := trim(left.dateadded[1..4]);
		ts_month := trim(left.dateadded[6..7]);
		ts_day := trim(left.dateadded[9..10]);
		ts_hour24 := trim(left.dateadded[12..13]);
		ts_minute := trim(left.dateadded[15..16]);
		ts_second := trim(left.dateadded[18..19]);
		
		self.ConsumerStatement := statementtype in [personContext.Constants.RecordTypes.cs, personcontext.Constants.RecordTypes.rs];
	
		isDispute := statementtype = personContext.Constants.RecordTypes.dr;
		self.dispute_on_file := isDispute;

		SELF.bankrupt_correct_cccn := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.BANKRUPTCY_MAIN, 
																																		PersonContext.constants.datagroups.BANKRUPTCY_SEARCH ], 
																[TRIM(left.RecID1, left, right)], 
																[]);    
		RecIdForStId := TRIM(left.RecID1, left, right);       
		SELF.lien_correct_tmsid_rmsid := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.LIEN_MAIN, 
											PersonContext.constants.datagroups.LIEN_PARTY ], 
											[TRIM(left.RecID1, left, right)], 
											[]);
		ConsumerStatements1 := project(Risk_Indicators.iid_constants.ds_Record, 
				transform(Risk_Indicators.Layouts.tmp_Consumer_Statements, 		
																									self.uniqueID := LexID;
																									self.statementID := statementID;
																									self.statementType := statementtype;
																									self.content := content;
																									self.dataGroup := if(BSversion>=50, datagroup, '');
																									//self.dataGroup := '';  // temporary fix, blank out the dataGroup for RQ-13408
																									self.timestamp.year := (integer)ts_year;
																									self.timestamp.month := (integer)ts_month;
																									self.timestamp.day := (integer)ts_day;
																									self.timestamp.hour24 := (integer)ts_hour24;
																									self.timestamp.minute := (integer)ts_minute;
																									self.timestamp.second := (integer)ts_second;
																									self.RecIdForStId := RecIdForStId;
																									self := []));		
		self.consumerStatements := sort(ConsumerStatements1, statementID);  // in case of multiple statements, always sort by StatementID to get them in same order each transaction
    
		SELF.crim_correct_ofk := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.OFFENDERS, 
																															PersonContext.constants.datagroups.OFFENDERS_PLUS,
																															PersonContext.constants.datagroups.OFFENSES	], 
													[TRIM(left.RecID1, left, right)], 
													[]);    
		SELF.prop_correct_lnfare := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.ASSESSMENT, 
																																			PersonContext.constants.datagroups.DEED,
																																			PersonContext.constants.datagroups.PROPERTY_SEARCH,
																																			PersonContext.constants.datagroups.PROPERTY	], 
												[TRIM(left.RecID1, left, right)], 
												[]); 
		SELF.water_correct_RECORD_ID := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.WATERCRAFT, 
																																					PersonContext.constants.datagroups.WATERCRAFT_DETAILS ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.proflic_correct_RECORD_ID := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.PROFLIC, 
																																						PersonContext.constants.datagroups.MARI	], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.student_correct_RECORD_ID := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.STUDENT, 
																															PersonContext.constants.datagroups.STUDENT_ALLOY	], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.air_correct_RECORD_ID  := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.AIRCRAFT ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.avm_correct_RECORD_ID := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.AVM ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.infutor_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.INFUTOR, 
																															PersonContext.constants.datagroups.INFUTORCID	], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.impulse_correct_record_id  := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.IMPULSE, 
																															PersonContext.constants.datagroups.THRIVE	], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.gong_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.GONG ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.advo_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.ADVO ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.paw_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.PAW ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.email_data_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.EMAIL_DATA ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.inquiries_correct_record_id  := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.INQUIRIES ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.ssn_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.SSN ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.header_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.HDR ], 
													[TRIM(left.RecID1, left, right)], 
													[]);
		SELF.ibehavior_correct_record_id := if(isDispute and left.dataGroup in [	PersonContext.constants.datagroups.IBEHAVIOR_CONSUMER, 
																															PersonContext.constants.datagroups.IBEHAVIOR_PURCHASE	], 
													[TRIM(left.RecID1, left, right)], 
													[]);
	
		self := [];
		
		));
		
PersonContext_sorted := SORT(PersonContext_transformed, lexid);
rolled_personContext := rollup(PersonContext_sorted, left.lexid=right.lexid, 
	transform(temp_statements, self.lexid := left.lexid,
		self.consumerStatements := left.consumerstatements + right.consumerstatements;
		// set the flags to true if any of the records in the rollup show as true
		self.ConsumerStatement := left.consumerstatement or right.consumerstatement;
		self.dispute_on_file := left.dispute_on_file or right.dispute_on_file;
		// self.security_freeze := left.security_freeze or right.security_freeze;
		

		SELF.bankrupt_correct_cccn          := left.bankrupt_correct_cccn  +  right.bankrupt_correct_cccn ;   
		SELF.lien_correct_tmsid_rmsid 			:= left.lien_correct_tmsid_rmsid + right.lien_correct_tmsid_rmsid; 
		SELF.crim_correct_ofk               := left.crim_correct_ofk  +  right.crim_correct_ofk ;
		SELF.prop_correct_lnfare            := left.prop_correct_lnfare  +  right.prop_correct_lnfare ;
		SELF.water_correct_RECORD_ID        := left.water_correct_RECORD_ID  +  right.water_correct_RECORD_ID ;
		SELF.proflic_correct_RECORD_ID      := left.proflic_correct_RECORD_ID  +  right.proflic_correct_RECORD_ID ;
		SELF.student_correct_RECORD_ID      := left.student_correct_RECORD_ID  +  right.student_correct_RECORD_ID ;
		SELF.air_correct_RECORD_ID          := left.air_correct_RECORD_ID  +  right.air_correct_RECORD_ID ;
		SELF.avm_correct_RECORD_ID          := left.avm_correct_RECORD_ID  +  right.avm_correct_RECORD_ID ;
		SELF.infutor_correct_record_id      := left.infutor_correct_record_id  +  right.infutor_correct_record_id ;
		SELF.impulse_correct_record_id      := left.impulse_correct_record_id  +  right.impulse_correct_record_id ;
		SELF.gong_correct_record_id         := left.gong_correct_record_id  +  right.gong_correct_record_id ;
		SELF.advo_correct_record_id         := left.advo_correct_record_id  +  right.advo_correct_record_id ;
		SELF.paw_correct_record_id          := left.paw_correct_record_id  +  right.paw_correct_record_id ;
		SELF.email_data_correct_record_id   := left.email_data_correct_record_id  +  right.email_data_correct_record_id ;
		SELF.inquiries_correct_record_id    := left.inquiries_correct_record_id  +  right.inquiries_correct_record_id ;
		SELF.ssn_correct_record_id          := left.ssn_correct_record_id  +  right.ssn_correct_record_id ;
		SELF.header_correct_record_id       := left.header_correct_record_id  +  right.header_correct_record_id ;
		SELF.ibehavior_correct_record_id		:= left.ibehavior_correct_record_id  +  right.ibehavior_correct_record_id ;

		self := left;
		));

with_personContext := join(input_with_DID, rolled_personContext, left.did=right.lexid,
	transform(risk_indicators.layout_output,

		self.consumerStatements := right.consumerStatements;
		// then set the flags within the shell that we can now get from the PersonContext gateway
		SELF.ConsumerFlags.corrected_flag := if(left.consumerFlags.corrected_flag or right.lexid<>0, true, false);
		SELF.ConsumerFlags.consumer_statement_flag := right.consumerstatement;
		SELF.ConsumerFlags.dispute_flag := right.dispute_on_file;


// for any of these data groups, add the record IDs from the flag file search together with the RecID1 values from PersonContext dispute records
// this way, anything that is found to be under Dispute in person context is treated as a suppression record and doesn't get used in the shell

		SELF.bankrupt_correct_cccn          := left.bankrupt_correct_cccn  +  right.bankrupt_correct_cccn ;   
		SELF.lien_correct_tmsid_rmsid 			:= left.lien_correct_tmsid_rmsid + right.lien_correct_tmsid_rmsid; 
		SELF.crim_correct_ofk               := left.crim_correct_ofk  +  right.crim_correct_ofk ;
		SELF.prop_correct_lnfare            := left.prop_correct_lnfare  +  right.prop_correct_lnfare ;
		SELF.water_correct_RECORD_ID        := left.water_correct_RECORD_ID  +  right.water_correct_RECORD_ID ;
		SELF.proflic_correct_RECORD_ID      := left.proflic_correct_RECORD_ID  +  right.proflic_correct_RECORD_ID ;
		SELF.student_correct_RECORD_ID      := left.student_correct_RECORD_ID  +  right.student_correct_RECORD_ID ;
		SELF.air_correct_RECORD_ID          := left.air_correct_RECORD_ID  +  right.air_correct_RECORD_ID ;
		SELF.avm_correct_RECORD_ID          := left.avm_correct_RECORD_ID  +  right.avm_correct_RECORD_ID ;
		SELF.infutor_correct_record_id      := left.infutor_correct_record_id  +  right.infutor_correct_record_id ;
		SELF.impulse_correct_record_id      := left.impulse_correct_record_id  +  right.impulse_correct_record_id ;
		SELF.gong_correct_record_id         := left.gong_correct_record_id  +  right.gong_correct_record_id ;
		SELF.advo_correct_record_id         := left.advo_correct_record_id  +  right.advo_correct_record_id ;
		SELF.paw_correct_record_id          := left.paw_correct_record_id  +  right.paw_correct_record_id ;
		SELF.email_data_correct_record_id   := left.email_data_correct_record_id  +  right.email_data_correct_record_id ;
		SELF.inquiries_correct_record_id    := left.inquiries_correct_record_id  +  right.inquiries_correct_record_id ;
		SELF.ssn_correct_record_id          := left.ssn_correct_record_id  +  right.ssn_correct_record_id ;
		SELF.header_correct_record_id       := left.header_correct_record_id  +  right.header_correct_record_id ;
		SELF.ibehavior_correct_record_id		:= left.ibehavior_correct_record_id  +  right.ibehavior_correct_record_id ;
		
		self := left,
		self := []), keep(1), left outer);
		
// output(input_with_DID, named('input_with_DID'));
// output(url, named('url'));
// output(PCkeys, named('PCkeys'));
// output(dsRequest, named('dsRequest'));
// output(dsResponse, named('dsResponse'));
// output(dsResponseRecords, named('dsResponseRecords'));		
// output(PersonContext_transformed, named('PersonContext_transformed'));	
// output(rolled_personContext, named('rolled_personContext'));			
// output(with_personContext, named('with_personContext'));			

return group(with_personContext,seq);


end;
