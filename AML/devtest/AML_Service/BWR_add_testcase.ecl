// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'AML.AML_Service';

in_rec := $.layout.request;

//pattern for adding new test cases: this is exactly how they appear in Roxie logs
xml_in :=
DATASET(FROMXML(in_rec, '<AML.AML_Service><DOBMask_Overload>none</DOBMask_Overload><_QueryId/><GLBPurpose>7</GLBPurpose><disallowtarguseid3220>0</disallowtarguseid3220><dlmask>0</dlmask><SSNMask>NONE</SSNMask><_GCID>7781564</_GCID><ExcludeDMVPII>1</ExcludeDMVPII><_TransactionId>qwerty</_TransactionId><datarestrictionmask>000000002000010100000000000000000000000000</datarestrictionmask><_TimeLimit>10000</_TimeLimit><_ReferenceCode/><_DeliveryMethod>XML</_DeliveryMethod><usage>0000000000050600</usage><industryclass>OTHER</industryclass><_ESPClientInterfaceVersion>2.090000</_ESPClientInterfaceVersion><DPPAPurpose>3</DPPAPurpose><testdataenabled>0</testdataenabled><dobmask>none</dobmask><deathmasterpurpose>11</deathmasterpurpose><_ESPMethodName>AntiMoneyLaunderingRiskAttributes</_ESPMethodName><datapermissionmask>11000100000000000000000000010000000</datapermissionmask><AntiMoneyLaunderingRiskAttributesRequest><Row><User><TestDataEnabled>0</TestDataEnabled><DLPurpose>3</DLPurpose><NonSubjectSuppression>0</NonSubjectSuppression><GLBPurpose>7</GLBPurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><ExcludeDMVPII>1</ExcludeDMVPII></User><Options><AttributesVersionRequest>AMLRINDVATTRV2</AttributesVersionRequest><ExcludeNewsAttributes>0</ExcludeNewsAttributes></Options><SearchBy><Individual><Address><Zip5>11111</Zip5><StreetAddress1>123 main st.</StreetAddress1><City>LAKE FOREST</City><State>CA</State></Address><Name><Last>Jones</Last><First>James</First></Name><SSN>111111111</SSN><DOB><Year>1900</Year><Day>01</Day><Month>01</Month></DOB><Phone>2222222222</Phone></Individual></SearchBy></Row></AntiMoneyLaunderingRiskAttributesRequest><SSNMask_Overload>NONE</SSNMask_Overload><DLMask_Overload>0</DLMask_Overload></AML.AML_Service>')) +
DATASET(FROMXML(in_rec, '<AML.AML_Service><DOBMask_Overload>none</DOBMask_Overload><_QueryId/><GLBPurpose>7</GLBPurpose><disallowtarguseid3220>0</disallowtarguseid3220><dlmask>0</dlmask><SSNMask>NONE</SSNMask><_GCID>7781564</_GCID><ExcludeDMVPII>1</ExcludeDMVPII><_TransactionId>qwerty</_TransactionId><datarestrictionmask>000000002000010100000000000000000000000000</datarestrictionmask><_TimeLimit>10000</_TimeLimit><_ReferenceCode/><_DeliveryMethod>XML</_DeliveryMethod><usage>0000000000050600</usage><industryclass>OTHER</industryclass><_ESPClientInterfaceVersion>2.090000</_ESPClientInterfaceVersion><DPPAPurpose>3</DPPAPurpose><testdataenabled>1</testdataenabled><dobmask>none</dobmask><deathmasterpurpose>11</deathmasterpurpose><_ESPMethodName>AntiMoneyLaunderingRiskAttributes</_ESPMethodName><datapermissionmask>11000100000000000000000000010000000</datapermissionmask><AntiMoneyLaunderingRiskAttributesRequest><Row><User><TestDataEnabled>1</TestDataEnabled><DLPurpose>3</DLPurpose><NonSubjectSuppression>0</NonSubjectSuppression><GLBPurpose>7</GLBPurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><ExcludeDMVPII>1</ExcludeDMVPII></User><Options><AttributesVersionRequest>AMLRINDVATTRV2</AttributesVersionRequest><ExcludeNewsAttributes>0</ExcludeNewsAttributes></Options><SearchBy><Individual><Address><Zip5>11111</Zip5><StreetAddress1>123 main st.</StreetAddress1><City>BIGLERVILLE</City><State>PA</State></Address><Name><Last>Jones</Last><First>James</First></Name><SSN>111111111</SSN><DOB><Year>1900</Year><Day>01</Day><Month>01</Month></DOB><Phone>2222222222</Phone></Individual></SearchBy></Row></AntiMoneyLaunderingRiskAttributesRequest><SSNMask_Overload>NONE</SSNMask_Overload><DLMask_Overload>0</DLMask_Overload></AML.AML_Service>'));


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
ds_2 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, 'first5', '1', 'year',  '', '1'));
ds_3 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '1', 'month', 'UTILI'));
ds_4 := PROJECT(ds_sample, SetValues(LEFT, '2', '7', mask_zero, mask_zero, '',       '',  '',      'CNSMR', '1'));
xml_recs := ds_in + ds_1 + ds_2 + ds_3 + ds_4;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'test AML service for compliance';
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

OUTPUT(xml_in, NAMED('xml_in'), ALL);
OUTPUT(ds_in, NAMED('ds_in'));
OUTPUT(testcases, NAMED('testcases'), ALL);
dev_regression.bucket().add(testcases, 'compliance regression');
