IMPORT dev_regression, didville, gateway;

#WORKUNIT('name', '-- didville.Did_Batch_Service_Raw regression --');

service_url_a := Gateway._shortcuts.soapshark('neutralroxie');
// service_url_a := Gateway._shortcuts.dev155_roxie;
service_url_b := Gateway._shortcuts.neutral_roxie_cert;
my_query := 'didville.Did_Batch_Service_Raw';

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url_a;

  EXPORT string query_b := my_query;// + '_regression';
  EXPORT string url_b := service_url_b;

  EXPORT string xp := 'Response/Results/Result/Dataset[@name=\'Result\']/Row';
   
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

svc_layout := didville.devtest.did_batch_service_raw.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
