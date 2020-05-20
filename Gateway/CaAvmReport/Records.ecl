IMPORT Doxie, dx_gateway, iesp, Gateway, Royalty;

EXPORT Records(
  iesp.gw_ca_avm_request.t_CaAvmReportRequest rec_in,
  Doxie.IDataAccess mod_access,
  DATASET(Gateway.layouts.config) gws)
:= FUNCTION

  gw_resp := Gateway.SoapCall_CaAvmReport(rec_in, gws);
  royalties := Royalty.RoyaltyCaAvmReport.GetRoyalties(rec_in, gw_resp[1].response);
  cleaned_resp := Gateway.CaAvmReport.Parser.CleanResponse(gw_resp[1].response, mod_access);

  service_header := iesp.ECL2ESP.GetHeaderRow();
  tesp_resp := PROJECT(cleaned_resp,
    TRANSFORM(iesp.propertyvaluationreport.t_PropertyValuationReportResponse,
      //Service layer Headers
      SELF._header.transactionID := service_header.transactionID;
      SELF._header.queryID := service_header.queryID;

      SELF._header := LEFT._header;
      SELF.report := LEFT.CaAvmResponse;
  ));

  bundled_rec := RECORD
    iesp.propertyvaluationreport.t_PropertyValuationReportResponse recs;
    Royalty.Layouts.Royalty royalties;
  END;

  bundled_rec bundle_royalties() := TRANSFORM
    SELF.recs := tesp_resp;
    SELF.royalties := royalties;
  END;

  RETURN ROW(bundle_royalties());
END;
