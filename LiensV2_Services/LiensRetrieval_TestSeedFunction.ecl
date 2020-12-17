IMPORT $, iesp, FFD, Risk_Indicators, RiskView, Seed_Files, STD;

EXPORT LiensRetrieval_TestSeedFunction(iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalSearchBy srchby,
                                        BOOLEAN DeferredTaskRequest = FALSE,
                                        INTEGER8 FFDOptionsMask,
                                        STRING32 TestDataTableName_in = ''
                                        ) := FUNCTION

   Risk_Indicators.Layout_Input toTestSeed() := TRANSFORM
    
    SELF.fname := STD.Str.ToUpperCase(srchby.Name.First);
    SELF.lname := STD.Str.ToUpperCase(srchby.Name.Last);
    SELF.ssn := srchby.SSN;
    SELF.in_zipCode := srchby.Address.Zip5;
    SELF.phone10 := srchby.Phone;
    SELF := [];

   END;

  packagedTestseedInput := DATASET([toTestSeed()]);

  SeedKey := Seed_Files.Key_RiskView2;

  Liensv2_services.layout_liens_Retrieval.layout_testseed_search getSeedData(Risk_Indicators.Layout_Input le, SeedKey ri) := TRANSFORM

    SELF.LexID := ri.LexID;
    SELF.SSN := ri.SSN;

    // liens 1&2
    lien1:= DATASET([TRANSFORM(
      $.layout_liens_Retrieval.layout_testseed_liens,
      SELF.seq := ri.liens1_seq;
      SELF.DateFiled := ri.liens1_DateFiled;
      SELF.LienTypeID := ri.Liens1_LienTypeID;
      SELF.Amount := ri.Liens1_Amount;
      SELF.ReleaseDate := ri.Liens1_ReleaseDate;
      SELF.Defendant := ri.Liens1_Defendant;
      SELF.StreetNumber := ri.Liens1_StreetNumber;
      SELF.StreetPreDirection := ri.Liens1_StreetPreDirection;
      SELF.StreetName := ri.Liens1_StreetName;
      SELF.StreetSuffix := ri.Liens1_StreetSuffix;
      SELF.StreetPostDirection := ri.Liens1_StreetPostDirection;
      SELF.UnitDesignation := ri.Liens1_UnitDesignation;
      SELF.UnitNumber := ri.Liens1_UnitNumber;
      SELF.StreetAddress1 := ri.Liens1_StreetAddress1;
      SELF.StreetAddress2 := ri.Liens1_StreetAddress2;
      SELF.City := ri.Liens1_City;
      SELF.State := ri.Liens1_State;
      SELF.Zip5 := ri.Liens1_Zip5;
      SELF.Zip4 := ri.Liens1_Zip4;
      SELF.County := ri.Liens1_County;
      SELF.PostalCode := ri.Liens1_PostalCode ;
      SELF.StateCityZip := ri.Liens1_StateCityZip;
      SELF.ConsumerStatementID := ri.Liens1_ConsumerStatementID;
      SELF := [];
    )]);
  
    lien2:= DATASET([TRANSFORM(
      $.layout_liens_Retrieval.layout_testseed_liens,
      SELF.seq := ri.liens2_seq;
      SELF.DateFiled := ri.Liens2_DateFiled;
      SELF.LienTypeID := ri.Liens2_LienTypeID;
      SELF.Amount := ri.Liens2_Amount;
      SELF.ReleaseDate := ri.Liens2_ReleaseDate;
      SELF.Defendant := ri.Liens2_Defendant;
      SELF.StreetNumber := ri.Liens2_StreetNumber;
      SELF.StreetPreDirection := ri.Liens2_StreetPreDirection;
      SELF.StreetName := ri.Liens2_StreetName;
      SELF.StreetSuffix := ri.Liens2_StreetSuffix;
      SELF.StreetPostDirection := ri.Liens2_StreetPostDirection;
      SELF.UnitDesignation := ri.Liens2_UnitDesignation;
      SELF.UnitNumber := ri.Liens2_UnitNumber;
      SELF.StreetAddress1 := ri.Liens2_StreetAddress1;
      SELF.StreetAddress2 := ri.Liens2_StreetAddress2;
      SELF.City := ri.Liens2_City;
      SELF.State := ri.Liens2_State;
      SELF.Zip5 := ri.Liens2_Zip5;
      SELF.Zip4 := ri.Liens2_Zip4;
      SELF.County := ri.Liens2_County;
      SELF.PostalCode := ri.Liens2_PostalCode ;
      SELF.StateCityZip := ri.Liens2_StateCityZip;
      SELF.ConsumerStatementID := ri.Liens2_ConsumerStatementID;
      SELF := [];
    )]);
    
    SELF.Alert1 := ri.Alert1;
    SELF.Alert2 := ri.Alert2;
    SELF.Alert3 := ri.Alert3;
    SELF.Alert4 := ri.Alert4;
    SELF.Alert5 := ri.Alert5;
    SELF.Alert6 := ri.Alert6;
    SELF.Alert7 := ri.Alert7;
    SELF.Alert8 := ri.Alert8;
    SELF.Alert9 := ri.Alert9;
    SELF.Alert10 := ri.Alert10;

    SELF.Liens := (lien1 + lien2)(seq<>'');

    // ConsumerStatement 1&2
    cs1:= DATASET([TRANSFORM(
    iesp.share_fcra.t_ConsumerStatement,
      SELF.UniqueId := ri.CS_UniqueId;
      SELF.TimeStamp.Year := ri.CS_Year;
      SELF.TimeStamp.Month := ri.CS_Month;
      SELF.TimeStamp.Day := ri.CS_Day;
      SELF.Timestamp.Hour24 := ri.CS_Hour24;
      SELF.Timestamp.Minute := ri.CS_Minute;
      SELF.Timestamp.Second := ri.CS_Second;
      SELF.StatementId := ri.CS_StatementId;
      SELF.StatementType := ri.CS_StatementType;
      SELF.DataGroup := ri.CS_DataGroup ;
      SELF.Content := ri.CS_Content;
      SELF := [];
      )]);
  
  
    cs2:= DATASET([TRANSFORM(
    iesp.share_fcra.t_ConsumerStatement,
      SELF.UniqueId := ri.CS2_UniqueId;
      SELF.TimeStamp.Year := ri.CS2_Year;
      SELF.TimeStamp.Month := ri.CS2_Month;
      SELF.TimeStamp.Day := ri.CS2_Day;
      SELF.Timestamp.Hour24 := ri.CS2_Hour24;
      SELF.Timestamp.Minute := ri.CS2_Minute;
      SELF.Timestamp.Second := ri.CS2_Second;
      SELF.StatementId := ri.CS2_StatementId;
      SELF.StatementType := ri.CS2_StatementType;
      SELF.DataGroup := ri.CS2_DataGroup ;
      SELF.Content := ri.CS2_Content;
      SELF := [];
    )]);
   
    SELF.ConsumerStatements := cs1 + cs2;
    SELF := le;
   END;

  seedResults := JOIN(packagedTestseedInput, SeedKey, 
    KEYED(RIGHT.TestDataTableName = TestDataTableName_in) AND
    KEYED(RIGHT.HashValue = Seed_Files.Hash_InstantID(STD.Str.ToUpperCase(TRIM(LEFT.FName, LEFT, RIGHT)),
    STD.Str.ToUpperCase(TRIM(LEFT.LName, LEFT, RIGHT)), TRIM(LEFT.SSN, LEFT, RIGHT),
    Risk_Indicators.nullstring, TRIM(LEFT.in_Zipcode[1..5], LEFT, RIGHT),
    TRIM(LEFT.Phone10, LEFT, RIGHT), Risk_Indicators.nullstring)),
                              getSeedData(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

  // Convert Search Results to alert code/description pairs for ESDL:
  seedResults_temp := PROJECT(seedResults, 
    TRANSFORM(riskview.layouts.layout_riskview5_search_results,
              SELF:= LEFT,SELF := []));
  nameValuePairsAlerts := NORMALIZE(seedResults_temp, 10, RiskView.Transforms.norm_alerts(LEFT, COUNTER))(code<>'');

  // unique id/ ssn found from seed key
  UniqueId := seedResults[1].Lexid;
  SSN_val := seedResults[1].ssn;

  //boolean checks
  is_valid_rec_found := EXISTS(seedResults(ssn <> ''));
  is_OKCsubmitted := ~DeferredTaskRequest AND is_valid_rec_found; // IF found has match IN key, assuming request has been submitted
  dte_gateway_success := DeferredTaskRequest AND is_valid_rec_found;

  // test seed liens recs
  iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRecord toRecords($.layout_liens_Retrieval.layout_testseed_liens L) := TRANSFORM

     SELF.UniqueId := UniqueId;
     SELF.DefendantName := iesp.ECL2ESP.SetName('', '', '', '', '', L.Defendant);
     SELF.DefendantAddress := iesp.ECL2ESP.SetAddress(L.StreetName, L.StreetNumber,
        L.StreetPreDirection, L.StreetPostDirection, L.StreetSuffix, L.UnitDesignation, L.UnitNumber,
        L.City, L.State, L.Zip5, L.zip4, L.County, L.PostalCode,
        L.StreetAddress1, L.StreetAddress2, L.StateCityZip);
     SELF.SSN := SSN_val;
     SELF.FilingDate := iesp.ECL2ESP.toDate((INTEGER)L.DateFiled);
     SELF.FilingTypeID := L.LienTypeID;
     SELF.ReleaseDate := iesp.ECL2ESP.toDate((INTEGER)L.ReleaseDate);
     SELF.Amount := L.amount;
     SELF.IsDisputed := FALSE; // this flag willbe removed IN future dev
     SELF.StatementIds := PROJECT(DATASET([L.ConsumerStatementId], iesp.share_fcra.t_StatementIdRec),
                         TRANSFORM(FFD.Layouts.StatementIdRec, SELF.StatementId := LEFT.StatementId, SELF := []));

   END;

   ds_liens_seeds := IF(DeferredTaskRequest AND is_valid_rec_found,
                  PROJECT(seedResults[1].liens, toRecords(LEFT)));

   iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalResponse toFinal() := TRANSFORM

      ds_norecs_excep := DATASET([{
        $.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
        (INTEGER) $.Constants.LIENS_RETRIEVAL.NO_RECS_FOUND_CODE,
        '',
        $.Constants.LIENS_RETRIEVAL.NO_RECS_FOUND_EXCEPTION}
      ], iesp.share.t_WsException);
                                                      
      SELF._Header.Exceptions:= IF(~is_valid_rec_found, ds_norecs_excep,
        DATASET([], iesp.share.t_WsException));
      
      //returns in case of okc submission success
      SELF._Header.Message := IF(is_OKCsubmitted, $.Constants.LIENS_RETRIEVAL.OKC_SUBMISSION_MESSAGE, '');
      SELF._Header:= iesp.ECL2ESP.GetHeaderRow();
      SELF.RecordCount := COUNT(ds_liens_seeds);
      SELF.InputEcho := srchby;
      SELF.Records := ds_liens_seeds;
      SELF.Alerts := nameValuePairsAlerts;
      SELF.ConsumerStatements := seedResults[1].ConsumerStatements;
      SELF.Consumer := FFD.MAC.PrepareConsumerRecord(UniqueId, TRUE, srchby);

   END;

  srch_recs := DATASET([toFinal()]);

  RETURN srch_recs;

END;
