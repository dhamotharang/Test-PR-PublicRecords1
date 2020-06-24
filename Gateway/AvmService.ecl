// This service adds opt-out suppression to the Avm gateway.
// The "Automated Valuation Model"
// http://gatewaycertesp.sc.seisint.com:7726/WsGateway/AVM?form&ver=3
// The input contains only an address, lexID resolution happens on the response only.

IMPORT AutoStandardI, Doxie, iesp, Gateway;

EXPORT AvmService := MACRO

  // ***IMPORTANT*** In order to compile on dev environments, in the ecl command include -foptimizeLevel=0
  // Never release to PROD with this option on.
  // #OPTION('optimizeLevel', 0);

  ds_in := DATASET([], iesp.avm_property_report.t_AVMPropertyReportRequest) : STORED('AVMPropertyReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  gws := Gateway.Configuration.Get();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  recs_bundled := Gateway.Avm.Records(first_row, mod_access, gws);

  OUTPUT(recs_bundled.recs, NAMED('Results'));
  OUTPUT(recs_bundled.royalties, NAMED('RoyaltySet'));

ENDMACRO;
