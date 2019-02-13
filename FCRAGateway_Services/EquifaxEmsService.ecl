IMPORT AutoStandardI, FFD, FCRA, iesp;

EXPORT EquifaxEmsService := MACRO

  rec_in := iesp.mergedcreditreport_fcra.t_FcraMergedCreditReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraMergedCreditReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputUser(first_row.user);

  isFCRA := TRUE;

  in_mod := MODULE(project(AutoStandardI.GlobalModule(isFCRA), FCRAGateway_Services.IParam.common_params, opt))
    EXPORT FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    EXPORT FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
    EXPORT dataset(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
  END;

  ds_ems_recs := FCRAGateway_Services.EquifaxEms_Records(ds_in, in_mod);

  //separate the transform, keep header information from response
  final_layout := iesp.mergedcreditreport_fcra.t_FcraMergedCreditReportResponse;
  final_layout to_final(FCRAGateway_Services.Layouts.equifax_ems.records_out L) := TRANSFORM
  
      //Service layer Headers
      service_header := iesp.ECL2ESP.GetHeaderRow();
      SELF._header.transactionID := service_header.transactionID;
      SELF._header.queryID := service_header.queryID;
      
      //Gateway layer headers
      SELF._header.status := L.response._header.status;
      SELF._header.message := L.response._header.message;
      SELF._header.exceptions := L.response._header.exceptions;
      
      //FCRA related fields
      SELF.consumerStatements := L.consumerStatements;
      SELF.consumerAlerts := L.consumerAlerts;
      SELF.consumer := L.consumer;
      SELF.validation := L.unique_validation;
      
      //Gateway response fields
      SELF.errorInfo := L.response.emsResponse.errorInfo;
      SELF.borrowerInputEcho := L.response.emsResponse.borrowerInputEcho;
      SELF.pdfReport := L.response.emsResponse.pdfReport;
      
      //G-ESP added a couple fields that aren't used by T-ESP here.
      //Fails when not projected.
      SELF.mergedCreditReport := PROJECT(L.response.emsResponse.creditReports, TRANSFORM(
        iesp.mergedcreditreport_fcra.t_CreditReportRecord, SELF := LEFT));
      
      SELF := L.response.emsResponse;
      SELF := [];
  END;

  ds_final := PROJECT(ds_ems_recs, to_final(LEFT));
  ds_royalties := ds_ems_recs[1].Royalties;
  OUTPUT(ds_final, NAMED('Results'));
  OUTPUT(ds_royalties, NAMED('RoyaltySet'));

ENDMACRO;