import dev_regression, Fedex_Services, gateway;

// service_url := Gateway._shortcuts.soapshark('dev_one_way_2'); 
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'Fedex_Services.AddressPreFillService';

testcases := dev_regression.bucket().get(my_query);
output(testcases, named('testcases'));

svc_layout := Fedex_Services.devtest._addressprefillservice.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, service_url);

