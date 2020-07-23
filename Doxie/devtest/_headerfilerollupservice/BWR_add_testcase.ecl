// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, doxie;

my_query := 'doxie.HeaderFileRollupService';
svc_layout := doxie.devtest._headerfilerollupservice.layout;

svc_layout.request xt(string _did) := TRANSFORM
  SELF.did := _did;
	SELF.datapermissionmask := '1111111111111111111111111111111';
	SELF.datarestrictionmask := '000000000000000000000000000000';
	SELF.dppapurpose := '1';
	SELF.glbpurpose := '1';
	SELF.addresslimit := '100';
  SELF := [];
END;
xml_recs := dataset([xt('000610327911')]);

dev_regression.layouts.testcase xtTc() := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'validate gong scores';
  SELF.request_xml := dev_regression.utils.wrapTOXML(xml_recs[1]);
END;

testcases := DATASET([xtTc()]);

dev_regression.bucket().add(testcases);
