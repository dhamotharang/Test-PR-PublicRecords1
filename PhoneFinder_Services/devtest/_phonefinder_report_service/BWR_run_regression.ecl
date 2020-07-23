import dev_regression, gateway, PhoneFinder_Services;

// service_url := Gateway._shortcuts.soapshark('dev_155');
service_url := Gateway._shortcuts.dev155_roxie;
my_query := 'PhoneFinder_Services.PhoneFinderReportService'; 
svc_layout := PhoneFinder_Services.devtest._phonefinder_report_service.layout;

testcases := dev_regression.bucket().get(my_query);
OUTPUT(testcases, NAMED('testcases'));

dev_regression.mac_run_regression(testcases, svc_layout.request, svc_layout.response, service_url);
