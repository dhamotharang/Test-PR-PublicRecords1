// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'DueDiligence.DueDiligence_service';

in_rec := $.layout.request;

xml_in :=
//example: input as it appears in roxie logs
DATASET(FROMXML(in_rec, '<duediligence.duediligence_service><dobmask_overload>none</dobmask_overload><_queryid>6YFSuZqYvUHIR+kXxb7S79SrUjBxwZxU</_queryid><glbpurpose>6</glbpurpose><disallowtarguseid3220>0</disallowtarguseid3220><duediligenceattributesrequest><row><User><TestDataEnabled>0</TestDataEnabled><DLPurpose>3</DLPurpose><QueryId>6YFSuZqYvUHIR+kXxb7S79SrUjBxwZxU</QueryId><glbpurpose>6</glbpurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><excludedmvpii>1</excludedmvpii></User><Options><FBOPDOBNumberOfYearsRadius>0</FBOPDOBNumberOfYearsRadius><FBOPIncludeLexIDPrimaryDOBYear>0</FBOPIncludeLexIDPrimaryDOBYear><FBOPDateTolerance>0</FBOPDateTolerance><DisplayText>0</DisplayText><FBOPDateToleranceYearsPrior>0</FBOPDateToleranceYearsPrior><FBOPIncludeExactInputLastName>0</FBOPIncludeExactInputLastName><FBOPNameOrderSearched>0</FBOPNameOrderSearched><DDAttributesVersionRequest>DDAPERV3</DDAttributesVersionRequest><FBOPIncludeNicknames>0</FBOPIncludeNicknames><FBOPIncludeDOBYearRadius>0</FBOPIncludeDOBYearRadius></Options><ReportBy><ProductRequestType>AttributesOnly</ProductRequestType><Person><Address><Zip5>07601</Zip5><StreetAddress1>123 main street</StreetAddress1><City>city</City><State>NJ</State></Address><SSN>111111111</SSN><Name><Last>James</Last><First>John</First><Middle>A</Middle></Name><DOB><Year>1900</Year><Day>01</Day><Month>01</Month></DOB><Phone>1111111111</Phone></Person></ReportBy></row></duediligenceattributesrequest><dlmask>0</dlmask><ssnmask>NONE</ssnmask><gateways>...</gateways><_gcid>13528801</_gcid><excludedmvpii>1</excludedmvpii><_transactionid>103640330R304668</_transactionid><datarestrictionmask>0000000040000101000000000000000000000000000000000</datarestrictionmask><_timelimit>90000</_timelimit><_referencecode></_referencecode><_deliverymethod>XML</_deliverymethod><_logfunctionname>DDAttributesV3</_logfunctionname><_clientip>1.1.1.1</_clientip><usage>0000000000000007</usage><_loginid>qwerty</_loginid><industryclass>OTHER</industryclass><_espclientinterfaceversion>2.600000</_espclientinterfaceversion><_companyid>111111</_companyid><dppapurpose>3</dppapurpose><testdataenabled>0</testdataenabled><dobmask>none</dobmask><ofacversion>4</ofacversion><deathmasterpurpose>01</deathmasterpurpose><_espmethodname>DueDiligenceAttributes</_espmethodname><datapermissionmask>11000100010000000000000000000000000</datapermissionmask><ssnmask_overload>NONE</ssnmask_overload><dlmask_overload>0</dlmask_overload></duediligence.duediligence_service>')) +
DATASET(FROMXML(in_rec, '<duediligence.duediligence_service><dobmask_overload>none</dobmask_overload><_queryid>o0m2ETVp192yxeQ/H6RaF6RRXHWO2Toz</_queryid><glbpurpose>6</glbpurpose><disallowtarguseid3220>0</disallowtarguseid3220><duediligenceattributesrequest><row><User><TestDataEnabled>0</TestDataEnabled><DLPurpose>3</DLPurpose><QueryId>o0m2ETVp192yxeQ/H6RaF6RRXHWO2Toz</QueryId><glbpurpose>6</glbpurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><excludedmvpii>1</excludedmvpii></User><Options><FBOPDOBNumberOfYearsRadius>0</FBOPDOBNumberOfYearsRadius><FBOPIncludeLexIDPrimaryDOBYear>0</FBOPIncludeLexIDPrimaryDOBYear><FBOPDateTolerance>0</FBOPDateTolerance><DisplayText>0</DisplayText><FBOPDateToleranceYearsPrior>0</FBOPDateToleranceYearsPrior><FBOPIncludeExactInputLastName>0</FBOPIncludeExactInputLastName><FBOPNameOrderSearched>0</FBOPNameOrderSearched><DDAttributesVersionRequest>DDAPERV3</DDAttributesVersionRequest><FBOPIncludeNicknames>0</FBOPIncludeNicknames><FBOPIncludeDOBYearRadius>0</FBOPIncludeDOBYearRadius></Options><ReportBy><ProductRequestType>AttributesOnly</ProductRequestType><Person><Address><Zip5>16057</Zip5><StreetAddress1>123 main street</StreetAddress1><City>city</City><State>PA</State></Address><SSN>111111111</SSN><Name><Last>James</Last><First>John</First><Middle>A</Middle></Name><DOB><Year>1900</Year><Day>01</Day><Month>01</Month></DOB><Phone>1111111111</Phone></Person></ReportBy></row></duediligenceattributesrequest><dlmask>0</dlmask><ssnmask>NONE</ssnmask><gateways>...</gateways><_gcid>13528801</_gcid><excludedmvpii>1</excludedmvpii><_transactionid>103640330R305240</_transactionid><datarestrictionmask>0000000040000101000000000000000000000000000000000</datarestrictionmask><_timelimit>90000</_timelimit><_referencecode></_referencecode><_deliverymethod>XML</_deliverymethod><_logfunctionname>DDAttributesV3</_logfunctionname><_clientip>1.1.1.1</_clientip><usage>0000000000000007</usage><_loginid>qwerty</_loginid><industryclass>OTHER</industryclass><_espclientinterfaceversion>2.600000</_espclientinterfaceversion><_companyid>111111</_companyid><dppapurpose>3</dppapurpose><testdataenabled>0</testdataenabled><dobmask>none</dobmask><ofacversion>4</ofacversion><deathmasterpurpose>01</deathmasterpurpose><_espmethodname>DueDiligenceAttributes</_espmethodname><datapermissionmask>11000100010000000000000000000000000</datapermissionmask><ssnmask_overload>NONE</ssnmask_overload><dlmask_overload>0</dlmask_overload></duediligence.duediligence_service>'));

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
                 string ssn_mask, string dl_mask, string ic,
                 boolean exc_dmv = FALSE) := TRANSFORM
  SELF.glbpurpose := glb;
  SELF.dppapurpose := dppa;
  SELF.datapermissionmask := dpm;
  SELF.datarestrictionmask := drm;
  SELF.dlmask := dl_mask;
  SELF.ssnmask := ssn_mask;
  SELF.industryclass := ic;

  ds_embedded := PROJECT(L.duediligenceattributesrequest,
                     TRANSFORM($.layout.esdl_request,
                       SELF.User.glbpurpose := glb,
                       SELF.User.DLPurpose := dppa,
                       SELF.User.datapermissionmask := dpm,
                       SELF.User.datarestrictionmask := drm,
                       SELF.User.excludedmvpii := exc_dmv,
                       // SELF.User.LnBranded
                       SELF := LEFT));

  SELF.duediligenceattributesrequest := ds_embedded;

  SELF := L;
END;

ds_1 := PROJECT(ds_in, SetValues(LEFT, '1', '1', '11111111111111111111111111111111111111111111', '00000000000000000000000000000000000000000000', 'first5', '', ''));
ds_2 := PROJECT(ds_in, SetValues(LEFT, '2', '7', '00000000000000000000000000000000000000000000', '11111111111111111111111111111111111111111111', '', '', 'CNSMR', TRUE));
ds_3 := PROJECT(ds_in, SetValues(LEFT, '0', '0', '11111111111111111111111111111111111111111111', '00000000000000000000000000000000000000000000', '', 'true', 'UTILI'));
xml_recs := ds_in + ds_1 + ds_2 + ds_3;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'test DueDiligence for compliance';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(xml_recs, toTestCase(LEFT));

// OUTPUT(ds_in, NAMED('ds_in'));
// OUTPUT(xml_recs, NAMED('xml_recs'));
// OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');
