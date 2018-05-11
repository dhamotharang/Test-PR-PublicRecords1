IMPORT DueDiligence;

EXPORT getIndReport(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    STRING6 ssnMask) := FUNCTION


  getCriminalReportData := DueDiligence.reportIndCriminal(inData, ssnMask);
  
  
  
  
  // OUTPUT(getCriminalReportData, NAMED('getCriminalReportData'));
  
  
  RETURN getCriminalReportData;
END;