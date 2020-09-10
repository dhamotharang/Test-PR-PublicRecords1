IMPORT Address, AutoStandardI, BatchServices, doxie, Doxie_Raw, dx_gateway, Gateway, iesp,
  Phones, PhoneFinder_Services, progressive_phone, STD;

lBatchIn := PhoneFinder_Services.Layouts.BatchInAppendDID;
lFinal := PhoneFinder_Services.Layouts.PhoneFinder.Final;
lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
lRTPIn := progressive_phone.layout_progressive_batch_in;
lPPResponse := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT GetQSentPhones :=
MODULE

  // QSent gateway data - PVSD
  EXPORT GetQSentPVSData(DATASET(lFinal) dIn,
    PhoneFinder_Services.iParam.SearchParams inMod,
    Gateway.Layouts.Config pGateway) :=
  FUNCTION

    globalMod := AutoStandardI.GlobalModule();
    timeoutSecs := $.Constants.GatewayMaxTimeout.QSENT_RequestTimeout; // gateway timeout
    today := (string) STD.Date.Today();

    // Keep only one record per acctno
    dInDedup := DEDUP(SORT(dIn, acctno), acctno);

    // Temporary layout
    rQSent_Layout := RECORD(lFinal)
      DATASET(lPPResponse) qsent_recs;
    END;

    // Input phone number is populated
    rQSent_Layout tGetPVSData(dInDedup pInput) :=
    TRANSFORM
      tmpMod := MODULE(PROJECT(globalMod, BatchServices.RealTimePhones_Params.params, OPT))
        EXPORT STRING15 Phone := pInput.phone;
        EXPORT STRING30 FirstName := '';
        EXPORT STRING30 LastName := '';
        EXPORT STRING200 Addr := '';
        EXPORT STRING25 City := '';
        EXPORT STRING2 State := '';
        EXPORT STRING6 Zip := '';
        EXPORT STRING11 SSN := '';
        EXPORT BOOLEAN FailOnError := FALSE;
        EXPORT STRING5 ServiceType := Phones.Constants.ServiceType.PVSD;
        EXPORT UNSIGNED1 RecordCount := PhoneFinder_Services.Constants.MaxTUGatewayResults;
        EXPORT STRING20 AcctNo := pInput.acctno;
        EXPORT STRING EspTransactionId := pGateway.TransactionId;
        EXPORT BOOLEAN TUGatewayPhoneticMatch := inMod.PhoneticMatch;
        EXPORT BOOLEAN UseQSENTV2 := TRUE;
      END;
      SELF.qsent_recs := Doxie_Raw.RealTimePhones_Raw(tmpMod, DATASET(pGateway), timeoutSecs, , inMod.UseTransUnionPVS);
      SELF := pInput;
    END;
    dPVSRecs := PROJECT(dInDedup, tGetPVSData(LEFT));

    // Normalize the qsent gateway records to flatten the child dataset
    // -- CCPA: No need to apply opt-out as PVS records will not have contact information.
    lFinal tNormPVSRecs(rQSent_Layout le, lPPResponse ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;
      SELF.isPrimaryPhone := le.isPrimaryPhone;
      SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.QSentGateway;
      SELF.dt_first_seen := iesp.ECL2ESP.t_DateToString8(ri.RealTimePhone_Ext.ListingCreationDate);
      SELF.dt_last_seen := today;
      SELF.did := (UNSIGNED)ri.did;
      SELF.telcordia_only := ri.telcordia_only = 'Y';
      fn_len := length(trim(ri.fname));
      fn_parsed := if(fn_len > 3 and ri.fname[fn_len-1] = ' ', ri.fname[1..fn_len-2], ri.fname);
      SELF.fname := fn_parsed;
      SELF.coc_description := IF(ri.RealTimePhone_Ext.ServiceClass != '', $.Functions.ServiceClassDesc(ri.RealTimePhone_Ext.ServiceClass), '');
      SELF := ri;
      SELF := le;
      SELF := [];
    END;
    dNormPVSRecs := NORMALIZE(dPVSRecs, LEFT.qsent_recs, tNormPVSRecs(LEFT,RIGHT));

    // Debug
    #IF(PhoneFinder_Services.Constants.Debug.QSent)
      OUTPUT(dIn,NAMED('dPVS_In'),OVERWRITE);
      OUTPUT(dPVSRecs,NAMED('dPVSRecs'),OVERWRITE);
      OUTPUT(dNormPVSRecs,NAMED('dNormPVSRecs'),OVERWRITE);
    #END

    RETURN dNormPVSRecs;
  END;

  // QSent gateway data - iQ411
  EXPORT GetQSentiQ411Data( DATASET(lBatchIn) dIn, DATASET(lExcludePhones) dExcludePhones,
    PhoneFinder_Services.iParam.SearchParams inMod, Gateway.Layouts.Config pGateway) :=
  FUNCTION

    globalMod := AutoStandardI.GlobalModule();
    mod_access := project(inMod, doxie.IDataAccess);
    timeoutSecs  := $.Constants.GatewayMaxTimeout.QSENT_RequestTimeout; // gateway timeout
    today := (string) STD.Date.Today();

    // Temporary layout
    rQSent_Layout := RECORD
      string20 acctno;
      DATASET(lPPResponse) qsent_recs;
    END;

    lRTPIn xtIQ411In(lBatchIn pInput) := TRANSFORM
      SELF.ssn := IF(pInput.ssn != '',INTFORMAT((INTEGER)pInput.ssn,9,1),'');
      SELF.phoneno := pInput.homephone;
      SELF.suffix := pInput.addr_suffix;
      SELF := pInput; // acctno, did, name_first, name_last, prim_range, predir, prim_name, postdir, sec_range, p_city_name, st, z5
      SELF := [];
    END;
    dRtpIn := PROJECT(dIn, xtIQ411In(LEFT));

    // apply ccpa optout before calling the gateway
    dRtpInClean := dx_gateway.parser_qsent_raw.CleanRawRequest(dRtpIn, mod_access);

    // making single call to Qsent with full addr, last name and ssn to improve response time
    rQSent_Layout IQ411_Recs(lRTPIn pInput) :=
    TRANSFORM
      dPhones := PROJECT( dExcludePhones(acctno = pInput.acctno),
        TRANSFORM(iesp.share.t_StringArrayItem,SELF.Value := LEFT.phone));

      tmpMod := MODULE(PROJECT(globalMod,BatchServices.RealTimePhones_Params.params,OPT))
        EXPORT STRING15 Phone:= IF(~inMod.IsPrimarySearchPII, pInput.phoneno, '');
        EXPORT STRING30 FirstName:= '';
        EXPORT STRING30 LastName:= pInput.name_last;
        EXPORT STRING200 Addr:= Address.Addr1FromComponents(pInput.prim_range, pInput.predir, pInput.prim_name,
          pInput.suffix, pInput.postdir, pInput.unit_desig, pInput.sec_range);
        EXPORT STRING25 City:= pInput.p_city_name;
        EXPORT STRING2 State:= pInput.st;
        EXPORT STRING6 Zip:= pInput.z5;
        EXPORT STRING11 SSN:= IF(pInput.ssn != '',INTFORMAT((INTEGER)pInput.ssn,9,1),'');
        EXPORT BOOLEAN FailOnError:= FALSE;
        EXPORT STRING5 ServiceType:= Phones.Constants.ServiceType.IQ411;
        EXPORT UNSIGNED1 RecordCount:= PhoneFinder_Services.Constants.MaxTUGatewayResults;
        EXPORT STRING20 AcctNo:= pInput.acctno;
        EXPORT STRING EspTransactionId:= pGateway.TransactionId;
        EXPORT BOOLEAN TUGatewayPhoneticMatch:= inMod.PhoneticMatch;
        EXPORT BOOLEAN UseQSentV2:= TRUE;
        EXPORT DATASET(iesp.share.t_StringArrayItem) ExcludedPhones:=dPhones;
      END;
      SELF.qsent_recs := Doxie_Raw.RealTimePhones_Raw(tmpMod, DATASET(pGateway), timeoutSecs, , inMod.UseTransUnionIQ411);
      SELF.acctno := pInput.acctno;
    END;

    dIQ411RawRecs := PROJECT(dRtpInClean, IQ411_Recs(LEFT));
    dNormIQ411Recs := NORMALIZE(dIQ411RawRecs, LEFT.qsent_recs(phone != ''),
      TRANSFORM(lPPResponse, SELF.acctno := left.acctno; SELF := RIGHT));

    // apply ccpa opt-out to gw response
    dCleanIQ411Recs := dx_gateway.parser_qsent_raw.CleanRawResponse(dNormIQ411Recs, mod_access);

    lFinal tFinalIQ411(lPPResponse le, INTEGER cnt) := TRANSFORM
      SELF.acctno := le.acctno;
      SELF.dt_first_seen := iesp.ECL2ESP.t_DateToString8(le.RealTimePhone_Ext.ListingCreationDate);
      SELF.dt_last_seen := iesp.ECL2ESP.t_DateToString8(le.RealTimePhone_Ext.ListingTransactionDate);
      SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.QSentGateway;
      SELF.did := (UNSIGNED) le.did;
      SELF.telcordia_only:= le.telcordia_only = 'Y';
      SELF.sort_order := cnt;
      SELF.isPrimaryIdentity := inMod.isPrimarySearchPII;
      fn_len := length(trim(le.fname));
      fn_parsed := if(fn_len > 3 and le.fname[fn_len-1] = ' ', le.fname[1..fn_len-2], le.fname);
      SELF.fname := fn_parsed;
      SELF.coc_description:= IF(le.RealTimePhone_Ext.ServiceClass != '', $.Functions.ServiceClassDesc(le.RealTimePhone_Ext.ServiceClass), '');
      SELF := le;
      SELF := [];
    END;
    dIQ411Recs := PROJECT(dCleanIQ411Recs, tFinalIQ411(LEFT, COUNTER));

    dIQ411RecsDedup := DEDUP(SORT(dIQ411Recs, acctno, phone, -dt_first_seen), acctno, phone);

    dIQ411PrimaryPhoneFlag_src := UNGROUP(ITERATE(GROUP(dIQ411RecsDedup, acctno), TRANSFORM(lFinal, SELF.isPrimaryPhone := COUNTER = 1, SELF := RIGHT)));

    dIQ411PrimaryPhoneFlag := PROJECT(dIQ411PrimaryPhoneFlag_src,
      TRANSFORM(lFinal, SELF.phn_src_all := LEFT.phn_src_all +
        IF(LEFT.phone_source = PhoneFinder_Services.Constants.PhoneSource.QSentGateway,
        DATASET([$.Constants.PFSourceCodes.QsentIQ411], $.Layouts.PhoneFinder.src_rec)),
        SELF := LEFT));

    // Debug
    #IF(PhoneFinder_Services.Constants.Debug.QSent)
      OUTPUT(dIn,NAMED('dQSentIQ411_In'));
      OUTPUT(dRtpInClean,NAMED('dRtpInClean'), EXTEND);
      OUTPUT(dIn,NAMED('dQSentIQ411_In'));
      OUTPUT(dIQ411RawRecs,NAMED('dIQ411RawRecs'));
      OUTPUT(dNormIQ411Recs,NAMED('dNormIQ411Recs'), EXTEND);
      OUTPUT(dCleanIQ411Recs,NAMED('dCleanIQ411Recs'), EXTEND);
      OUTPUT(dCleanIQ411Recs,NAMED('dCleanIQ411Recs'));
      OUTPUT(dIQ411Recs,NAMED('dIQ411Recs'));
      OUTPUT(dIQ411RecsDedup,NAMED('dIQ411RecsDedup'));
      OUTPUT(dIQ411PrimaryPhoneFlag,NAMED('dIQ411PrimaryPhoneFlag'));
    #END

    RETURN dIQ411PrimaryPhoneFlag;

  END;

END;
