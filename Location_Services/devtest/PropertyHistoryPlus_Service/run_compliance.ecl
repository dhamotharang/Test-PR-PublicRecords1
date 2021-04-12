IMPORT dev_regression, gateway;

#WORKUNIT('name', 'Location_Services, regression');

target_url_a := Gateway._shortcuts.soapshark('dev_155');
target_url_b := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.neutral_roxie_cert;

// target_url_a := Gateway._shortcuts.dev155_roxie;
// target_url_b := Gateway._shortcuts.dev155_roxie;

my_query := 'Location_Services.PropertyHistoryPlus_Service';

testcases := dev_regression.bucket().get(my_query, 'compliance regression');

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query + '.5';
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := my_query + '.4';
  EXPORT string url_b := target_url_b;
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
