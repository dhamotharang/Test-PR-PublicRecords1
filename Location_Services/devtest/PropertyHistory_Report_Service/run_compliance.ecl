IMPORT dev_regression, gateway;

#WORKUNIT('name', 'Location_Services, regression');

target_url_a := Gateway._shortcuts.soapshark('dev_155');
target_url_b := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.neutral_roxie_cert;

// target_url_a := Gateway._shortcuts.dev155_roxie;
// target_url_b := Gateway._shortcuts.dev155_roxie;

my_query := 'Location_Services.PropertyHistory_Report_Service';

//take a subset of original (20 records) and variations (180)
testcases := dev_regression.bucket().get(my_query, 'compliance regression')
  ((tid BETWEEN 2353 AND 2372) OR tid > 2782 - 180) (;

//OUTPUT(testcases, ALL);

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query + '.1';
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := my_query + '.2';
  EXPORT string url_b := target_url_b;
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
