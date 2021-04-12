IMPORT dev_regression, gateway;

#WORKUNIT('name', 'InstantID regression, compliance');

target_url_a := Gateway._shortcuts.dev155_roxie;
target_url_b := target_url_a;
// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_155');

my_query := 'Risk_Indicators.InstantID';

//tids := [1164, 1210, 1230, 1250, 1270, 1290];
testcases := dev_regression.bucket().get(my_query, 'compliance regression');// (tid IN tids);
// OUTPUT(testcases, NAMED('testcases'));

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query + '.4';
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := my_query + '.3';
  EXPORT string url_b := target_url_b;
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
