IMPORT $, ConsumerDisclosure, doxie, FFD, FCRA, ut, iesp, Gateway, STD;

todaysdate := (STRING) Std.Date.Today();

EXPORT ReportRecords(DATASET(doxie.layout_references) in_dids,
                     $.IParams.IParam in_mod,
                     BOOLEAN isFCRA = TRUE,
                     DATASET(FFD.Layouts.PersonContextBatch) in_PersonContext = DATASET([], FFD.Layouts.PersonContextBatch)) :=
FUNCTION

  ValidSearchLexids := CHOOSEN(in_dids(did<>0),iesp.Constants.FCRAInqHist.MAX_LEXIDS);

  BOOLEAN FailOnSoapError := TRUE;
  // person context/consumer statements
  in_pc := IF(isFCRA,PROJECT(ValidSearchLexids, TRANSFORM(FFD.Layouts.DidBatch, SELF.acctno := (STRING) COUNTER, SELF.did := LEFT.did)));
  pc_resp := FFD.Functions.FetchPersonContextAsResponse(in_pc, in_mod.gateways,[FFD.Constants.DataGroups.Inquiries], in_mod.FFDOptionsMask, FailOnSoapError);

  pc_recs := IF(in_mod.SkipPersonContextCall,in_PersonContext, PROJECT(pc_resp.Records, FFD.Layouts.PersonContextBatch));

  slim_pc_recs := FFD.SlimPersonContext(pc_recs);

  delta_IH_results	:= $.Functions.PerformDeltabaseCall(ValidSearchLexids, in_mod.gateways).response;
  delta_IH_recs := PROJECT(delta_IH_results.Records,
                           TRANSFORM($.Layouts.inquiry_history_rec,
                           SELF.UniqueId := (UNSIGNED) LEFT.LexId,  //For records pulled from index this is appended LexId. There are no appended LexId in Deltabase records, so we populate that field with string Lex_id logged for inquiry
                           SELF.isDeltabaseSource := TRUE,
                           SELF := LEFT,
                           SELF := []));

  payload_IH_recs := $.Functions.GetIHPayloadData(ValidSearchLexids, in_mod.gateways, isFCRA);

  all_recs := delta_IH_recs + payload_IH_recs;
  all_recs_filter := all_recs((integer)ppc not in [420,426]); // dropping banko transactions before release (11/04/19); to be removed once in place on data side.

  // now combine results and remove diplicates.
  all_IH_recs := DEDUP(SORT(all_recs_filter,RECORD,EXCEPT UniqueId),
                       EXCEPT isDeltabaseSource,UniqueId); // we will keep only most recent records from deltabase, not available in index; in case of duplicates we will keep records pulled from index

  recent_IH_recs := all_IH_recs(
      ut.fn_date_is_ok(todaysdate, (STRING8)InquiryDate, 1)
      OR (FCRA.FCRAPurpose.isEmploymentScreening((INTEGER) ppc) AND
      ut.fn_date_is_ok(todaysdate, (STRING8)InquiryDate, 2))
    );


  recent_srtd_recs := CHOOSEN(SORT(recent_IH_recs, -InquiryDate,UniqueId,TransactionID),iesp.Constants.FCRAInqHist.MAX_RECORDS);

  // Now we need to apply DUD and LT suppression if indicated in PC - setting flags in Metadata
  with_DUD_recs := JOIN(recent_srtd_recs, slim_pc_recs(isDisputed),
                            LEFT.UniqueId = (UNSIGNED) RIGHT.lexid AND
                            LEFT.TransactionID = RIGHT.RecID1,
                            TRANSFORM($.Layouts.inquiry_history_rec,
                            SELF.Metadata.IsDisputed := TRIM(RIGHT.RecID1) <> '',
                            SELF := LEFT),
                            LEFT OUTER, KEEP(1), LIMIT(0));

  with_suppression_flags := JOIN(with_DUD_recs, pc_recs(RecordType = FFD.Constants.RecordType.SR),
                            LEFT.UniqueId = (UNSIGNED) RIGHT.lexid AND
                            LEFT.TransactionID = RIGHT.RecID1,
                            TRANSFORM($.Layouts.inquiry_history_rec,
                            SELF.Metadata.IsSuppressed := TRIM(RIGHT.RecID1) <> '',
                            SELF := LEFT),
                            LEFT OUTER, KEEP(1), LIMIT(0));

  // filtering out FCRA DUD and LT suppression if requested
  fltrd_fcra_recs := with_suppression_flags((in_mod.ReturnSuppressed OR ~Metadata.IsSuppressed) AND (in_mod.ReturnDisputed OR ~Metadata.IsDisputed));

  final_IH_recs := IF(isFCRA, fltrd_fcra_recs, recent_srtd_recs);


 // prepare results for output - we need to add status/message per input subject
  $.Layouts.inquiry_history_out xform_indv(doxie.layout_references L,
                                                            DATASET($.Layouts.inquiry_history_rec) R) := TRANSFORM
            StatusCode := IF(EXISTS(R),
              ConsumerDisclosure.Constants.StatusCodes.ResultsFound,
              ConsumerDisclosure.Constants.StatusCodes.NoResultsFound);
            SELF.UniqueId := L.did;
            SELF.SearchStatus := StatusCode;
            SELF.Message := ConsumerDisclosure.Constants.GetStatusMessage(StatusCode);
            SELF.IndividualResults := SORT(PROJECT(R, TRANSFORM($.Layouts.inquiry_history_per_transaction,
                                                                        SELF.LexID:=(STRING)LEFT.LexID, // should it be as appears in index lex_id field or appended_did?
                                                                        SELF:=LEFT)),
                                      -InquiryDate,TransactionID);
            SELF:=[];
  END;

  res_grpd := DENORMALIZE(in_dids, final_IH_recs,   //keeping all input sunjects in the result, even if no IH data
                          LEFT.did = RIGHT.UniqueId, GROUP,
                          xform_indv(LEFT,ROWS(RIGHT)));

  res_srtd := SORT(res_grpd, UniqueId);

  isPCSoapFail := ~in_mod.SkipPersonContextCall AND pc_resp._Header.Status = ConsumerDisclosure.Constants.StatusCodes.SOAPError;
  isIHSoapFail := delta_IH_results._Header.Status = ConsumerDisclosure.Constants.StatusCodes.SOAPError;

  $.Layouts.inquiry_history_out xform_onfail() := TRANSFORM
      _err_code := IF(isPCSoapFail, pc_resp._Header.Status, delta_IH_results._Header.Status);
      SELF.SearchExceptions := IF(isIHSoapFail, delta_IH_results._Header.Exceptions) + IF(isPCSoapFail, pc_resp._Header.Exceptions);
      SELF.SearchStatus := _err_code;
      SELF.Message := ConsumerDisclosure.Constants.GetStatusMessage(_err_code);
      SELF := [];
  END;

  res_soapfail := DATASET([xform_onfail()]);

  res_vldt := IF(isPCSoapFail OR isIHSoapFail, res_soapfail, res_srtd);

  RETURN res_vldt;
END;