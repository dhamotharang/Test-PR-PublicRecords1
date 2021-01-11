//This for requesting the IDA combined models in the FraudIntelligence product (lives in Fraudpoint)
//Returns Scores and reason codes for FraudIntelligence models
//Still has logic to return attributes counts of up to 538 (v202 + DI) in case that support is needed in the future

import data_services, risk_indicators, models, riskwise, STD;
#workunit('name','Fraud Intelligence Score');

//----------------
//  ROXIE TARGET
//----------------
roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;
// roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;
// roxieIP := riskwise.shortcuts.Dev156;

unsigned record_limit 	:= 0;   //number of records to process from input file; 0 means ALL
unsigned eyeball        := 50;  //number of records to display in outputs
unsigned Threads        := 20;  //number of threads to use in the soapcall
unsigned retrys         := 5 ;  //number of retrys in the soapcall

//---------------- FILE NAMES -----------------
filename := '~fallen::in::fibn12010_validation_pii.csv';
outputfile := '~fallen::out::fibn12010_validation_results_' + std.system.Job.wuid();
qa_outputfile := outputfile+'_QA';


//----------------- INPUT OPTIONS SECTION -------------------------------
//Models to request, FP can now accept up to 3 models. Only populate the Models you need to run
Model1 := 'fibn12010_0'; //Primary model, Example IDA flagship model = 'fibn12010_0'
Model2 := ''; //second model if needed, Example Flagships: FP2.0 = fp1109_0 || FP3.0 = 'fp31505_0' or 'fp3fdn1505_0'
Model3 := ''; //third model if needed

// RequestedAttrGroup := 'fraudpointattrv202_diattrv1'; //digital insights attr group
// RequestedAttrGroup := 'fraudpointattrv202';  //Version 202 attr group
// RequestedAttrGroup := 'fraudpointattrv201';  //Version 201 attr group
// RequestedAttrGroup := 'fraudpointattrv2';    //Version 2 attr group
RequestedAttrGroup := '';    //No attributes

// Change history date here to be what you need, options are listed
historydate_to_use := 999999;   //999999 will run in current mode
                           //0 to use history date on file
                           //any other date to use that specific date e.g.(201805)
GLB  := 1;
DPPA := 3;
DataRestriction_Mask := '0000000000000000000000000';  // byte 6, if 1, restricts experian || byte 8, if 1, restricts equifax || byte 10 restricts Transunion
DataPermission_Mask  := '0000000000000';    // to allow population of FDN Virtual Fraud, Test Fraud and Contributory Fraud, set position 11 to '1'
                                            // to allow access to Insurance DL data, set position 13 to '1'
_IncludeRiskIndices          := FALSE;  // Set to true to return riskIndicies if the requested model is able
_OfacOnly                    := FALSE;
_ExcludeWatchLists           := FALSE;
_OFACversion                 := 1;
_IncludeOfac                 := FALSE;
_IncludeAdditionalWatchLists := FALSE;
_GlobalWatchlistThreshold    := 0.84;
_SuppressCompromisedDLs      := FALSE;  // don’t search the eqfx compromised DL list by Last Name and SSN unless specifically requested
_include_internal_extras     := FALSE;  // internal fields for debugging, when set to false, QA file will not be output
Score_only                   := RequestedAttrGroup = '';
//-------------------------------------------------------------------------

prii_layout := RECORD
     string ACCOUNT;
     string FirstName;
     string MiddleName;
     string LastName;
     string StreetAddress;
     string CITY;
     string STATE;
     string ZIP;
     string HomePhone;
     string SSN;
     string DateOfBirth;
     string WorkPhone;
     string INCOME;
     string DLNumber;
     string DLState;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERName;
     string EMAIL;
     string EmployerName;
     string HistoryDate;
		 unsigned did := 0;
     string IPAddress;
end;

f := if(record_limit = 0, //depending on the record_limit, either process the entire input file or the number of records specified
				dataset(filename,prii_layout, csv(quote('"'))),
				choosen(dataset(filename,prii_layout, csv(quote('"'))), record_limit));

output(choosen(f,eyeball), named('original_input'));
output(count(f), named('original_input_count'));


Layout_Attributes_In := RECORD
	string name;
END;

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	string DataRestrictionMask;		
	integer HistoryDateYYYYMM;
  string20 HistoryDateTimeStamp;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
	string Model;
  dataset(Models.Layouts.Layout_Model_Request_In) ModelRequests;
  boolean OfacOnly;
  boolean ExcludeWatchLists;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
	// fields below are all new for fp 2.0
	boolean IncludeRiskIndices;  // turns on the 6 fp indices that go with the model
	// the rest of these aren't used yet, just added for possible future custom models to use
	string Channel;
	string Income;
	string OwnOrRent;
	string LocationIdentifier;
	string OtherApplicationIdentifier;
	string OtherApplicationIdentifier2;
	string OtherApplicationIdentifier3;
	string DateofApplication;
	string TimeofApplication;
	unsigned did := 0;
	string50 DataPermissionMask;	
	boolean SuppressCompromisedDLs;
  boolean IncludeQAOutputs;
  unsigned1 IDA_gateway_mode;
end;

layout_old_acct := RECORD
	STRING old_account_number;
	layout_soap;
END;

layout_old_acct into_fdInput(f le, INTEGER c) := TRANSFORM
	self.SuppressCompromisedDLs := true; // leave this set to true for soapcall; otherwise field values will be offset
	
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.OtherApplicationIdentifier3 := (STRING)c;	//this is mapped to AppID for IDA gateway calls using the same as Account for now
	SELF.DPPAPurpose := DPPA;
	SELF.GLBPurpose := GLB;
  SELF.DataRestrictionMask := DataRestriction_Mask;
	SELF.DataPermissionMask  := DataPermission_Mask;
  SELF.IDA_gateway_mode := 2; // 0=production, 1=UAT testing, 2=production testing/retro // this forces companyid = 1357055

  //**********************************************************************************************
  // History date is governed by the historydate_to_use field above in the input options section
  //**********************************************************************************************
  self.historydateyyyymm := Map(historydate_to_use > 0 and historydate_to_use != 999999 => historydate_to_use,
                                historydate_to_use = 999999             => 999999,
                                historydate_to_use = 0                  => map(
                                                                              regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
                                                                              regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
                                                                                                                              (unsigned)le.historydate
                                                                              ),
                                                                           999999 //defaults to current mode, shouldn't get here
                                );
	
  self.historyDateTimeStamp := Map(historydate_to_use > 0 and historydate_to_use != 999999 => (String)historydate_to_use + '01 00000100',
                                historydate_to_use = 999999             => '',
                                historydate_to_use = 0                  => map(
                                                                              le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
                                                                              regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
                                                                              regexfind('^\\d{8}$',        le.historydate) => le.historydate + ' '   + STD.Date.CurrentTime(),
                                                                              regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 ' + STD.Date.CurrentTime(),		                                                
                                                                                                                              le.historydate
                                                                              ),
                                                                              '' //defaults to current mode, shouldn't get here
                                  );
  
	SELF.RequestedAttributeGroups := dataset([{RequestedAttrGroup}], layout_attributes_in);
  
  modelrequest1 := DATASET([TRANSFORM(Models.Layouts.Layout_Model_Request_In,
                                 SELF.ModelName := 'customfa_service',
                                 Self.ModelOptions := Dataset([Transform(Models.Layouts.Layout_Model_Options, Self.OptionName := 'custom', Self.OptionValue := Model1
                           )]) )]); //First model request

  modelrequest2 := DATASET([TRANSFORM(Models.Layouts.Layout_Model_Request_In,
                                 SELF.ModelName := 'customfa_service',
                                 Self.ModelOptions := Dataset([Transform(Models.Layouts.Layout_Model_Options, Self.OptionName := 'custom', Self.OptionValue := Model2
                           )]) )]); //Second model request
  
  modelrequest3 := DATASET([TRANSFORM(Models.Layouts.Layout_Model_Request_In,
                                 SELF.ModelName := 'customfa_service',
                                 Self.ModelOptions := Dataset([Transform(Models.Layouts.Layout_Model_Options, Self.OptionName := 'custom', Self.OptionValue := Model3
                           )]) )]); //Third model request
  
  self.ModelRequests := IF(Model1 != '', modelrequest1) +
                        IF(Model2 != '', modelrequest2) +
                        IF(Model3 != '', modelrequest3); //Fraudpoint now accepts up to 3 models.
  
 	// self.gateways := dataset([{'IDAReport', 'https://rw_score_dev:Password01@10.176.68.164:8726/wsgatewayex/?ver_=2.84'}], Risk_Indicators.Layout_Gateways_In); //cert gateway
 	self.gateways := dataset([{'IDAReport_Retro', 'https://rw_score_dev:Password01@10.176.68.164:8726/wsgatewayex/?ver_=2.84'}], Risk_Indicators.Layout_Gateways_In) //cert gateway
                   + riskwise.shortcuts.gw_netacuityv4_cert  // use riskwise.shortcuts.gw_netacuityv4_prod for paid customer transactions
                   /* + riskwise.shortcuts.gw_threatmetrix */
                   /* + riskwise.shortcuts.gw_targus */;     //Can uncomment targus gateway and/or watchlists if needed
                   
  self.IncludeRiskIndices := _IncludeRiskIndices;
	self.OfacOnly := _OfacOnly;
  self.ExcludeWatchLists := _ExcludeWatchLists;
	self.OFACversion := _OFACversion;
	self.IncludeOfac := _IncludeOfac;
	self.IncludeAdditionalWatchLists := _IncludeAdditionalWatchLists;
	self.GlobalWatchlistThreshold := _GlobalWatchlistThreshold;

  SELF.IncludeQAOutputs := _include_internal_extras;  
	SELF := le;
	self := [];
end;
fdInput := project(f, into_fdInput(left, counter));
output(choosen(fdInput, eyeball), named('FD_Input'));

dist_dataset := distribute(fdInput, random());

Layout_FA_Input := RECORD
	Risk_Indicators.Layout_Input;
	STRING5 Grade := '';
	string16 Channel := '';
	string8 Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';
	string8 TimeofApplication := '';
END;

Layout_Attribute := RECORD, maxlength(10000)
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD, maxlength(70000)
	string name;
	string index;
	DATASET(Layout_Attribute) Attributes;
END;
Layout_FDAttributesOut := RECORD, maxlength(100000)
	string30 accountnumber;
	Layout_FA_Input input;
  STRING50 Description;
	DATASET(models.Layouts.Layout_Score_FP) Scores;
	DATASET(Layout_AttributeGroup) AttributeGroup;
  Models.Layout_Fraudpoint_Debug;
	string errorcode;
END;

Layout_FDAttributesOut myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.accountnumber := le.AccountNumber;
  SELF.shell.account := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'Models.FraudAdvisor_Service', {dist_dataset}, 
				DATASET(layout_FDAttributesOut),
				PARALLEL(Threads), 
				retry(retrys),
				onFail(myFail(LEFT)));
				
// output(choosen(resu, eyeball), named('roxie_result'));
	
