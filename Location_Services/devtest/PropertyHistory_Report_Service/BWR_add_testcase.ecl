// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'Location_Services.PropertyHistory_Report_Service';
in_rec := $.layout.request;

xml_in :=
DATASET(FROMXML(in_rec, '<Location_Services.PropertyHistory_Report_Service><glbpurpose>5</glbpurpose><dlmask>0</dlmask><ssnmask>NONE</ssnmask><excludedmvpii>1</excludedmvpii><probationoverride>1</probationoverride><datarestrictionmask>0000000020000101000000000000000000000000</datarestrictionmask><state>CA</state><city>SAN JOSE</city><usage>0111000300050000</usage><streetaddress>123 main street</streetaddress><industryclass>OTHER</industryclass><lnbranded>1</lnbranded><dppapurpose>3</dppapurpose><testdataenabled>0</testdataenabled><dobmask>NONE</dobmask><deathmasterpurpose>10</deathmasterpurpose><zip>11111</zip><useinhousephonemetadata>1</useinhousephonemetadata><datapermissionmask>11000100010000000000100000010000000</datapermissionmask></Location_Services.PropertyHistory_Report_Service>')) +
DATASET(FROMXML(in_rec, '<Location_Services.PropertyHistory_Report_Service><glbpurpose>5</glbpurpose><dlmask>0</dlmask><ssnmask>NONE</ssnmask><excludedmvpii>1</excludedmvpii><probationoverride>1</probationoverride><datarestrictionmask>0000000020000101000000001000000000000000</datarestrictionmask><state>AZ</state><city>FLAGSTAFF</city><applicationtype>RSKM</applicationtype><usage>0111000300050000</usage><streetaddress>123 main street</streetaddress><IndustryClass>OTHER</IndustryClass><lnbranded>1</lnbranded><dppapurpose>3</dppapurpose><testdataenabled>0</testdataenabled><dobmask>NONE</dobmask><deathmasterpurpose>10</deathmasterpurpose><zip>11111</zip><useinhousephonemetadata>1</useinhousephonemetadata><datapermissionmask>110001000100000000000000000100</datapermissionmask></Location_Services.PropertyHistory_Report_Service>'));


ds_in_orig := DEDUP(SORT(xml_in, streetaddress), streetaddress);
ds_in := DEDUP(xml_in, RECORD, ALL);
//OUTPUT(ds_in, NAMED('ds_in_orig'), ALL);

//Create variations of compliance values
ds_sample := CHOOSEN(ds_in, 20);
$.layout.request SetValues($.layout.request L,
      string glb, string dppa, string dpm, string drm,
      string ssn_mask, string dlmask, string dobmask, string ic,
      string excludedmvpii = '', string ignoreFares = '', string ignoreFidelity = '',
      string lnbranded = '', string probation = '') := TRANSFORM

	SELF.glbpurpose := glb;
	SELF.dppapurpose :=dppa;
	SELF.datapermissionmask := dpm;
	SELF.datarestrictionmask := drm;

  SELF.ssnmask := ssn_mask;
  SELF.dlmask := dlmask;
  SELF.dobmask := dobmask;
  SELF.industryclass := ic;

  SELF.excludedmvpii := excludedmvpii;
  SELF.ignorefares := ignoreFares;
  SELF.ignorefidelity := ignoreFidelity;

  SELF.lnbranded := lnbranded;
  SELF.probationoverride := probation;
  // string  applicationtype;
  // string  intendeduse;
  // string  includeminors;
  SELF := [];
END;

mask_zero := '00000000000000000000000000000000000000000000';
mask_ones := '11111111111111111111111111111111111111111111';
ds_1 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, 'first5', '',  'day',   ''));
ds_2 := PROJECT(ds_sample, SetValues(LEFT, '2', '7', mask_ones, mask_zero, 'first5', '1', 'year',  '', '1'));
ds_3 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '1', 'month', 'UTILI'));
ds_4 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '',  '',      'CNSMR', '1'));
ds_5 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',     '1', 'true'));
ds_6 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',     '1', 'true', 'true'));
ds_7 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',        ,       ,       , 'true'));
ds_8 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',        ,       ,       , 'true', 'true'));

xml_recs := ds_in + ds_1 + ds_2 + ds_3 + ds_4 + ds_5 + ds_6 + ds_7 + ds_8;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance: variations';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_variations := PROJECT(xml_recs, toTestCase(LEFT));

// Set default values
ds_default := PROJECT(ds_sample, $.layout.request_defaults);

dev_regression.layouts.testcase toTestCaseDefaults($.layout.request_defaults L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance: defaults';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_def := PROJECT(ds_default, toTestCaseDefaults(LEFT));

testcases := testcases_variations + testcases_def;

OUTPUT(xml_recs, NAMED('xml_recs'), ALL);
OUTPUT(ds_default, NAMED('ds_default'));
dev_regression.bucket().add(testcases, 'compliance regression');
