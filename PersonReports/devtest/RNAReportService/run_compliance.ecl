IMPORT dev_regression, gateway, PersonReports;

#WORKUNIT('name', 'RNA report regression, neighbors');

// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_155');
target_url_a := Gateway._shortcuts.dev155_roxie;
target_url_b := Gateway._shortcuts.dev155_roxie;

my_query := 'PersonReports.RNAReportService';

testcases := dev_regression.bucket().get(my_query, 'compliance regression');
OUTPUT(testcases, NAMED('testcases'));

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := 'TDocSearchA';
  EXPORT string url_b := target_url_b;
END;

svc_layout := PersonReports.devtest.RNAReportService.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, mod_test);
