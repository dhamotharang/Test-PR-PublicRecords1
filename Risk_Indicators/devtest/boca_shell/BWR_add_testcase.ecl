// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'Risk_Indicators.Boca_Shell';

in_rec := $.layout.request;

//pattern for adding new test cases: this is exactly how they appear in Roxie logs
xml_in :=
DATASET(FROMXML(in_rec, '<risk_indicators.Boca_Shell><ssn>111111111</ssn><lastname>Smith</lastname><streetaddress>123 main st.</streetaddress><glbpurpose>1</glbpurpose><dppapurpose>3</dppapurpose><accountnumber>32</accountnumber><dateofbirth>19900101</dateofbirth><bsversion>3</bsversion><datarestrictionmask>0000000000000000</datarestrictionmask><historydateyyyymm>999999</historydateyyyymm><city>Bowling Green</city><zip>11111</zip><state>KY</state><homephone>2222222222</homephone><firstname>John</firstname></risk_indicators.Boca_Shell>')) +
DATASET(FROMXML(in_rec, '<risk_indicators.Boca_Shell><ssn>111111111</ssn><lastname>Smith</lastname><streetaddress>123 main st.</streetaddress><glbpurpose>1</glbpurpose><dppapurpose>3</dppapurpose><accountnumber>4</accountnumber><dateofbirth>19900101</dateofbirth><bsversion>3</bsversion><datarestrictionmask>0000000000000000</datarestrictionmask><historydateyyyymm>999999</historydateyyyymm><city>CENTENNIAL</city><zip>11111</zip><state>CO</state><firstname>John</firstname></risk_indicators.Boca_Shell>'));

// fix the input (remove unnecessary duplicates, ensure not passing blanks in some fields, etc.)
in_rec FixInput(in_rec L) := TRANSFORM
  // SELF.skiprecords := '';
  // SELF.maxresults := IF(L.maxresults != '', L.maxresults, (string)MaxResults_val);
  // SELF.maxresultsthistime := IF(L.maxresultsthistime != '', L.maxresultsthistime, (string)MaxResultsThisTime_val);
  SELF := L;
END;
ds_in := PROJECT(DEDUP(xml_in, RECORD, ALL), FixInput(LEFT));

// to produce variations of the input
in_rec SetValues(in_rec L, string glb, string dppa, string dpm, string drm,
                 string ssn_mask, string dlmask, string dobmask, string ic,
                 string excludedmvpii = '') := TRANSFORM
	SELF.glbpurpose := glb;
	SELF.dppapurpose :=dppa;
	SELF.datapermissionmask := dpm;
	SELF.datarestrictionmask := drm;
  SELF.industryclass := ic;
  SELF.excludedmvpii := excludedmvpii;

  SELF.ssnmask := ssn_mask;
  SELF.dlmask := dlmask;
  SELF.dobmask := dobmask;
  SELF := L;
END;

//choose a small sample for compliance variations:
ds_sample := CHOOSEN(ds_in, 20);

mask_zero := '00000000000000000000000000000000000000000000';
mask_ones := '11111111111111111111111111111111111111111111';
ds_1 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, 'first5', '',  'day',   ''));
ds_2 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_ones, mask_zero, 'first5', '1', 'year',  '', '1'));
ds_3 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_ones, 'first5', '1', 'year',  '', '1'));
ds_4 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '1', 'month', 'UTILI'));
ds_5 := PROJECT(ds_sample, SetValues(LEFT, '2', '7', mask_zero, mask_zero, '',       '',  '',      'CNSMR', '1'));
xml_recs := ds_in + ds_1 + ds_2 + ds_3 + ds_4 + ds_5;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'test Boca Shell for compliance';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases_variations := PROJECT(xml_recs, toTestCase(LEFT));


ds_default := PROJECT(ds_in, $.layout.request_defaults);

dev_regression.layouts.testcase toTestCaseDefaults($.layout.request_defaults L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance: defaults';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_def := PROJECT(ds_default, toTestCaseDefaults(LEFT));

testcases := testcases_variations + testcases_def;

OUTPUT(ds_in, NAMED('ds_in'));
OUTPUT(xml_in, NAMED('xml_in'));
OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');
