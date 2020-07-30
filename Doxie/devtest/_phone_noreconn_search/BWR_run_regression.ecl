import dev_regression, doxie, gateway;

// service_url := Gateway._shortcuts.soapshark('dev_one_way_2'); 
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'doxie.phone_noreconn_search';

testcases := dev_regression.bucket().get(my_query);
output(testcases, named('testcases'));

svc_layout := doxie.devtest._phone_noreconn_search.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, service_url);
