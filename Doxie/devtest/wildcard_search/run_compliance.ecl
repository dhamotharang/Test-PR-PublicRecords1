import dev_regression, gateway;

#WORKUNIT('name', 'wild-vehicles regression');

my_query := 'doxie.wildcard_search';

testcases := dev_regression.bucket().get(my_query, 'compliance regression');
output(testcases, named('testcases'));


// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_154');
target_url_a := Gateway._shortcuts.dev155_roxie;
target_url_b := Gateway._shortcuts.dev155_roxie;

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := 'compreporta';
  EXPORT string url_b := target_url_b;

  //wildcard_search uses lowercase tag name for "results"
  EXPORT string xp := 'Response/Results/Result/Dataset[@name=\'results\']/Row';
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
