import addrBest, dev_regression, gateway;

service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'addrBest.BestAddress_Batch_Service';
svc_layout := addrBest.devtest._bestaddress_batch_service.layout;

testcases := dev_regression.bucket().get(my_query);
output(testcases, named('testcases'));

dev_regression.mac_run_regression(testcases, service_url, svc_layout.request, svc_layout.response);
