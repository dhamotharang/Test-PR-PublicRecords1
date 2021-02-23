IMPORT deathv2_services, dev_regression, gateway;

#WORKUNIT('name', '-- DeathV2 Search Service regression --');

// service_url := Gateway._shortcuts.soapshark('dev_one_way_2');
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'deathv2_services.searchservice';

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url;

  EXPORT string query_b := my_query + '_regression';
  EXPORT string url_b := service_url;
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

svc_layout := deathv2_services.devtest._searchservice.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
