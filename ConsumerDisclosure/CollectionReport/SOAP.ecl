IMPORT $, iesp;
EXPORT SOAP := MODULE
  
  EXPORT CollectionReportService := 'ConsumerDisclosure.CollectionReportService';
  EXPORT CollectionReportTier2Service := 'ConsumerDisclosure.CollectionReportTier2Service';

  EXPORT layout_soap_request := iesp.consumer_collection_report.t_CollectionReportRequest;
  EXPORT layout_soap_response := iesp.consumer_collection_report.t_CollectionReportResponse;
  EXPORT layout_soap_request_t2 := iesp.consumer_collection_report.t_CollectionReportTier2Request;
  EXPORT layout_soap_response_t2 := iesp.consumer_collection_report.t_CollectionReportTier2Response;

  EXPORT ISOAPParam := INTERFACE
    EXPORT UNSIGNED6 LexID;
    EXPORT STRING8 request_date;
    EXPORT STRING target_url;
  END;

  // soap call to collection report query
  EXPORT callReport(ISOAPParam in_mod) := FUNCTION 
    
    layout_soap_request xtIn() := TRANSFORM
      SELF.ReportBy.LexID := (STRING) in_mod.LexID;
      req_date := ROW({
        (INTEGER) in_mod.request_date[1..4], (INTEGER) in_mod.request_date[5..6], (INTEGER) in_mod.request_date[7..8]}, 
        iesp.share.t_Date);
      SELF.ReportBy.RequestDate := IF(in_mod.request_date <> '', req_date, ROW([], iesp.share.t_date));
      SELF := [];
    END;
    d_soap_req := DATASET([xtIn()]);
    
    request_layout := RECORD
      DATASET(layout_soap_request) collectionreportrequest;
    END;
    request_layout formatRequest() := TRANSFORM
      SELF.collectionreportrequest := d_soap_req; 
    END;
    formatted_request := DATASET([formatRequest()]);
    
    layout_soap_response xtFail() := TRANSFORM
      self._Header.Message := FAILMESSAGE;
      self._Header.Status := FAILCODE;
      self := [];
    END;

    d_soap_resp := SOAPCALL(formatted_request, in_mod.target_url,
      CollectionReportService,
      request_layout, TRANSFORM(request_layout, SELF := LEFT; SELF := []),
      DATASET(layout_soap_response), ONFAIL(xtFail()),
      TIMEOUT(10),RETRY(0));
    
    // output(d_soap_req, named('d_soap_req'));
    // output(d_soap_resp, named('d_soap_resp'));
    return  d_soap_resp[1];

  END;

  // soap call to collection tier 2 report query
  EXPORT callReportTier2(ISOAPParam in_mod) := FUNCTION 
    
    layout_soap_request_t2 xtIn() := TRANSFORM
      SELF.ReportBy.LexID := (STRING) in_mod.LexID;
      req_date := ROW({
        (INTEGER) in_mod.request_date[1..4], (INTEGER) in_mod.request_date[5..6], (INTEGER) in_mod.request_date[7..8]}, 
        iesp.share.t_Date);
      SELF.ReportBy.RequestDate := IF(in_mod.request_date <> '', req_date, ROW([], iesp.share.t_date));
      SELF := [];
    END;
    d_soap_req := DATASET([xtIn()]);
    
    request_layout := RECORD
      DATASET(layout_soap_request_t2) CollectionReportTier2Request;
    END;
    request_layout formatRequest() := TRANSFORM
      SELF.CollectionReportTier2Request := d_soap_req; 
    END;
    formatted_request := DATASET([formatRequest()]);
    
    layout_soap_response_t2 xtFail() := TRANSFORM
      self._Header.Message := FAILMESSAGE;
      self._Header.Status := FAILCODE;
      self := [];
    END;

    d_soap_resp := SOAPCALL(formatted_request, in_mod.target_url,
      CollectionReportTier2Service,
      request_layout, TRANSFORM(request_layout, SELF := LEFT; SELF := []),
      DATASET(layout_soap_response_t2), ONFAIL(xtFail()),
      TIMEOUT(10),RETRY(0));
    
    // output(d_soap_req, named('d_soap_req_t2'));
    // output(d_soap_resp, named('d_soap_resp_t2'));
    return  d_soap_resp[1];

  END;
  
END;