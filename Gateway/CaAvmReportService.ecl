// This service adds opt-out suppression to the CaAvm gateway.
// The "Collateral Assesment Automated Valuation Model"
// http://gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/CaAvmReport?form&ver_=2.70
// The input contains only an address, lexID resolution happens on the response only.


IMPORT $, AutoStandardI, Doxie, iesp, Gateway;

EXPORT CaAvmReportService := MACRO

  ds_in := DATASET([], iesp.gw_ca_avm_request.t_CaAvmReportRequest) : STORED('CaAvmReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  gws := Gateway.Configuration.Get();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  recs_bundled := Gateway.CaAvmReport.Records(first_row, mod_access, gws);

  OUTPUT(recs_bundled.recs, NAMED('Results'));
  OUTPUT(recs_bundled.royalties, NAMED('RoyaltySet'));

ENDMACRO;
