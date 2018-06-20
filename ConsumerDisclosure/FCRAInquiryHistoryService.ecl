IMPORT iesp, doxie, InquiryHistory, WSInput;

EXPORT FCRAInquiryHistoryService() := FUNCTION

  isFCRA := TRUE;
  
  WSInput.MAC_FCRA_InquiryHistory_Service();

  in_req := DATASET([], iesp.fcrainquiryhistory.t_FCRAInquiryHistoryRequest) : STORED('FCRAInquiryHistoryRequest');
  
  // Report request and options
  first_row := in_req[1] : INDEPENDENT;
  report_options := GLOBAL(first_row.options);
  report_by := GLOBAL(first_row.ReportBy);
  
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	in_dids := DATASET([{(UNSIGNED)report_by.LexID}], doxie.layout_references);
	in_mod := InquiryHistory.IParams.GetParams(report_options);

  IHResponse := InquiryHistory.ReportRecords(in_dids, in_mod, isFCRA)[1];

	iesp.fcrainquiryhistory.t_FCRAInquiryHistoryResponse xform(InquiryHistory.Layouts.inquiry_history_out L) := TRANSFORM
		SELF._Header			:= PROJECT(iesp.ECL2ESP.GetHeaderRow(), 
                                TRANSFORM(iesp.share.t_ResponseHeader, 
                                           SELF.Status := L.SearchStatus,
                                           SELF.Message := L.Message,
                                           SELF := LEFT));
                        
		SELF.Records			:= CHOOSEN(PROJECT(L.IndividualResults, 
                                 TRANSFORM(iesp.fcrainquiryhistory.t_FCRAInquiryHistoryRecord, 
                                          SELF.LexID := (STRING) L.UniqueId,
                                          SELF := LEFT)),
                                 iesp.Constants.FCRAInqHist.MAX_RECORDS);
	END;
	outfile := PROJECT(IHResponse,xform(LEFT));

  RETURN OUTPUT(outfile, NAMED('Results'));

END;    