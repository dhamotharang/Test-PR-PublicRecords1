IMPORT addrBest, dev_regression, gateway;

#WORKUNIT('name', '-- best address batch regression --');

service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'addrBest.BestAddress_Batch_Service';
svc_layout := addrBest.devtest._bestaddress_batch_service.layout;

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url;

  EXPORT string query_b := my_query + '_regression';
  EXPORT string url_b := service_url;
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