fd_attributes_norm := RECORD
	string30 AccountNumber;
	Models.Layout_FraudAttributes.version2;	
	Models.Layout_FraudAttributes.version201;	
	Models.Layout_FraudAttributes.version202;	
	Models.Layout_FraudAttributes.Threatmetrix;	
	string3 FP_score1;
	string5 FP_reason1_1;
	string5 FP_reason1_2;
	string5 FP_reason1_3;
	string5 FP_reason1_4;
	string5 FP_reason1_5;
	string5 FP_reason1_6;
  string3 FP_score2;
	string5 FP_reason2_1;
	string5 FP_reason2_2;
	string5 FP_reason2_3;
	string5 FP_reason2_4;
	string5 FP_reason2_5;
	string5 FP_reason2_6;
  string3 FP_score3;
	string5 FP_reason3_1;
	string5 FP_reason3_2;
	string5 FP_reason3_3;
	string5 FP_reason3_4;
	string5 FP_reason3_5;
	string5 FP_reason3_6;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;

	string6 historydate;
	string200 errorcode;
END;

No_attributes_layout := RECORD
	string30 AccountNumber;
	string3 FP_score1;
	string5 FP_reason1_1;
	string5 FP_reason1_2;
	string5 FP_reason1_3;
	string5 FP_reason1_4;
	string5 FP_reason1_5;
	string5 FP_reason1_6;
  string3 FP_score2;
	string5 FP_reason2_1;
	string5 FP_reason2_2;
	string5 FP_reason2_3;
	string5 FP_reason2_4;
	string5 FP_reason2_5;
	string5 FP_reason2_6;
  string3 FP_score3;
	string5 FP_reason3_1;
	string5 FP_reason3_2;
	string5 FP_reason3_3;
	string5 FP_reason3_4;
	string5 FP_reason3_5;
	string5 FP_reason3_6;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;

	string6 historydate;
	string200 errorcode;
END;

Output_attr_group := CASE(RequestedAttrGroup,
                          'fraudpointattrv202_diattrv1' => 'Version202_DI1',
                          'fraudpointattrv202'          => 'Version202',
                          'fraudpointattrv201'          => 'Version201',
                          'fraudpointattrv2'            => 'Version2',
                                                           ''
                          );

get_group(recordof(Layout_FDAttributesOut) groups, string name_i) := function
	groupi := groups.attributegroup(name=name_i);
	return groupi;
end;

get_attribute(dataset(Layout_AttributeGroup) groupi, integer i) := function
	attr := groupi.attributes[i];
	return attr;	
end;

