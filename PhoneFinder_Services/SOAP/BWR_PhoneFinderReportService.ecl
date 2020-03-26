/***************************************************************************
 * Use the code below when testing SOAP.CallPhoneFinderReport.
 ***************************************************************************/
import Gateway, iesp, risk_indicators, PhoneFinder_Services;

#WORKUNIT('name', '-- SOAP wrapper -- PhoneFinderReport');  
#STORED('gateways', Gateway._shortcuts.gateways);

// start off with a base template for the soap request
soap_req_base := PhoneFinder_Services.SOAP.Helper.GetSimpleRequest();

// customize your search
soap_req := project(soap_req_base, transform(iesp.phonefinder.t_PhoneFinderSearchRequest,
  self.SearchBy.PhoneNumber := '555123456';
  self.Options._Type := 'BASIC';
  self.Options.IncludePhoneMetadata := true;
  self.Options.UseInHousePhoneMetadata := true;
  self.Options.IncludeRiskIndicators := true;
  self := left;  
  ));

// and call the wrapper to get a response	
service_url := Gateway._shortcuts.neutral_roxie_cert;
soap_resp := PhoneFinder_Services.SOAP.CallPhoneFinderReport(soap_req, service_url);

output(soap_req, named('soap_request'));
output(soap_resp, named('soap_resp'));
