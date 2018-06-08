IMPORT DueDiligence;

EXPORT getIndReport(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    STRING6 ssnMask) := FUNCTION



  
  getInputBestInfo := DueDiligence.reportIndBestInfo(inData, ssnMask);
  
  // getPropertyReportData := DueDiligence.reportIndProperty(inData);
  
  getCriminalReportData := DueDiligence.reportIndCriminal(getInputBestInfo, ssnMask);
  
  
  
  
  // OUTPUT(getInputBestInfo, NAMED('getInputBestInfo'));
  // OUTPUT(getPropertyReportData, NAMED('getPropertyReportData'));
  // OUTPUT(getCriminalReportData, NAMED('getCriminalReportData'));
  
  
  RETURN getCriminalReportData;
END;