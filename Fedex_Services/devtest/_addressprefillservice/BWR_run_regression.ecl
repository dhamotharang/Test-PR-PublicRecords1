IMPORT dev_regression, Fedex_Services, gateway;

#WORKUNIT('name', '-- Fedex address prefil regression --');

// service_url := Gateway._shortcuts.soapshark('dev_one_way_2');
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'Fedex_Services.AddressPreFillService';

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url;

  EXPORT string query_b := my_query + '_regression';
  EXPORT string url_b := service_url;
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

svc_layout := Fedex_Services.devtest._addressprefillservice.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
