IMPORT AML, Gateway, Risk_Indicators, STD;

/*
for testing use this declaration with set up the gateways in the appropriate stored variable
*/
// gateway_ext := dataset([
	// {'bridgerxg5','http://bridger_dev:[PASSWORD_REDACTED]@10.173.132.10:7001/WsSearchCore?ver_=1'}
	// ,
	// {'searchcore','HTTP://khillqa:[PASSWORD_REDACTED]@gatewaycertesp.sc.seisint.com:7726/WsGateway/?ver_=1.93'}
// ],  Risk_Indicators.Layout_Gateways_In );
// ],  Gateway.Layouts.Config );
// #stored('Gateways', gateway_ext);



EXPORT GetNewsProfile(DATASET(AML.Layouts.AMLRiskProfileInput) indata, 
                      STRING1 UseXG5, 
                      BOOLEAN IncludeNews, 
                      DATASET (Gateway.Layouts.Config) gateways) := FUNCTION


  //needs to be in release bug for V2
  AML.Layouts.BridgerSearchInput PrepBridger(indata le) := TRANSFORM
    SELF.seq := le.seq;
    SELF.did := le.did;
    SELF.bdid := le.Bdid;
    SELF.historydate := le.historydate;
    SELF.firstName := le.firstname;
    SELF.middleName := le.middleName;
    SELF.lastName := le.lastName;
    SELF.DOB := le.DOB;
    SELF.company_name := le.company_name;
    SELF.prim_range := le.prim_range;
    SELF.predir := le.predir;
    SELF.prim_name := le.prim_name;
    SELF.addr_suffix := le.addr_suffix;
    SELF.postdir := le.postdir;
    SELF.unit_desig := le.unit_desig;
    SELF.sec_range := le.sec_range;
    SELF.city_name := le.city_name;
    SELF.state := le.state;
    SELF.z5 := le.z5;
    SELF := [];
  END;

  PrepNewsProfile := PROJECT(indata, PrepBridger(LEFT));

  BridgerSearch := AML.BridgerGatewayCall(PrepNewsProfile, gateways);

  CategoryRecord := RECORD
    STRING fullname;
    STRING notes;
    STRING SearchCriteria;
    STRING reason;
    STRING reasonLevel;
    STRING reasonCtgy;
    STRING reasonSubCtgy;
    STRING score;
    STRING bestname;
    INTEGER IndProfileType;
    BOOLEAN OFACpresence;
    BOOLEAN amlCtgy;
    BOOLEAN exactamlCtgy;
    BOOLEAN possamlctgy;
    BOOLEAN exactnonamlctgy;
    BOOLEAN possnonamlctgy;
  END;

  BlockRec := RECORD
    INTEGER blockid;
    STRING errormessage;
    UNSIGNED2 exactamlCtgycnt;
    UNSIGNED2 possamlctgycnt;
    UNSIGNED2 exactnonamlctgycnt;
    UNSIGNED2 possnonamlctgycnt;	
    UNSIGNED2 MaxIndProfileType;	
    DATASET(CategoryRecord) CatRec;
  END;



  BlockRec GetResultTypes(BridgerSearch le) := TRANSFORM
    SELF.blockid := le.blockid;
    SELF.errormessage := le.errormessage;
    SELF.catrec := PROJECT(le.catrec, TRANSFORM(CategoryRecord,
                          PrepamlCtgy := TRIM(LEFT.reasonCtgy) + '-' + TRIM(LEFT.reasonSubCtgy); 						
                          amlCtgy := IF(STD.Str.ToUpperCase(PrepamlCtgy) IN AML.AMLConstants.AMLNewsCategory, TRUE, FALSE);
                          SELF.fullname := LEFT.fullname;
                          SELF.notes := LEFT.notes;
                          SELF.reason := LEFT.reason;
                          SELF.reasonLevel := LEFT.reasonLevel;
                          SELF.reasonCtgy := LEFT.reasonCtgy;
                          SELF.reasonSubCtgy := LEFT.reasonSubCtgy;
                          SELF.OFACpresence := LEFT.OFACpresence;
                          SELF.SearchCriteria := LEFT.SearchCriteria;
                          SELF.score := LEFT.score;
                          SELF.bestname := LEFT.bestname;
                          reasonCtgyUC := STD.Str.ToUpperCase(LEFT.reasonCtgy);
                          reasonSubCtgyUC := STD.Str.ToUpperCase(LEFT.reasonSubCtgy);
                          SELF.IndProfileType := Map(LEFT.OFACpresence =>  9,
                                                    reasonCtgyUC  = 'SANCTION LIST' => 8,
                                                    reasonCtgyUC  = 'ENFORCEMENT' => 7,
                                                    reasonCtgyUC  = 'PEP' AND reasonSubCtgyUC <> 'FORMER PEP' => 6,
                                                    (reasonCtgyUC  = 'PEP' OR reasonCtgyUC  = 'ENFORCEMENT' OR reasonCtgyUC  = 'ASSOCIATED ENTITY' 
                                                        OR reasonCtgyUC  = 'ADVERSE MEDIA' OR reasonCtgyUC  = 'INVESTIGATION' OR 	reasonCtgyUC  = 'INFLUENTIAL PERSON')	
                                                        AND reasonSubCtgyUC = 'FORMER PEP' => 5,
                                                    reasonCtgyUC  = 'ADVERSE MEDIA' => 4,
                                                    reasonCtgyUC  = 'INVESTIGATION' OR reasonCtgyUC = 'EXCLUDED PARTY' => 3,
                                                    reasonCtgyUC  = 'ASSOCIATED ENTITY' => 2,
                                                     1);

                             
                          SELF.amlCtgy := amlCtgy;												
                          SELF.exactamlCtgy := IF(amlCtgy AND (INTEGER)LEFT.score = 100, TRUE, FALSE); 
                          SELF.possamlctgy := IF(amlCtgy AND (INTEGER)LEFT.score < 100, TRUE, FALSE); 
                          SELF.exactnonamlctgy := IF(~amlCtgy AND (INTEGER)LEFT.score = 100, TRUE, FALSE); 
                          SELF.possnonamlctgy := IF(~amlCtgy AND (INTEGER)LEFT.score < 100, TRUE, FALSE))); 
    
    SELF := [];  
  END;

  newResulttypes := PROJECT(BridgerSearch, GetResultTypes(LEFT));

  BlockRec GetNewsCnt(newResulttypes le) := TRANSFORM
    SELF.blockid := le.blockid;
    SELF.errormessage := le.errormessage;
    SELF.catrec := le.catrec;											
    SELF.exactamlCtgycnt := COUNT(le.catrec(exactamlCtgy = TRUE ));	
    SELF.possamlctgycnt := COUNT(le.catrec(possamlctgy = TRUE ));
    SELF.exactnonamlctgycnt := COUNT(le.catrec(exactnonamlctgy = TRUE ));	
    SELF.possnonamlctgycnt := COUNT(le.catrec(possnonamlctgy = TRUE));
    SELF.maxIndProfileType := IF(COUNT(le.catrec) = 0, 1, MAX(le.catrec, IndProfileType));
    SELF := [];  
  END;

  CtgyCounts := PROJECT(newResulttypes, GetNewsCnt(LEFT));

  AML.Layouts.AMLRiskProfileInput AddKRI(indata le, CtgyCounts ri) := TRANSFORM
    SELF.seq := le.seq;
    SELF.did := le.did;
    SELF.bdid := le.bdid;
    SELF.historydate := le.historydate;
    SELF.firstName := le.firstName;
    SELF.middleName := le.middleName;
    SELF.lastName := le.lastName;
    SELF.DOB := le.DOB;
    SELF.company_name := le.company_name;
    SELF.state := le.state;
    SELF.IndHighRiskNewsProfiles := IF(le.did <> 0, 	
                                        MAP(ri.errormessage <> '' => '-999',
                                            ri.exactamlCtgycnt > 1 =>  '9',
                                            ri.exactamlCtgycnt = 1 =>  '8',
                                            ri.exactnonamlctgycnt > 1 =>  '7',
                                            ri.exactnonamlctgycnt = 1 =>  '6',
                                            ri.possamlctgycnt > 1 =>  '5',
                                            ri.possamlctgycnt = 1 =>  '4',
                                            ri.possnonamlctgycnt > 1 =>  '3',
                                            ri.possnonamlctgycnt = 1 =>  '2',
                                            ri.exactamlCtgycnt = 0 AND ri.possamlctgycnt = 0	AND 
                                                  ri.exactnonamlctgycnt = 0 AND ri.possnonamlctgycnt = 0 	=>  '1',
                                            '0'),
                                        '0');

		SELF.IndHighRiskNewsProfileType :=  IF(le.did <> 0, 		
                                            MAP(ri.errormessage <> '' => '-999',
                                                ri.errormessage = '' => (STRING)ri.maxIndProfileType, 
                                                '0'),
                                            '0');


	  SELF := [];
	END;

	NewsProfileKRI :=  JOIN(indata, CtgyCounts,  
                          LEFT.seq = RIGHT.blockid,
													AddKRI(LEFT, RIGHT), 
                          LEFT OUTER);

	finalwithxg5 := JOIN(NewsProfileKRI, BridgerSearch, 
                      LEFT.seq = RIGHT.blockid,
											TRANSFORM(AML.Layouts.AMLRiskProfileInput, 
                                SELF.XG5Return := RIGHT.XG5Return, 
                                SELF := LEFT));
	
 	finalKri := IF(UseXG5 = '1', finalwithxg5, NewsProfileKRI);
	
	AML.Layouts.AMLRiskProfileInput AddNoNewsKRI(indata le) := TRANSFORM
      SELF.seq := le.seq;
      SELF.did := le.did;
      SELF.bdid := le.bdid;
      SELF.historydate := le.historydate;
      SELF.firstName := le.firstName;
      SELF.middleName := le.middleName;
      SELF.lastName := le.lastName;
      SELF.DOB := le.DOB;
      SELF.company_name := le.company_name;
      SELF.state := le.state;
      SELF.IndHighRiskNewsProfiles := '0';
      SELF.IndHighRiskNewsProfileType := '0';
      SELF := [];
	END;
	
	NoNewsProfileKRI :=  PROJECT(indata(did <>0), AddNoNewsKRI(LEFT));
													
	NewsProfileAttrib := IFF(IncludeNews, finalKri, NoNewsProfileKRI);	
	
										
						
  //TESTING
  // output(indata, named('indata'));
  // output(UseXG5, named('UseXG5'));
  // output(PrepNewsProfile, named('PrepNewsProfile'), overwrite);	
  // output(BridgerSearch, named('BridgerSearch'), overwrite);	
  // output(newResulttypes, named('newResulttypes'), overwrite);	
  // output(CtgyCounts, named('CtgyCounts'), overwrite);	
  // output(NewsProfileKRI, named('NewsProfileKRI'), overwrite);	

  RETURN NewsProfileAttrib;	
		
END;