fd_attributes_norm normit(resu L, fdInput R) := transform
	self.AccountNumber := r.old_account_number;
		
	// Digital Insights attribute output
	v := get_group(l, Output_attr_group);
  v1	:= get_attribute(v, 	1	);
  v2	:= get_attribute(v, 	2	);
  v3	:= get_attribute(v, 	3	);
  v4	:= get_attribute(v, 	4	);
  v5	:= get_attribute(v, 	5	);
  v6	:= get_attribute(v, 	6	);
  v7	:= get_attribute(v, 	7	);
  v8	:= get_attribute(v, 	8	);
  v9	:= get_attribute(v, 	9	);
  v10	:= get_attribute(v, 	10	);
  v11	:= get_attribute(v, 	11	);
  v12	:= get_attribute(v, 	12	);
  v13	:= get_attribute(v, 	13	);
  v14	:= get_attribute(v, 	14	);
  v15	:= get_attribute(v, 	15	);
  v16	:= get_attribute(v, 	16	);
  v17	:= get_attribute(v, 	17	);
  v18	:= get_attribute(v, 	18	);
  v19	:= get_attribute(v, 	19	);
  v20	:= get_attribute(v, 	20	);
  v21	:= get_attribute(v, 	21	);
  v22	:= get_attribute(v, 	22	);
  v23	:= get_attribute(v, 	23	);
  v24	:= get_attribute(v, 	24	);
  v25	:= get_attribute(v, 	25	);
  v26	:= get_attribute(v, 	26	);
  v27	:= get_attribute(v, 	27	);
  v28	:= get_attribute(v, 	28	);
  v29	:= get_attribute(v, 	29	);
  v30	:= get_attribute(v, 	30	);
  v31	:= get_attribute(v, 	31	);
  v32	:= get_attribute(v, 	32	);
  v33	:= get_attribute(v, 	33	);
  v34	:= get_attribute(v, 	34	);
  v35	:= get_attribute(v, 	35	);
  v36	:= get_attribute(v, 	36	);
  v37	:= get_attribute(v, 	37	);
  v38	:= get_attribute(v, 	38	);
  v39	:= get_attribute(v, 	39	);
  v40	:= get_attribute(v, 	40	);
  v41	:= get_attribute(v, 	41	);
  v42	:= get_attribute(v, 	42	);
  v43	:= get_attribute(v, 	43	);
  v44	:= get_attribute(v, 	44	);
  v45	:= get_attribute(v, 	45	);
  v46	:= get_attribute(v, 	46	);
  v47	:= get_attribute(v, 	47	);
  v48	:= get_attribute(v, 	48	);
  v49	:= get_attribute(v, 	49	);
  v50	:= get_attribute(v, 	50	);
  v51	:= get_attribute(v, 	51	);
  v52	:= get_attribute(v, 	52	);
  v53	:= get_attribute(v, 	53	);
  v54	:= get_attribute(v, 	54	);
  v55	:= get_attribute(v, 	55	);
  v56	:= get_attribute(v, 	56	);
  v57	:= get_attribute(v, 	57	);
  v58	:= get_attribute(v, 	58	);
  v59	:= get_attribute(v, 	59	);
  v60	:= get_attribute(v, 	60	);
  v61	:= get_attribute(v, 	61	);
  v62	:= get_attribute(v, 	62	);
  v63	:= get_attribute(v, 	63	);
  v64	:= get_attribute(v, 	64	);
  v65	:= get_attribute(v, 	65	);
  v66	:= get_attribute(v, 	66	);
  v67	:= get_attribute(v, 	67	);
  v68	:= get_attribute(v, 	68	);
  v69	:= get_attribute(v, 	69	);
  v70	:= get_attribute(v, 	70	);
  v71	:= get_attribute(v, 	71	);
  v72	:= get_attribute(v, 	72	);
  v73	:= get_attribute(v, 	73	);
  v74	:= get_attribute(v, 	74	);
  v75	:= get_attribute(v, 	75	);
  v76	:= get_attribute(v, 	76	);
  v77	:= get_attribute(v, 	77	);
  v78	:= get_attribute(v, 	78	);
  v79	:= get_attribute(v, 	79	);
  v80	:= get_attribute(v, 	80	);
  v81	:= get_attribute(v, 	81	);
  v82	:= get_attribute(v, 	82	);
  v83	:= get_attribute(v, 	83	);
  v84	:= get_attribute(v, 	84	);
  v85	:= get_attribute(v, 	85	);
  v86	:= get_attribute(v, 	86	);
  v87	:= get_attribute(v, 	87	);
  v88	:= get_attribute(v, 	88	);
  v89	:= get_attribute(v, 	89	);
  v90	:= get_attribute(v, 	90	);
  v91	:= get_attribute(v, 	91	);
  v92	:= get_attribute(v, 	92	);
  v93	:= get_attribute(v, 	93	);
  v94	:= get_attribute(v, 	94	);
  v95	:= get_attribute(v, 	95	);
  v96	:= get_attribute(v, 	96	);
  v97	:= get_attribute(v, 	97	);
  v98	:= get_attribute(v, 	98	);
  v99	:= get_attribute(v, 	99	);
  v100	:= get_attribute(v, 	100	);
  v101	:= get_attribute(v, 	101	);
  v102	:= get_attribute(v, 	102	);
  v103	:= get_attribute(v, 	103	);
  v104	:= get_attribute(v, 	104	);
  v105	:= get_attribute(v, 	105	);
  v106	:= get_attribute(v, 	106	);
  v107	:= get_attribute(v, 	107	);
  v108	:= get_attribute(v, 	108	);
  v109	:= get_attribute(v, 	109	);
  v110	:= get_attribute(v, 	110	);
  v111	:= get_attribute(v, 	111	);
  v112	:= get_attribute(v, 	112	);
  v113	:= get_attribute(v, 	113	);
  v114	:= get_attribute(v, 	114	);
  v115	:= get_attribute(v, 	115	);
  v116	:= get_attribute(v, 	116	);
  v117	:= get_attribute(v, 	117	);
  v118	:= get_attribute(v, 	118	);
  v119	:= get_attribute(v, 	119	);
  v120	:= get_attribute(v, 	120	);
  v121	:= get_attribute(v, 	121	);
  v122	:= get_attribute(v, 	122	);
  v123	:= get_attribute(v, 	123	);
  v124	:= get_attribute(v, 	124	);
  v125	:= get_attribute(v, 	125	);
  v126	:= get_attribute(v, 	126	);
  v127	:= get_attribute(v, 	127	);
  v128	:= get_attribute(v, 	128	);
  v129	:= get_attribute(v, 	129	);
  v130	:= get_attribute(v, 	130	);
  v131	:= get_attribute(v, 	131	);
  v132	:= get_attribute(v, 	132	);
  v133	:= get_attribute(v, 	133	);
  v134	:= get_attribute(v, 	134	);
  v135	:= get_attribute(v, 	135	);
  v136	:= get_attribute(v, 	136	);
  v137	:= get_attribute(v, 	137	);
  v138	:= get_attribute(v, 	138	);
  v139	:= get_attribute(v, 	139	);
  v140	:= get_attribute(v, 	140	);
  v141	:= get_attribute(v, 	141	);
  v142	:= get_attribute(v, 	142	);
  v143	:= get_attribute(v, 	143	);
  v144	:= get_attribute(v, 	144	);
  v145	:= get_attribute(v, 	145	);
  v146	:= get_attribute(v, 	146	);
  v147	:= get_attribute(v, 	147	);
  v148	:= get_attribute(v, 	148	);
  v149	:= get_attribute(v, 	149	);
  v150	:= get_attribute(v, 	150	);
  v151	:= get_attribute(v, 	151	);
  v152	:= get_attribute(v, 	152	);
  v153	:= get_attribute(v, 	153	);
  v154	:= get_attribute(v, 	154	);
  v155	:= get_attribute(v, 	155	);
  v156	:= get_attribute(v, 	156	);
  v157	:= get_attribute(v, 	157	);
  v158	:= get_attribute(v, 	158	);
  v159	:= get_attribute(v, 	159	);
  v160	:= get_attribute(v, 	160	);
  v161	:= get_attribute(v, 	161	);
  v162	:= get_attribute(v, 	162	);
  v163	:= get_attribute(v, 	163	);
  v164	:= get_attribute(v, 	164	);
  v165	:= get_attribute(v, 	165	);
  v166	:= get_attribute(v, 	166	);
  v167	:= get_attribute(v, 	167	);
  v168	:= get_attribute(v, 	168	);
  v169	:= get_attribute(v, 	169	);
  v170	:= get_attribute(v, 	170	);
  v171	:= get_attribute(v, 	171	);
  v172	:= get_attribute(v, 	172	);
  v173	:= get_attribute(v, 	173	);
  v174	:= get_attribute(v, 	174	);
  v175	:= get_attribute(v, 	175	);
  v176	:= get_attribute(v, 	176	);
  v177	:= get_attribute(v, 	177	);
  v178	:= get_attribute(v, 	178	);
  v179	:= get_attribute(v, 	179	);
  v180	:= get_attribute(v, 	180	);
  v181	:= get_attribute(v, 	181	);
  v182	:= get_attribute(v, 	182	);
  v183	:= get_attribute(v, 	183	);
  v184	:= get_attribute(v, 	184	);
  v185	:= get_attribute(v, 	185	);
  v186	:= get_attribute(v, 	186	);
  v187	:= get_attribute(v, 	187	);
  v188	:= get_attribute(v, 	188	);
  v189	:= get_attribute(v, 	189	);
  v190	:= get_attribute(v, 	190	);
  v191	:= get_attribute(v, 	191	);
  v192	:= get_attribute(v, 	192	);
  v193	:= get_attribute(v, 	193	);
  v194	:= get_attribute(v, 	194	);
  v195	:= get_attribute(v, 	195	);
  v196	:= get_attribute(v, 	196	);
  v197	:= get_attribute(v, 	197	);
  v198	:= get_attribute(v, 	198	);
  v199	:= get_attribute(v, 	199	);
  v200	:= get_attribute(v, 	200	);
  v201	:= get_attribute(v, 	201	);
  v202	:= get_attribute(v, 	202	);
  v203	:= get_attribute(v, 	203	);
  v204	:= get_attribute(v, 	204	);
  v205	:= get_attribute(v, 	205	);
  v206	:= get_attribute(v, 	206	);
  v207	:= get_attribute(v, 	207	);
  v208	:= get_attribute(v, 	208	);
  v209	:= get_attribute(v, 	209	);
  v210	:= get_attribute(v, 	210	);
  v211	:= get_attribute(v, 	211	);
  v212	:= get_attribute(v, 	212	);
  v213	:= get_attribute(v, 	213	);
  v214	:= get_attribute(v, 	214	);
  v215	:= get_attribute(v, 	215	);
  v216	:= get_attribute(v, 	216	);
  v217	:= get_attribute(v, 	217	);
  v218	:= get_attribute(v, 	218	);
  v219	:= get_attribute(v, 	219	);
  v220	:= get_attribute(v, 	220	);
  v221	:= get_attribute(v, 	221	);
  v222	:= get_attribute(v, 	222	);
  v223	:= get_attribute(v, 	223	);
  v224	:= get_attribute(v, 	224	);
  v225	:= get_attribute(v, 	225	);
  v226	:= get_attribute(v, 	226	);
  v227	:= get_attribute(v, 	227	);
  v228	:= get_attribute(v, 	228	);
  v229	:= get_attribute(v, 	229	);
  v230	:= get_attribute(v, 	230	);
  v231	:= get_attribute(v, 	231	);
  v232	:= get_attribute(v, 	232	);
  v233	:= get_attribute(v, 	233	);
  v234	:= get_attribute(v, 	234	);
  v235	:= get_attribute(v, 	235	);
  v236	:= get_attribute(v, 	236	);
  v237	:= get_attribute(v, 	237	);
  v238	:= get_attribute(v, 	238	);
  v239	:= get_attribute(v, 	239	);
  v240	:= get_attribute(v, 	240	);
  v241	:= get_attribute(v, 	241	);
  v242	:= get_attribute(v, 	242	);
  v243	:= get_attribute(v, 	243	);
  v244	:= get_attribute(v, 	244	);
  v245	:= get_attribute(v, 	245	);
  v246	:= get_attribute(v, 	246	);
  v247	:= get_attribute(v, 	247	);
  v248	:= get_attribute(v, 	248	);
  v249	:= get_attribute(v, 	249	);
  v250	:= get_attribute(v, 	250	);
  v251	:= get_attribute(v, 	251	);
  v252	:= get_attribute(v, 	252	);
  v253	:= get_attribute(v, 	253	);
  v254	:= get_attribute(v, 	254	);
  v255	:= get_attribute(v, 	255	);
  v256	:= get_attribute(v, 	256	);
  v257	:= get_attribute(v, 	257	);
  v258	:= get_attribute(v, 	258	);
  v259	:= get_attribute(v, 	259	);
  v260	:= get_attribute(v, 	260	);
  v261	:= get_attribute(v, 	261	);
  v262	:= get_attribute(v, 	262	);
  v263	:= get_attribute(v, 	263	);
  v264	:= get_attribute(v, 	264	);
  v265	:= get_attribute(v, 	265	);
  v266	:= get_attribute(v, 	266	);
  v267	:= get_attribute(v, 	267	);
  v268	:= get_attribute(v, 	268	);
  v269	:= get_attribute(v, 	269	);
  v270	:= get_attribute(v, 	270	);
  v271	:= get_attribute(v, 	271	);
  v272	:= get_attribute(v, 	272	);
  v273	:= get_attribute(v, 	273	);
  v274	:= get_attribute(v, 	274	);
  v275	:= get_attribute(v, 	275	);
  v276	:= get_attribute(v, 	276	);
  v277	:= get_attribute(v, 	277	);
  v278	:= get_attribute(v, 	278	);
  v279	:= get_attribute(v, 	279	);
  v280	:= get_attribute(v, 	280	);
  v281	:= get_attribute(v, 	281	);
  v282	:= get_attribute(v, 	282	);
  v283	:= get_attribute(v, 	283	);
  v284	:= get_attribute(v, 	284	);
  v285	:= get_attribute(v, 	285	);
  v286	:= get_attribute(v, 	286	);
  v287	:= get_attribute(v, 	287	);
  v288	:= get_attribute(v, 	288	);
  v289	:= get_attribute(v, 	289	);
  v290	:= get_attribute(v, 	290	);
  v291	:= get_attribute(v, 	291	);
  v292	:= get_attribute(v, 	292	);
  v293	:= get_attribute(v, 	293	);
  v294	:= get_attribute(v, 	294	);
  v295	:= get_attribute(v, 	295	);
  v296	:= get_attribute(v, 	296	);
  v297	:= get_attribute(v, 	297	);
  v298	:= get_attribute(v, 	298	);
  v299	:= get_attribute(v, 	299	);
  v300	:= get_attribute(v, 	300	);
  v301	:= get_attribute(v, 	301	);
  v302	:= get_attribute(v, 	302	);
  v303	:= get_attribute(v, 	303	);
  v304	:= get_attribute(v, 	304	);
  v305	:= get_attribute(v, 	305	);
  v306	:= get_attribute(v, 	306	);
  v307	:= get_attribute(v, 	307	);
  v308	:= get_attribute(v, 	308	);
  v309	:= get_attribute(v, 	309	);
  v310	:= get_attribute(v, 	310	);
  v311	:= get_attribute(v, 	311	);
  v312	:= get_attribute(v, 	312	);
  v313	:= get_attribute(v, 	313	);
  v314	:= get_attribute(v, 	314	);
  v315	:= get_attribute(v, 	315	);
  v316	:= get_attribute(v, 	316	);
  v317	:= get_attribute(v, 	317	);
  v318	:= get_attribute(v, 	318	);
  v319	:= get_attribute(v, 	319	);
  v320	:= get_attribute(v, 	320	);
  v321	:= get_attribute(v, 	321	);
  v322	:= get_attribute(v, 	322	);
  v323	:= get_attribute(v, 	323	);
  v324	:= get_attribute(v, 	324	);
  v325	:= get_attribute(v, 	325	);
  v326	:= get_attribute(v, 	326	);
  v327	:= get_attribute(v, 	327	);
  v328	:= get_attribute(v, 	328	);
  v329	:= get_attribute(v, 	329	);
  v330	:= get_attribute(v, 	330	);
  v331	:= get_attribute(v, 	331	);
  v332	:= get_attribute(v, 	332	);
  v333	:= get_attribute(v, 	333	);
  v334	:= get_attribute(v, 	334	);
  v335	:= get_attribute(v, 	335	);
  v336	:= get_attribute(v, 	336	);
  v337	:= get_attribute(v, 	337	);
  v338	:= get_attribute(v, 	338	);
  v339	:= get_attribute(v, 	339	);
  v340	:= get_attribute(v, 	340	);
  v341	:= get_attribute(v, 	341	);
  v342	:= get_attribute(v, 	342	);
  v343	:= get_attribute(v, 	343	);
  v344	:= get_attribute(v, 	344	);
  v345	:= get_attribute(v, 	345	);
  v346	:= get_attribute(v, 	346	);
  v347	:= get_attribute(v, 	347	);
  v348	:= get_attribute(v, 	348	);
  v349	:= get_attribute(v, 	349	);
  v350	:= get_attribute(v, 	350	);
  v351	:= get_attribute(v, 	351	);
  v352	:= get_attribute(v, 	352	);
  v353	:= get_attribute(v, 	353	);
  v354	:= get_attribute(v, 	354	);
  v355	:= get_attribute(v, 	355	);
  v356	:= get_attribute(v, 	356	);
  v357	:= get_attribute(v, 	357	);
  v358	:= get_attribute(v, 	358	);
  v359	:= get_attribute(v, 	359	);
  v360	:= get_attribute(v, 	360	);
  v361	:= get_attribute(v, 	361	);
  v362	:= get_attribute(v, 	362	);
  v363	:= get_attribute(v, 	363	);
  v364	:= get_attribute(v, 	364	);
  v365	:= get_attribute(v, 	365	);
  v366	:= get_attribute(v, 	366	);
  v367	:= get_attribute(v, 	367	);
  v368	:= get_attribute(v, 	368	);
  v369	:= get_attribute(v, 	369	);
  v370	:= get_attribute(v, 	370	);
  v371	:= get_attribute(v, 	371	);
  v372	:= get_attribute(v, 	372	);
  v373	:= get_attribute(v, 	373	);
  v374	:= get_attribute(v, 	374	);
  v375	:= get_attribute(v, 	375	);
  v376	:= get_attribute(v, 	376	);
  v377	:= get_attribute(v, 	377	);
  v378	:= get_attribute(v, 	378	);
  v379	:= get_attribute(v, 	379	);
  v380	:= get_attribute(v, 	380	);
  v381	:= get_attribute(v, 	381	);
  v382	:= get_attribute(v, 	382	);
  v383	:= get_attribute(v, 	383	);
  v384	:= get_attribute(v, 	384	);
  v385 := get_attribute(v, 385);
  v386 := get_attribute(v, 386);
  v387 := get_attribute(v, 387);
  v388 := get_attribute(v, 388);
  v389 := get_attribute(v, 389);
  v390 := get_attribute(v, 390);
  v391 := get_attribute(v, 391);
  v392 := get_attribute(v, 392);
  v393 := get_attribute(v, 393);
  v394 := get_attribute(v, 394);
  v395 := get_attribute(v, 395);
  v396 := get_attribute(v, 396);
  v397 := get_attribute(v, 397);
  v398 := get_attribute(v, 398);
  v399 := get_attribute(v, 399);
  v400 := get_attribute(v, 400);
  v401 := get_attribute(v, 401);
  v402 := get_attribute(v, 402);
  v403 := get_attribute(v, 403);
  v404 := get_attribute(v, 404);
  v405 := get_attribute(v, 405);
  v406 := get_attribute(v, 406);
  v407 := get_attribute(v, 407);
  v408 := get_attribute(v, 408);
  v409 := get_attribute(v, 409);
  v410 := get_attribute(v, 410);
  v411 := get_attribute(v, 411);
  v412 := get_attribute(v, 412);
  v413 := get_attribute(v, 413);
  v414 := get_attribute(v, 414);
  v415 := get_attribute(v, 415);
  v416 := get_attribute(v, 416);
  v417 := get_attribute(v, 417);
  v418 := get_attribute(v, 418);
  v419 := get_attribute(v, 419);
  v420 := get_attribute(v, 420);
  v421 := get_attribute(v, 421);
  v422 := get_attribute(v, 422);
  v423 := get_attribute(v, 423);
  v424 := get_attribute(v, 424);
  v425 := get_attribute(v, 425);
  v426 := get_attribute(v, 426);
  v427 := get_attribute(v, 427);
  v428 := get_attribute(v, 428);
  v429 := get_attribute(v, 429);
  v430 := get_attribute(v, 430);
  v431 := get_attribute(v, 431);
  v432 := get_attribute(v, 432);
  v433 := get_attribute(v, 433);
  v434 := get_attribute(v, 434);
  v435 := get_attribute(v, 435);
  v436 := get_attribute(v, 436);
  v437 := get_attribute(v, 437);
  v438 := get_attribute(v, 438);
  v439 := get_attribute(v, 439);
  v440 := get_attribute(v, 440);
  v441 := get_attribute(v, 441);
  v442 := get_attribute(v, 442);
  v443 := get_attribute(v, 443);
  v444 := get_attribute(v, 444);
  v445 := get_attribute(v, 445);
  v446 := get_attribute(v, 446);
  v447 := get_attribute(v, 447);
  v448 := get_attribute(v, 448);
  v449 := get_attribute(v, 449);
  v450 := get_attribute(v, 450);
  v451 := get_attribute(v, 451);
  v452 := get_attribute(v, 452);
  v453 := get_attribute(v, 453);
  v454 := get_attribute(v, 454);
  v455 := get_attribute(v, 455);
  v456 := get_attribute(v, 456);
  v457 := get_attribute(v, 457);
  v458 := get_attribute(v, 458);
  v459 := get_attribute(v, 459);
  v460 := get_attribute(v, 460);
  v461 := get_attribute(v, 461);
  v462 := get_attribute(v, 462);
  v463 := get_attribute(v, 463);
  v464 := get_attribute(v, 464);
  v465 := get_attribute(v, 465);
  v466 := get_attribute(v, 466);
  v467 := get_attribute(v, 467);
  v468 := get_attribute(v, 468);
  v469 := get_attribute(v, 469);
  v470 := get_attribute(v, 470);
  v471 := get_attribute(v, 471);
  v472 := get_attribute(v, 472);
  v473 := get_attribute(v, 473);
  v474 := get_attribute(v, 474);
  v475 := get_attribute(v, 475);
  v476 := get_attribute(v, 476);
  v477 := get_attribute(v, 477);
  v478 := get_attribute(v, 478);
  v479 := get_attribute(v, 479);
  v480 := get_attribute(v, 480);
  v481 := get_attribute(v, 481);
  v482 := get_attribute(v, 482);
  v483 := get_attribute(v, 483);
  v484 := get_attribute(v, 484);
  v485 := get_attribute(v, 485);
  v486 := get_attribute(v, 486);
  v487 := get_attribute(v, 487);
  v488 := get_attribute(v, 488);
  v489 := get_attribute(v, 489);
  v490 := get_attribute(v, 490);
  v491 := get_attribute(v, 491);
  v492 := get_attribute(v, 492);
  v493 := get_attribute(v, 493);
  v494 := get_attribute(v, 494);
  v495 := get_attribute(v, 495);
  v496 := get_attribute(v, 496);
  v497 := get_attribute(v, 497);
  v498 := get_attribute(v, 498);
  v499 := get_attribute(v, 499);
  v500 := get_attribute(v, 500);
  v501 := get_attribute(v, 501);
  v502 := get_attribute(v, 502);
  v503 := get_attribute(v, 503);
  v504 := get_attribute(v, 504);
  v505 := get_attribute(v, 505);
  v506 := get_attribute(v, 506);
  v507 := get_attribute(v, 507);
  v508 := get_attribute(v, 508);
  v509 := get_attribute(v, 509);
  v510 := get_attribute(v, 510);
  v511 := get_attribute(v, 511);
  v512 := get_attribute(v, 512);
  v513 := get_attribute(v, 513);
  v514 := get_attribute(v, 514);
  v515 := get_attribute(v, 515);
  v516 := get_attribute(v, 516);
  v517 := get_attribute(v, 517);
  v518 := get_attribute(v, 518);
  v519 := get_attribute(v, 519);
  v520 := get_attribute(v, 520);
  v521 := get_attribute(v, 521);
  v522 := get_attribute(v, 522);
  v523 := get_attribute(v, 523);
  v524 := get_attribute(v, 524);
  v525 := get_attribute(v, 525);
  v526 := get_attribute(v, 526);
  v527 := get_attribute(v, 527);
  v528 := get_attribute(v, 528);
  v529 := get_attribute(v, 529);
  v530 := get_attribute(v, 530);
  v531 := get_attribute(v, 531);
  v532 := get_attribute(v, 532);
  v533 := get_attribute(v, 533);
  v534 := get_attribute(v, 534);
  v535 := get_attribute(v, 535);
  v536 := get_attribute(v, 536);
  v537 := get_attribute(v, 537);
  v538 := get_attribute(v, 538);
	
