//This for requesting the extra 202 FP attributes for AmEx
//Returns attributes counts of 384 (v202)
//v203 - set RequestedAttributeGroups = fraudpointattrv203
//v202 - set RequestedAttributeGroups = fraudpointattrv202
//v201 - set RequestedAttributeGroups = fraudpointattrv201 (set SuppressCompromiesDLs to true to display last field (226))
//v2   - set RequestedAttributeGroups = fraudpointattrv2

import ut, risk_indicators, models, riskwise, iesp;
#workunit('name','Fraudpoint 3 Score and Attributes 202');

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

filename := ut.foreign_prod + 'tfuerstenberg::in::disc_9645_test_in.csv';
outputfile := '~dvstemp::out::fp3202_' + thorlib.wuid();
qa_outputfile := outputfile+'_QA';


eyeball 								:= 25;	//number of records to display in outputs
unsigned 	record_limit 	:= 10;   //number of records to process from input file; 0 means ALL


f := if(record_limit = 0, //depending on the record_limit, either process the entire input file or the number of records specified
				dataset(filename,prii_layout, csv(quote('"'))),
				choosen(dataset(filename,prii_layout, csv(quote('"'))), record_limit));

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
  // dataset(iesp.share.t_StringArrayItem) Watchlist {xpath('Watchlist/Row/WatchList/Name')}; ;
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
end;

roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;  

layout_old_acct := RECORD
	STRING old_account_number;
	layout_soap;
END;

SuppressCompromisedDLs := false; // don’t search the eqfx compromised DL list by Last Name and SSN unless specifically requested

layout_old_acct into_fdInput(f le, INTEGER c) := TRANSFORM
	self.SuppressCompromisedDLs := true; // leave this set to true for soapcall; otherwise field values will be offset
	
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
//self.DataPermissionMask  := '0000000000100';  // to allow population of FDN Virtual Fraud, Test Fraud and Contributory Fraud, set position 11 to '1'
	self.DataPermissionMask  := '0000000000101';  // to allow population of FDN Virtual Fraud, Test Fraud and Contributory Fraud, set position 11 to '1'

																								// to allow access to Insurance DL data, set position 13 to '1'

	SELF.RequestedAttributeGroups := dataset([{'fraudpointattrv202'}], layout_attributes_in);
 self.model := 'fp31505_0';  // this is the Fraudpoint 3.0 model without FDN data
	//	self.model := 'fp3fdn1505_0';  // this is the Fraudpoint 3.0 model with FDN data 
	self.IncludeRiskIndices := true;
 	self.gateways := riskwise.shortcuts.gw_netacuityv4 /*+ riskwise.shortcuts.gw_targus*/
  /* + dataset([{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], Risk_Indicators.Layout_Gateways_In)*/; //Can uncomment targus gateway and/or watchlists if needed
  
	self.OfacOnly := false;
  self.ExcludeWatchLists := false;
	self.OFACversion := 1;
	self.IncludeOfac := false;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem); // use this if you only need one watchlist
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem) +
									  // dataset([{'BES'}],iesp.share.t_StringArrayItem); // use this if you need more than one watchlist, follow the same formatting to add one more if needing more than two 
  
  SELF.IncludeQAOutputs := include_internal_extras;  
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
				'Models.FraudAdvisor_Service', 
				{dist_dataset}, 
				DATASET(layout_FDAttributesOut),
				PARALLEL(30), 
				retry(10),
				onFail(myFail(LEFT)));
				
output(choosen(resu, eyeball), named('roxie_result'));
	
fd_attributes_norm := RECORD
	string30 AccountNumber;
	Models.Layout_FraudAttributes.version2;	
	Models.Layout_FraudAttributes.version201;	
	Models.Layout_FraudAttributes.version202;	
	// Models.Layout_FraudAttributes.version203;	
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
	v := get_group(l, 'Version202');
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
// v385	:= get_attribute(v, 	385	);
// v386	:= get_attribute(v, 	386	);
	
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
self.IdentityDriversLicenseComp	:= if(SuppressCompromisedDLs, v226.attribute[1].value, 'XX');  // only populate this field when it's requested
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
//AmEx 203 attributes
// self.IDVerSSNVerAgeOldest := '';
// self.IDVerSSNNotVerAgeOldest := '';	

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

//Since XPATH is not used in the Soapcall, filter on non-blank accountnumber to join only the records from the 'Results' dataset.  
//Otherwise 'resu' includes all datasets, which could cause the join to fail.
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

temp_prii_layout := record
	prii_layout;
	string errorcode;
end;

valid_error_codes := ['', '301ReceivedRoxieException: (Insufficient input)'];
// keep track of any record that gets an error other than the insufficent input error
// 301ReceivedRoxieException: (Insufficient input)                                                                                                                                                         
input_file_of_errors := join(dist_dataset, rolled_to_1_record(trim(errorcode) not in valid_error_codes), left.old_account_number=right.accountnumber,
	transform(temp_prii_layout,
	self.errorcode := right.errorcode;
	self.account := left.old_account_number;
	self.historydate := (string)left.historydateyyyymm;
	self := left;
	self := [];));
output(choosen(input_file_of_errors, eyeball), named('input_file_from_errors'));
if(count(input_file_of_errors)>0, output(input_file_of_errors,,outputfile + '_errors' ,CSV(heading(single), quote('"'))) );  // don't output this file if there aren't any error records


fd_attributes_norm_minus_compromised_dl := record
	fd_attributes_norm - IdentityDriversLicenseComp;
end;

without_compromised_dl := project(rolled_to_1_record, transform(fd_attributes_norm_minus_compromised_dl, self := left));

// if the option is turned on to suppress compromised DLs, then output the file that has the attribute included
// otherwise, output the file without that field in the layout
if(SuppressCompromisedDLs,
output(rolled_to_1_record(trim(errorcode) in valid_error_codes),,outputfile,CSV(heading(single), quote('"'))),  // don't include records which failed
output(without_compromised_dl(trim(errorcode) in valid_error_codes),,outputfile,CSV(heading(single), quote('"')))// don't include records which failed
);

if(SuppressCompromisedDLs,
output(rolled_to_1_record,named('rolled_to_1_record')),
output(without_compromised_dl,named('without_compromised_dl'))
);

IF(Include_Internal_Extras, OUTPUT(CHOOSEN(qa_results, eyeball), NAMED('Sample_QA_Results')));
IF(Include_Internal_Extras, OUTPUT(qa_results(trim(errorcode) in valid_error_codes),,qa_outputfile, CSV(heading(single), quote('"')))); // don't include records which failed