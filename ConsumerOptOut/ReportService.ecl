// This service returns opt out data related to a lexID.
// If given no lexID, it will attempt to resolve one from PII.
// It is similar to BatchServices.OptOutBatchService

IMPORT AutoStandardI, Doxie, iesp;

EXPORT ReportService := MACRO

  ds_in := DATASET([], iesp.consumeroptout.t_ConsumerOptoutReportRequest) : STORED('ConsumerOptoutReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  // check the input, adding lexid if necessary
  checked_input := ConsumerOptOut.Functions.CheckInputRec(first_row, mod_access);

  // If there is no lexID at this point, fail the query for insufficient input.
  IF((unsigned6)checked_input.ReportBy.LexID = 0, FAIL(301, Doxie.ErrorCodes(301)));

  recs := ConsumerOptOut.Records(checked_input, mod_access);

  OUTPUT(recs, NAMED('Results'));

ENDMACRO;
