IMPORT AML, Gateway, iesp;


EXPORT BridgerGatewayCall(DATASET(AML.Layouts.BridgerSearchInput) inData,
                          DATASET(Gateway.Layouts.Config) gateways) := FUNCTION



    apiGatewayConfig := Gateway.Configuration.get()(Gateway.Configuration.IsBridgerAPI(servicename))[1];
    //eventually world compliance will be removed from XG5 and this will no longer produce any results
    //adding for backwards compatiility while conversion happens
    xg5GatewayConfig  := Gateway.Configuration.get()(Gateway.Configuration.IsBridgerXG5(servicename))[1];


    //if both gateways were passed - API should take precedence
    gatewayResults := MAP(apiGatewayConfig.url <> AML.AMLConstants.EMPTY_STRING => AML.BridgerAPIGatewayCall(inData, gateways),
                          xg5GatewayConfig.url <> AML.AMLConstants.EMPTY_STRING => AML.BSSXG5GatewayCall(inData, gateways),
                          DATASET([], iesp.WsSearchCore.t_SearchResponse));





    entityDetailsRecord := RECORD, MAXLENGTH(16384)
      STRING fullname;
      STRING notes;
      STRING reason;
      STRING SearchCriteria;
      STRING score;
      STRING bestname;
    end;

    ResponseRec := RECORD
      INTEGER blockid;
      STRING errormessage;
      DATASET(entityDetailsRecord) EDRec;
    END;
    
    CategoryRecord := RECORD, MAXLENGTH(16384)
      STRING fullname;
      STRING notes;
      STRING SearchCriteria;
      STRING source;
      STRING reason;
      STRING reasonLevel;
      STRING reasonCtgy;
      STRING reasonSubCtgy;
      STRING score;
      STRING bestname;
      STRING offense;
      STRING level;
      STRING lastupdated;
      STRING country;
      BOOLEAN ofacPresence;
    END;

    ResponseRecSlim := record
      INTEGER blockID;
      STRING errormessage;
      DATASET(CategoryRecord) catRec;
      iesp.WsSearchCore.t_SearchResponse xg5Return;
    END;


    
    
    
    // Xg5call can have multiple returns if the soap call is given multiple requests,
    // EntityRecords can have multiple if a single request contained multiple entity
    // requests

    // iesp.WsSearchCore.t_SearchResponse // SearchResult // EntityRecords[] // Matches[] // Entity // EntityDetails.full // checksum, reason
    // we can have multiple entity records, if we request multiple entity records on the input...
    // assuming we only do one, we need only hit a single return: XG5Call[1].SearchResult.EntityRecords[1]
    // all data below that is about the single entity on input.
    

    newsMain := PROJECT(gatewayResults, TRANSFORM(ResponseRec,
                                                  SELF.blockID := LEFT.searchresult.EntityRecords[1].InputRecord.id;
                                                  SELF.errormessage := LEFT.searchresult.errormessage;
                                                  
                                                  SELF.EDRec := PROJECT(LEFT.SearchResult.EntityRecords.Matches, TRANSFORM(entityDetailsRecord,
                                                                                                                          SELF.notes := LEFT.Entity.EntityDetails.Notes[1..4000];
                                                                                                                          SELF.reason := IF(TRIM(LEFT.entity.EntityUniqueID) = '', '', LEFT.Entity.EntityDetails.reason);
                                                                                                                          SELF.SearchCriteria := IF(TRIM(LEFT.entity.EntityUniqueID) = '', '', LEFT.Entity.SearchCriteria);
                                                                                                                          SELF.fullname := (STRING)LEFT.Entity.EntityDetails.Name.full;
                                                                                                                          SELF.score := (STRING)LEFT.entity.Score;
                                                                                                                          SELF.bestname := (STRING)LEFT.Name.Best;
                                                                                                                          SELF := [];));));


    

    // NOTES PARSER ------------------------------------------------
    PATTERN notdelim := PATTERN('[^|]');
    PATTERN notcomma := PATTERN('[^,]');
    PATTERN ws1 := PATTERN('[ \t]');

    PATTERN ws := ws1*;
    PATTERN recA := notdelim+;
    PATTERN recB := notcomma+;
    PATTERN endrec := '||' ws;
    //extra recA created to keep seperate/track of those should level be optional
    PATTERN lvl := recA;
    PATTERN cat := recA;
    PATTERN sub := recA;

    PATTERN source :=  'Source:' ws recB ws ',' ws recA;
    PATTERN offense := 'Offense:' ws recA;
    PATTERN levcat  := ('Level:' ws lvl ws '|' ws)* 'Category:' ws cat ws '|' ws 'Subcategory:' ws sub;
    PATTERN lastup :=  'Last updated:' ws recA;
    PATTERN skp := recA ('|' recA)*; // some contain single embedded pipes as field delims

    PATTERN thedata := (levcat | source | offense | lastup | skp);
    RULE allrecs := FIRST ws thedata (endrec thedata)* LAST;
    // ------------------------------------------------

    CategoryRecord parseXform(entityDetailsRecord le) := TRANSFORM
      SELF.fullName := le.fullname;
      SELF.reason := le.reason;
      SELF.source := TRIM(MATCHTEXT(source/recA)); 
      SELF.ofacPresence := TRIM(MATCHTEXT(source/recA)) in AML.AMLConstants.BRIDGER_OFAC_SOURCES;
      SELF.reasonLevel := TRIM(MATCHTEXT(levcat/lvl));
      SELF.reasonCtgy := TRIM(MATCHTEXT(levcat/cat));
      SELF.reasonSubCtgy := TRIM(MATCHTEXT(levcat/sub));
      SELF.score := le.score;
      SELF.bestName := le.bestname;

      SELF.country := TRIM(MATCHTEXT(source/recB));
      SELF.offense:= TRIM(MATCHTEXT(offense/recA));
      SELF.lastUpdated := TRIM(MATCHTEXT(lastup/recA));
      
      SELF := [];
    END;
    

    categoryRec := JOIN(newsMain, gatewayResults,
                        LEFT.blockid = RIGHT.searchresult.EntityRecords[1].InputRecord.id,
                        TRANSFORM(ResponseRecSlim,
                                  SELF.blockID := LEFT.blockID;
                                  SELF.errorMessage := LEFT.errorMessage;
                                  SELF.catrec := PARSE(LEFT.EDRec, Notes, allrecs, parseXform(LEFT), BEST, SCAN, NOCASE);
                                  SELF.xg5Return := RIGHT;
                                  SELF := []; ));




    // OUTPUT(inData, NAMED('inDataNEWS'), OVERWRITE);
    // OUTPUT(gatewayResults, NAMED('gatewayResults'), OVERWRITE);
    // OUTPUT(newsMain, NAMED('NewsMain'), OVERWRITE);
    // OUTPUT(categoryRec, NAMED('CategoryRec'), OVERWRITE);
    // OUTPUT(categoryRec[1].XG5Return, NAMED('xg5res'));
      

    RETURN categoryRec;
END;