self.IdentityRiskLevel	:= v1.attribute[1].value;
self.IdentityAgeOldest	:= v2.attribute[1].value;
self.IdentityAgeNewest	:= v3.attribute[1].value;
self.IdentityRecentUpdate	:= v4.attribute[1].value;
self.IdentityRecordCount	:= v5.attribute[1].value;
self.IdentitySourceCount	:= v6.attribute[1].value;
self.IdentityAgeRiskIndicator	:= v7.attribute[1].value;
self.IDVerRiskLevel	:= v8.attribute[1].value;
self.IDVerSSN	:= v9.attribute[1].value;
self.IDVerName	:= v10.attribute[1].value;
self.IDVerAddress	:= v11.attribute[1].value;
self.IDVerAddressNotCurrent	:= v12.attribute[1].value;
self.IDVerAddressAssocCount	:= v13.attribute[1].value;
self.IDVerPhone	:= v14.attribute[1].value;
self.IDVerDriversLicense	:= v15.attribute[1].value;
self.IDVerDOB	:= v16.attribute[1].value;
self.IDVerSSNSourceCount	:= v17.attribute[1].value;
self.IDVerAddressSourceCount	:= v18.attribute[1].value;
self.IDVerDOBSourceCount	:= v19.attribute[1].value;
self.IDVerSSNCreditBureauCount	:= v20.attribute[1].value;
self.IDVerSSNCreditBureauDelete	:= v21.attribute[1].value;
self.IDVerAddrCreditBureauCount	:= v22.attribute[1].value;  
self.SourceRiskLevel	:= v23.attribute[1].value;
self.SourceFirstReportingIdentity	:= v24.attribute[1].value;
self.SourceCreditBureau	:= v25.attribute[1].value;
self.SourceCreditBureauCount	:= v26.attribute[1].value;
self.SourceCreditBureauAgeOldest	:= v27.attribute[1].value;
self.SourceCreditBureauAgeNewest	:= v28.attribute[1].value;
self.SourceCreditBureauAgeChange	:= v29.attribute[1].value;
self.SourcePublicRecord	:= v30.attribute[1].value;
self.SourcePublicRecordCount	:= v31.attribute[1].value;
self.SourcePublicRecordCountYear	:= v32.attribute[1].value;
self.SourceEducation	:= v33.attribute[1].value;
self.SourceOccupationalLicense	:= v34.attribute[1].value;
self.SourceVoterRegistration	:= v35.attribute[1].value;
self.SourceOnlineDirectory	:= v36.attribute[1].value;
self.SourceDoNotMail	:= v37.attribute[1].value;
self.SourceAccidents	:= v38.attribute[1].value;
self.SourceBusinessRecords	:= v39.attribute[1].value;
self.SourceProperty	:= v40.attribute[1].value;
self.SourceAssets	:= v41.attribute[1].value;
self.SourcePhoneDirectoryAssistance	:= v42.attribute[1].value;
self.SourcePhoneNonPublicDirectory	:= v43.attribute[1].value;
self.VariationRiskLevel	:= v44.attribute[1].value;
self.VariationIdentityCount	:= v45.attribute[1].value;
self.VariationSSNCount	:= v46.attribute[1].value;
self.VariationSSNCountNew	:= v47.attribute[1].value;
self.VariationMSourcesSSNCount	:= v48.attribute[1].value;
self.VariationMSourcesSSNUnrelCount	:= v49.attribute[1].value;
self.VariationLastNameCount	:= v50.attribute[1].value;
self.VariationLastNameCountNew	:= v51.attribute[1].value;
self.VariationAddrCountYear	:= v52.attribute[1].value;
self.VariationAddrCountNew	:= v53.attribute[1].value;
self.VariationAddrStability	:= v54.attribute[1].value;
self.VariationAddrChangeAge	:= v55.attribute[1].value;
self.VariationDOBCount	:= v56.attribute[1].value;
self.VariationDOBCountNew	:= v57.attribute[1].value;
self.VariationPhoneCount	:= v58.attribute[1].value;
self.VariationPhoneCountNew	:= v59.attribute[1].value;
self.VariationSearchSSNCount	:= v60.attribute[1].value;
self.VariationSearchAddrCount	:= v61.attribute[1].value;
self.VariationSearchPhoneCount	:= v62.attribute[1].value;
self.SearchVelocityRiskLevel	:= v63.attribute[1].value;
self.SearchCount	:= v64.attribute[1].value;
self.SearchCountYear	:= v65.attribute[1].value;
self.SearchCountMonth	:= v66.attribute[1].value;
self.SearchCountWeek	:= v67.attribute[1].value;
self.SearchCountDay	:= v68.attribute[1].value;
self.SearchUnverifiedSSNCountYear	:= v69.attribute[1].value;
self.SearchUnverifiedAddrCountYear	:= v70.attribute[1].value;
self.SearchUnverifiedDOBCountYear	:= v71.attribute[1].value;
self.SearchUnverifiedPhoneCountYear	:= v72.attribute[1].value;
self.SearchBankingSearchCount	:= v73.attribute[1].value;
self.SearchBankingSearchCountYear	:= v74.attribute[1].value;
self.SearchBankingSearchCountMonth	:= v75.attribute[1].value;
self.SearchBankingSearchCountWeek	:= v76.attribute[1].value;
self.SearchBankingSearchCountDay	:= v77.attribute[1].value;
self.SearchHighRiskSearchCount	:= v78.attribute[1].value;
self.SearchHighRiskSearchCountYear	:= v79.attribute[1].value;
self.SearchHighRiskSearchCountMonth	:= v80.attribute[1].value;
self.SearchHighRiskSearchCountWeek	:= v81.attribute[1].value;
self.SearchHighRiskSearchCountDay	:= v82.attribute[1].value;
self.SearchFraudSearchCount	:= v83.attribute[1].value;
self.SearchFraudSearchCountYear	:= v84.attribute[1].value;
self.SearchFraudSearchCountMonth	:= v85.attribute[1].value;
self.SearchFraudSearchCountWeek	:= v86.attribute[1].value;
self.SearchFraudSearchCountDay	:= v87.attribute[1].value;
self.SearchLocateSearchCount	:= v88.attribute[1].value;
self.SearchLocateSearchCountYear	:= v89.attribute[1].value;
self.SearchLocateSearchCountMonth	:= v90.attribute[1].value;
self.SearchLocateSearchCountWeek	:= v91.attribute[1].value;
self.SearchLocateSearchCountDay	:= v92.attribute[1].value;
self.AssocRiskLevel	:= v93.attribute[1].value;
self.AssocCount	:= v94.attribute[1].value;
self.AssocDistanceClosest	:= v95.attribute[1].value;
self.AssocSuspicousIdentitiesCount	:= v96.attribute[1].value;
self.AssocCreditBureauOnlyCount	:= v97.attribute[1].value;
self.AssocCreditBureauOnlyCountNew	:= v98.attribute[1].value;
self.AssocCreditBureauOnlyCountMonth	:= v99.attribute[1].value;
self.AssocHighRiskTopologyCount	:= v100.attribute[1].value;
self.ValidationRiskLevel	:= v101.attribute[1].value;
self.ValidationSSNProblems	:= v102.attribute[1].value;
self.ValidationAddrProblems	:= v103.attribute[1].value;
self.ValidationPhoneProblems	:= v104.attribute[1].value;
self.ValidationDLProblems	:= v105.attribute[1].value;
self.ValidationIPProblems	:= v106.attribute[1].value;
self.CorrelationRiskLevel	:= v107.attribute[1].value;
self.CorrelationSSNNameCount	:= v108.attribute[1].value;
self.CorrelationSSNAddrCount	:= v109.attribute[1].value;
self.CorrelationAddrNameCount	:= v110.attribute[1].value;
self.CorrelationAddrPhoneCount	:= v111.attribute[1].value;
self.CorrelationPhoneLastNameCount	:= v112.attribute[1].value;
self.DivRiskLevel	:= v113.attribute[1].value;
self.DivSSNIdentityCount	:= v114.attribute[1].value;
self.DivSSNIdentityCountNew	:= v115.attribute[1].value;
self.DivSSNIdentityMSourceCount	:= v116.attribute[1].value;
self.DivSSNIdentityMSourceUrelCount	:= v117.attribute[1].value;
self.DivSSNLNameCount	:= v118.attribute[1].value;
self.DivSSNLNameCountNew	:= v119.attribute[1].value;
self.DivSSNAddrCount	:= v120.attribute[1].value;
self.DivSSNAddrCountNew	:= v121.attribute[1].value;
self.DivSSNAddrMSourceCount	:= v122.attribute[1].value;
self.DivAddrIdentityCount	:= v123.attribute[1].value;
self.DivAddrIdentityCountNew	:= v124.attribute[1].value;
self.DivAddrIdentityMSourceCount	:= v125.attribute[1].value;
self.DivAddrSuspIdentityCountNew	:= v126.attribute[1].value;
self.DivAddrSSNCount	:= v127.attribute[1].value;
self.DivAddrSSNCountNew	:= v128.attribute[1].value;
self.DivAddrSSNMSourceCount	:= v129.attribute[1].value;
self.DivAddrPhoneCount	:= v130.attribute[1].value;
self.DivAddrPhoneCountNew	:= v131.attribute[1].value;
self.DivAddrPhoneMSourceCount	:= v132.attribute[1].value;
self.DivPhoneIdentityCount	:= v133.attribute[1].value;
self.DivPhoneIdentityCountNew	:= v134.attribute[1].value;
self.DivPhoneIdentityMSourceCount	:= v135.attribute[1].value;
self.DivPhoneAddrCount	:= v136.attribute[1].value;
self.DivPhoneAddrCountNew	:= v137.attribute[1].value;
self.DivSearchSSNIdentityCount	:= v138.attribute[1].value;
self.DivSearchAddrIdentityCount	:= v139.attribute[1].value;
self.DivSearchAddrSuspIdentityCount	:= v140.attribute[1].value;
self.DivSearchPhoneIdentityCount	:= v141.attribute[1].value;
self.SearchComponentRiskLevel	:= v142.attribute[1].value;
self.SearchSSNSearchCount	:= v143.attribute[1].value;
self.SearchSSNSearchCountYear	:= v144.attribute[1].value;
self.SearchSSNSearchCountMonth	:= v145.attribute[1].value;
self.SearchSSNSearchCountWeek	:= v146.attribute[1].value;
self.SearchSSNSearchCountDay	:= v147.attribute[1].value;
self.SearchAddrSearchCount	:= v148.attribute[1].value;
self.SearchAddrSearchCountYear	:= v149.attribute[1].value;
self.SearchAddrSearchCountMonth	:= v150.attribute[1].value;
self.SearchAddrSearchCountWeek	:= v151.attribute[1].value;
self.SearchAddrSearchCountDay	:= v152.attribute[1].value;
self.SearchPhoneSearchCount	:= v153.attribute[1].value;
self.SearchPhoneSearchCountYear	:= v154.attribute[1].value;
self.SearchPhoneSearchCountMonth	:= v155.attribute[1].value;
self.SearchPhoneSearchCountWeek	:= v156.attribute[1].value;
self.SearchPhoneSearchCountDay	:= v157.attribute[1].value;
self.ComponentCharRiskLevel	:= v158.attribute[1].value;
self.SSNHighIssueAge	:= v159.attribute[1].value;
self.SSNLowIssueAge	:= v160.attribute[1].value;
self.SSNIssueState	:= v161.attribute[1].value;
self.SSNNonUS	:= v162.attribute[1].value;
self.InputPhoneType	:= v163.attribute[1].value;
self.IPState	:= v164.attribute[1].value;
self.IPCountry	:= v165.attribute[1].value;
self.IPContinent	:= v166.attribute[1].value;
self.InputAddrAgeOldest	:= v167.attribute[1].value;
self.InputAddrAgeNewest	:= v168.attribute[1].value;
self.InputAddrType	:= v169.attribute[1].value;
self.InputAddrLenOfRes	:= v170.attribute[1].value;
self.InputAddrDwellType	:= v171.attribute[1].value;
self.InputAddrDelivery	:= v172.attribute[1].value;
self.InputAddrActivePhoneList	:= v173.attribute[1].value;
self.InputAddrOccupantOwned	:= v174.attribute[1].value;
self.InputAddrBusinessCount	:= v175.attribute[1].value;
self.InputAddrNBRHDBusinessCount	:= v176.attribute[1].value;
self.InputAddrNBRHDSingleFamilyCount	:= v177.attribute[1].value;
self.InputAddrNBRHDMultiFamilyCount	:= v178.attribute[1].value;
self.InputAddrNBRHDMedianIncome	:= v179.attribute[1].value;
self.InputAddrNBRHDMedianValue	:= v180.attribute[1].value;
self.InputAddrNBRHDMurderIndex	:= v181.attribute[1].value;
self.InputAddrNBRHDCarTheftIndex	:= v182.attribute[1].value;
self.InputAddrNBRHDBurglaryIndex	:= v183.attribute[1].value;
self.InputAddrNBRHDCrimeIndex	:= v184.attribute[1].value;
self.InputAddrNBRHDMobilityIndex	:= v185.attribute[1].value;
self.InputAddrNBRHDVacantPropCount	:= v186.attribute[1].value;
self.AddrChangeDistance	:= v187.attribute[1].value;
self.AddrChangeStateDiff	:= v188.attribute[1].value;
self.AddrChangeIncomeDiff	:= v189.attribute[1].value;
self.AddrChangeValueDiff	:= v190.attribute[1].value;
self.AddrChangeCrimeDiff	:= v191.attribute[1].value;
self.AddrChangeEconTrajectory	:= v192.attribute[1].value;
self.AddrChangeEconTrajectoryIndex	:= v193.attribute[1].value;
self.CurrAddrAgeOldest	:= v194.attribute[1].value;
self.CurrAddrAgeNewest	:= v195.attribute[1].value;
self.CurrAddrLenOfRes	:= v196.attribute[1].value;
self.CurrAddrDwellType	:= v197.attribute[1].value;
self.CurrAddrStatus	:= v198.attribute[1].value;
self.CurrAddrActivePhoneList	:= v199.attribute[1].value;
self.CurrAddrMedianIncome	:= v200.attribute[1].value;
self.CurrAddrMedianValue	:= v201.attribute[1].value;
self.CurrAddrMurderIndex	:= v202.attribute[1].value;
self.CurrAddrCarTheftIndex	:= v203.attribute[1].value;
self.CurrAddrBurglaryIndex	:= v204.attribute[1].value;
self.CurrAddrCrimeIndex	:= v205.attribute[1].value;
self.PrevAddrAgeOldest	:= v206.attribute[1].value;
self.PrevAddrAgeNewest	:= v207.attribute[1].value;
self.PrevAddrLenOfRes	:= v208.attribute[1].value;
self.PrevAddrDwellType	:= v209.attribute[1].value;
self.PrevAddrStatus	:= v210.attribute[1].value;
self.PrevAddrOccupantOwned	:= v211.attribute[1].value;
self.PrevAddrMedianIncome	:= v212.attribute[1].value;
self.PrevAddrMedianValue	:= v213.attribute[1].value;
self.PrevAddrMurderIndex	:= v214.attribute[1].value;
self.PrevAddrCarTheftIndex	:= v215.attribute[1].value;
self.PrevAddrBurglaryIndex	:= v216.attribute[1].value;
self.PrevAddrCrimeIndex	:= v217.attribute[1].value;
//AmEx 201 attributes
self.IDVerAddressMatchesCurrent	:= v218.attribute[1].value;
self.IDVerAddressVoter	:= v219.attribute[1].value;
self.IDVerAddressVehicleRegistation	:= v220.attribute[1].value;
self.IDVerAddressDriversLicense	:= v221.attribute[1].value;
self.IDVerDriversLicenseType	:= v222.attribute[1].value;
self.IDVerSSNDriversLicense	:= v223.attribute[1].value;
self.SourceVehicleRegistration	:= v224.attribute[1].value;
self.SourceDriversLicense	:= v225.attribute[1].value;
self.IdentityDriversLicenseComp	:= if(_SuppressCompromisedDLs, v226.attribute[1].value, 'XX');  // only populate this field when it's requested
//AmEx 202 attributes
self.IDVerFNameBest := v227.attribute[1].value;
self.IDVerLNameBest := v228.attribute[1].value;
self.IDVerSSNBest := v229.attribute[1].value;
self.VariationSearchSSNCtDay := v230.attribute[1].value;
self.VariationSearchSSNCtWeek := v231.attribute[1].value;
self.VariationSearchSSNCtMonth := v232.attribute[1].value;
self.VariationSearchSSNCt3Month := v233.attribute[1].value;
self.VariationSearchSSNCtNew := v234.attribute[1].value;
self.VariationSearchAddrCtDay := v235.attribute[1].value;
self.VariationSearchAddrCtWeek := v236.attribute[1].value;
self.VariationSearchAddrCtMonth := v237.attribute[1].value;
self.VariationSearchAddrCt3Month := v238.attribute[1].value;
self.VariationSearchAddrCtNew := v239.attribute[1].value;
self.VariationSearchPhoneCtDay := v240.attribute[1].value;
self.VariationSearchPhoneCtWeek := v241.attribute[1].value;
self.VariationSearchPhoneCtMonth := v242.attribute[1].value;
self.VariationSearchPhoneCt3Month := v243.attribute[1].value;
self.VariationSearchLNameCtDay := v244.attribute[1].value;
self.VariationSearchLNameCtWeek := v245.attribute[1].value;
self.VariationSearchLNameCtMonth := v246.attribute[1].value;
self.VariationSearchLNameCt3Month := v247.attribute[1].value;
self.VariationSearchFNameCtDay := v248.attribute[1].value;
self.VariationSearchFNameCtWeek := v249.attribute[1].value;
self.VariationSearchFNameCtMonth := v250.attribute[1].value;
self.VariationSearchFNameCt3Month := v251.attribute[1].value;
self.VariationSearchFNameCtNew := v252.attribute[1].value;
self.VariationSearchDOBCtDay := v253.attribute[1].value;
self.VariationSearchDOBCtWeek := v254.attribute[1].value;
self.VariationSearchDOBCtMonth := v255.attribute[1].value;
self.VariationSearchDOBCt3Month := v256.attribute[1].value;
self.VariationSearchDOBCtNew := v257.attribute[1].value;
self.VariationSearchEmailCt := v258.attribute[1].value;
self.VariationSearchEmailCtDay := v259.attribute[1].value;
self.VariationSearchEmailCtWeek := v260.attribute[1].value;
self.VariationSearchEmailCtMonth := v261.attribute[1].value;
self.VariationSearchEmailCt3Month := v262.attribute[1].value;
self.VariationSearchEmailCtNew := v263.attribute[1].value;
self.VariationSearchSSN1SubCt := v264.attribute[1].value;
self.VariationSearchPhone1SubCt := v265.attribute[1].value;
self.VariationSearchAddr1SubCt := v266.attribute[1].value;
self.VariationSearchDOB1SubCt := v267.attribute[1].value;
self.VariationSearchFName1SubCt := v268.attribute[1].value;
self.VariationSearchLName1SubCt := v269.attribute[1].value;
self.VariationSearchDOB1SubDayCt := v270.attribute[1].value;
self.VariationSearchDOB1SubMoCt := v271.attribute[1].value;
self.VariationSearchDOB1SubYrCt := v272.attribute[1].value;
self.VariationSearchSSNSeqCt := v273.attribute[1].value;
self.VariationSearchPhoneSeqCt := v274.attribute[1].value;
self.VariationSearchAddrSeqCt := v275.attribute[1].value;
self.VariationSearchDobSeqCt := v276.attribute[1].value;
self.SearchSSNBestSearchCt := v277.attribute[1].value;
self.DivSearchSSNBestIdentityCt := v278.attribute[1].value;
self.DivSearchSSNBestLNameCt := v279.attribute[1].value;
self.DivSearchSSNBestAddrCt := v280.attribute[1].value;
self.DivSearchSSNBestDOBCt := v281.attribute[1].value;
self.CorrNameDOBCt := v282.attribute[1].value;
self.CorrAddrDOBCt := v283.attribute[1].value;
self.CorrSSNDOBCt := v284.attribute[1].value;
self.CorrSearchSSNNameCt := v285.attribute[1].value;
self.CorrSearchVerSSNNameCt := v286.attribute[1].value;
self.CorrSearchNamePhoneCt := v287.attribute[1].value;
self.CorrSearchVerNamePhoneCt := v288.attribute[1].value;
self.CorrSearchSSNAddrCt := v289.attribute[1].value;
self.CorrSearchVerSSNAddrCt := v290.attribute[1].value;
self.CorrSearchAddrDOBCt := v291.attribute[1].value;
self.CorrSearchVerAddrDOBCt := v292.attribute[1].value;
self.CorrSearchAddrPhoneCt := v293.attribute[1].value;
self.CorrSearchVerAddrPhoneCt := v294.attribute[1].value;
self.CorrSearchSSNDOBCt := v295.attribute[1].value;
self.CorrSearchVerSSNDOBCt := v296.attribute[1].value;
self.CorrSearchSSNPhoneCt := v297.attribute[1].value;
self.CorrSearchVerSSNPhoneCt := v298.attribute[1].value;
self.CorrSearchDOBPhoneCt := v299.attribute[1].value;
self.CorrSearchVerDOBPhoneCt := v300.attribute[1].value;
self.CorrSearchSSNAddrNameCt := v301.attribute[1].value;
self.CorrSearchVerSSNAddrNameCt := v302.attribute[1].value;
self.CorrSearchSSNNamePhoneCt := v303.attribute[1].value;
self.CorrSearchVerSSNNamePhoneCt := v304.attribute[1].value;
self.CorrSearchSSNAddrNamePhoneCt := v305.attribute[1].value;
self.CorrSearchVerSSNAddrNamePhneCt := v306.attribute[1].value;
self.DivSearchAddrSSNCtDay := v307.attribute[1].value;
self.DivSearchAddrSSNCtWeek := v308.attribute[1].value;
self.DivSearchAddrSSNCt1Month := v309.attribute[1].value;
self.DivSearchAddrSSNCt3Month := v310.attribute[1].value;
self.DivSearchAddrSSNCtNew := v311.attribute[1].value;
self.DivSearchSSNIdentityCtDay := v312.attribute[1].value;
self.DivSearchSSNIdentityCtWeek := v313.attribute[1].value;
self.DivSearchSSNIdentityCt1Month := v314.attribute[1].value;
self.DivSearchSSNIdentityCt3Month := v315.attribute[1].value;
self.DivSearchSSNIdentityCtNew := v316.attribute[1].value;
self.DivSearchAddrIdentityCtDay := v317.attribute[1].value;
self.DivSearchAddrIdentityCtWeek := v318.attribute[1].value;
self.DivSearchAddrIdentityCt1Month := v319.attribute[1].value;
self.DivSearchAddrIdentityCt3Month := v320.attribute[1].value;
self.DivSearchAddrIdentityCtNew := v321.attribute[1].value;
self.DivSearchPhoneIdentityCt := v322.attribute[1].value;
self.DivSearchPhoneIdentityCtDay := v323.attribute[1].value;
self.DivSearchPhoneIdentityCtWeek := v324.attribute[1].value;
self.DivSearchPhoneIdentityCt1Month := v325.attribute[1].value;
self.DivSearchPhoneIdentityCt3Month := v326.attribute[1].value;
self.DivSearchPhoneIdentityCtNew := v327.attribute[1].value;
self.DivSearchSSNLNameCtDay := v328.attribute[1].value;
self.DivSearchSSNLNameCtWeek := v329.attribute[1].value;
self.DivSearchSSNLNameCt1Month := v330.attribute[1].value;
self.DivSearchSSNLNameCt3Month := v331.attribute[1].value;
self.DivSearchSSNLNameCtNew := v332.attribute[1].value;
self.DivSearchSSNAddrCtDay := v333.attribute[1].value;
self.DivSearchSSNAddrCtWeek := v334.attribute[1].value;
self.DivSearchSSNAddrCt1Month := v335.attribute[1].value;
self.DivSearchSSNAddrCt3Month := v336.attribute[1].value;
self.DivSearchSSNAddrCtNew := v337.attribute[1].value;
self.DivSearchSSNDOBCtDay := v338.attribute[1].value;
self.DivSearchSSNDOBCtWeek := v339.attribute[1].value;
self.DivSearchSSNDOBCt1Month := v340.attribute[1].value;
self.DivSearchSSNDOBCt3Month := v341.attribute[1].value;
self.DivSearchSSNDOBCtNew := v342.attribute[1].value;
self.DivSearchAddrLNameCtDay := v343.attribute[1].value;
self.DivSearchAddrLNameCtWeek := v344.attribute[1].value;
self.DivSearchAddrLNameCt1Month := v345.attribute[1].value;
self.DivSearchAddrLNameCt3Month := v346.attribute[1].value;
self.DivSearchAddrLNameCtNew := v347.attribute[1].value;
self.DivSearchEmailIdentityCt := v348.attribute[1].value;
self.DivSearchEmailIdentityCtDay := v349.attribute[1].value;
self.DivSearchEmailIdentityCtWeek := v350.attribute[1].value;
self.DivSearchEmailIdentityCt1Month := v351.attribute[1].value;
self.DivSearchEmailIdentityCt3Month := v352.attribute[1].value;
self.DivSearchEmailIdentityCtNew := v353.attribute[1].value;
self.SearchPhoneSearchCtDay := v354.attribute[1].value;
self.SearchPhnSearchCtWeek := v355.attribute[1].value;
self.SearchPhnSearchCt1Month := v356.attribute[1].value;
self.SearchPhnSearchCt3Month := v357.attribute[1].value;
self.SearchPhnSearchCtNew := v358.attribute[1].value;
self.SourceTypeIndicator := v359.attribute[1].value;
self.SourceTypeEmergence := v360.attribute[1].value;
self.SourceTypeCredentialCt := v361.attribute[1].value;
self.SourceTypeCredentialAgeOldest := v362.attribute[1].value;
self.SourceTypeOtherCt := v363.attribute[1].value;
self.SourceTypeOtherAgeOldest := v364.attribute[1].value;
self.SourceCreditBureauCBOCt := v365.attribute[1].value;
self.SourceCreditBureauVerSSN := v366.attribute[1].value;
self.SourceCreditBureauVerAddr := v367.attribute[1].value;
self.SourceCreditBureauVerDOB := v368.attribute[1].value;
self.IDVerAddressMatchesCurrentV2 := v369.attribute[1].value;
self.SearchSSNUnVerAddrCt := v370.attribute[1].value;
self.SearchSSNIdentitySearchCtDiff := v371.attribute[1].value;
self.SearchNonBankSearchCtWeek := v372.attribute[1].value;
self.SearchNonBankSearchCtYear := v373.attribute[1].value;
self.SearchNonBankSearchCtRecency := v374.attribute[1].value;
self.AssocCBOIdentityCt := v375.attribute[1].value;
self.AssocCBOHHMemberCt := v376.attribute[1].value;
self.SourceCreditBureauFSAge := v377.attribute[1].value;
self.SourceCreditBureauFSAge25to59 := v378.attribute[1].value;
self.SourceCreditBureauCBOFSAge := v379.attribute[1].value;
self.SourceCreditBureauNotSSNVer := v380.attribute[1].value;
self.IdentitySyntheticRiskLevel := v381.attribute[1].value;
self.IdentitySynthetic := v382.attribute[1].value;
self.IdentityManipSSNRiskLevel := v383.attribute[1].value;
self.IdentitySSNManip := v384.attribute[1].value;
//Digital Insights attributes
  self.DIEOnBListBankFlagEv := v385.attribute[1].value;
  self.DIEOnBListEcomFlagEv := v386.attribute[1].value;
  self.DIEOnBListFinTechFlagEv := v387.attribute[1].value;
  self.DIEOnBListFlagEv := v388.attribute[1].value;
  self.DIEEIdOnBListFlagEv := v389.attribute[1].value;
  self.DIEEIdOnBListFlag1M := v390.attribute[1].value;
  self.DIPEIdOnBListFlag1M := v391.attribute[1].value;
  self.DIPEIdOnBListFlag1Y := v392.attribute[1].value;
  self.DIESmIdOnBListFlagEv := v393.attribute[1].value;
  self.DIESmIdOnBListFlag1M := v394.attribute[1].value;
  self.DIPSmIdOnBListFlag1M := v395.attribute[1].value;
  self.DIPSmIdOnBListFlag1Y := v396.attribute[1].value;
  self.DICorrPECntEv := v397.attribute[1].value;
  self.DICorrPECnt3M := v398.attribute[1].value;
  self.DICorrPECnt1Y := v399.attribute[1].value;
  self.DICorrPECnt1M := v400.attribute[1].value;
  self.DICorrFLECnt1Y := v401.attribute[1].value;
  self.DICorrAECnt6M := v402.attribute[1].value;
  self.DICorrAECntEv := v403.attribute[1].value;
  self.DICorrAECnt1M := v404.attribute[1].value;
  self.DICorrAECnt1Y := v405.attribute[1].value;
  self.DICorrAECnt3M := v406.attribute[1].value;
  self.DICorrFLECntEv := v407.attribute[1].value;
  self.DICorrFLECnt1M := v408.attribute[1].value;
  self.DICorrFLECnt3M := v409.attribute[1].value;
  self.DICorrFLECnt6M := v410.attribute[1].value;
  self.DICorrFLAPECntEv := v411.attribute[1].value;
  self.DICorrFLAPECnt1M := v412.attribute[1].value;
  self.DICorrFLAPECnt1Y := v413.attribute[1].value;
  self.DICorrFLAPECnt3M := v414.attribute[1].value;
  self.DICorrFLAPECnt6M := v415.attribute[1].value;
  self.DICorrPECnt6M := v416.attribute[1].value;
  self.DICorrFLPECntEv := v417.attribute[1].value;
  self.DICorrFLPECnt1M := v418.attribute[1].value;
  self.DICorrFLPECnt1Y := v419.attribute[1].value;
  self.DICorrFLPECnt3M := v420.attribute[1].value;
  self.DICorrFLPECnt6M := v421.attribute[1].value;
  self.DICorrFLPCntEv := v422.attribute[1].value;
  self.DICorrFLPCnt1M := v423.attribute[1].value;
  self.DICorrFLPCnt1Y := v424.attribute[1].value;
  self.DICorrFLPCnt3M := v425.attribute[1].value;
  self.DICorrFLPCnt6M := v426.attribute[1].value;
  self.DIAvTimeBtwEEvent := v427.attribute[1].value;
  self.DIAvTimeBtwPEvent := v428.attribute[1].value;
  self.DIAvDistBtwTrueIpEEvent := v429.attribute[1].value;
  self.DIAvDistBtwTrueIpPEvent := v430.attribute[1].value;
  self.DIEEventCnt6M := v431.attribute[1].value;
  self.DIEEventCnt1Y := v432.attribute[1].value;
  self.DIPEventCnt1Y := v433.attribute[1].value;
  self.DIPEventCntEv := v434.attribute[1].value;
  self.DIPEventCnt6M := v435.attribute[1].value;
  self.DILexIDDEventCnt1M := v436.attribute[1].value;
  self.DIAEventOldestDt := v437.attribute[1].value;
  self.DIAEventNewestDt := v438.attribute[1].value;
  self.DIEEventOldestDt := v439.attribute[1].value;
  self.DIEEventNewestDt := v440.attribute[1].value;
  self.DIFLEventOldestDt := v441.attribute[1].value;
  self.DIFLEventNewestDt := v442.attribute[1].value;
  self.DIPEventOldestDt := v443.attribute[1].value;
  self.DIPEventNewestDt := v444.attribute[1].value;
  self.DILexIDDEventOldestDt := v445.attribute[1].value;
  self.DILexIDDEventNewestDt := v446.attribute[1].value;
  self.DIEAliasFlag := v447.attribute[1].value;
  self.DIEHighRiskDomainFlag := v448.attribute[1].value;
  self.DIEMachineGenFlag := v449.attribute[1].value;
  self.DIEventEAcceptCntEv := v450.attribute[1].value;
  self.DIEventEAcceptCnt1M := v451.attribute[1].value;
  self.DIEventPAcceptCntEv := v452.attribute[1].value;
  self.DIEventPAcceptCnt1M := v453.attribute[1].value;
  self.DIEventERejectCntEv := v454.attribute[1].value;
  self.DIEventERejectCnt1M := v455.attribute[1].value;
  self.DIEventPRejectCntEv := v456.attribute[1].value;
  self.DIEventPRejectCnt1M := v457.attribute[1].value;
  self.DILexIDDFraudByCFlag1M := v458.attribute[1].value;
  self.DILexIDDFraudByCFlag1Y := v459.attribute[1].value;
  self.DILexIDDFraudByCFlag3M := v460.attribute[1].value;
  self.DILexIDDFraudByCFlag6M := v461.attribute[1].value;
  self.DIETrustByCFlag1M := v462.attribute[1].value;
  self.DIETrustByCFlag1Y := v463.attribute[1].value;
  self.DIETrustByCFlag3M := v464.attribute[1].value;
  self.DIETrustByCFlag6M := v465.attribute[1].value;
  self.DILexIDDTrustByCFlag1M := v466.attribute[1].value;
  self.DILexIDDTrustByCFlag1Y := v467.attribute[1].value;
  self.DILexIDDTrustByCFlag3M := v468.attribute[1].value;
  self.DILexIDDTrustByCFlag6M := v469.attribute[1].value;
  self.DIACHNumPerECntEv := v470.attribute[1].value;
  self.DIAgentPKeyHashPerECntEv := v471.attribute[1].value;
  self.DIBrowserPerECntEv := v472.attribute[1].value;
  self.DIBrowserSHashPerECntEv := v473.attribute[1].value;
  self.DICarrierIdPerECntEv := v474.attribute[1].value;
  self.DICCardPerECntEv := v475.attribute[1].value;
  self.DICurrencyPerECntEv := v476.attribute[1].value;
  self.DIDnsIpPerECntEv := v477.attribute[1].value;
  self.DIDnsIpGeoPerECntEv := v478.attribute[1].value;
  self.DIEIdPerECnt1M := v479.attribute[1].value;
  self.DIEIdPerECntEv := v480.attribute[1].value;
  self.DIEIdPerECnt3M := v481.attribute[1].value;
  self.DIEIdPerECnt6M := v482.attribute[1].value;
  self.DIEIdPerECnt1Y := v483.attribute[1].value;
  self.DIOrgIdPerECntEv := v484.attribute[1].value;
  self.DIPPerECnt1Y := v485.attribute[1].value;
  self.DIPPerECnt3M := v486.attribute[1].value;
  self.DIPPerECnt1M := v487.attribute[1].value;
  self.DIProxyIpPerECntEv := v488.attribute[1].value;
  self.DIProxyIpGeoPerECntEv := v489.attribute[1].value;
  self.DIScreenResPerECntEv := v490.attribute[1].value;
  self.DISmIdPerECnt1M := v491.attribute[1].value;
  self.DISmIdPerECnt3M := v492.attribute[1].value;
  self.DISmIdPerECntEv := v493.attribute[1].value;
  self.DISmIdPerECnt1Y := v494.attribute[1].value;
  self.DISmIdPerECnt6M := v495.attribute[1].value;
  self.DITimeZonePerECntEv := v496.attribute[1].value;
  self.DILexIDDPerECnt1M := v497.attribute[1].value;
  self.DILexIDDPerECntEv := v498.attribute[1].value;
  self.DILexIDDPerECnt1Y := v499.attribute[1].value;
  self.DILexIDDPerECnt3M := v500.attribute[1].value;
  self.DILexIDDPerECnt6M := v501.attribute[1].value;
  self.DITrueIpPerECntEv := v502.attribute[1].value;
  self.DITrueIpGeoPerECntEv := v503.attribute[1].value;
  self.DITrueIpRCPerECnt1W := v504.attribute[1].value;
  self.DIBrowserSHashPerPCntEv := v505.attribute[1].value;
  self.DIEPerPCnt3M := v506.attribute[1].value;
  self.DIEPerPCnt6M := v507.attribute[1].value;
  self.DIEPerPCnt1Y := v508.attribute[1].value;
  self.DIEPerPCntEv := v509.attribute[1].value;
  self.DIEPerPCnt1M := v510.attribute[1].value;
  self.DIEIdPerPCnt3M := v511.attribute[1].value;
  self.DIEIdPerPCntEv := v512.attribute[1].value;
  self.DIEIdPerPCnt1M := v513.attribute[1].value;
  self.DIEIdPerPCnt1Y := v514.attribute[1].value;
  self.DIEIdPerPCnt6M := v515.attribute[1].value;
  self.DILoginIdPerPCntEv := v516.attribute[1].value;
  self.DISmIdPerPCnt1M := v517.attribute[1].value;
  self.DISmIdPerPCnt1Y := v518.attribute[1].value;
  self.DISmIdPerPCntEv := v519.attribute[1].value;
  self.DISmIdPerPCnt3M := v520.attribute[1].value;
  self.DISmIdPerPCnt6M := v521.attribute[1].value;
  self.DILexIDDPerPCnt3M := v522.attribute[1].value;
  self.DILexIDDPerPCnt1Y := v523.attribute[1].value;
  self.DILexIDDPerPCntEv := v524.attribute[1].value;
  self.DILexIDDPerPCnt1M := v525.attribute[1].value;
  self.DILexIDDPerPCnt6M := v526.attribute[1].value;
  self.DITrueIpPerPCntEv := v527.attribute[1].value;
  self.DITrueIpRCPerPCnt1W := v528.attribute[1].value;
  self.DIEPerLexIDDCntEv := v529.attribute[1].value;
  self.DIEIdPerLexIDDCntEv := v530.attribute[1].value;
  self.DIEIdPerLexIDDCnt1W := v531.attribute[1].value;
  self.DIFLPerLexIDDCntEv := v532.attribute[1].value;
  self.DIPPerLexIDDCntEv := v533.attribute[1].value;
  self.DISmIdPerLexIDDCntEv := v534.attribute[1].value;
  self.DITrueIpPerLexIDDCnt1M := v535.attribute[1].value;
  self.DITrueIpPerLexIDDCntEv := v536.attribute[1].value;
  self.DITrueIpPerLexIDDCnt1W := v537.attribute[1].value;
  self.DITrueIpGeoPerLexIDDCnt1W := v538.attribute[1].value;

	self.fp_score1 := L.scores[1].i;
	self.fp_reason1_1 := L.scores[1].reason_codes[1].reason_code;
	self.fp_reason1_2 := L.scores[1].reason_codes[2].reason_code;
	self.fp_reason1_3 := L.scores[1].reason_codes[3].reason_code;
	self.fp_reason1_4 := L.scores[1].reason_codes[4].reason_code;
	self.fp_reason1_5 := L.scores[1].reason_codes[5].reason_code;
	self.fp_reason1_6 := L.scores[1].reason_codes[6].reason_code;
	
	self.StolenIdentityIndex        := L.scores[1].StolenIdentityIndex;
	self.SyntheticIdentityIndex     := L.scores[1].SyntheticIdentityIndex;
	self.ManipulatedIdentityIndex   := L.scores[1].ManipulatedIdentityIndex;
	self.VulnerableVictimIndex      := L.scores[1].VulnerableVictimIndex;
	self.FriendlyFraudIndex         := L.scores[1].FriendlyFraudIndex;
	self.SuspiciousActivityIndex    := L.scores[1].SuspiciousActivityIndex;
			
	self.historydate := (string)r.HistoryDateYYYYMM;	
	self := l;
	self := [];
