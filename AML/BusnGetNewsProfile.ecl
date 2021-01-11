IMPORT AML, Gateway, STD;

EXPORT BusnGetNewsProfile(DATASET(AML.Layouts.AMLRiskProfileInput) indata, 
													STRING UseXG5, 
													BOOLEAN IncludeNews,
													DATASET (Gateway.Layouts.Config) gateways) := FUNCTION

    //needs to be in release bug for V2
    AML.Layouts.BridgerSearchInput  PrepBridger(indata le)  := TRANSFORM
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
      INTEGER BusProfileType;
      BOOLEAN OFACpresence;
      BOOLEAN amlCtgy;
      BOOLEAN exactamlCtgy;
      BOOLEAN possamlctgy;
      BOOLEAN exactnonamlctgy;
      BOOLEAN possnonamlctgy;
      
    end;

    BlockRec := RECORD
      INTEGER blockid;
      STRING errormessage;
      UNSIGNED2 exactamlCtgycnt;
      UNSIGNED2 possamlctgycnt;
      UNSIGNED2 exactnonamlctgycnt;
      UNSIGNED2 possnonamlctgycnt;	
      UNSIGNED2 MaxBusProfileType;	
      UNSIGNED2 MaxIndProfileType;		
      STRING4 BusHighRiskNewsProfiles;		
      STRING4 BusHighRiskNewsProfileType;	
      DATASET(CategoryRecord) CatRec;
    END;



    BlockRec GetResultTypes(BridgerSearch le) := TRANSFORM
      SELF.blockid := le.blockid;
      SELF.errormessage := le.errormessage;
      SELF.catrec := PROJECT(le.catrec, TRANSFORM(CategoryRecord,
                            amlCtgy := IF(STD.Str.ToUpperCase(TRIM(LEFT.reasonCtgy)) + '-' + STD.Str.ToUpperCase(TRIM(LEFT.reasonSubCtgy)) IN AML.AMLConstants.AMLNewsCategory, TRUE, FALSE);						
      
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
                            SELF.BusProfileType := Map(LEFT.OFACpresence   =>  9,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'SANCTION LIST'  => 8,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'ENFORCEMENT'  => 7,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'ADVERSE MEDIA'  => 6,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'INVESTIGATION' or STD.Str.ToUpperCase(LEFT.reasonCtgy) = 'EXCLUDED PARTY'  => 5,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'ASSOCIATED ENTITY'  => 4,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'END-USE CONTROLS'  => 3,
                                                        STD.Str.ToUpperCase(LEFT.reasonCtgy)  = 'COMPANY OF INTEREST' or STD.Str.ToUpperCase(LEFT.reasonCtgy) = 'GOVERNMENT CORP'  => 2,
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
      SELF.maxBusProfileType :=  IF(COUNT(le.catrec) = 0, 1, MAX(le.catrec, BusProfileType));
      self := [];  
    End;

    CtgyCounts := PROJECT(newResulttypes, GetNewsCnt(LEFT));



    BlockRec GetKRI(CtgyCounts ri) := TRANSFORM
      SELF.blockid :=  ri.blockid;

      SELF.BusHighRiskNewsProfiles := MAP(ri.errormessage <> '' => '-999',
                                          ri.exactamlCtgycnt > 1 =>  '9',
                                          ri.exactamlCtgycnt = 1 =>  '8',
                                          ri.exactnonamlctgycnt > 1 =>  '7',
                                          ri.exactnonamlctgycnt = 1 =>  '6',
                                          ri.possamlctgycnt > 1 =>  '5',
                                          ri.possamlctgycnt = 1 =>  '4',
                                          ri.possnonamlctgycnt > 1 =>  '3',
                                          ri.possnonamlctgycnt = 1 =>  '2',
                                          ri.exactamlCtgycnt = 0 AND ri.possamlctgycnt = 0 AND 
                                                  ri.exactnonamlctgycnt = 0 AND ri.possnonamlctgycnt = 0 =>  '1',
                                          '0');


        SELF.BusHighRiskNewsProfileType := MAP(ri.errormessage <> '' => '-999',
                                                ri.errormessage = '' => (STRING)ri.maxBusProfileType, 
                                                '0');
        SELF := ri;
    END;

    NewsProfileKRI :=  PROJECT(CtgyCounts,  GetKRI(LEFT));

    SortNewProf := SORT(NewsProfileKRI, blockid);

    BlockRec rollnewprofile(SortNewProf le, SortNewProf ri ) := TRANSFORM
            SELF.BusHighRiskNewsProfiles := MAX(le.BusHighRiskNewsProfiles, ri.BusHighRiskNewsProfiles );
            SELF.BusHighRiskNewsProfileType  := MAX(le.BusHighRiskNewsProfileType, ri.BusHighRiskNewsProfileType);
            SELF := ri;
    END;

    RollBusnNewsProf :=  ROLLUP(SortNewProf, LEFT.blockid = RIGHT.blockid,
                              rollnewprofile(LEFT, RIGHT));

    AML.Layouts.AMLRiskProfileInput  AddKRI(indata le, RollBusnNewsProf ri) := TRANSFORM
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

      SELF.BusHighRiskNewsProfiles := ri.BusHighRiskNewsProfiles;
      SELF.BusHighRiskNewsProfileType := ri.BusHighRiskNewsProfileType;
      SELF.xg5return := [];
      SELF := [];
    END;

    AddNewsProfileKRI :=  JOIN(indata(bdid <>0), RollBusnNewsProf,  
                              LEFT.seq = RIGHT.blockid,
                              AddKRI(LEFT, RIGHT), 
                              LEFT OUTER);
                              
    finalBusnWithxg5 := JOIN(AddNewsProfileKRI, BridgerSearch, 
                              LEFT.seq = RIGHT.blockid,
                              TRANSFORM(AML.Layouts.AMLRiskProfileInput, 
                                        SELF.XG5Return := RIGHT.XG5Return, 
                                        SELF := LEFT), 
                              LEFT OUTER);
                           
    finalBusnKri := IF(UseXG5 = '1',finalBusnWithxg5,AddNewsProfileKRI);											
                              
    AML.Layouts.AMLRiskProfileInput  NoNewsKRI(indata le) := TRANSFORM
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

      SELF.BusHighRiskNewsProfiles := '0';
      SELF.BusHighRiskNewsProfileType := '0';
      SELF.xg5return := [];
      SELF := [];
    END;

    NoNewsProfileKRI :=  PROJECT(indata(bdid <>0), NoNewsKRI(LEFT));
                              
    NewsProfileAttrib := IFF(IncludeNews, finalBusnKri, NoNewsProfileKRI);
                              
    // output(indata, named('indata'));
    // output(gateways, named('gateways'));
    // output(PrepNewsProfile, named('PrepNewsProfile'), overwrite);	
    // output(BridgerSearch, named('BridgerSearch'), overwrite);	
    // output(newResulttypes, named('newResulttypes'), overwrite);	
    // output(CtgyCounts, named('CtgyCounts'), overwrite);	
    // output(NewsProfileKRI, named('NewsProfileKRI'), overwrite);	
    // output(SortNewProf, named('SortNewProf'), overwrite);	
    // output(RollBusnNewsProf, named('RollBusnNewsProf'), overwrite);	
      

		
		RETURN NewsProfileAttrib;												
END;
