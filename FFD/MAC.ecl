EXPORT MAC := MODULE

  EXPORT AppendConsumerAlertsAndStatements(__inf, __outf, __statements, __alerts, __consumer, __lout, __csf = 'ConsumerStatements', __caf = 'ConsumerAlerts', __cnsmr = 'Consumer') := MACRO
    __outf := PROJECT(__inf, transform(__lout,
                                        self.__caf := __alerts,
                                        self.__csf := __statements,
                                        self.__cnsmr := __consumer,
                                        self := left, self:=[]));
  ENDMACRO;

  EXPORT PrepareConsumerRecord(__lexId, __isESDL = TRUE, __searchby = '', __reportby_uniqueId = '', __allow_zero_lexid = FALSE) := FUNCTIONMACRO
    IMPORT FFD,iesp, AutoStandardI;

    gm := AutoStandardI.GlobalModule(TRUE);
    iesp.share_fcra.t_FcraConsumer SetConsumerRecord() := TRANSFORM
      SELF.Lexid := (STRING)__lexId;
      #IF(__isESDL AND #TEXT(__searchby)<>'')
        searchDOB := iesp.ECL2ESP.t_DateToString8(__searchby.DOB);
        SELF.Inquiry.DOB := IF((UNSIGNED)searchDOB > 0, searchDOB, '');
        SELF.Inquiry := __searchby;
      #ELSIF(__isESDL AND #TEXT(__reportby_uniqueId)<>'')
        SELF.Inquiry.UniqueId := (STRING)__reportby_uniqueId;  // for report ESDL queries we have only input UniqueId
      #ELSIF(__isESDL)
        SELF.Inquiry.UniqueId := (STRING)__lexId;  // if only __lexId was provided for ESDL service we log it as inquiry
      #ELSE  // for nonESDL services we pull input from stored
        SELF.Inquiry.UniqueId := gm.did;
        SELF.Inquiry.SSN := gm.ssn;
        SELF.Inquiry.DOB := IF(gm.dob > 0, (STRING) gm.dob, '');
        SELF.Inquiry.Phone10 := gm.phone;
        SELF.Inquiry.Name := iesp.ECL2ESP.SetName (gm.firstname, gm.middlename, gm.lastname, gm.namesuffix, '', gm.unparsedfullname);
        SELF.Inquiry.Address := iesp.ECL2ESP.SetAddress (gm.prim_name, gm.prim_range, gm.predir, gm.postdir, gm.suffix, '', gm.sec_range,
                                                          gm.city, gm.state, gm.zip, '', '', '', gm.addr, '', gm.statecityzip);
      #END
      SELF := [];
    END;
    __outrec := ROW(SetConsumerRecord());
    // return result only if there is resolved LexId, or if it's explcitly allowed.
    RETURN 	IF(__allow_zero_lexid OR (UNSIGNED) __lexId > 0, __outrec);
  ENDMACRO;

  EXPORT PrepareResultRecord(__results, __outrec, __statements, __alerts, __lout) := MACRO
    IMPORT FFD,iesp;
    #uniquename(__res_statements);
    %__res_statements% := IF(EXISTS(__results),__statements,__statements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel));

    #uniquename(__res_layout);
    %__res_layout% := RECORD
      DATASET(__lout) Records;
      DATASET(iesp.share_fcra.t_ConsumerStatement) Statements;
      DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts;
    END;

    __outrec :=  ROW ({__results, %__res_statements%, __alerts}, %__res_layout%);
  ENDMACRO;

  EXPORT PrepareResultRecordBatch(__results, __outrec, __statements, __lout) := MACRO
    #uniquename(__res_layout);
    %__res_layout% := RECORD
      DATASET(__lout) Records;
      DATASET(FFD.Layouts.ConsumerStatementBatchFull) Statements;  // includes all consumer info
     END;
    __outrec := ROW ({__results, __statements}, %__res_layout%);
  ENDMACRO;

  EXPORT ApplyConsumerAlertsBatch(__inf, __alert_flags, __statementids, __lout, __FFDOptionsmask=0, __Lexid_field='', __DUD_field='') := FUNCTIONMACRO

    __lout xf_apply_alerts( RECORDOF(__inf) l, FFD.Layouts.ConsumerFlagsBatch r ) :=
    TRANSFORM, SKIP(r.suppress_records)
      SELF.acctno := IF((UNSIGNED)l.acctno <> 0, l.acctno, r.acctno);
      // in batch we filter consumer statements to keep only referencing actual results. Person context may contain more record level statements than what is returned. Alert flag is set only if statements are returned
      SELF.alert_cnsmr_statement := IF(r.has_consumer_statement OR EXISTS(l.__statementids(RecordType IN FFD.Constants.RecordType.StatementRecordLevel)), FFD.Constants.subject_has_alert, '');
      SELF := r.consumer_flags;
       #IF(#TEXT(__Lexid_field)<>'')
         SELF.__Lexid_field	:= IF((UNSIGNED)l.__Lexid_field <> 0, l.__Lexid_field, r.UniqueID);
       #END
       #IF(#TEXT(__DUD_field)<>'')
         SELF.__DUD_field := IF(EXISTS(l.__statementids(RecordType=FFD.Constants.RecordType.DR)), FFD.Constants.subject_has_alert, '');
       #END
      SELF := l;
    END;

    __res_ftr := JOIN(__inf, __alert_flags,
      #if(#TEXT(__Lexid_field)<>'')
          (UNSIGNED) LEFT.__Lexid_field	= (UNSIGNED) RIGHT.UniqueID  AND
        #end
        LEFT.acctno = RIGHT.acctno,
        xf_apply_alerts(LEFT, RIGHT),
        FULL OUTER, LIMIT(0));

    // now we add single record per account for all cases where we had to skip all records due to suppression
    __rec_suppr := PROJECT( __alert_flags(suppress_records),
        TRANSFORM(__lout, SELF.acctno:=LEFT.acctno,
       #if(#TEXT(__Lexid_field)<>'')
          SELF.__Lexid_field	:= LEFT.UniqueID,
        #end
        SELF.alert_cnsmr_statement := IF(LEFT.has_consumer_statement, FFD.Constants.subject_has_alert, ''),
        SELF := LEFT.consumer_flags,  // put other alert flags here
        SELF :=[])
        );

    __all_recs := __rec_suppr + __res_ftr;

    __filterDempseyHits := ~FFD.FFDMask.isShowConsumerStatements(__FFDOptionsMask);

    __noflag_recs := __res_ftr(alert_security_freeze = '', alert_security_fraud='', alert_identity_theft='', alert_legal_flag='', alert_cnsmr_statement='');

    __outf := IF(__filterDempseyHits, __noflag_recs, __all_recs);

    RETURN __outf;
  ENDMACRO;

  EXPORT InquiryLexidBatch(__ds_input, __ds_results, __lout, __addl_options) := FUNCTIONMACRO

  __ds_out := JOIN(__ds_input, __ds_results,
                        LEFT.acctno = RIGHT.acctno,
                        TRANSFORM(__lout,
                                SELF.acctno := IF((UNSIGNED) LEFT.did > 0 OR RIGHT.acctno<>'', LEFT.acctno, SKIP),
                                SELF.inquiry_lexid := MAP(__addl_options>0 AND (UNSIGNED) RIGHT.inquiry_lexid > 0 => RIGHT.inquiry_lexid,  // if it was assigned already - keep it
                                                           (UNSIGNED) LEFT.did > 0 => (STRING) LEFT.did,   // if resolved input Lexid available, use it for inquiry
                                                           ''),
                                SELF:= RIGHT),
                        LEFT OUTER,
                        LIMIT(0));

    RETURN __ds_out;
  ENDMACRO;

END;