end;

//Since XPATH is not used in the Soapcall, filter on non-blank accountnumber to join only the records from the 'Results' dataset.  
//Otherwise 'resu' includes all datasets, which could cause the join to fail.
normed := JOIN(resu(accountnumber <> ''), fdInput,LEFT.accountnumber=RIGHT.accountnumber, normit(LEFT,RIGHT));

qa_results := GROUP(SORT(JOIN(resu(Shell.Account<>''), fdInput, LEFT.Shell.Account=RIGHT.accountnumber,
                      TRANSFORM({Models.Layout_Fraudpoint_Debug.Shell, STRING errorcode}, 
                      SELF.Account := RIGHT.old_account_number, SELF := LEFT.Shell, SELF := LEFT)), Account), Account);

Input_errors := normed(errorcode in ['0ReceivedRoxieException: (Invalid request for Digital Insights, must supply a phone number and email.)',
                                     '301ReceivedRoxieException: (Insufficient input)']);

Other_errors := normed(errorcode not in ['','0ReceivedRoxieException: (Invalid request for Digital Insights, must supply a phone number and email.)',
                                            '301ReceivedRoxieException: (Insufficient input)']);

// output(choosen(Input_errors, eyeball), named('Input_errors'));
// output(count(Input_errors), named('Input_error_count'));

