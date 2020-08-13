IMPORT dev_regression, gateway, PhoneFinder_Services;

#WORKUNIT('name', '-- phone finder report regression --');

// service_url := Gateway._shortcuts.soapshark('dev_155');
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'PhoneFinder_Services.PhoneFinderReportService';
svc_layout := PhoneFinder_Services.devtest._phonefinder_report_service.layout;

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url;

  EXPORT string query_b := my_query + '_regression';
  EXPORT string url_b := service_url;
END;


testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
