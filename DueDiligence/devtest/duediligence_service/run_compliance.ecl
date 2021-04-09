IMPORT dev_regression, gateway;

#WORKUNIT('name', 'DueDiligence service regression, compliance');

// target_url_a := Gateway._shortcuts.soapshark('dev_155');
// target_url_b := Gateway._shortcuts.soapshark('dev_155');
target_url_a := Gateway._shortcuts.dev155_roxie;
target_url_b := Gateway._shortcuts.dev155_roxie;

my_query := 'DueDiligence.DueDiligence_service';

//tids := [693, 703, 713, 723];
testcases := dev_regression.bucket().get(my_query, 'compliance regression'); //(tid IN tids);
OUTPUT(testcases, NAMED('testcases'));

mod_test := MODULE (dev_regression.ISoapConfig)
  EXPORT string query_a := my_query + '.1';
  EXPORT string url_a := target_url_a;

  EXPORT string query_b := my_query + '.2';
  EXPORT string url_b := target_url_b;
END;

svc_layout := $.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, mod_test);