// output(choosen(Other_errors, eyeball), named('Other_errors'));
// output(count(Other_errors), named('Other_error_count'));

attr_plus_scores := group(sort(normed, accountnumber), accountnumber);

scores_only := attr_plus_scores(fp_score1 != '' or fp_reason1_1 != '');
attrs_only := attr_plus_scores(fp_score1 = '' and fp_reason1_1 = '');

// output(choosen(scores_only, eyeball), named('scores_only'));
// output(choosen(attrs_only, eyeball), named('attrs_only'));

fd_attributes_norm get_scores(fd_attributes_norm le, fd_attributes_norm rt, integer c) := Transform
  self.fp_score1 := IF(c = 1, rt.fp_score1, '');
	self.fp_reason1_1 := IF(c = 1, rt.fp_reason1_1, '');
	self.fp_reason1_2 := IF(c = 1, rt.fp_reason1_2, '');
	self.fp_reason1_3 := IF(c = 1, rt.fp_reason1_3, '');
	self.fp_reason1_4 := IF(c = 1, rt.fp_reason1_4, '');
	self.fp_reason1_5 := IF(c = 1, rt.fp_reason1_5, '');
	self.fp_reason1_6 := IF(c = 1, rt.fp_reason1_6, '');
  self.fp_score2 := IF(c = 2, rt.fp_score1, '');
	self.fp_reason2_1 := IF(c = 2, rt.fp_reason1_1, '');
	self.fp_reason2_2 := IF(c = 2, rt.fp_reason1_2, '');
	self.fp_reason2_3 := IF(c = 2, rt.fp_reason1_3, '');
	self.fp_reason2_4 := IF(c = 2, rt.fp_reason1_4, '');
	self.fp_reason2_5 := IF(c = 2, rt.fp_reason1_5, '');
	self.fp_reason2_6 := IF(c = 2, rt.fp_reason1_6, '');
  self.fp_score3 := IF(c = 3, rt.fp_score1, '');
	self.fp_reason3_1 := IF(c = 3, rt.fp_reason1_1, '');
	self.fp_reason3_2 := IF(c = 3, rt.fp_reason1_2, '');
	self.fp_reason3_3 := IF(c = 3, rt.fp_reason1_3, '');
	self.fp_reason3_4 := IF(c = 3, rt.fp_reason1_4, '');
	self.fp_reason3_5 := IF(c = 3, rt.fp_reason1_5, '');
	self.fp_reason3_6 := IF(c = 3, rt.fp_reason1_6, '');
  self := rt;
