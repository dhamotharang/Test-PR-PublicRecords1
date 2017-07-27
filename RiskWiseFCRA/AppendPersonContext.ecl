import Gateway, PersonContext, risk_indicators, iesp, ut;

EXPORT AppendPersonContext(grouped DATASET(risk_indicators.Layout_Boca_Shell) clam, DATASET (Gateway.Layouts.Config) gateways, boolean UsePersonContext=false) := function

// if you want, you can hard code the URL while testing
// URL := PersonContext.TempData.URL;  // dev box
// URL := riskwise.shortcuts.gw_personContext;  // boca cert gateway

URL := if(UsePersonContext, 
	gateways(stringlib.StringToLowerCase(trim(servicename))=gateway.constants.ServiceName.delta_personcontext)[1].url,
	''); // extra safety net to turn off the personContext even if the gateway is passed in to the roxie

PCkeys := project(ungroup(clam), transform(PersonContext.Layouts.Layout_PCSearchKey, 
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

dsResponseRecords := TOPN(dsResponse[1].records,
	iesp.Constants.MAX_CONSUMER_STATEMENTS, 
	dsResponse[1].records.LexID,
	-(integer) stringLib.StringFilter(dsResponse[1].records.dateadded[1..10], '0123456789'));

temp_statements := record
	unsigned LexID;
	boolean ConsumerStatement;
	boolean dispute_on_file;
	// boolean security_freeze;	
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
end;
	
consumer_statements := project(dsResponseRecords(searchStatus=personContext.Constants.statusCodes.ResultsFound), 
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
		self.dispute_on_file := statementtype = personContext.Constants.RecordTypes.dr;
		// self.security_freeze := statementtype = personContext.Constants.RecordTypes.sf;	
	
		ConsumerStatements1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share_fcra.t_ConsumerStatement, 	
																									self.uniqueID := LexID;
																									self.statementID := statementID;
																									self.statementType := statementtype;
																									self.content := content;
																									// self.dataGroup := datagroup;
																									self.dataGroup := '';  // temporary fix, blank out the dataGroup for RQ-13408
																									self.timestamp.year := (integer)ts_year;
																									self.timestamp.month := (integer)ts_month;
																									self.timestamp.day := (integer)ts_day;
																									self.timestamp.hour24 := (integer)ts_hour24;
																									self.timestamp.minute := (integer)ts_minute;
																									self.timestamp.second := (integer)ts_second;
																									self := []));		
		self.consumerStatements := sort(ConsumerStatements1, statementID);  // in case of multiple statements, always sort by StatementID to get them in same order each transaction
		));
		
consumer_statements_srted := SORT(consumer_statements, lexid);
rolled_statements := rollup(consumer_statements_srted, left.lexid=right.lexid, 
	transform(temp_statements, self.lexid := left.lexid,
		self.consumerStatements := left.consumerstatements + right.consumerstatements;
		
		// set the flags to true if any of the records in the rollup show as true
		self.ConsumerStatement := left.consumerstatement or right.consumerstatement;
		self.dispute_on_file := left.dispute_on_file or right.dispute_on_file;
		// self.security_freeze := left.security_freeze or right.security_freeze;
		));
	
shell_with_personContext := join(clam, rolled_statements, left.did=right.lexid,
	transform(riskwisefcra.layouts.PersonContext_layout,
		// first populate the new consumerStatements section with all of the details
		self.consumerStatements := right.ConsumerStatements;		
		
		// then set the flags within the shell that we can now get from the PersonContext gateway
		SELF.ConsumerFlags.corrected_flag := if(left.consumerFlags.corrected_flag or right.lexid<>0, true, false);
		SELF.ConsumerFlags.consumer_statement_flag := right.consumerstatement;
		SELF.ConsumerFlags.dispute_flag := right.dispute_on_file;
		// SELF.ConsumerFlags.security_freeze := right.security_freeze;
		
		// security freeze won't be ready in personcontext until end of June sometime, so keep getting that from PCR keys for time being
		SELF.ConsumerFlags.security_freeze := left.ConsumerFlags.security_freeze;
		
		// these 3 flags still come from DOST PCR keys
		SELF.ConsumerFlags.security_alert := left.ConsumerFlags.security_alert;
		SELF.ConsumerFlags.negative_alert := left.ConsumerFlags.negative_alert;
		SELF.ConsumerFlags.id_theft_flag := left.ConsumerFlags.id_theft_flag;
	
		self := left,
		self := []), keep(1), left outer);
		
// output(PCkeys, named('PCkeys'));
// output(dsRequest, named('dsRequest'));
// output(dsResponse, named('dsResponse'));
// output(dsResponseRecords, named('dsResponseRecords'));		
// output(consumer_statements, named('consumer_statements'));	
// output(rolled_statements, named('rolled_statements'));			
// output(shell_with_personContext, named('shell_with_personContext'));			

// if the user doesn't pass in a gateways dataset, then we can't get information from the personcontext function
no_URL := project(clam, transform(riskwisefcra.layouts.PersonContext_layout, self := left, self := []));

// input_ok := if(trim(url)<>'', true, ERROR(301,'Error - Insufficient Input.  Please supply delta_personcontext gateway') );
// with_personContext := if(input_ok, group(shell_with_personContext, seq), no_url);

// for initial performance testing, keep the errorcode out of the picture, just return the shell_with_personContext
with_personContext := if(trim(url)='', no_url, group(shell_with_personContext, seq));

// if you're running on roxie that doesn't have the personcontext keys loaded, your query will be suspended.
// best way to work around that suspension is to simply uncomment this line and comment out the line above
// with_personContext := project(clam, transform(riskwisefcra.layouts.PersonContext_layout, self := left, self := []));	

return with_personContext;

end;
