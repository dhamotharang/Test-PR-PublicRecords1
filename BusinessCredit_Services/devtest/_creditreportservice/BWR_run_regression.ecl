#WORKUNIT('name', '-- dev regression: CreditReportService --');

IMPORT dev_regression, gateway;

// service_url := Gateway._shortcuts.soapshark('neutralroxie');
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'BusinessCredit_Services.CreditReportService';

soap_cfg := MODULE(dev_regression.ISoapConfig)
  EXPORT string query_a := my_query;
  EXPORT string url_a := service_url;

  EXPORT string query_b := my_query + '_regression';
  EXPORT string url_b := service_url;
END;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

svc_layout := BusinessCredit_Services.devtest._creditreportservice.layout;
dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, soap_cfg);