end;

scores_denormed := iterate(scores_only, get_scores(left,right,counter));

// scores are always in the Result, and attributes are always in Results2, so scores are le. and attributes are rt.
fd_attributes_norm combine_scores(fd_attributes_norm le, fd_attributes_norm rt) := transform
	self.fp_score1 := IF(le.fp_score1 != '', le.fp_score1, '');
	self.fp_reason1_1 := IF(le.fp_score1 != '', le.fp_reason1_1, '');
	self.fp_reason1_2 := IF(le.fp_score1 != '', le.fp_reason1_2, '');
	self.fp_reason1_3 := IF(le.fp_score1 != '', le.fp_reason1_3, '');
	self.fp_reason1_4 := IF(le.fp_score1 != '', le.fp_reason1_4, '');
	self.fp_reason1_5 := IF(le.fp_score1 != '', le.fp_reason1_5, '');
	self.fp_reason1_6 := IF(le.fp_score1 != '', le.fp_reason1_6, '');
  self.fp_score2 := IF(le.fp_score2 != '', le.fp_score2, rt.fp_score2);
	self.fp_reason2_1 := IF(le.fp_score2 != '', le.fp_reason2_1, rt.fp_reason2_1);
	self.fp_reason2_2 := IF(le.fp_score2 != '', le.fp_reason2_2, rt.fp_reason2_2);
	self.fp_reason2_3 := IF(le.fp_score2 != '', le.fp_reason2_3, rt.fp_reason2_3);
	self.fp_reason2_4 := IF(le.fp_score2 != '', le.fp_reason2_4, rt.fp_reason2_4);
	self.fp_reason2_5 := IF(le.fp_score2 != '', le.fp_reason2_5, rt.fp_reason2_5);
	self.fp_reason2_6 := IF(le.fp_score2 != '', le.fp_reason2_6, rt.fp_reason2_6);
  self.fp_score3 := IF(le.fp_score3 != '', le.fp_score3, rt.fp_score3);
	self.fp_reason3_1 := IF(le.fp_score3 != '', le.fp_reason3_1, rt.fp_reason3_1);
	self.fp_reason3_2 := IF(le.fp_score3 != '', le.fp_reason3_2, rt.fp_reason3_2);
	self.fp_reason3_3 := IF(le.fp_score3 != '', le.fp_reason3_3, rt.fp_reason3_3);
	self.fp_reason3_4 := IF(le.fp_score3 != '', le.fp_reason3_4, rt.fp_reason3_4);
	self.fp_reason3_5 := IF(le.fp_score3 != '', le.fp_reason3_5, rt.fp_reason3_5);
	self.fp_reason3_6 := IF(le.fp_score3 != '', le.fp_reason3_6, rt.fp_reason3_6);
	self.StolenIdentityIndex        := IF(le.StolenIdentityIndex != '', le.StolenIdentityIndex, rt.StolenIdentityIndex);
	self.SyntheticIdentityIndex     := IF(le.SyntheticIdentityIndex != '', le.SyntheticIdentityIndex, rt.SyntheticIdentityIndex);
	self.ManipulatedIdentityIndex   := IF(le.ManipulatedIdentityIndex != '', le.ManipulatedIdentityIndex, rt.ManipulatedIdentityIndex);
	self.VulnerableVictimIndex      := IF(le.VulnerableVictimIndex != '', le.VulnerableVictimIndex, rt.VulnerableVictimIndex);
	self.FriendlyFraudIndex         := IF(le.FriendlyFraudIndex != '', le.FriendlyFraudIndex, rt.FriendlyFraudIndex);
	self.SuspiciousActivityIndex    := IF(le.SuspiciousActivityIndex != '', le.SuspiciousActivityIndex, rt.SuspiciousActivityIndex);
	self := rt;
