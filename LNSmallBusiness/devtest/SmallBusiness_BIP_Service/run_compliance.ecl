IMPORT dev_regression, gateway;

#WORKUNIT('name', 'Small Business BIP service regression, compliance');

// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_155');
target_url_a := Gateway._shortcuts.dev156_roxie;
target_url_b := Gateway._shortcuts.dev156_roxie;

my_query := 'lnsmallbusiness.smallbusiness_bip_service';

_testcases := dev_regression.bucket().get(my_query, 'compliance regression');
//re-run only failed tests
tids := [875, 880, 883, 911];
testcases := _testcases(tid IN tids);


OUTPUT(testcases, NAMED('testcases'));

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query + '.39'; //not necessarily the latest version
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := my_query + '_test';
  EXPORT string url_b := target_url_b;
END;

svc_layout := $.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, mod_test);
