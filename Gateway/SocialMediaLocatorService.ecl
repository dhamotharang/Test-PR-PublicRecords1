// This service adds opt-out suppression to the SocialMediaLocator gateway.
// http://gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/SocialMediaLocator?ver_=2.70
// Input PII -> Resolve DID -> Check for Suppression -> If not suppressed or no did, return results.
// If Suppressed, echo input into RequestInfo, don't call gateway, return.

IMPORT $, AutoStandardI, Doxie, iesp, Gateway;

EXPORT SocialMediaLocatorService := MACRO

  ds_in := DATASET([], iesp.socialmedialocatorsearch.t_SocialMediaLocatorSearchRequest) : STORED('SocialMediaLocatorSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  gws := Gateway.Configuration.Get();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  recs_bundled := Gateway.SocialMediaLocator.Records(first_row, mod_access, gws);

  OUTPUT(recs_bundled.recs, NAMED('Results'));
  OUTPUT(recs_bundled.royalties, NAMED('RoyaltySet'));
ENDMACRO;
