// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, iesp, PhoneFinder_Services;

my_query := 'PhoneFinder_Services.PhoneFinderReportService';
svc_layout := PhoneFinder_Services.devtest._phonefinder_report_service.layout;

// start off with a base template for the soap request
xlm_base := PhoneFinder_Services.SOAP.Helper.GetSimpleRequest();

esdl_recs := project(xlm_base, TRANSFORM(iesp.phonefinder.t_PhoneFinderSearchRequest,
  SELF.SearchBy.PhoneNumber := '5551234444';
  SELF.Options._Type := 'BASIC';
  SELF.Options.IncludePhoneMetadata := true;
  SELF.Options.UseInHousePhoneMetadata := true;
  SELF.Options.IncludeRiskIndicators := true;
  SELF := LEFT;  
  ));

svc_layout.request wrapESDL() := TRANSFORM
  SELF.PhoneFinderSearchRequest := esdl_recs;
END;

dev_regression.layouts.testcase xt() := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'a quick description should go here...';
  SELF.request_xml := dev_regression.utils.wrapTOXML(ROW(wrapESDL()));
END;

testcases := DATASET([xt()]);
output(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases);
