// Use it as an example, modify as you wish
IMPORT dev_regression, gateway, risk_indicators;

#WORKUNIT('name', 'doxie-vehicles regression');

my_query := 'vehicleV2_services.VehicleRegSearchService';

gateways_in := DATASET([
  {'experian', 'http://webapp_roxie_test:web33436$@10.194.5.12:5004'}
], risk_indicators.layout_Gateways_in);
#STORED('gateways', gateways_in);


testcases := dev_regression.bucket().get(my_query, 'compliance regression');
OUTPUT(testcases, NAMED('testcases'));


// target_url_a := Gateway._shortcuts.soapshark('dev_155');
target_url_a := Gateway._shortcuts.dev155_roxie;
// target_url_b := Gateway._shortcuts.soapshark('neutralroxie');
// target_url_a := Gateway._shortcuts.neutral_roxie_cert;


mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := 'fedexaddressprefillb';
  EXPORT string url_b := target_url_a;
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
