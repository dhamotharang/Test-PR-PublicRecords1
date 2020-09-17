IMPORT dev_regression, doxie, gateway;

#WORKUNIT('name', 'doxie-vehicles regression');

// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_155');
target_url_a := Gateway._shortcuts.dev155_roxie;
target_url_b := Gateway._shortcuts.dev155_roxie;

my_query := 'doxie.vehicle_report';

testcases := dev_regression.bucket().get(my_query, 'compliance regression');
OUTPUT(testcases, NAMED('testcases'));

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := 'FedexAddressPrefillA';
  EXPORT string url_b := target_url_b;

  //vehicle_report uses lowercase tag name for "results"
  EXPORT string xp := 'Response/Results/Result/Dataset[@name=\'results\']/Row';
END;

svc_layout := doxie.devtest.vehicle_report.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, mod_test);
