IMPORT dev_regression, gateway, iesp;

#WORKUNIT('name', 'AML_Service regression, compliance');

// target_url_a := Gateway._shortcuts.dev156_roxie;
// target_url_b := Gateway._shortcuts.neutral_roxie_cert;
target_url_a := Gateway._shortcuts.soapshark('dev_155');
target_url_b := Gateway._shortcuts.soapshark('dev_155');


my_query := 'AML.AML_Service';

testcases := dev_regression.bucket().get(my_query, 'compliance regression');
//OUTPUT(testcases, NAMED('testcases'));

//------------------------------------
in_rec := $.layout.request;

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query + '.2';
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := my_query + '.1';
  EXPORT string url_b := target_url_b;
END;

dev_regression.mac_run_regression(testcases, $.layout.request, $.layout.response, mod_test);
