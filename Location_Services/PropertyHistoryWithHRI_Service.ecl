// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
EXPORT PropertyHistoryWithHRI_Service :=
MACRO
  dIn := DATASET([],iesp.propertyhistoryplus.t_PropertyHistoryPlusReportRequest) : STORED('PropertyHistoryPlusReportRequest',FEW);
  mcRequest := dIn[1] : GLOBAL;

  // Searchby request
  xmlSearchBy:= GLOBAL(mcRequest.ReportBy);

  // Report options
  mcOptions := GLOBAL(mcRequest.Options);

  // #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest(mcRequest);
  iesp.ECL2ESP.SetInputReportBy(PROJECT(xmlSearchBy,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF := LEFT,SELF := [])));
  iesp.ECL2ESP.SetInputSearchOptions(PROJECT(mcOptions,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT,SELF := [])));

  // Global module
  globalMod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(globalMod);
  searchMod := PROJECT(globalMod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT);

  reportParams := MODULE(Location_Services.iParam.PropHistHRI)
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    EXPORT BOOLEAN   IgnoreFares         := globalMod.ignoreFares;
    EXPORT BOOLEAN   IgnoreFidelity      := globalMod.ignoreFidelity;
  END;

  // Populating the XML request from the soap fields
  STRING vAPN := '' : STORED('APN');

  iesp.propertyhistoryplus.t_PropertyHistoryPlusReportBy tFormatSoapFields2Xml() :=
  TRANSFORM
    SELF.ParcelId := vAPN;
    SELF.Address  := ROW({'','','','','','','',searchMod.addr[1..60],searchMod.addr[61..],searchMod.city,searchMod.state,searchMod.zip,'','','',''},iesp.share.t_Address);
  END;

  soapSearchBy := ROW(tFormatSoapFields2Xml());

  propHistPlusSearchBy := IF(EXISTS(dIn),xmlSearchBy,soapSearchBy);

  // Clean the address
  Autokey_batch.Layouts.rec_inBatchMaster tConvert2Batch(iesp.propertyhistoryplus.t_PropertyHistoryPlusReportBy pInput) :=
  TRANSFORM
    cleanAddr := Address.CleanAddressFieldsFips(AutoStandardI.InterfaceTranslator.clean_address.val(searchMod)).addressrecord;

    SELF.acctno      := '1';  // since there would only be one record
    SELF.z5          := cleanAddr.zip;
    SELF.apn         := pInput.ParcelId;
    SELF             := cleanAddr;
  END;

  dReqCleanAddr := PROJECT(DATASET(propHistPlusSearchBy),tConvert2Batch(LEFT));

  // Filter records with no unit number populated
  dUnitNumbersDedup := Location_Services.Functions.GetSecRanges (dReqCleanAddr(sec_range = ''));

  // If we do get back more than one distinguished secondary range (not counting blanks), then we fail the service with insufficient address
  // NB: in case APN is in the input search will go on by APN.
  IF(trim(vAPN) = '' and (count(dUnitNumbersDedup) > 1), FAIL(310,doxie.ErrorCodes(310)));

  dResults := Location_Services.PropertyHistoryWithHRI_Records(dReqCleanAddr,reportParams,propHistPlusSearchBy);

  OUTPUT(dResults,NAMED('Results'));
ENDMACRO;
