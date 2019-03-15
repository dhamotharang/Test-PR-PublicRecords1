  import ut, risk_indicators, models, riskwise, Gateway;
#workunit('name','Fraudpoint Score and Attributes 2.0');

// internal fields for debugging, when set to false, QA file will not be output
include_internal_extras := TRUE;

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
end;

filename := ut.foreign_prod + 'jpyon::in::capone_8511_aff059ot_mvst_part0_sample.csv';
// outputfile := '~dvstemp::out::capone_8511_aff059ot_mvst_part0_fp20_20190118_Sample' + thorlib.wuid();
outputfile := '~dvstemp::out::capone_8511_aff059ot_mvst_part0_fp20_20190118_Sample_without_quickheader_' + thorlib.wuid();
qa_outputfile := outputfile+'_QA';

eyeball := 10;

// f := choosen(dataset(filename,prii_layout, csv(quote('"'))),10);
f := dataset(filename,prii_layout, csv(quote('"')));

output(choosen(f,eyeball), named('original_input'));

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
  boolean OfacOnly;
  boolean ExcludeWatchLists;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
  // dataset(iesp.share.t_StringArrayItem) WatchList;
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
  boolean IncludeQAOutputs;
  boolean RemoveQuickHeader;
end;


roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;  
// roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;  
// roxieIP := riskwise.shortcuts.dev156;  

layout_old_acct := RECORD
	STRING old_account_number;
	layout_soap;
END;


layout_old_acct into_fdInput(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;

 //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
		// self.historydateyyyymm := 201504;  
		// self.historyDateTimeStamp := '20150401 00000100';  

		// self.historydateyyyymm := 999999;  
		// self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
			regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
			                                                (unsigned)le.historydate
	);
	
  self.historyDateTimeStamp := map(
      le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
			regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
			regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		                                                
			                                                le.historydate
	);
	
	self.DataRestrictionMask := '0000000000000000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products

	SELF.RequestedAttributeGroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
self.model := 'fp1109_0';  // 
		//self.model := 'fp1109_9';  // fp1109_9 is the same model as fp1109_0, but includes criminal risk indicators
	self.IncludeRiskIndices := true;
 	self.gateways := riskwise.shortcuts.gw_netacuityv4 /*+ riskwise.shortcuts.gw_targus*/
  /* + dataset([{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], Gateway.Layouts.Config)*/; //Can uncomment targus gateway and/or watchlists if needed
  
	self.OfacOnly := false;
  self.ExcludeWatchLists := false;
	self.OFACversion := 2;
	self.IncludeOfac := false;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem);
    
  SELF.IncludeQAOutputs := include_internal_extras;   
	
  self.RemoveQuickHeader := false;
  // self.RemoveQuickHeader := true;
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
				PARALLEL(30), 
				retry(10),
				onFail(myFail(LEFT)));
				
output(choosen(resu, eyeball), named('roxie_result'));

fd_attributes_norm := RECORD
	string30 AccountNumber;
	Models.Layout_FraudAttributes.version2;	
	
	string3 FP_score;
	string3 FP_reason;
	string3 FP_reason2;
	string3 FP_reason3;
	string3 FP_reason4;
	string3 FP_reason5;
	string3 FP_reason6;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
	string6 historydate;
	string200 errorcode;
END;
	
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
		
	// version2 output
	v := get_group(l, 'Version2');
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

	self.fp_score := L.scores[1].i;
	self.fp_reason := L.scores[1].reason_codes[1].reason_code;
	self.fp_reason2 := L.scores[1].reason_codes[2].reason_code;
	self.fp_reason3 := L.scores[1].reason_codes[3].reason_code;
	self.fp_reason4 := L.scores[1].reason_codes[4].reason_code;
	self.fp_reason5 := L.scores[1].reason_codes[5].reason_code;
	self.fp_reason6 := L.scores[1].reason_codes[6].reason_code;
	
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

normed := JOIN(resu(accountnumber <> ''), fdInput,LEFT.accountnumber=RIGHT.accountnumber, normit(LEFT,RIGHT));

qa_results := GROUP(SORT(JOIN(resu(Shell.Account<>''), fdInput, LEFT.Shell.Account=RIGHT.accountnumber,
                      TRANSFORM({Models.Layout_Fraudpoint_Debug.Shell, STRING errorcode}, 
                      SELF.Account := RIGHT.old_account_number, SELF := LEFT.Shell, SELF := LEFT)), Account), Account);

output(choosen(normed, eyeball), named('sample'));
output(choosen(normed(errorcode<>''), eyeball), named('errors'));
output(count(normed(errorcode<>'')), named('err_count'));

attr_plus_scores := group(sort(normed, accountnumber), accountnumber);

// scores are always in the Result, and attributes are always in Results2, so scores are le. and attributes are rt.
fd_attributes_norm combine_scores_attributes(fd_attributes_norm le, fd_attributes_norm rt) := transform
	self.fp_score := le.fp_score;
	self.fp_reason := le.fp_reason;
	self.fp_reason2 := le.fp_reason2;
	self.fp_reason3 := le.fp_reason3;
	self.fp_reason4 := le.fp_reason4;
	self.fp_reason5 := le.fp_reason5;
	self.fp_reason6 := le.fp_reason6;
	self.StolenIdentityIndex        := le.StolenIdentityIndex;
	self.SyntheticIdentityIndex     := le.SyntheticIdentityIndex;
	self.ManipulatedIdentityIndex   := le.ManipulatedIdentityIndex;
	self.VulnerableVictimIndex      := le.VulnerableVictimIndex;
	self.FriendlyFraudIndex         := le.FriendlyFraudIndex;
	self.SuspiciousActivityIndex    := le.SuspiciousActivityIndex;
	self := rt;
end;

rolled_to_1_record := rollup(attr_plus_scores, true, combine_scores_attributes(left,right));
output(choosen(rolled_to_1_record, eyeball), named('rolled_records'));

output(rolled_to_1_record,,outputfile,CSV(heading(single), quote('"')), overwrite);

IF(Include_Internal_Extras, OUTPUT(CHOOSEN(qa_results, eyeball), NAMED('Sample_QA_Results')));
IF(Include_Internal_Extras, OUTPUT(qa_results,,qa_outputfile, CSV(heading(single), quote('"')), overwrite));

