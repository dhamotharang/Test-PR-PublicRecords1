#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, Fedex_Services;

my_query := 'Fedex_Services.AddressPreFillService';
svc_layout := Fedex_Services.devtest._addressprefillservice.layout;

layout_request_plus := RECORD(svc_layout.request)
  dev_regression.layouts.testcase.short_description;
END;

layout_request_plus xt(string desc, string addr, string st, string z5, string lname = '', string fname = '') := TRANSFORM
  SELF.datapermissionmask := '1111111111111111111111111111111';
  SELF.datarestrictionmask := '000000000000000000000000000000';
  SELF.dppapurpose := '1';
  SELF.glbpurpose := '7';
  SELF.addr := addr;
  SELF.state := st;
  SELF.zip := z5;
  SELF.firstname := fname;
  SELF.lastname := lname;
  // SELF.customerdataonly := '1';
  SELF.short_description := desc;
  SELF := [];
END;
xml_recs := 
  dataset([xt('some proper description here', 'address', 'st', 'z5', 'lname (optional)', 'fname (optional)')])
  ;
  
dev_regression.layouts.testcase xtTc(layout_request_plus L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := L.short_description;
  SELF.request_xml := dev_regression.utils.wrapTOXML(PROJECT(L, TRANSFORM(svc_layout.request, SELF := LEFT)));
END;

testcases := PROJECT(xml_recs, xtTc(LEFT));

dev_regression.bucket().add(testcases);
