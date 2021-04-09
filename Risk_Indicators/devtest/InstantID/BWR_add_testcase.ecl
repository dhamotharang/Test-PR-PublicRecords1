// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'Risk_Indicators.InstantID';

in_rec := $.layout.request;

//pattern for adding new test cases: this is exactly how they appear in Roxie logs
xml_in :=
DATASET(FROMXML(in_rec, '<Risk_Indicators.InstantID><DOBMask_Overload>day</DOBMask_Overload><ExactFirstNameMatch>0</ExactFirstNameMatch><ExactSSNMatch>1</ExactSSNMatch><ExactDriverLicenseMatch>0</ExactDriverLicenseMatch><_GCID>1234567</_GCID><ExcludeDMVPII>1</ExcludeDMVPII><_TransactionId>...</_TransactionId><ExactFirstNameMatchAllowNicknames>0</ExactFirstNameMatchAllowNicknames><LastSeenThreshold>365</LastSeenThreshold><State>NJ</State><_DeliveryMethod>XML</_DeliveryMethod><HomePhone>2222222222</HomePhone><IncludeDriverLicenseInCVI>1</IncludeDriverLicenseInCVI><ExactLastNameMatch>0</ExactLastNameMatch><_LoginId>...</_LoginId><_ClientIP>...</_ClientIP><IncludeComplianceCap>0</IncludeComplianceCap><ofaconly>0</ofaconly><industryclass>OTHER</industryclass><_ESPClientInterfaceVersion>2.640000</_ESPClientInterfaceVersion><IncludeDLVerification>1</IncludeDLVerification><DOBRadius>2</DOBRadius><GlobalWatchlistThreshold>0.84</GlobalWatchlistThreshold><DisableCustomerNetworkOptionInCVI>0</DisableCustomerNetworkOptionInCVI><DPPAPurpose>3</DPPAPurpose><DateOfBirth>19900101</DateOfBirth><dobmask>day</dobmask><ExactAddrMatch>0</ExactAddrMatch><OFACversion>4</OFACversion><IncludeDOBInCVI>1</IncludeDOBInCVI><deathmasterpurpose>10</deathmasterpurpose><IncludeMIOverride>0</IncludeMIOverride><Addr>123 main st.</Addr><datapermissionmask>11000100010000000000000000000000000</datapermissionmask><FirstName>John</FirstName><SSN>111111111</SSN><IncludeAllRiskIndicators>1</IncludeAllRiskIndicators><_QueryId/><EnableEmergingId>0</EnableEmergingId><GLBPurpose>1</GLBPurpose><disallowtarguseid3220>0</disallowtarguseid3220><timeofapplication/><dlmask>1</dlmask><SSNMask>LAST4</SSNMask><DisallowInsurancePhoneHeaderGateway>0</DisallowInsurancePhoneHeaderGateway><datarestrictionmask>00100100000011000000000000000000000000000000000</datarestrictionmask><_ReferenceCode>897993 - 12772609135</_ReferenceCode><ExactPhoneMatch>0</ExactPhoneMatch><_TimeLimit>10000</_TimeLimit><PoBoxCompliance>0</PoBoxCompliance><City>Bridgewater</City><_LogFunctionName>InstantID</_LogFunctionName><usage>0100000000050600</usage><StreetAddress>123 main st.</StreetAddress><ExcludeMinors>0</ExcludeMinors><nameinputorder>-1</nameinputorder><LastName>Smith</LastName><_CompanyId>1111111</_CompanyId><IncludeDPBC>0</IncludeDPBC><dateofapplication/><IncludeTargusE3220>1</IncludeTargusE3220><IncludeITIN>0</IncludeITIN><testdataenabled>0</testdataenabled><InstantIDVersion>1</InstantIDVersion><IncludeCLOverride>0</IncludeCLOverride><UseDOBFilter>0</UseDOBFilter><includeofac>0</includeofac><DisableNonGovernmentDLData>0</DisableNonGovernmentDLData><Zip>11111</Zip><_ESPMethodName>InstantID</_ESPMethodName><IncludeMsOverride>0</IncludeMsOverride><DOBMatchOptions><row><DOBMatch>FuzzyCCYYMMDD</DOBMatch><DOBMatchYearRadius>0</DOBMatchYearRadius></row></DOBMatchOptions><IncludeEmailVerification>0</IncludeEmailVerification><DLMask_Overload>1</DLMask_Overload><SSNMask_Overload>LAST4</SSNMask_Overload></Risk_Indicators.InstantID>')) +
DATASET(FROMXML(in_rec, '<Risk_Indicators.InstantID><DOBMask_Overload>NONE</DOBMask_Overload><ExactFirstNameMatch>0</ExactFirstNameMatch><ExactSSNMatch>0</ExactSSNMatch><ExactDriverLicenseMatch>0</ExactDriverLicenseMatch><_GCID>1234567</_GCID><ExcludeDMVPII>1</ExcludeDMVPII><_TransactionId>...</_TransactionId><ExactFirstNameMatchAllowNicknames>0</ExactFirstNameMatchAllowNicknames><State>MO</State><_DeliveryMethod>XML</_DeliveryMethod><HomePhone>2222222222</HomePhone><IncludeDriverLicenseInCVI>0</IncludeDriverLicenseInCVI><RedFlag_version>1</RedFlag_version><ExactLastNameMatch>0</ExactLastNameMatch><_LoginId>...</_LoginId><_ClientIP>...</_ClientIP><watchlist><row><watchlist><Name>ALL</Name></watchlist></row></watchlist><industryclass>OTHER</industryclass><_ESPClientInterfaceVersion>1.830000</_ESPClientInterfaceVersion><IncludeDLVerification>0</IncludeDLVerification><GlobalWatchlistThreshold>0.84</GlobalWatchlistThreshold><DisableCustomerNetworkOptionInCVI>0</DisableCustomerNetworkOptionInCVI><DPPAPurpose>3</DPPAPurpose><DateOfBirth>19900101</DateOfBirth><dobmask>NONE</dobmask><ExactAddrMatch>0</ExactAddrMatch><Addr>123 main st.</Addr><IncludeDOBInCVI>0</IncludeDOBInCVI><deathmasterpurpose>11</deathmasterpurpose><IncludeMIOverride>0</IncludeMIOverride><datapermissionmask>11000100010000000000000000000000000</datapermissionmask><FirstName>John</FirstName><SSN>111111111</SSN><IncludeAllRiskIndicators>0</IncludeAllRiskIndicators><_QueryId>e505d5a306f69-NJwdTj-615053403</_QueryId><GLBPurpose>1</GLBPurpose><disallowtarguseid3220>1</disallowtarguseid3220><timeofapplication/><dlmask>0</dlmask><SSNMask>NONE</SSNMask><DisallowInsurancePhoneHeaderGateway>0</DisallowInsurancePhoneHeaderGateway><datarestrictionmask>0000000040000101000000000000000000000000</datarestrictionmask><_ReferenceCode>2021031685495</_ReferenceCode><ExactPhoneMatch>0</ExactPhoneMatch><_TimeLimit>10000</_TimeLimit><PoBoxCompliance>1</PoBoxCompliance><City>Ozark</City><_LogFunctionName>InstantID</_LogFunctionName><usage>0100000000000000</usage><StreetAddress>123 main st.</StreetAddress><LastName>Smith</LastName><_CompanyId>111111</_CompanyId><dateofapplication/><IncludeTargusE3220>0</IncludeTargusE3220><testdataenabled>0</testdataenabled><InstantIDVersion/><IncludeCLOverride>0</IncludeCLOverride><UseDOBFilter>0</UseDOBFilter><_ESPMethodName>InstantID</_ESPMethodName><Zip>11111</Zip><IncludeMsOverride>0</IncludeMsOverride><DOBMatchOptions><row><DOBMatch>FuzzyCCYYMMDD</DOBMatch><DOBMatchYearRadius>0</DOBMatchYearRadius></row></DOBMatchOptions><DLMask_Overload>0</DLMask_Overload><SSNMask_Overload>NONE</SSNMask_Overload></Risk_Indicators.InstantID>'));

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
  // string  _transactionid;
  // string  _batchuid;
  // string  _gcid;
  // string  lexidsourceoptout;
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
  SELF.short_description := 'test instant ID for compliance';
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
