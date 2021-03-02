// Use it as an example, modify as you wish
IMPORT dev_regression, STD;

my_query := 'lnsmallbusiness.smallbusiness_bip_service';

in_rec := $.layout.request;
//sample, with sensitive info masked
xml_in :=
DATASET(FROMXML(in_rec, '<lnsmallbusiness.smallbusiness_bip_service><dobmask_overload>day</dobmask_overload><_queryid></_queryid><glbpurpose>1</glbpurpose><dlmask>1</dlmask><ssnmask>LAST4</ssnmask><_transactionid>111111</_transactionid><datarestrictionmask>0000000010000101000000000000000000000000</datarestrictionmask><_timelimit>110000</_timelimit><_referencecode></_referencecode><_deliverymethod>XML</_deliverymethod><_logfunctionname>SmllBusAnalytics</_logfunctionname><usage>0011000000050000</usage><smallbusinessanalyticsrequest><row><User><ExcludeDMVPII>0</ExcludeDMVPII><DLPurpose>0</DLPurpose><NonSubjectSuppression>0</NonSubjectSuppression><glbpurpose>1</glbpurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><TestDataEnabled>0</TestDataEnabled></User><Options><AttributesVersion><Name>SmallBusinessAttrV1</Name></AttributesVersion></Options><SearchBy><Company><Address><State>CA</State><Zip5>11111</Zip5><StreetAddress1>123 main st</StreetAddress1><City>city</City><StreetAddress2>123 main st</StreetAddress2></Address><AlternateCompanyName>cname</AlternateCompanyName><FEIN>111111111</FEIN><CompanyName>cname</CompanyName><Phone>2222222222</Phone></Company><AuthorizedRep1><Address><StreetAddress1>123 main st</StreetAddress1><City>city</City><State>CA</State></Address><Name><Last>johns</Last><First>john</First></Name><SSN>111111111</SSN><Phone>2222222222</Phone></AuthorizedRep1></SearchBy></row></smallbusinessanalyticsrequest><_clientip>1.1.1.1</_clientip><_loginid>qwerty</_loginid><industryclass>OTHER</industryclass><_espclientinterfaceversion>1.720000</_espclientinterfaceversion><_companyid>0000000</_companyid><bpsreportmigrationmode>3</bpsreportmigrationmode><dppapurpose>0</dppapurpose><testdataenabled>0</testdataenabled><dobmask>day</dobmask><_espmethodname>SmallBusinessAnalytics</_espmethodname><datapermissionmask>110001000000000000000000000000</datapermissionmask><ssnmask_overload>LAST4</ssnmask_overload><dlmask_overload>1</dlmask_overload></lnsmallbusiness.smallbusiness_bip_service>')) +
DATASET(FROMXML(in_rec, '<lnsmallbusiness.smallbusiness_bip_service><dobmask_overload>day</dobmask_overload><_queryid></_queryid><glbpurpose>1</glbpurpose><dlmask>1</dlmask><ssnmask>LAST4</ssnmask><_transactionid>111111</_transactionid><datarestrictionmask>0000000010000101000000000000000000000000</datarestrictionmask><_timelimit>110000</_timelimit><_referencecode></_referencecode><_deliverymethod>XML</_deliverymethod><_logfunctionname>SmllBusAnalytics</_logfunctionname><usage>0011000000050000</usage><smallbusinessanalyticsrequest><row><User><ExcludeDMVPII>0</ExcludeDMVPII><DLPurpose>0</DLPurpose><NonSubjectSuppression>0</NonSubjectSuppression><glbpurpose>1</glbpurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><TestDataEnabled>0</TestDataEnabled></User><Options><AttributesVersion><Name>SmallBusinessAttrV1</Name></AttributesVersion></Options><SearchBy><Company><Address><State>PA</State><Zip5>11111</Zip5><StreetAddress1>123 main st</StreetAddress1><City>city</City><StreetAddress2>123 main st</StreetAddress2></Address><AlternateCompanyName>cname</AlternateCompanyName><FEIN>111111111</FEIN><CompanyName>cname</CompanyName><Phone>2222222222</Phone></Company><AuthorizedRep1><Address><StreetAddress1>123 main st</StreetAddress1><City>city</City><State>PA</State></Address><Name><Last>johns</Last><First>john</First></Name><SSN>111111111</SSN><Phone>2222222222</Phone></AuthorizedRep1></SearchBy></row></smallbusinessanalyticsrequest><_clientip>1.1.1.1</_clientip><_loginid>qwerty</_loginid><industryclass>OTHER</industryclass><_espclientinterfaceversion>1.720000</_espclientinterfaceversion><_companyid>0000000</_companyid><bpsreportmigrationmode>3</bpsreportmigrationmode><dppapurpose>0</dppapurpose><testdataenabled>0</testdataenabled><dobmask>day</dobmask><_espmethodname>SmallBusinessAnalytics</_espmethodname><datapermissionmask>110001000000000000000000000000</datapermissionmask><ssnmask_overload>LAST4</ssnmask_overload><dlmask_overload>1</dlmask_overload></lnsmallbusiness.smallbusiness_bip_service>'));


