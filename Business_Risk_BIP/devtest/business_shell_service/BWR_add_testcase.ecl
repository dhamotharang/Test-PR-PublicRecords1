// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'business_risk_bip.business_shell_service';

in_rec := $.layout.request;

//pattern for adding new test cases: this is exactly how they appear in Roxie logs
xml_in :=
DATASET(FROMXML(in_rec, '<business_risk_bip.business_shell_service><companyurl></companyurl><rep_city>city</rep_city><rep_zip></rep_zip><rep_addr_suffix></rep_addr_suffix><rep_lexid>0</rep_lexid><marketingmode>0</marketingmode><rep_zip5></rep_zip5><rep_zip4></rep_zip4><sic_code></sic_code><powid>0</powid><overrideexperianrestriction>true</overrideexperianrestriction><corteraretrotest>false</corteraretrotest><rep_predir></rep_predir><data_restriction_mask>0000000000000000000000000</data_restriction_mask><rep_addr_status></rep_addr_status><state>CA</state><predir></predir><sec_range></sec_range><rep_streetaddress1>123 main st</rep_streetaddress1><rep_streetaddress2></rep_streetaddress2><streetaddress1>456 main st</streetaddress1><rep_sec_range></rep_sec_range><rep_dateofbirth></rep_dateofbirth><streetaddress2></streetaddress2><glba_purpose>1</glba_purpose><bipbestappend>0</bipbestappend><encode_>0</encode_><allowedsources></allowedsources><phone10>2222222222</phone10><addr_status></addr_status><lat></lat><companyname>company</companyname><rep_county></rep_county><prim_range></prim_range><rep_fullname></rep_fullname><rep_postdir></rep_postdir><corteraretrotestrecords></corteraretrotestrecords><rep_age></rep_age><zip9>11111</zip9><county></county><zip5></zip5><zip4></zip4><rep_geo_block></rep_geo_block><ultid>0</ultid><rep_dlnumber></rep_dlnumber><includeauthrepinbipappend>true</includeauthrepinbipappend><acctno>159799433R9327</acctno><historydate>20191216</historydate><rep_middlename></rep_middlename><linksearchlevel>0</linksearchlevel><proxid>0</proxid><prim_name></prim_name><rep_email></rep_email><rep_long></rep_long><geo_block></geo_block><altcompanyname>company</altcompanyname><rep_firstname>John</rep_firstname><seq>0</seq><city>city</city><rep_nametitle></rep_nametitle><rep_ssn>111111111</rep_ssn><fein>333333333</fein><dppa_purpose>3</dppa_purpose><data_permission_mask>00000000000100000000</data_permission_mask><orgid>0</orgid><busshellversion>31</busshellversion><rep_namesuffix></rep_namesuffix><addr_suffix></addr_suffix><unit_desig></unit_desig><rep_lat></rep_lat><long></long><postdir></postdir><ipaddr></ipaddr><rep_lastname>James</rep_lastname><rep_state>CA</rep_state><rep_phone10>2222222222</rep_phone10><seleid>0</seleid><rep_unit_desig></rep_unit_desig><addr_type></addr_type><useupdatedbipappend>false</useupdatedbipappend><rep_addr_type></rep_addr_type><rep_prim_range></rep_prim_range><rep_dlstate></rep_dlstate><naic_code></naic_code><rep_formerlastname></rep_formerlastname><rep_prim_name></rep_prim_name></business_risk_bip.business_shell_service>')) +
DATASET(FROMXML(in_rec, '<business_risk_bip.business_shell_service><companyurl></companyurl><rep_city>city</rep_city><rep_zip></rep_zip><rep_addr_suffix></rep_addr_suffix><rep_lexid>0</rep_lexid><marketingmode>0</marketingmode><rep_zip5></rep_zip5><rep_zip4></rep_zip4><sic_code></sic_code><powid>0</powid><overrideexperianrestriction>true</overrideexperianrestriction><corteraretrotest>false</corteraretrotest><rep_predir></rep_predir><data_restriction_mask>0000000000000000000000000</data_restriction_mask><rep_addr_status></rep_addr_status><state>GA</state><predir></predir><sec_range></sec_range><rep_streetaddress1>123 main st</rep_streetaddress1><rep_streetaddress2></rep_streetaddress2><streetaddress1>456 main st</streetaddress1><rep_sec_range></rep_sec_range><rep_dateofbirth></rep_dateofbirth><streetaddress2></streetaddress2><glba_purpose>1</glba_purpose><bipbestappend>0</bipbestappend><encode_>0</encode_><allowedsources></allowedsources><phone10>2222222222</phone10><addr_status></addr_status><lat></lat><companyname>company</companyname><rep_county></rep_county><prim_range></prim_range><rep_fullname></rep_fullname><rep_postdir></rep_postdir><corteraretrotestrecords></corteraretrotestrecords><rep_age></rep_age><zip9>11111</zip9><county></county><zip5></zip5><zip4></zip4><rep_geo_block></rep_geo_block><ultid>0</ultid><rep_dlnumber></rep_dlnumber><includeauthrepinbipappend>true</includeauthrepinbipappend><acctno>159815293R1372</acctno><historydate>20191214</historydate><rep_middlename></rep_middlename><linksearchlevel>0</linksearchlevel><proxid>0</proxid><prim_name></prim_name><rep_email></rep_email><rep_long></rep_long><geo_block></geo_block><altcompanyname>company</altcompanyname><rep_firstname>John</rep_firstname><seq>0</seq><city>city</city><rep_nametitle></rep_nametitle><rep_ssn>111111111</rep_ssn><fein>333333333</fein><dppa_purpose>3</dppa_purpose><data_permission_mask>00000000000100000000</data_permission_mask><orgid>0</orgid><busshellversion>31</busshellversion><rep_namesuffix></rep_namesuffix><addr_suffix></addr_suffix><unit_desig></unit_desig><rep_lat></rep_lat><long></long><postdir></postdir><ipaddr></ipaddr><rep_lastname>James</rep_lastname><rep_state>GA</rep_state><rep_phone10>2222222222</rep_phone10><seleid>0</seleid><rep_unit_desig></rep_unit_desig><addr_type></addr_type><useupdatedbipappend>false</useupdatedbipappend><rep_addr_type></rep_addr_type><rep_prim_range></rep_prim_range><rep_dlstate></rep_dlstate><naic_code></naic_code><rep_formerlastname></rep_formerlastname><rep_prim_name></rep_prim_name></business_risk_bip.business_shell_service>'));

