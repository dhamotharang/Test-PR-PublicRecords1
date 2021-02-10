// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'businessinstantid20_services.instantid20_service';

in_rec := $.layout.request;

xml_in :=
//example: input as it appears in roxie logs
DATASET(FROMXML(in_rec, '<businessinstantid20_services.instantid20_service><dobmask_overload>none</dobmask_overload><_queryid></_queryid><glbpurpose>5</glbpurpose><disallowtarguseid3220>0</disallowtarguseid3220><dlmask>0</dlmask><ssnmask>NONE</ssnmask><gateways><row><servicename>targus</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.70</url></row><row><servicename>netacuity</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.93</url></row><row><servicename>gbgroup</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.70</url></row><row><servicename>gg2verification</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=1.78</url></row><row><servicename>gdcverify</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway?ver_=1.78</url></row><row><servicename>insurancephoneheader</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=1.87</url></row><row><servicename>searchcore</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.93</url></row><row><servicename>bridgerxg5</servicename><url>HTTP://bridger_api_esp:S34rchc0r34p!@bctnpbrgprdesponline.risk.regn.net:12510/WsSearchCore?ver_=1</url></row><row><servicename>bridgerwlc</servicename><url>HTTPS://bridger_api_esp:S34rchc0r34p!@watchlistprodonline.risk.regn.net:12522/WsSearchCore?ver_=1.0</url></row><row><servicename>delta_inquiry</servicename><url>HTTPS://delta_iid_api_user:2rch%40p1$$@10.176.69.151:8909/WsDeltaBase</url></row><row><servicename>threatmetrix</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=2.28</url></row><row><servicename>idareport</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=2.84</url></row></gateways><_gcid>11400281</_gcid><excludedmvpii>1</excludedmvpii><_transactionid>103640340R301801</_transactionid><datarestrictionmask>000000004000010000000000000000000000000000000</datarestrictionmask><_timelimit>10000</_timelimit><_referencecode>451583 - 10704354985</_referencecode><_deliverymethod>XML</_deliverymethod><_logfunctionname>BusInsID2</_logfunctionname><_clientip>111.111.111.111</_clientip><usage>0000000000050000</usage><_loginid>...</_loginid><industryclass>OTHER</industryclass><_espclientinterfaceversion>2.090000</_espclientinterfaceversion><_companyid>111111</_companyid><dppapurpose>3</dppapurpose><testdataenabled>0</testdataenabled><dobmask>none</dobmask><_espmethodname>BusinessInstantID2</_espmethodname><businessinstantid20request><row><User><OutcomeTrackingOptOut>0</OutcomeTrackingOptOut><DLMaskingOn>0</DLMaskingOn><SSNMaskingOn>0</SSNMaskingOn><glbpurpose>5</glbpurpose><LnBranded>0</LnBranded><EndUser><CompanyName>aaaaaa</CompanyName></EndUser><DLMask>0</DLMask><NonSubjectSuppression>0</NonSubjectSuppression><excludedmvpii>1</excludedmvpii><TestDataEnabled>0</TestDataEnabled><DLPurpose>3</DLPurpose><DebitUnits>0</DebitUnits><ReferenceCode>451583 - 10704354985</ReferenceCode><ArchiveOptIn>0</ArchiveOptIn><MaxWaitSeconds>10</MaxWaitSeconds><AllowRoamingBypass>0</AllowRoamingBypass></User><Options><MarketingMode>0</MarketingMode><IncludeAllRiskIndicators>0</IncludeAllRiskIndicators><OutcomeTrackingOptOut>0</OutcomeTrackingOptOut><EnableEmergingID>0</EnableEmergingID><HistoryDate>0</HistoryDate><LinkSearchLevel>0</LinkSearchLevel><OverRideExperianRestriction>0</OverRideExperianRestriction><DLMask>0</DLMask><ExactFirstNameMatch>0</ExactFirstNameMatch><ExactSSNMatch>0</ExactSSNMatch><ExactDriverLicenseMatch>0</ExactDriverLicenseMatch><ExactFirstNameMatchAllowNicknames>0</ExactFirstNameMatchAllowNicknames><ExactPhoneMatch>0</ExactPhoneMatch><LastSeenThreshold>365</LastSeenThreshold><PoBoxCompliance>0</PoBoxCompliance><IIDVersionOverride>0</IIDVersionOverride><IncludeDriverLicenseInCVI>1</IncludeDriverLicenseInCVI><ExactLastNameMatch>0</ExactLastNameMatch><BIPBestAppend>0</BIPBestAppend><NameInputOrder>null</NameInputOrder><OFACOnly>0</OFACOnly><Encrypt>0</Encrypt><BusShellVersion>0</BusShellVersion><DOBRadius>2</DOBRadius><IncludeDLVerification>1</IncludeDLVerification><Blind>0</Blind><DisableCustomerNetworkOptionInCVI>0</DisableCustomerNetworkOptionInCVI><IncludeTargusE3220>0</IncludeTargusE3220><ExactDOBMatch>1</ExactDOBMatch><BIID20ProductType>1</BIID20ProductType><IncludeDPBC>0</IncludeDPBC><ExactAddrMatch>1</ExactAddrMatch><TestDataEnabled>0</TestDataEnabled><IncludeCLOverride>0</IncludeCLOverride><IncludeDOBInCVI>1</IncludeDOBInCVI><IncludeMIOverride>0</IncludeMIOverride><UseDOBFilter>0</UseDOBFilter><IncludeOFAC>1</IncludeOFAC><OFACVersion>0</OFACVersion><IncludeAdditionalWatchlists>0</IncludeAdditionalWatchlists><IncludeMSOverride>0</IncludeMSOverride><DOBMatchOptions><DOBMatchOption><MatchYearRadius>0</MatchYearRadius><MatchType>ExactCCYYMMDD</MatchType></DOBMatchOption></DOBMatchOptions><ExcludeWatchLists>0</ExcludeWatchLists></Options><SearchBy><Company><Address><Zip5>11111</Zip5><StreetAddress1>123 Main St.</StreetAddress1><City>City</City><State>NY</State></Address><FEIN>1111111111</FEIN><CompanyName>Company Name</CompanyName><Phone>222222222</Phone></Company></SearchBy></row></businessinstantid20request><datapermissionmask>11000100000000000000000000010000000</datapermissionmask><ssnmask_overload>NONE</ssnmask_overload><dlmask_overload>0</dlmask_overload></businessinstantid20_services.instantid20_service>')) +
DATASET(FROMXML(in_rec, '<businessinstantid20_services.instantid20_service><dobmask_overload>NONE</dobmask_overload><outcometrackingoptout>1</outcometrackingoptout><_queryid></_queryid><glbpurpose>2</glbpurpose><disallowtarguseid3220>1</disallowtarguseid3220><dlmask>0</dlmask><ssnmask>NONE</ssnmask><gateways><row><servicename>targus</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.70</url></row><row><servicename>netacuity</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.93</url></row><row><servicename>gbgroup</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.70</url></row><row><servicename>gg2verification</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=1.78</url></row><row><servicename>gdcverify</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway?ver_=1.78</url></row><row><servicename>insurancephoneheader</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=1.87</url></row><row><servicename>searchcore</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGateway/?ver_=1.93</url></row><row><servicename>bridgerxg5</servicename><url>HTTP://bridger_api_esp:S34rchc0r34p!@bctnpbrgprdesponline.risk.regn.net:12510/WsSearchCore?ver_=1</url></row><row><servicename>bridgerwlc</servicename><url>HTTPS://bridger_api_esp:S34rchc0r34p!@watchlistprodonline.risk.regn.net:12522/WsSearchCore?ver_=1.0</url></row><row><servicename>delta_inquiry</servicename><url>HTTPS://delta_iid_api_user:2rch%40p1$$@10.176.69.151:8909/WsDeltaBase</url></row><row><servicename>threatmetrix</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=2.28</url></row><row><servicename>idareport</servicename><url>HTTPS://api_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx/?ver_=2.84</url></row></gateways><_gcid>8234401</_gcid><excludedmvpii>1</excludedmvpii><_transactionid>103640300R269742</_transactionid><datarestrictionmask>0000000020000101000000000000000000000000</datarestrictionmask><_timelimit>50000</_timelimit><_referencecode></_referencecode><_deliverymethod>XML</_deliverymethod><_logfunctionname>BusInsID2Com</_logfunctionname><_clientip>111.111.111.111</_clientip><usage>0100000000000000</usage><_loginid>...</_loginid><industryclass>OTHER</industryclass><_espclientinterfaceversion>2.090000</_espclientinterfaceversion><_companyid>111111</_companyid><dppapurpose>2</dppapurpose><testdataenabled>0</testdataenabled><dobmask>NONE</dobmask><ofacversion>2</ofacversion><deathmasterpurpose>11</deathmasterpurpose><_espmethodname>BusinessInstantID2</_espmethodname><businessinstantid20request><row><User><TestDataEnabled>0</TestDataEnabled><DLPurpose>2</DLPurpose><NonSubjectSuppression>0</NonSubjectSuppression><glbpurpose>2</glbpurpose><LnBranded>0</LnBranded><MaxWaitSeconds>0</MaxWaitSeconds><excludedmvpii>1</excludedmvpii></User><Options><NameInputOrder>Unknown</NameInputOrder><IncludeDPBC>0</IncludeDPBC><DOBRadius>0</DOBRadius><ExactFirstNameMatch>0</ExactFirstNameMatch><IncludeDLVerification>0</IncludeDLVerification><ExactDOBMatch>0</ExactDOBMatch><ExactSSNMatch>1</ExactSSNMatch><BIID20ProductType>2</BIID20ProductType><ExactDriverLicenseMatch>0</ExactDriverLicenseMatch><IncludeOFAC>0</IncludeOFAC><ExactAddrMatch>0</ExactAddrMatch><IncludeCLOverride>0</IncludeCLOverride><IncludeDOBInCVI>1</IncludeDOBInCVI><IncludeMIOverride>0</IncludeMIOverride><UseDOBFilter>0</UseDOBFilter><ExactFirstNameMatchAllowNicknames>0</ExactFirstNameMatchAllowNicknames><ExactPhoneMatch>0</ExactPhoneMatch><IncludeAdditionalWatchlists>0</IncludeAdditionalWatchlists><IncludeMSOverride>0</IncludeMSOverride><PoBoxCompliance>0</PoBoxCompliance><IncludeDriverLicenseInCVI>0</IncludeDriverLicenseInCVI><ExactLastNameMatch>0</ExactLastNameMatch><DOBMatchOptions><DOBMatchOption><MatchYearRadius>0</MatchYearRadius><MatchType>FuzzyCCYYMMDD</MatchType></DOBMatchOption></DOBMatchOptions><ExcludeWatchLists>1</ExcludeWatchLists></Options><SearchBy><Company><Address><StreetAddress2>null null</StreetAddress2><Zip5>11111</Zip5><StreetAddress1>123 Main St</StreetAddress1><City>City</City><State>TX</State></Address><FEIN>11111111111</FEIN><CompanyName>Company Name</CompanyName><Phone>22222222222</Phone></Company><AuthorizedRep1><Address><Zip5>11111</Zip5><StreetAddress1>123 Main St</StreetAddress1><City>City</City><State>TX</State></Address><Name><Last>John</Last><First>Smith</First></Name><SSN>11111111111</SSN><DOB><Year>1900</Year><Day>10</Day><Month>10</Month></DOB></AuthorizedRep1></SearchBy></row></businessinstantid20request><datapermissionmask>110001000100000000000000000000</datapermissionmask><ssnmask_overload>NONE</ssnmask_overload><dlmask_overload>0</dlmask_overload></businessinstantid20_services.instantid20_service>'));

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
                 boolean exc_dmv = FALSE,
                 unsigned1 marketng = 0) := TRANSFORM
  SELF.glbpurpose := glb;
  SELF.dppapurpose := dppa;
  SELF.datapermissionmask := dpm;
  SELF.datarestrictionmask := drm;
  SELF.dlmask := dl_mask;
  SELF.ssnmask := ssn_mask;
  SELF.industryclass := ic;

  ds_embedded := PROJECT(L.businessinstantid20request,
                     TRANSFORM($.layout.esdl_request,
                       SELF.User.glbpurpose := glb,
                       SELF.User.DLPurpose := dppa,
                       SELF.User.datapermissionmask := dpm,
                       SELF.User.datarestrictionmask := drm,
                       SELF.User.excludedmvpii := exc_dmv,
                       // SELF.User.LnBranded
                       SELF := LEFT));

  SELF.businessinstantid20request := ds_embedded;

  SELF := L;
END;

//variate first 10 recrds w.r.t. compliance values
ds_10 := CHOOSEN(ds_in, 10);

mask_zero := '00000000000000000000000000000000000000000000';
mask_ones := '11111111111111111111111111111111111111111111';

ds_1 := PROJECT(ds_10, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '', '', ''));
ds_2 := PROJECT(ds_10, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '', '', 'UTILI'));
ds_3 := PROJECT(ds_10, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '', '', '', TRUE, 1));
ds_4 := PROJECT(ds_10, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '', '', ''));
xml_recs := ds_in + ds_1 + ds_2 + ds_3 + ds_4;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance check';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(xml_recs, toTestCase(LEFT));

// OUTPUT(ds_in, NAMED('ds_in'));
// OUTPUT(xml_recs, NAMED('xml_recs'));
// OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');
