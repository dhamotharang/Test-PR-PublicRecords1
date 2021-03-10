// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, doxie;

my_query := 'doxie.phone_noreconn_search';
svc_layout := doxie.devtest._phone_noreconn_search.layout;

svc_layout.request xt(string phone) := TRANSFORM
  SELF.phone := phone;
	SELF.datapermissionmask := '1111111111111111111111111111111';
	SELF.datarestrictionmask := '000000000000000000000000000000';
	SELF.dppapurpose := '1';
	SELF.glbpurpose := '7';
	SELF.includerealtimephones := '1';
	SELF.useqsentv2 := '1';
  SELF := [];
END;
xml_recs := dataset([xt('5102062894')]);

dev_regression.layouts.testcase xtTc() := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'a quick description should go here...';
  SELF.request_xml := dev_regression.utils.wrapTOXML(xml_recs[1]);
END;

testcases := DATASET([xtTc()]);

dev_regression.bucket().add(testcases);