// fix the input (remove unnecessary duplicates, ensure not passing blanks in some fields, etc.)
in_rec FixInput(in_rec L) := TRANSFORM
  // SELF.skiprecords := '';
  // SELF.maxresults := IF(L.maxresults != '', L.maxresults, (string)MaxResults_val);
  // SELF.maxresultsthistime := IF(L.maxresultsthistime != '', L.maxresultsthistime, (string)MaxResultsThisTime_val);
  SELF := L;
END;
ds_in := PROJECT(DEDUP(xml_in, RECORD, ALL), FixInput(LEFT));

// to produce variations of the input
in_rec SetValues(in_rec L, unsigned1 glb, unsigned1 dppa, string dpm, string drm,
                 string ssn_mask, string dl_mask, string ic,
                 unsigned1 marketng = 0) := TRANSFORM
	SELF.glba_purpose := glb;
	SELF.dppa_purpose :=dppa;
	SELF.data_permission_mask := dpm;
	SELF.data_restriction_mask := drm;
  SELF.industryclass := ic;
  SELF.marketingmode := marketng;
  SELF := L;
END;

mask_zero := '00000000000000000000000000000000000000000000';
mask_ones := '11111111111111111111111111111111111111111111';
ds_1 := PROJECT(ds_in, SetValues(LEFT, 1, 1, mask_ones, mask_zero, 'first5', '', ''));
ds_2 := PROJECT(ds_in, SetValues(LEFT, 1, 1, mask_ones, mask_zero, 'first5', '', '', 1));
ds_3 := PROJECT(ds_in, SetValues(LEFT, 0, 0, mask_zero, mask_ones, '', '', 'UTILI'));
ds_4 := PROJECT(ds_in, SetValues(LEFT, 2, 7, mask_zero, mask_zero, '', '', 'CNSMR'));
xml_recs := ds_in + ds_1 + ds_2 + ds_3 + ds_4;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'test business-shell-service for compliance';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(xml_recs, toTestCase(LEFT));

// OUTPUT(xml_in, NAMED('xml_in'));
// OUTPUT(ds_in, NAMED('ds_in'));
// OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');
