IMPORT dev_regression, didville, gateway;

#WORKUNIT('name', '-- didville.did_service regression --');

// service_url_a := Gateway._shortcuts.soapshark('neutralroxie');
service_url_a := Gateway._shortcuts.dev155_roxie;
// service_url_b := Gateway._shortcuts.neutral_roxie_cert;
service_url_b := Gateway._shortcuts.dev155_roxie;
my_query := 'didville.did_service';

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url_a;

  EXPORT string query_b := my_query;// + '_regression';
  EXPORT string url_b := service_url_b;

  // This service has a weird response and I'm having a hard time getting both 'result 1'
  // and 'result 2' datasets back at the same time.
  EXPORT string xp := 'Response/Results/Result/Dataset[@name=\'Result 1\']/Row';
  // EXPORT string xp := 'Response/Results/Result/Dataset[@name=\'Result 2\']/Row';
   
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

svc_layout := didville.devtest.did_service.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response_rslt1, soap_cfg);
// dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response_rslt2, soap_cfg);
