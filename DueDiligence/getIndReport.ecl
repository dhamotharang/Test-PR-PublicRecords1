IMPORT DueDiligence;

EXPORT getIndReport(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    STRING6 ssnMask) := FUNCTION



  
  getInputBestInfo := DueDiligence.reportIndBestInfo(inData, ssnMask);
  
  getPropertyReportData := DueDiligence.reportIndProperty(getInputBestInfo);
  
  getCriminalReportData := DueDiligence.reportIndCriminal(getPropertyReportData, ssnMask);
  
  getProfessionalLicenseData := DueDiligence.reportIndProfLicense(getCriminalReportData);  
  
  
  
  
  // OUTPUT(getInputBestInfo, NAMED('getInputBestInfo'));
  // OUTPUT(getPropertyReportData, NAMED('getPropertyReportData'));
  // OUTPUT(getCriminalReportData, NAMED('getCriminalReportData'));
  // OUTPUT(getProfessionalLicenseData, NAMED('getProfessionalLicenseData'));
  
  
  RETURN getProfessionalLicenseData;
END;