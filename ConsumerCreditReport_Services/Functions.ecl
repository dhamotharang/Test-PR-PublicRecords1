IMPORT Address, BatchShare, FFD, FCRA, iesp, PersonContext, Risk_Indicators, RiskView, Standard, Suppress, STD;

EXPORT Functions := MODULE

  EXPORT format_InputRec (DATASET(iesp.consumercreditreport_fcra.t_FcraConsumerCreditReportRequest) ds_ccr_req) := FUNCTION

    ConsumerCreditReport_Services.Layouts.inputRec xformInput(ds_ccr_req L) := TRANSFORM
      SELF.acctno:=L.ReportBy.AccountNumber;
      SELF.name_full:=L.ReportBy.Name.Full;
      SELF.name_first:=L.ReportBy.Name.First;
      SELF.name_middle:=L.ReportBy.Name.Middle;
      SELF.name_last:=L.ReportBy.Name.Last;
      SELF.name_suffix:=L.ReportBy.Name.Suffix;
      SELF.SSN:=STD.Str.Filter(L.ReportBy.SSN,'0123456789');
      DOB:=iesp.ECL2ESP.DateToString(L.ReportBy.DOB);
      SELF.DOB:=IF((UNSIGNED)DOB>0,DOB,'');
      SELF.phoneno:=STD.Str.Filter(L.ReportBy.PhoneNumber,'0123456789');
      SELF.addr:=TRIM(L.ReportBy.Address.StreetAddress1)+' '+L.ReportBy.Address.StreetAddress2;
      SELF.prim_range:=L.ReportBy.Address.StreetNumber;
      SELF.predir:=L.ReportBy.Address.StreetPreDirection;
      SELF.prim_name:=L.ReportBy.Address.StreetName;
      SELF.addr_suffix:=L.ReportBy.Address.StreetSuffix;
      SELF.postdir:=L.ReportBy.Address.StreetPostDirection;
      SELF.unit_desig:=L.ReportBy.Address.UnitDesignation;
      SELF.sec_range:=L.ReportBy.Address.UnitNumber;
      SELF.p_city_name:=L.ReportBy.Address.City;
      SELF.st:=L.ReportBy.Address.State;
      SELF.z5:=L.ReportBy.Address.Zip5;
      SELF.zip4:=L.ReportBy.Address.Zip4;
      SELF.county_name:=L.ReportBy.Address.County;
      SELF.did:=0;
    END;

    RETURN PROJECT(ds_ccr_req,xformInput(LEFT));
  END;


  EXPORT clean_Names (DATASET(ConsumerCreditReport_Services.Layouts.inputRec) ds_input_recs) := FUNCTION

    ConsumerCreditReport_Services.Layouts.inputRec cleanName(ds_input_recs L) := TRANSFORM
      hasFullName:=L.name_full!='' AND (L.name_first='' AND L.name_last='');
      cln:=Address.CleanNameFields(Address.CleanPerson73(L.name_full));
      SELF.name_first := IF(hasFullName,cln.fname,L.name_first);
      SELF.name_middle:= IF(hasFullName,cln.mname,L.name_middle);
      SELF.name_last  := IF(hasFullName,cln.lname,L.name_last);
      SELF.name_suffix:= IF(hasFullName,cln.name_suffix,L.name_suffix);
      SELF:=L;
    END;
    
    RETURN PROJECT(ds_input_recs,cleanName(LEFT));  
  END;


  EXPORT append_Dids (DATASET(ConsumerCreditReport_Services.Layouts.workRec) ds_work_in,
                      ConsumerCreditReport_Services.IParams.Params in_mod) := FUNCTION

    BatchShare.MAC_AppendDidVilleDID(ds_work_in(error_code=0),ds_work_out,in_mod);

    ConsumerCreditReport_Services.Layouts.workRec appendDids(ds_work_in L, ds_work_out R) := TRANSFORM
      noRecordsFound:=R.err_search=Standard.Errors.SEARCH.DID_NOT_FOUND;
      hasTooManySubjects:=R.err_search=Standard.Errors.SEARCH.DID_MULTIPLE;
      SELF.did:=IF(noRecordsFound OR hasTooManySubjects,L.did,R.did);
      SELF.err_search:=R.err_search;
      SELF.error_code:=R.error_code;
      SELF:=L;
    END;

    RETURN JOIN(ds_work_in,ds_work_out,
      LEFT.acctno=RIGHT.acctno,
      appendDids(LEFT,RIGHT),
      LEFT OUTER,KEEP(1));
  END;


  EXPORT append_PersonContext (DATASET(ConsumerCreditReport_Services.Layouts.workRec) ds_work_in,
                                ConsumerCreditReport_Services.IParams.Params in_mod, 
                DATASET(FFD.Layouts.PersonContextBatch) pc_recs = DATASET([],FFD.Layouts.PersonContextBatch)) := FUNCTION
                
  isReseller := TRUE;
  pc_alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask, isReseller);
  consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, pc_alert_flags[1], in_mod.FFDOptionsMask);

    Risk_Indicators.Layouts.tmp_Consumer_Statements xformConsumerStatement(FFD.Layouts.PersonContextBatch L) := TRANSFORM  
      SELF.UniqueId:=L.LexID;
      SELF.Timestamp:=iesp.ECL2ESP.toTimeStamp(STD.Str.Filter(L.DateAdded,' 0123456789'));
      SELF.StatementId:=L.StatementId;
      SELF.StatementType:=L.RecordType;
      SELF.DataGroup:=L.DataGroup;
      SELF.Content:=L.Content;
      SELF.RecIdForStId:=L.RecId1;
    END;
    
    consumer_statements:=PROJECT(pc_recs(RecordType IN [FFD.Constants.RecordType.StatementRecordLevel,
                                                     FFD.Constants.RecordType.StatementConsumerLevel
                                                    ]),xformConsumerStatement(LEFT));

    ConsumerCreditReport_Services.Layouts.workRec addChildRecs(ConsumerCreditReport_Services.Layouts.workRec L, 
                                                   DATASET(Risk_Indicators.Layouts.tmp_Consumer_Statements) R) := TRANSFORM
      SELF.ConsumerStatements:=R;
      SELF:=L;
    END;

  ds_work_with_cs:=DENORMALIZE(ds_work_in,consumer_statements,
                               LEFT.did=(UNSIGNED)RIGHT.UniqueId,
                               GROUP,addChildRecs(LEFT,ROWS(RIGHT)));

    ConsumerCreditReport_Services.Layouts.workRec addAlertRecs(ConsumerCreditReport_Services.Layouts.workRec L, 
                                                   DATASET(iesp.share_fcra.t_ConsumerAlert) R) := TRANSFORM
      SELF.ConsumerAlerts:=R;
      SELF:=L;
    END;

  ds_work_with_alerts:=DENORMALIZE(ds_work_with_cs,consumer_alerts,
                                   LEFT.did=(UNSIGNED)RIGHT.UniqueId,
                                   GROUP,addAlertRecs(LEFT,ROWS(RIGHT)));

    ConsumerCreditReport_Services.Layouts.workRec checkForAlerts(ConsumerCreditReport_Services.Layouts.workRec L, 
                                                               FFD.layouts.ConsumerFlagsBatch R) := TRANSFORM
      SELF.error_code:=MAP(
        L.error_code>0 => L.error_code,
        R.suppress_records => ConsumerCreditReport_Services.Constants.CONSUMER_ALERT_CODE, //records to be suppressed due to consumer alert(s), but no _header.exception to be generated, consumer alerts and CS statements to be returned
        L.did=0 => ConsumerCreditReport_Services.Constants.NO_LEXID_FOUND_CODE, 
        L.error_code);
      ds_consumer_statements:=IF(R.suppress_records,L.ConsumerStatements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel), 
                               L.ConsumerStatements);
      SELF.ConsumerStatements:= IF(R.has_consumer_statement OR R.has_record_statement,  ds_consumer_statements);                       
      // filtering out consumer statement alert in case of suppression of results and no consumer level statements on file for subject
      SELF.ConsumerAlerts:=IF(R.has_consumer_statement OR (R.has_record_statement AND ~R.suppress_records), L.ConsumerAlerts, L.ConsumerAlerts(Code<>FCRA.Constants.ALERT_CODE.CONSUMER_STATEMENT));
      SELF:=L;
    END;

  ds_work_out:=JOIN(ds_work_with_alerts, pc_alert_flags, LEFT.did=(UNSIGNED)RIGHT.UniqueId,
                    checkForAlerts(LEFT,RIGHT), LEFT OUTER, KEEP(1), LIMIT(0));

    RETURN ds_work_out;
  END;


  EXPORT append_UniqueId (DATASET(ConsumerCreditReport_Services.Layouts.ccrResp) ds_ccr_resp,
                          ConsumerCreditReport_Services.IParams.Params in_mod) := FUNCTION

    ConsumerCreditReport_Services.Layouts.workRec didvilleReq(ds_ccr_resp L):= TRANSFORM
      SELF.acctno := L.AccountNumber,
      Subj := L.ConsumerCreditReports[1].ReportHeader.Subject;
      SELF.name_first  := Subj.Name.First;
      SELF.name_middle := Subj.Name.Middle;
      SELF.name_last   := Subj.Name.Last;
      SELF.name_suffix := Subj.Name.Suffix;
      SELF.ssn := Subj.SSN;
      DOB := iesp.ECL2ESP.DateToString(Subj.DOB);
      SELF.dob := IF((UNSIGNED)DOB>0,DOB,'');
      Addr := L.ConsumerCreditReports[1].Addresses[1];
      SELF.phoneno     := Addr.PhoneNumber;
      SELF.prim_range  := Addr.StreetNumber;
      SELF.predir      := Addr.StreetPreDirection;
      SELF.prim_name   := Addr.StreetName;
      SELF.addr_suffix := Addr.StreetSuffix;
      SELF.postdir     := Addr.StreetPostDirection;
      SELF.unit_desig  := Addr.UnitDesignation;
      SELF.sec_range   := Addr.UnitNumber;
      SELF.p_city_name := Addr.City;
      SELF.st   := Addr.State;
      SELF.z5   := IF(Addr.Zip5!='',Addr.Zip5,Addr.PostalCode);
      SELF.zip4 := Addr.Zip4;
      SELF:=[];
    END;

    ds_didville_in:=PROJECT(ds_ccr_resp,didvilleReq(LEFT));
    BatchShare.MAC_AppendDidVilleDID(ds_didville_in,ds_didville_out,in_mod);

    iesp.consumercreditreport_fcra.t_FcraCCReport applyMasking(iesp.consumercreditreport_fcra.t_FcraCCReport L) := TRANSFORM
      SELF.ReportHeader.Subject.SSN:=Suppress.ssn_mask(L.ReportHeader.Subject.SSN,in_mod.SSN_Mask);
      DOB:=iesp.ECL2ESP.DateToInteger(L.ReportHeader.Subject.DOB);
      dobMasked:=Suppress.date_mask(DOB,Suppress.date_mask_math.MaskIndicator(in_mod.DOBMask));
      SELF.ReportHeader.Subject.DOB:=iesp.ECL2ESP.toDatestring8(dobMasked.Year+dobMasked.Month+dobMasked.day);
      SELF.IdentificationSSN.MDBSubject.SSN:=Suppress.ssn_mask(L.IdentificationSSN.MDBSubject.SSN,in_mod.SSN_Mask);
      SELF.IdentificationSSN.InquirySubject.SSN:=Suppress.ssn_mask(L.IdentificationSSN.InquirySubject.SSN,in_mod.SSN_Mask);
      SELF:=L;
    END;

    ConsumerCreditReport_Services.Layouts.ccrResp appendUniqueid(ds_ccr_resp L, ds_didville_out R) := TRANSFORM
      noRecordsFound:=R.err_search=Standard.Errors.SEARCH.DID_NOT_FOUND;
      hasTooManySubjects:=R.err_search=Standard.Errors.SEARCH.DID_MULTIPLE;
      UniqueId2:=IF(noRecordsFound OR hasTooManySubjects,'',(STRING)R.did);
      hasMatchingIds:=(UNSIGNED)L.UniqueId1=(UNSIGNED)UniqueId2;
      SELF.UniqueId2:=UniqueId2;
      SELF._Header.QueryId:=L.AccountNumber;
      SELF._Header.Exceptions:=MAP(
        noRecordsFound => L._Header.Exceptions+ConsumerCreditReport_Services.Constants.NO_LEXID_FOUND_G,
        hasTooManySubjects => L._Header.Exceptions+ConsumerCreditReport_Services.Constants.TOO_MANY_SUBJECTS_G,
        NOT hasMatchingIds => L._Header.Exceptions+ConsumerCreditReport_Services.Constants.NON_MATCHING_LEXID,
        L._Header.Exceptions);
      SELF.UniqueId:=IF(hasMatchingIds,UniqueId2,'');
      SELF.ConsumerCreditReports:=IF(hasMatchingIds,PROJECT(L.ConsumerCreditReports,applyMasking(LEFT)));
      SELF.ConsumerStatements:=IF(hasMatchingIds,L.ConsumerStatements);
      SELF.ConsumerAlerts:=IF(hasMatchingIds,L.ConsumerAlerts);
      SELF.LiensJudgmentsReports:=IF(hasMatchingIds,L.LiensJudgmentsReports);
      SELF:=L;
    END;

    RETURN JOIN(ds_ccr_resp,ds_didville_out,
      LEFT.AccountNumber=RIGHT.acctno,
      appendUniqueid(LEFT,RIGHT),
      LEFT OUTER,KEEP(1),LIMIT(0));
  END;


  EXPORT append_LiensJudgments (DATASET(ConsumerCreditReport_Services.Layouts.ccrResp) ds_ccr_resp,
                                ConsumerCreditReport_Services.IParams.Params in_mod,
                DATASET(FCRA.Layout_override_flag) ds_flags,
                DATASET(FFD.Layouts.PersonContextBatch) pc_recs) := FUNCTION

  isReseller := FALSE;
  pc_alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask, isReseller);
  //since alerts might differ for reseller product vs Liens product we need to generate them for Liens and combine with relseller alerts
  consumer_alerts_nonreseller := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, pc_alert_flags[1], in_mod.FFDOptionsMask);
  
  // we keep only records which qualify for Liens results (not suppressed due to alerts)
  ds_ccr_fltrd := JOIN(ds_ccr_resp((UNSIGNED) UniqueId1 = (UNSIGNED) UniqueId2), pc_alert_flags,
                          (UNSIGNED) LEFT.UniqueId = (UNSIGNED) RIGHT.UniqueID 
                          AND RIGHT.suppress_records,
                          TRANSFORM(LEFT), LEFT ONLY);

  flagfile := ds_flags(file_id=FCRA.FILE_ID.LIEN);
  pc_dr_records := pc_recs(datagroup IN FFD.Constants.DataGroupSet.Liens, recordtype=FFD.Constants.RecordType.DR);
  
    Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus xformInput(ConsumerCreditReport_Services.Layouts.ccrResp L) := TRANSFORM
   override_flags:=flagfile(did=L.UniqueId1);
   DUD_flags := pc_dr_records(Lexid=L.UniqueId1);
      SELF.seq:=(UNSIGNED)L.AccountNumber;
      SELF.historyDate:=Risk_Indicators.iid_constants.default_history_date;
      SELF.did:=(UNSIGNED)L.UniqueId1;
   SELF.lien_correct_ffid:=SET(override_flags,flag_file_id);
   SELF.lien_correct_tmsid_rmsid :=SET(override_flags,record_id) + SET(DUD_flags, RecId1);
      SELF:=[];
    END;

    ds_input := PROJECT(ds_ccr_fltrd,xformInput(LEFT));

    Risk_Indicators.Layout_Output xformPersonContext(ConsumerCreditReport_Services.Layouts.ccrResp L) := TRANSFORM
      SELF.seq:=(UNSIGNED)L.AccountNumber;
      SELF.historyDate:=Risk_Indicators.iid_constants.default_history_date;
      SELF.did:=(UNSIGNED)L.UniqueId1;
      SELF:=L;
      SELF:=[];
    END;

    ds_withPersonContext := PROJECT(ds_ccr_fltrd,xformPersonContext(LEFT));

    ds_LiensJudgments := Risk_Indicators.Boca_Shell_Liens_LnJ_FCRA(in_mod.bsVersion,0,GROUP(ds_input,seq),TRUE,GROUP(ds_withPersonContext,seq));

    ds_input_shell := PROJECT(ds_LiensJudgments,TRANSFORM(RiskView.Layouts.shell_NoScore,
      SELF.trueDid:=TRUE;
      SELF.LnJ_attributes:=PROJECT(LEFT,TRANSFORM(Risk_Indicators.Layouts_Derog_Info.LJ_Attributes,
        SELF:=LEFT)),
      SELF.LnJ_datasets.LnJLiens:=PROJECT(LEFT.LnJLiens,TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Liens,
        SELF.seq:=(STRING)LEFT.seq,
        SELF:=LEFT)),
      SELF.LnJ_datasets.LnJJudgments:=PROJECT(LEFT.LnJJudgments,TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Judgments,
        SELF.seq:=(STRING)LEFT.seq,
        SELF:=LEFT)),
      SELF:=LEFT,
      SELF:=[]));

    ds_LiensJudgmentsAttributes := riskview.get_attributes_LnJ(GROUP(ds_input_shell,seq),FALSE);

    iesp.riskview2.t_RiskView2LiensJudgmentsReportForLien iespLiens(Risk_Indicators.Layouts_Derog_Info.Liens L) := TRANSFORM
      SELF.DateFiled:=iesp.ECL2ESP.toDate((UNSIGNED4)L.DateFiled);
      SELF.ReleaseDate:=iesp.ECL2ESP.toDate((UNSIGNED4)L.ReleaseDate);
      SELF.DateLastSeen:=iesp.ECL2ESP.toDate((UNSIGNED4)L.DateLastSeen);
      SELF:=L;
    END;

    iesp.riskview2.t_RiskView2LiensJudgmentsReportForJudgement iespJudgements(Risk_Indicators.Layouts_Derog_Info.Judgments L) := TRANSFORM
      SELF.DateFiled:=iesp.ECL2ESP.toDate((UNSIGNED4)L.DateFiled);
      SELF.ReleaseDate:=iesp.ECL2ESP.toDate((UNSIGNED4)L.ReleaseDate);
      SELF.DateLastSeen:=iesp.ECL2ESP.toDate((UNSIGNED4)L.DateLastSeen);
      SELF:=L;
    END;

    iesp.share.t_NameValuePair normAttributes(riskview.layouts.attributes_internal_layout L,INTEGER c) := TRANSFORM
      SELF.name := MAP(
        c=1  => 'LnJEvictionTotalCount'       ,c=2  => 'LnJEvictionTotalCount12Month',c=3  => 'LnJEvictionTimeNewest'       ,
        c=4  => 'LnJJudgmentSmallClaimsCount' ,c=5  => 'LnJJudgmentCourtCount'       ,c=6  => 'LnJJudgmentForeclosureCount' ,
        c=7  => 'LnJLienJudgmentSeverityIndex',c=8  => 'LnJLienJudgmentCount'        ,c=9  => 'LnJLienJudgmentCount12Month' ,
        c=10 => 'LnJLienTaxCount'             ,c=11 => 'LnJLienJudgmentOtherCount'   ,c=12 => 'LnjLienJudgmentTimeNewest'   ,
        c=13 => 'LnJLienJudgmentDollarTotal'  ,c=14 => 'LnJLienCount'                ,c=15 => 'LnJLienTimeNewest'           ,
        c=16 => 'LnJLienDollarTotal'          ,c=17 => 'LnJLienTaxTimeNewest'        ,c=18 => 'LnJLienTaxDollarTotal'       ,
        c=19 => 'LnJLienTaxStateCount'        ,c=20 => 'LnJLienTaxStateTimeNewest'   ,c=21 => 'LnJLienTaxStateDollarTotal'  ,
        c=22 => 'LnJLienTaxFederalCount'      ,c=23 => 'LnJLienTaxFederalTimeNewest' ,c=24 => 'LnJLienTaxFederalDollarTotal',
        c=25 => 'LnJJudgmentCount'            ,c=26 => 'LnJJudgmentTimeNewest'       ,c=27 => 'LnJJudgmentDollarTotal'      ,
        '');
      SELF.value := MAP(
        c=1  => L.LnJEvictionTotalCount       ,c=2  => L.LnJEvictionTotalCount12Month,c=3  => L.LnJEvictionTimeNewest       ,
        c=4  => L.LnJJudgmentSmallClaimsCount ,c=5  => L.LnJJudgmentCourtCount       ,c=6  => L.LnJJudgmentForeclosureCount ,
        c=7  => L.LnJLienJudgmentSeverityIndex,c=8  => L.LnJLienJudgmentCount        ,c=9  => L.LnJLienJudgmentCount12Month ,
        c=10 => L.LnJLienTaxCount             ,c=11 => L.LnJLienJudgmentOtherCount   ,c=12 => L.LnjLienJudgmentTimeNewest   ,
        c=13 => L.LnJLienJudgmentDollarTotal  ,c=14 => L.LnJLienCount                ,c=15 => L.LnJLienTimeNewest           ,
        c=16 => L.LnJLienDollarTotal          ,c=17 => L.LnJLienTaxTimeNewest        ,c=18 => L.LnJLienTaxDollarTotal       ,
        c=19 => L.LnJLienTaxStateCount        ,c=20 => L.LnJLienTaxStateTimeNewest   ,c=21 => L.LnJLienTaxStateDollarTotal  ,
        c=22 => L.LnJLienTaxFederalCount      ,c=23 => L.LnJLienTaxFederalTimeNewest ,c=24 => L.LnJLienTaxFederalDollarTotal,
        c=25 => L.LnJJudgmentCount            ,c=26 => L.LnJJudgmentTimeNewest       ,c=27 => L.LnJJudgmentDollarTotal      ,
        '');
    END;

    ConsumerCreditReport_Services.Layouts.ccrResp appendLiensJudgmentsAttributes(ConsumerCreditReport_Services.Layouts.ccrResp L,
                                                                                 ds_LiensJudgmentsAttributes R) := TRANSFORM
      SELF.LiensJudgmentsReports.Liens:=PROJECT(R.LnJLiens,iespLiens(LEFT));
      SELF.LiensJudgmentsReports.Judgments:=PROJECT(R.LnJJudgments,iespJudgements(LEFT));
      recCnts:=COUNT(R.LnJLiens(did>0))+COUNT(R.LnJJudgments(did>0));
      ds_attr:=DATASET([R],riskview.layouts.attributes_internal_layout);
      ds_null:=DATASET([],iesp.share.t_NameValuePair);
      SELF.LiensJudgmentsReports.LnJAttributes:=IF(recCnts>0,NORMALIZE(ds_attr,27,normAttributes(LEFT,COUNTER)),ds_null);
      // for records without LnJ keeping consumer level statements only 
      SELF.ConsumerStatements:=IF(recCnts>0, L.ConsumerStatements, L.ConsumerStatements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel));
      SELF.ConsumerAlerts:=L.ConsumerAlerts;
      SELF:=L;
    END;

    ds_ccr_with_liens := JOIN(ds_ccr_resp,ds_LiensJudgmentsAttributes,
      LEFT.AccountNumber=(STRING)RIGHT.seq AND (UNSIGNED)LEFT.UniqueId1=RIGHT.did,
      appendLiensJudgmentsAttributes(LEFT,RIGHT),LEFT OUTER,KEEP(1));
      
    ConsumerCreditReport_Services.Layouts.ccrResp addLnJAlertRecs(ConsumerCreditReport_Services.Layouts.ccrResp L,
                                                               DATASET(iesp.share_fcra.t_ConsumerAlert) R) := TRANSFORM
      // we combine alerts for resellers with alerts for in-house data                                                         
      SELF.ConsumerAlerts := DEDUP(SORT(L.ConsumerAlerts + R, code, Message), code);
      SELF:=L;
    END;
    
    // we need to add non-reseller alerts  for records eligible for LnJ in-house data 
    ds_res_with_alerts := DENORMALIZE(ds_ccr_with_liens,consumer_alerts_nonreseller,
                                   (UNSIGNED)LEFT.UniqueId=(UNSIGNED)RIGHT.UniqueId
                                   AND (UNSIGNED) LEFT.UniqueId > 0,  
                                   GROUP,addLnJAlertRecs(LEFT,ROWS(RIGHT)));
      
    RETURN ds_res_with_alerts;
  END;


  EXPORT format_Rejects (DATASET(ConsumerCreditReport_Services.Layouts.workRec) ds_work_in) := FUNCTION

    ConsumerCreditReport_Services.Layouts.ccrResp xformRejects(ds_work_in L) := TRANSFORM
      SELF.AccountNumber:=L.acctno;
      SELF.UniqueId1:=IF(L.did!=0,(STRING)L.did,'');
      SELF._Header.QueryId:=L.acctno;
      SELF._Header.Exceptions:=CASE(L.error_code,
        ConsumerCreditReport_Services.Constants.NO_LEXID_FOUND_CODE => ConsumerCreditReport_Services.Constants.NO_LEXID_FOUND,
        ConsumerCreditReport_Services.Constants.TOO_MANY_SUBJECTS_CODE => ConsumerCreditReport_Services.Constants.TOO_MANY_SUBJECTS,
        ConsumerCreditReport_Services.Constants.INSUFFICIENT_INPUT_CODE => ConsumerCreditReport_Services.Constants.INSUFFICIENT_INPUT, 
        DATASET([],iesp.share.t_WsException));
   // no Exceptions generated in case of CONSUMER_ALERT_CODE, results will be suppressed and consumer statements and alerts returned
      SELF.ConsumerStatements:=L.ConsumerStatements;
      SELF.ConsumerAlerts:=L.ConsumerAlerts;
      SELF:=[];
    END;

    RETURN PROJECT(ds_work_in,xformRejects(LEFT));
  END;


  EXPORT restore_AccountNumber (DATASET(ConsumerCreditReport_Services.Layouts.ccrResp) ds_ccr_resp,
                                DATASET(ConsumerCreditReport_Services.Layouts.workRec) ds_work_in) := FUNCTION

    ConsumerCreditReport_Services.Layouts.ccrResp restoreAcctNo(ds_ccr_resp L,ds_work_in R) := TRANSFORM
      SELF._Header.Exceptions:=L._Header.Exceptions;
      SELF._Header:=iesp.ECL2ESP.GetHeaderRow();
      orig_acctno:=R.orig_acctno;
      SELF.AccountNumber:=IF(orig_acctno!='',orig_acctno,L.AccountNumber);
      SELF.InputEcho:=PROJECT(R,TRANSFORM(iesp.consumercreditreport_fcra.t_FcraCCRReportBy,
        SELF.AccountNumber:=orig_acctno,
        SELF.PhoneNumber:=LEFT.phoneno,
        SELF.Name.Full:=LEFT.name_full,
        SELF.Name.First:=LEFT.name_first,
        SELF.Name.Middle:=LEFT.name_middle,
        SELF.Name.Last:=LEFT.name_last,
        SELF.Name.Suffix:=LEFT.name_suffix,
        SELF.Address.StreetNumber:=LEFT.prim_range,
        SELF.Address.StreetPreDirection:=LEFT.predir,
        SELF.Address.StreetName:=LEFT.prim_name,
        SELF.Address.StreetSuffix:=LEFT.addr_suffix,
        SELF.Address.StreetPostDirection:=LEFT.postdir,
        SELF.Address.UnitDesignation:=LEFT.unit_desig,
        SELF.Address.UnitNumber:=LEFT.sec_range,
        SELF.Address.StreetAddress1:=LEFT.addr,
        SELF.Address.City:=LEFT.p_city_name,
        SELF.Address.State:=LEFT.st,
        SELF.Address.Zip5:=LEFT.z5,
        SELF.Address.Zip4:=LEFT.zip4,
        SELF.Address.County:=LEFT.county_name,
        SELF.DOB:=iesp.ECL2ESP.toDatestring8(LEFT.DOB),
        SELF:=LEFT,
        SELF:=[]));
      SELF:=L;
      SELF:=R;
    END;

    RETURN JOIN(ds_ccr_resp,ds_work_in,
      LEFT.AccountNumber=RIGHT.acctno,
      restoreAcctNo(LEFT,RIGHT),
      LEFT OUTER,KEEP(1));
  END;

END;