// fix the input (remove unnecessary duplicates, ensure not passing blanks in some fields, etc.)
in_rec FixInput(in_rec L) := TRANSFORM
  // drop all customer's info
  SELF.smallbusinessanalyticsrequest.User := ROW(dev_regression.utils.CleanUser(L.smallbusinessanalyticsrequest.User));
  SELF := L;
END;
ds_in := PROJECT(DEDUP(xml_in, RECORD, ALL), FixInput(LEFT));

// to produce variations of the input
in_rec SetValues(in_rec L, string glb, string dppa, string dpm, string drm,
                 string ssn_mask, string dl_mask, string dob_mask, string ic,
                 boolean exc_dmv = FALSE) := TRANSFORM
  SELF.glbpurpose := glb;
  SELF.dppapurpose := dppa;
  SELF.datapermissionmask := dpm;
  SELF.datarestrictionmask := drm;
  SELF.dlmask := dl_mask;
  SELF.ssnmask := ssn_mask;
  SELF.industryclass := ic;

  ds_embedded := PROJECT(L.smallbusinessanalyticsrequest,
                     TRANSFORM($.layout.esdl_request,
                       SELF.User.GLBPurpose := glb,
                       SELF.User.DLPurpose := dppa,
                       SELF.User.IndustryClass := ic;
                       SELF.User.SSNMask := ssn_mask;
                      //  SELF.User.DOBMask :=
                       SELF.User.ExcludeDMVPII := exc_dmv;
                       SELF.User.DLMask := dl_mask = '1';
                       SELF.User.DataPermissionMask := dpm;
                       SELF.User.DataRestrictionMask := drm;
                      //  SELF.User.ApplicationType :=
                      //  SELF.User.SSNMaskingOn :=
                      //  SELF.User.DLMaskingOn :=
                      //  SELF.User.LnBranded :=
                      //  SELF.User.DeathMasterPurpose :=
                      //  SELF.User.ResellerType:=
                       SELF := LEFT));

  SELF.smallbusinessanalyticsrequest := ds_embedded;

  SELF := L;
END;

// create vaariations of compliance values
string zeroes := '00000000000000000000000000000000000000000000';
string ones := '11111111111111111111111111111111111111111111';
ds_1 := PROJECT(ds_in, SetValues(LEFT, '1', '1', ones, zeroes,       '',  '',     '',      ''      ));
ds_2 := PROJECT(ds_in, SetValues(LEFT, '2', '7', zeroes, ones,       '',  '',     '', 'CNSMR', TRUE));
ds_3 := PROJECT(ds_in, SetValues(LEFT, '0', '0', ones, zeroes,       '',  '', 'year', 'UTILI'      ));
ds_4 := PROJECT(ds_in, SetValues(LEFT, '1', '1', ones, zeroes, 'first5', '1', 'year',      '', TRUE));
ds_variations := ds_in + ds_1 + ds_2 + ds_3 + ds_4;

dev_regression.layouts.testcase toTestCase(in_rec L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_variations := PROJECT(ds_variations, toTestCase(LEFT));


//blank all compliance values to test the defaults
ds_default := PROJECT(ds_in, $.layout.request_defaults);

dev_regression.layouts.testcase toTestCaseDefaults($.layout.request_defaults L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance: defaults';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_def := PROJECT(ds_default, toTestCaseDefaults(LEFT));


//combine variations and defaults
testcases := testcases_variations + testcases_def;

OUTPUT(ds_in, NAMED('ds_in'));
OUTPUT(ds_variations, NAMED('ds_variations'));
OUTPUT(ds_default, NAMED('ds_default'));
dev_regression.bucket().add(testcases, 'compliance regression');
