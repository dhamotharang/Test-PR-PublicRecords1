IMPORT DueDiligence;

EXPORT getIndReport(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    STRING6 ssnMask) := FUNCTION



  
  getInputBestInfo := DueDiligence.reportIndBestInfo(inData, ssnMask);
  
  getPropertyReportData := DueDiligence.reportIndProperty(getInputBestInfo);
  
  getWatercraftReportData := DueDiligence.reportIndWatercraft(getPropertyReportData);
  
  getCriminalReportData := DueDiligence.reportIndCriminal(getWatercraftReportData, ssnMask);
  
  getProfessionalLicenseData := DueDiligence.reportIndProfLicense(getCriminalReportData);  
  
  getVehicleData := DueDiligence.reportIndVehicle(getProfessionalLicenseData);  
  
  
  // OUTPUT(getInputBestInfo, NAMED('getInputBestInfo'));
  // OUTPUT(getPropertyReportData, NAMED('getPropertyReportData'));
  // OUTPUT(getWatercraftReportData, NAMED('getWatercraftReportData'));
  // OUTPUT(getCriminalReportData, NAMED('getCriminalReportData'));
  // OUTPUT(getProfessionalLicenseData, NAMED('getProfessionalLicenseData'));
  //OUTPUT(getVehicleData, NAMED('getVehicleData'));
  
  
  RETURN getVehicleData;     //****DON't FORGET TO CHANGE THIS!!!!!!!!
END;