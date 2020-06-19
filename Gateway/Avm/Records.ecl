IMPORT Doxie, iesp, Gateway, Royalty;

EXPORT Records(
  iesp.avm_property_report.t_AVMPropertyReportRequest rec_in,
  Doxie.IDataAccess mod_access,
  DATASET(Gateway.layouts.config) gws)
:= FUNCTION

  // For some reason, shorthand project causes syntax error here.
  gw_req := PROJECT(rec_in, TRANSFORM(iesp.avm_internal_req.t_AVMInternalRequest,
    SELF := LEFT));

  gw_resp := Gateway.SoapCall_Avm(rec_in, gws);
  gw_resp_cleaned := Gateway.Avm.Parser.cleanResponse(gw_resp[1].response, mod_access);
  royalties := Royalty.RoyaltyAvm.GetRoyalties(gw_resp[1].response);

  service_header := iesp.ECL2ESP.GetHeaderRow();
  tesp_resp := PROJECT(gw_resp_cleaned,
    TRANSFORM(iesp.avm_property_report.t_AVMPropertyReportResponse,
      //Service layer Headers
      SELF._header.transactionID := service_header.transactionID,
      SELF._header.queryID := service_header.queryID,
      SELF := LEFT
  ));

  bundled_rec := RECORD
    iesp.avm_property_report.t_AVMPropertyReportResponse recs,
    Royalty.Layouts.Royalty royalties;
  END;

  bundled_rec bundle_royalties() := TRANSFORM
    SELF.recs := tesp_resp;
    SELF.royalties := royalties;
  END;

  RETURN ROW(bundle_royalties());
END;
