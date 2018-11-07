IMPORT HIPIEBIZ;
EXPORT Keys(HIPIEBIZ.Options.SearchParams inOptions) := MODULE
  SHARED MainFile := DATASET('', HIPIEBIZ.Layouts.MainFileLayout, THOR);
  SHARED OfficerFile := DATASET('', HIPIEBIZ.Layouts.OfficerFileLayout, THOR);
  
  EXPORT NewBusinessesFile  := DATASET('~batchr3::'+(STRING)inOptions.GCID+'::biz::ramps::'+(STRING)inOptions.JOBID+'::newbusinesses',  HIPIEBIZ.Layouts.MainFileLayout, THOR);
  EXPORT KeyCustomerAccount := INDEX(MainFile, {(string200) customer_account}, {MainFile}, HIPIEBIZ.Constants.KeyName+'Account::'+(STRING)inOptions.JOBID);
  EXPORT KeyPayload         := INDEX(MainFile, {(INTEGER8) BizRecId}, {MainFile}, HIPIEBIZ.Constants.KeyName+'Payload::'+(STRING)inOptions.JOBID);
  
  dBusinessName             := DATASET('', {STRING200 CompanyName, HIPIEBIZ.Layouts.MainFileLayout}, THOR);
  EXPORT KeyBusinessName    := INDEX(dBusinessName, {CompanyName}, {dBusinessName}, HIPIEBIZ.Constants.KeyName+'BusinessName::'+(STRING)inOptions.JOBID);
  dBusinessAddress          := DATASET('', {HIPIEBIZ.Layouts.MainFileLayout,	UNSIGNED CityCode}, THOR);
  EXPORT KeyBusinessAddress := INDEX(dBusinessAddress, {PhysicalAddressPrimaryName,PhysicalAddressPrimaryRange,PhysicalAddressState,CityCode,PhysicalAddressZip,PhysicalAddressSecondaryRange}, {dBusinessAddress}, HIPIEBIZ.Constants.KeyName+'BusinessAddress::'+(STRING)inOptions.JOBID);
  EXPORT KeyBusinessTaxID   := INDEX(MainFile, {(STRING9) FEIN}, {MainFile}, HIPIEBIZ.Constants.KeyName+'BusinessTaxID::'+(STRING)inOptions.JOBID);
  
  
  dOfficerName              := DATASET('', {HIPIEBIZ.Layouts.OfficerFileLayout, STRING100 OfficerFirstName, STRING20 OfficerMiddleName, STRING100 OfficerLastName, STRING10 OfficerNameSuffix, STRING6  OfficerPhoneticLastName, STRING20 OfficerPreferredFirstName}, THOR); 
  EXPORT KeyOfficerName     := INDEX(dOfficerName, {OfficerPhoneticLastName,OfficerLastName,OfficerPreferredFirstName,OfficerMiddleName,OfficerFirstName}, {dOfficerName}, HIPIEBIZ.Constants.KeyName+'OfficerName::'+(STRING)inOptions.JOBID);
  dOfficerAddress           := DATASET('', {HIPIEBIZ.Layouts.OfficerFileLayout,	UNSIGNED CityCode}, THOR);
  EXPORT KeyOfficerAddress  := INDEX(dOfficerAddress, {ReportedOfficerCleanPrimaryName,ReportedOfficerCleanPrimaryRange,ReportedOfficerCleanState,CityCode,ReportedOfficerCleanZip,ReportedOfficerCleanSecondaryRange}, {dOfficerAddress}, HIPIEBIZ.Constants.KeyName+'OfficerAddress::'+(STRING)inOptions.JOBID);
  EXPORT KeyOfficerTaxID    := INDEX(OfficerFile, {(STRING9) ReportedOfficerSSN}, {OfficerFile}, HIPIEBIZ.Constants.KeyName+'OfficerTaxID::'+(STRING)inOptions.JOBID);
END;