end;

rolled_scores := rollup(scores_denormed, true, combine_scores(left,right));

to_1_record_temp := join(rolled_scores, attrs_only,
                    left.accountnumber = right.accountnumber,
                    Transform(fd_attributes_norm,
                              self.accountnumber := left.accountnumber;
                              self.fp_score1 :=left.fp_score1;
                              self.fp_reason1_1 := left.fp_reason1_1;
                              self.fp_reason1_2 := left.fp_reason1_2;
                              self.fp_reason1_3 := left.fp_reason1_3;
                              self.fp_reason1_4 := left.fp_reason1_4;
                              self.fp_reason1_5 := left.fp_reason1_5;
                              self.fp_reason1_6 := left.fp_reason1_6;
                              self.fp_score2 := left.fp_score2;
                              self.fp_reason2_1 := left.fp_reason2_1;
                              self.fp_reason2_2 := left.fp_reason2_2;
                              self.fp_reason2_3 := left.fp_reason2_3;
                              self.fp_reason2_4 := left.fp_reason2_4;
                              self.fp_reason2_5 := left.fp_reason2_5;
                              self.fp_reason2_6 := left.fp_reason2_6;
                              self.fp_score3 := left.fp_score3;
                              self.fp_reason3_1 := left.fp_reason3_1;
                              self.fp_reason3_2 := left.fp_reason3_2;
                              self.fp_reason3_3 := left.fp_reason3_3;
                              self.fp_reason3_4 := left.fp_reason3_4;
                              self.fp_reason3_5 := left.fp_reason3_5;
                              self.fp_reason3_6 := left.fp_reason3_6;
                              self.StolenIdentityIndex        := left.StolenIdentityIndex;
                              self.SyntheticIdentityIndex     := left.SyntheticIdentityIndex;
                              self.ManipulatedIdentityIndex   := left.ManipulatedIdentityIndex;
                              self.VulnerableVictimIndex      := left.VulnerableVictimIndex;
                              self.FriendlyFraudIndex         := left.FriendlyFraudIndex;
                              self.SuspiciousActivityIndex    := left.SuspiciousActivityIndex;
                              self := right
                              ), left outer);

output(choosen(to_1_record_temp, eyeball), named('to_1_record_temp'));

fd_attributes_norm_minus_compromised_dl := record
	fd_attributes_norm - IdentityDriversLicenseComp;
end;

//Add any input errors back to the results so that we have all the input records
to_1_record := to_1_record_temp + Input_errors;

without_attributes := project(to_1_record, transform(No_attributes_layout, self := left));
other_errors_wo_attributes := project(Other_errors, transform(No_attributes_layout, self := left));

without_compromised_dl := project(to_1_record, transform(fd_attributes_norm_minus_compromised_dl, self := left));
other_errors_wo_comp_dl := project(Other_errors, transform(fd_attributes_norm_minus_compromised_dl, self := left));

output(choosen(to_1_record, eyeball), named('to_1_record'));
output(choosen(without_compromised_dl, eyeball), named('without_compromised_dl'));

// if the option is turned on to suppress compromised DLs, then output the file that has the attribute included
// if the option is turned on to not have attributes in the response, then output the file that doesn't have attributes
// otherwise, output the file without that field in the layout
if(_SuppressCompromisedDLs,
output(to_1_record,,outputfile,CSV(heading(single), quote('"')), overwrite),
  if(Score_only,
     output(without_attributes,,outputfile,CSV(heading(single), quote('"')), overwrite),
     output(without_compromised_dl,,outputfile,CSV(heading(single), quote('"')), overwrite)
    )
);

if(_SuppressCompromisedDLs,
output(Other_errors,,outputfile + '_errors',CSV(heading(single), quote('"')), overwrite),
  if(Score_only,
     output(other_errors_wo_attributes,,outputfile + '_errors',CSV(heading(single), quote('"')), overwrite),
     output(other_errors_wo_comp_dl,,outputfile + '_errors',CSV(heading(single), quote('"')), overwrite)
    )
);


IF(_include_internal_extras, OUTPUT(CHOOSEN(qa_results, eyeball), NAMED('Sample_QA_Results')));
IF(_include_internal_extras, OUTPUT(qa_results,,qa_outputfile, CSV(heading(single), quote('"')), overwrite));
