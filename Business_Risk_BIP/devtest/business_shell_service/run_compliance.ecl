IMPORT dev_regression, gateway;

#WORKUNIT('name', 'Business shell service regression, compliance');

// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_155');
target_url_a := Gateway._shortcuts.dev155_roxie;
target_url_b := Gateway._shortcuts.dev155_roxie;

my_query := 'business_risk_bip.business_shell_service';

testcases := dev_regression.bucket().get(my_query, 'compliance regression');
OUTPUT(testcases, NAMED('testcases'));

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := 'business_risk_bip.business_shell_service_test';
  EXPORT string url_b := target_url_b;
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
