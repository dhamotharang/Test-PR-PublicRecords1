IMPORT PersonSlimReport_Services, iesp, doxie, AutoheaderV2, Royalty;
EXPORT ReportService() := FUNCTION
  //to use the new salt library version
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT); 
  ds_in     := DATASET([], iesp.personslimreport.t_PersonSlimReportRequest) : STORED('PersonSlimReportRequest',FEW);
  first_row := ds_in[1] : INDEPENDENT;
  
  mod := PersonSlimReport_Services.IParams.getOptions(first_row);
  PersonSlimReport_Services.IParams.StoreIesp(first_row);
  
  in_dids := DATASET([(unsigned6)first_row.ReportBy.UniqueID],doxie.layout_references_hh);
  results := PersonSlimReport_Services.Records(in_dids, mod);
  // where datasource & vehicleinfo.vin are fields inside of results.vehicles
  Royalty.RoyaltyVehicles.MAC_ReportSet(results.vehicles, royalties_rtv, datasource, vehicleinfo.vin);
  
  #WEBSERVICE(FIELDS('PersonSlimReportRequest','Gateways'));
  output(royalties_rtv,named('RoyaltySet'));
  RETURN OUTPUT(results, NAMED('Results'));
END;