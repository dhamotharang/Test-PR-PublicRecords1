IMPORT BizLinkFull_ELERT AS pkgQAMonitor;
IMPORT BIPV2 AS pkg1;
IMPORT BIPV2 AS pkg2;
IMPORT SALT37;
IMPORT Business_Header_SS;

EXPORT modCallFunctions := MODULE 
  //Change all of this to match your data. -ZRS 4/8/2019    
  //Main Thor Call for Healthcare Provider Header
  EXPORT DATASET(modLayouts.lSampleLayout) fCallWrapperIdAppendThor(DATASET(pkgQAMonitor.modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bForce=TRUE,BOOLEAN isFuzzy=FALSE, BOOLEAN zipRadius=FALSE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := FUNCTION
		// dThorInput := dInData(source not in ['T1','T2','T3','T4','T5', 'T', 'P', 'B#']);
		dThorInput := project(distribute(dInData, uniqueId), transform(pkg1.IdAppendLayouts.AppendInput, 
																						 self.request_id := left.uniqueId;
																						 self.source := IF(bUseSourceRid, left.src_category, left.source);
																						 self.source_record_id := IF(bUseSourceRid, left.source_record_id, 0);
																						 self := left, 
																						 Self:=[]));  

		appendThor:=  pkg1.IdAppendThor(dThorInput,
																							,scoreThreshold := iscore
																							,weightThreshold := iweight 
																							,primForce := bForce
																							,reappend := TRUE
																							,allowInvalidResults := true // defaults to false in IdAppendThor
																							,mimicRoxie := FALSE 
																							,svcAppendUrl := inUrl
																							,useFuzzy := isFuzzy
																							,doZipExpansion := zipRadius
                                                                                            ,segmentation := bSegmentation);
																							
			
		dTHOR := appendThor.IdsOnly(); //: INDEPENDENT;																				

		RETURN JOIN(dTHOR, dInData, left.request_id=right.uniqueid, TRANSFORM(modLayouts.lSampleLayout,
																																											SELF := LEFT;
																																											SELF := RIGHT;
																																											SELF := []; 
																																											));
  END;
 
 EXPORT DATASET(modLayouts.lSampleLayout) fCallWrapperIdAppendRoxie(DATASET(pkgQAMonitor.modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bForce=FALSE,BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := FUNCTION
   
	
	dRoxieInput := project(dInData, transform(pkg1.IdAppendLayouts.AppendInput, 
																						 self.request_id := left.uniqueId;
																						 self.source := IF(bUseSourceRid, left.src_category, left.source);
																						 self.source_record_id := IF(bUseSourceRid, left.source_record_id, 0);
																						 self := left, 
																						 Self:=[]));  
	groupSize := 5;
	groups := count(dRoxieInput)/groupSize + 1;

	outDsRec := record
	dataset(pkg1.IdAppendLayouts.IdsOnlyOutput) ds;
	end;

    distNodes := if(inSvcName = '', 25, 3);

    withGroupNumber := project(dRoxieInput,
                               transform({dataset(recordof(left)) grp_ds, unsigned grp_num},
                                         self.grp_ds := dataset(left),
                                         self.grp_num := counter % groups));

    rollGroups := rollup(sort(distribute(withGroupNumber, grp_num), grp_num, local),
                          left.grp_num = right.grp_num,
                          transform(recordof(left),
                                    self.grp_ds := left.grp_ds + right.grp_ds,
                                    self := left),
                          local);

    dRoxieInputDist := distribute(rollGroups, grp_num % distNodes):INDEPENDENT; //put on one node                          

	append := project(dRoxieInputDist, 
	                  transform(outDsRec,
								self.ds := project(pkg1.IdAppendRoxieRemote(left.grp_ds
																			,iscore // 75 is the default, valid values are >= 51 and <= 100
																			,iweight // default is 0. Can be set higher to ensure a stronger match
																			,not bForce
																			,true  //reappend
																			,false //primForcePost
																			,isFuzzy
																			,zipRadius
																			,inUrl
																			,inSvcName
                                                                            ,segmentation := bSegmentation).IdsOnly(), pkg1.IdAppendLayouts.IdsOnlyOutput) ));

  dRoxie := normalize(append, count(left.ds),
                      transform(pkg1.IDAppendLayouts.AppendOutput,
                                               self := left.ds[counter];
																							 self := []));


		RETURN JOIN(dInData, dRoxie, 
                    left.uniqueid=right.request_id, 
                    TRANSFORM(modLayouts.lSampleLayout,
						      SELF.request_id := right.request_id;
						      SELF.dotid     := right.dotid;
						      SELF.dotweight := right.dotweight;
						      SELF.dotscore  := right.dotscore;
						      SELF.empid     := right.empid;
						      SELF.empweight := right.empweight;
						      SELF.empscore  := right.empscore;
						      SELF.proxid     := right.proxid;
						      SELF.proxweight := right.proxweight;
						      SELF.proxscore  := right.proxscore;
						      SELF.seleid     := right.seleid;
						      SELF.seleweight := right.seleweight;
						      SELF.selescore  := right.selescore;
						      SELF.orgid      := right.orgid;
						      SELF.orgweight  := right.orgweight;
						      SELF.orgscore   := right.orgscore;
						      SELF.ultid      := right.ultid;
						      SELF.ultweight  := right.ultweight;
						      SELF.ultscore   := right.ultscore;
						    //   SELF.transaction_time := right.transaction_time;
                              SELF.errorcode := map(right.request_id = 0 => '1000 - Some requests ids were lost which means the Roxie you are hitting is overwhelmed.',
                                                    right.error_code != 0 => right.error_code + ' ' + right.error_msg,
                                                    '');
						      SELF := LEFT;
						      SELF := RIGHT;
						      ), left outer);
																																									
    END;

//IdFunctions call
 EXPORT DATASET(modLayouts.lSampleLayout) fCallWrapperIdFunctions(DATASET(pkgQAMonitor.modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bForce=FALSE,BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := FUNCTION



  // roxieIP 		 := 'http://10.173.3.1:9876'; // Dev 1-way 1
  // roxieIP 		 := 'http://certstagingvip.hpcc.risk.regn.net:9876'; // Cert
	roxieIP := 'http://roxiebatch.br.seisint.com:9856'; // Prod

  serviceName := 'BIPV2.IDfunctions_Service';

  svcInput := pkg1.IDFunctions.rec_SearchInput;
	


	idFunctionsInput0  := project(dInData, transform(svcInput, 
	                                                self := left, 
																									self.acctNo := (String) left.uniqueId; 
																									SELF.results_limit := 0;
																									SELF.inSeleid := '0';
																									SELF.allow7DigitMatch := FALSE;
																									SELF.HSort := FALSE;
																									SELF := LEFT));
																									// self        := []));  //FIX ME!
	 
	 
	groupSize := 10;
  groups := count(dInData)/groupSize + 1;

	recRequest := {
		DATASET(svcInput) search_input {xpath('search_input/Row')},
	};
	
 idFunctionsInput := PROJECT(idFunctionsInput0[1..groups], 
										 TRANSFORM(recRequest,
		                           SELF.search_input := idFunctionsInput0[((counter-1)*groupSize+1)..(counter*groupSize)]));

  idFunctionsInputDist := DISTRIBUTE(idFunctionsInput, 1); //1 node

  svcOut := RECORD
		SALT37.UIDType uniqueid;
		INTEGER2 weight;
		INTEGER2 score;
		UNSIGNED4 KeysUsed := 0;
		UNSIGNED4 KeysFailed := 0;
		BOOLEAN IsTruncated := FALSE;
		SALT37.UIDType seleid;
		SALT37.UIDType orgid;
		SALT37.UIDType ultid;
		SALT37.UIDType proxid;
		SALT37.UIDType powid; 
		SALT37.UIDType rcid;
		STRING acctno;
		STRING keysused_desc;
	END;

	

	// dsBatch := PROJECT(idFunctionsInput,
		// TRANSFORM(svcInput, 
			// SELF.results_limit := 0;
			// SELF.inSeleid := '0';
			// SELF.allow7DigitMatch := FALSE;
			// SELF.HSort := FALSE;
			// SELF := LEFT;
		// ));



	// inputs0 := PROJECT(dsBatch, 
		// TRANSFORM(recRequest,
			// SELF.search_input := LEFT;));

	// input := DISTRIBUTE(inputs0, RANDOM());

	output_layout := svcOut;
							
	errx := {(output_layout)
		STRING errorcode := '';
		INTEGER transaction_time {xpath('_call_latency_ms')};
	};

	errx err_out(idFunctionsInput L) := TRANSFORM
		SELF.errorcode := FAILCODE + FAILMESSAGE;
		self := L;
		self := [];
	end;

	// parallel(2) is the default for a SOAPCALL
	dIdFunctions :=
		SOAPCALL(idFunctionsInputDist, roxieIP, servicename, {idFunctionsInput}, DATASET(errx)
			,XPATH(servicename + 'Response/Results/Result/Dataset/Row') //you can look at the XML output from wsecl to get this (but the first 'results' doesnt show there)
			,ONFAIL(err_out(left)), PARALLEL(5), MERGE(10)
			// RETRY(3), TIMEOUT(300)
			,MERGE(1)
		);


  topChoice := dedup(sort(dIdFunctions, acctNo, -weight), acctNo)(weight >= iweight and score >=iscore);
  // topChoice := didFunctions;
	return NOFOLD(JOIN(topChoice, dInData,  (unsigned) left.acctNo = right.uniqueId  , TRANSFORM(modLayouts.lSampleLayout,
																																											SELF.uniqueId := if(LEFT.acctno !='', (unsigned) LEFT.acctno, right.uniqueId) ;
																																											SELF.proxweight := LEFT.weight;
																																											SELF.proxscore  := LEFT.score;
																																											self.proxid     := left.proxid;
																									                                    self.seleid     := left.seleid;
																									                                    self.orgid      := left.orgid;
																									                                    self.ultid      := left.ultid;
                                                                                      SELF            := RIGHT;
																																											SELF            := LEFT;
																																											),right outer));

																																										
												
	END; 

EXPORT DATASET(modLayouts.lSampleLayout) fCallWrapperMMF(DATASET(pkgQAMonitor.modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bForce=FALSE,BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := FUNCTION

lMmfInput := RECORD
  UNSIGNED   acctno;
  STRING120  company_name;
  STRING10   prim_range:='';
  STRING28   prim_name:='';
  STRING8    sec_range:='';
  STRING25   city:='';
  STRING2    st:='';
  STRING5    zip:='';
  STRING20   fname:='';
  STRING20   mname:='';
  STRING20   lname:='';
  STRING2    source:='';
  UNSIGNED   source_record_id:=0;
  STRING10   company_phone:='';
  STRING9    company_fein:='';
  STRING8    company_sic_code1:='';
  STRING80   company_url:='';
  STRING9    contact_ssn:='';
  STRING60   contact_email:='';
  UNSIGNED6  entered_proxid:=0;
  // These fields must be in your layout so that they can be populated by the macro
  UNSIGNED6  dotid:=0;
  UNSIGNED2  dotweight:=0;
  UNSIGNED2  dotscore:=0;
  UNSIGNED6  proxid:=0;
  UNSIGNED2  proxweight:=0;
  UNSIGNED2  proxscore:=0;
  UNSIGNED6  powid:=0;
  UNSIGNED2  powweight:=0;
  UNSIGNED2  powscore:=0;
  UNSIGNED6  seleid:=0;
  UNSIGNED2  seleweight:=0;
  UNSIGNED2  selescore:=0;
  UNSIGNED6  orgid:=0;
  UNSIGNED2  orgweight:=0;
  UNSIGNED2  orgscore:=0;
  UNSIGNED6  ultid:=0;
  UNSIGNED2  ultweight:=0;
  UNSIGNED2  ultscore:=0;
  UNSIGNED6  empid:=0;
  UNSIGNED2  empweight:=0;
  UNSIGNED2  empscore:=0;
END;

	pMMF0  := project(dInData, transform(lMmfInput, 
																									SELF.acctNo := left.uniqueId; 
																									SELF.st := left.state;
																									SELF.zip := left.zip5;
																									SELF.fname := left.contact_fname;
																									SELF.mname := left.contact_mname;
																									SELF.lname := left.contact_lname;
																									SELF.company_phone := left.phone10;
																									SELF.company_fein := left.fein;
																									SELF.company_sic_code1 := LEFT.sic_code;
																									SELF.company_url := LEFT.url;
																									SELF.contact_email := left.email;
																									self.source := IF(bUseSourceRid, left.src_category, left.source);
																						 			self.source_record_id := IF(bUseSourceRid, left.source_record_id, 0);
																									SELF := LEFT));


Business_Header_SS.MAC_Match_Flex
(
 /*  1: infile                                                         */  pMMF0
,/*  2: matchset                                                       */  ['A','F','P']
,/*  3: company_name_field                                             */  company_name
,/*  4: prange_field                                                   */  prim_range
,/*  5: pname_field                                                    */  prim_name
,/*  6: zip_field                                                      */  zip
,/*  7: srange_field                                                   */  sec_range
,/*  8: state_field                                                    */  st
,/*  9: phone_field                                                    */  company_phone
,/* 10: fein_field                                                     */  company_fein
,/* 11: BDID_field                                                     */  bdid
,/* 12: outrec                                                         */  RECORDOF(pMMF0)
,/* 13: bool_outrec_has_score                                          */  FALSE
,/* 14: BDID_Score_field                                               */  bdid_score
,/* 15: outfile                                                        */  dOutput
,/* 16: keep_count = '1'                                               */  
,/* 17: score_threshold = '75'                                         */  iScore
,/* 18: pFileVersion = '\'prod\''                                      */    
,/* 19: pUseOtherEnvironment = business_header._Dataset().IsDataland   */  
,/* 20: pSetLinkingVersions = BIPV2.IDconstants.xlink_versions_default */  [pkg1.IDconstants.xlink_version_BIP]
,/* 21: pURL =  ''                                                     */	 company_url
,/* 22: pEmail =  ''                                                   */  contact_email
,/* 23: pCity = ''                                                     */  city
,/* 24: pContact_fname = ''                                            */  fname
,/* 25: pContact_mname = ''                                            */  mname
,/* 26: pContact_lname = ''                                            */  lname
,/* 27: contact_ssn = ''                                               */  contact_ssn
,/* 28: source = ''                                                    */  source
,/* 29: source_record_id = ''                                          */  source_record_id
,/* 30: src_matching_is_priority  = FALSE                              */
,/* 31: setofstrings = '[\'NA\',\'NA\',\'NA\']'                        */
,/* 32: bScoreParents = TRUE                                           */  
// ,/* 33: bSegmentation = TRUE                                           */  bSegmentation  // NEEDS TO BE ADDED BACK ONCE MMF IS PLUMBED FOR SEGMENTATION
);

RETURN JOIN(dOutput, dInData, left.acctNo=right.uniqueid, TRANSFORM(modLayouts.lSampleLayout,
																																											SELF := LEFT;
																																											SELF := RIGHT;
																																											SELF := []; 
																																											));

END;

END;