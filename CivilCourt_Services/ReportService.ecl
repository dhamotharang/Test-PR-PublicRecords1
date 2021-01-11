// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns Civil Court reports records.*/

IMPORT CivilCourt_services, iesp, AutoStandardI;
EXPORT ReportService := MACRO
    
  rec_in := iesp.CivilCourt.t_CivilCourtReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('CivilCourtReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  report_by := GLOBAL (first_row.ReportBy);
  #STORED ('CaseId', report_by.caseId);
              
  tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),
    CivilCourt_services.ReportService_Records.params,OPT))
    SHARED STRING60 caseID_mixed := '' : STORED('CaseId');
    SHARED STRING60 caseID := STD.STR.ToUpperCase(caseID_mixed);
  END;
  
  tmp := CivilCourt_services.ReportService_Records.val(tempmod);
  
  temp_results := PROJECT(tmp, TRANSFORM(iesp.civilCourt.t_CivilCourtReportResponse ,
    SELF._Header := iesp.ECL2ESP.GetHeaderRow();
    SELF.CivilCourtRecord := LEFT));
  results := CHOOSEN(temp_results, iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
  OUTPUT(results, NAMED('Results'));
ENDMACRO;
//ReportService ();
/*
<CivilCourtReportRequest>
<row>
  <User>
    <ReferenceCode></ReferenceCode>
    <BillingCode></BillingCode>
    <QueryId></QueryId>
    <GLBPurpose></GLBPurpose>
    <DLPurpose></DLPurpose>
    <EndUser>
      <CompanyName></CompanyName>
      <StreetAddress1></StreetAddress1>
      <City></City>
      <State></State>
      <Zip5></Zip5>
    </EndUser>
    <MaxWaitSeconds></MaxWaitSeconds>
  </User>
  <ReportBy>
    <CaseId></CaseId>
  </ReportBy>
</row>
</CivilCourtReportRequest>
*/
