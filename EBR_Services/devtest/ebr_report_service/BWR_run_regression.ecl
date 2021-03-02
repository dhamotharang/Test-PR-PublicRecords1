IMPORT dev_regression, gateway, EBR_Services;

#WORKUNIT('name', '-- ebr report regression --');

// service_url := Gateway._shortcuts.soapshark('dev_155');
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'EBR_Services.EbrReportService';
svc_layout := EBR_Services.devtest.ebr_report_service.layout;

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := Gateway._shortcuts.neutral_roxie_cert;

  // EXPORT string query_b := my_query + '_regression';
  EXPORT string query_b := my_query;
  EXPORT string url_b := Gateway._shortcuts.dev155_roxie;
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
