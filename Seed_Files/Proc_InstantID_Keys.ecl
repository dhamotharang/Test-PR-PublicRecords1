import roxiekeybuild,seed_files;

export Proc_InstantID_Keys(string filedate) := 
function


roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_InstantID,'abc','~thor_data400::key::testseed::'+filedate+'::instantid',a);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_BInstantID,'abc','~thor_data400::key::testseed::'+filedate+'::binstantid',b);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_CBD,'abc','~thor_data400::key::testseed::'+filedate+'::cbd',c);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_CBDAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::cbdattributes',ca);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_BusinessDefender,'abc','~thor_data400::key::testseed::'+filedate+'::businessdefender',aa);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_frauddefender,'abc','~thor_data400::key::testseed::'+filedate+'::frauddefender',bb);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_redflags,'abc','~thor_data400::key::testseed::'+filedate+'::redflags',cc);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IntlIID,'abc','~thor_data400::key::testseed::'+filedate+'::intliid',d);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_LNSmallBusiness,'abc','~thor_data400::key::testseed::'+filedate+'::lnsmallbusiness',e);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_BS_Services,'abc','~thor_data400::key::testseed::'+filedate+'::bs_services_iid_address_history',f);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_Identifier2,'abc','~thor_data400::key::testseed::'+filedate+'::identifier2',g);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_FOVInteractive,'abc','~thor_data400::key::testseed::'+filedate+'::FOV_Interactive',h);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_FOVRenewal,'abc','~thor_data400::key::testseed::'+filedate+'::FOV_Renewal',i);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_identityreport,'abc','~thor_data400::key::testseed::'+filedate+'::identityreport',j);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_FlexID,'abc','~thor_data400::key::testseed::'+filedate+'::flexid',k);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_LeadIntegrityAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::leadintegrityattributes',l);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_Boca_Shell(),'abc','~thor_data400::key::testseed::'+filedate+'::boca_shell',m);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_Boca_Shell4(),'abc','~thor_data400::key::testseed::'+filedate+'::boca_shell4',n);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_HealthCareAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::healthcareattributes',hc);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_AMLRiskAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::amlriskattributes',amlr);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_AMLRiskAttributesBusn,'abc','~thor_data400::key::testseed::'+filedate+'::amlriskattributesbusn',amlrb);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_AMLRiskAttributesV2,'abc','~thor_data400::key::testseed::'+filedate+'::amlriskattributesV2',amlrv2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_AMLRiskAttributesBusnV2,'abc','~thor_data400::key::testseed::'+filedate+'::amlriskattributesbusnV2',amlrbv2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_Address,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_address',idfa);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_Combination,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_combination',idfc);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_Email,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_email',idfe);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_IPAddress,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_ipaddress',idfi);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_Name,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_name',idfn);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_Phone,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_phone',idfp);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IdentityFraudNetwork_SSN,'abc','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_ssn',idfs);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_VerificationOfOccupancy,'abc','~thor_data400::key::testseed::'+filedate+'::verificationofoccupancy',vo);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_IntlIID_GG2,'abc','~thor_data400::key::testseed::'+filedate+'::intliid_gg2',intlgg);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_ProfileBooster,'abc','~thor_data400::key::testseed::'+filedate+'::profilebooster',prbo);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_SmallBusinessAnalytics,'abc','~thor_data400::key::testseed::'+filedate+'::smallbusinessanalytics',sba);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_SmallBusFinancialExchange,'abc','~thor_data400::key::testseed::'+filedate+'::smallbusfinancialexchange',sbfe);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_SmallBusModels,'abc','~thor_data400::key::testseed::'+filedate+'::smallbusmodels',sbm);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_OS,'abc','~thor_data400::key::testseed::'+filedate+'::os',osm);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_OSAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::OSAttributes',osattributesm);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.BIID20_keys.BIID20keypart1,'abc','~thor_data400::key::testseed::'+filedate+'::Part1::BIID_V2',biid20Pt1);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.BIID20_keys.BIID20keypart2,'abc','~thor_data400::key::testseed::'+filedate+'::Part2::BIID_V2',biid20Pt2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.BIID20_keys.BIID20keypart3,'abc','~thor_data400::key::testseed::'+filedate+'::Part3::BIID_V2',biid20Pt3);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_SmallBusinessAnalyticsV20,'abc','~thor_data400::key::testseed::'+filedate+'::smallbusinessanalyticsv20',sba20);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.Summary,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::Summary',vor1);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.TargetSummary,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::TargetSummary',vor2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.Sources,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::Sources',vor3);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.OwnedProperties,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::OwnedProperties',vor4);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.OwnedPropertiesAsOf,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::OwnedPropertiesAsOf',vor5);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.PhoneAndUtility,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::PhoneAndUtility',vor6);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.VerificationOfOccupancy_Report_keys.AssociatedIdentities,'abc','~thor_data400::key::testseed::'+filedate+'::VOOreport::AssociatedIdentities',vor7);




roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::instantid','~thor_data400::key::testseed::'+filedate+'::instantid',a1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::binstantid','~thor_data400::key::testseed::'+filedate+'::binstantid',b1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::cbd','~thor_data400::key::testseed::'+filedate+'::cbd',c1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::cbdattributes','~thor_data400::key::testseed::'+filedate+'::cbdattributes',ca1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::businessdefender','~thor_data400::key::testseed::'+filedate+'::businessdefender',aa1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::frauddefender','~thor_data400::key::testseed::'+filedate+'::frauddefender',bb1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::redflags','~thor_data400::key::testseed::'+filedate+'::redflags',cc1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::intliid','~thor_data400::key::testseed::'+filedate+'::intliid',d1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::lnsmallbusiness','~thor_data400::key::testseed::'+filedate+'::lnsmallbusiness',e1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::bs_services_iid_address_history','~thor_data400::key::testseed::'+filedate+'::bs_services_iid_address_history',f1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identifier2','~thor_data400::key::testseed::'+filedate+'::identifier2',g1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::FOV_Interactive','~thor_data400::key::testseed::'+filedate+'::FOV_Interactive',h1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::FOV_Renewal','~thor_data400::key::testseed::'+filedate+'::FOV_Renewal',i1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityreport','~thor_data400::key::testseed::'+filedate+'::identityreport',j1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::flexid','~thor_data400::key::testseed::'+filedate+'::flexid',k1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::leadintegrityattributes','~thor_data400::key::testseed::'+filedate+'::leadintegrityattributes',l1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::boca_shell','~thor_data400::key::testseed::'+filedate+'::boca_shell',m1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::boca_shell4','~thor_data400::key::testseed::'+filedate+'::boca_shell4',n1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::healthcareattributes','~thor_data400::key::testseed::'+filedate+'::healthcareattributes',hcbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::amlriskattributes','~thor_data400::key::testseed::'+filedate+'::amlriskattributes',amlrbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::amlriskattributesbusn','~thor_data400::key::testseed::'+filedate+'::amlriskattributesbusn',amlrbbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::amlriskattributesV2','~thor_data400::key::testseed::'+filedate+'::amlriskattributesV2',amlrbuiltv2);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::amlriskattributesbusnV2','~thor_data400::key::testseed::'+filedate+'::amlriskattributesbusnV2',amlrbbuiltv2);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_address','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_address',idfabuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_combination','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_combination',idfcbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_email','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_email',idfebuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_ipaddress','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_ipaddress',idfibuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_name','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_name',idfnbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_phone','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_phone',idfpbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::identityfraudnetwork_ssn','~thor_data400::key::testseed::'+filedate+'::identityfraudnetwork_ssn',idfsbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::verificationofoccupancy','~thor_data400::key::testseed::'+filedate+'::verificationofoccupancy',vobuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::intliid_gg2','~thor_data400::key::testseed::'+filedate+'::intliid_gg2',intlggbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::profilebooster','~thor_data400::key::testseed::'+filedate+'::profilebooster',prbobuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::smallbusinessanalytics','~thor_data400::key::testseed::'+filedate+'::smallbusinessanalytics',sbabuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::smallbusfinancialexchange','~thor_data400::key::testseed::'+filedate+'::smallbusfinancialexchange',sbfebuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::smallbusmodels','~thor_data400::key::testseed::'+filedate+'::smallbusmodels',sbmbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::os','~thor_data400::key::testseed::'+filedate+'::os',osbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::osattributes','~thor_data400::key::testseed::'+filedate+'::osattributes',osattributesbuilt);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::Part1::BIID_V2','~thor_data400::key::testseed::'+filedate+'::Part1::BIID_V2',biid20Pt1built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::Part2::BIID_V2','~thor_data400::key::testseed::'+filedate+'::Part2::BIID_V2',biid20Pt2built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::Part3::BIID_V2','~thor_data400::key::testseed::'+filedate+'::Part3::BIID_V2',biid20Pt3built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::smallbusinessanalyticsv20','~thor_data400::key::testseed::'+filedate+'::smallbusinessanalyticsv20',sba20built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::Summary','~thor_data400::key::testseed::'+filedate+'::VOOreport::Summary',vor1built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::TargetSummary','~thor_data400::key::testseed::'+filedate+'::VOOreport::TargetSummary',vor2built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::Sources','~thor_data400::key::testseed::'+filedate+'::VOOreport::Sources',vor3built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::OwnedProperties','~thor_data400::key::testseed::'+filedate+'::VOOreport::OwnedProperties',vor4built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::OwnedPropertiesAsOf','~thor_data400::key::testseed::'+filedate+'::VOOreport::OwnedPropertiesAsOf',vor5built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::PhoneAndUtility','~thor_data400::key::testseed::'+filedate+'::VOOreport::PhoneAndUtility',vor6built);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::VOOreport::AssociatedIdentities','~thor_data400::key::testseed::'+filedate+'::VOOreport::AssociatedIdentities',vor7built);



roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::instantid','Q',a2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::binstantid','Q',b2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::cbd','Q',c2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::cbdattributes','Q',ca2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::businessdefender','Q',aa2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::frauddefender','Q',bb2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::redflags','Q',cc2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::intliid','Q',d2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::lnsmallbusiness','Q',e2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::bs_services_iid_address_history','Q',f2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identifier2','Q',g2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::FOV_Interactive','Q',h2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::FOV_Renewal','Q',i2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityreport','Q',j2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::flexid','Q',k2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::leadintegrityattributes','Q',l2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::boca_shell','Q',m2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::boca_shell4','Q',n2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::healthcareattributes','Q',hcqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::amlriskattributes','Q',amlrqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::amlriskattributesbusn','Q',amlrbqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::amlriskattributesV2','Q',amlrqav2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::amlriskattributesbusnV2','Q',amlrbqav2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_address','Q',idfaqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_combination','Q',idfcqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_email','Q',idfeqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_ipaddress','Q',idfiqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_name','Q',idfnqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_phone','Q',idfpqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::identityfraudnetwork_ssn','Q',idfsqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::verificationofoccupancy','Q',voqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::intliid_gg2','Q',intlggqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::profilebooster','Q',prboqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::smallbusinessanalytics','Q',sbaqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::smallbusfinancialexchange','Q',sbfeqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::smallbusmodels','Q',sbmqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::os','Q',osqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::osattributes','Q',osattributesqa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::Part1::BIID_V2','Q',biid20Pt1qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::Part2::BIID_V2','Q',biid20Pt2qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::Part3::BIID_V2','Q',biid20Pt3qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::smallbusinessanalyticsv20','Q',sba20qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::Summary','Q',vor1qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::TargetSummary','Q',vor2qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::Sources','Q',vor3qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::OwnedProperties','Q',vor4qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::OwnedPropertiesAsOf','Q',vor5qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::PhoneAndUtility','Q',vor6qa);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::VOOreport::AssociatedIdentities','Q',vor7qa);



buildkey := parallel(a,b,c,ca,aa,bb,cc,d,e,f,g,h,i,j,k,l,m,n,hc,amlr,amlrb, amlrv2,amlrbv2,idfa,idfc,idfe,idfi,idfn,idfp,idfs,vo,intlgg,prbo,sba,sbfe,sbm, osm, osattributesm, biid20Pt1,biid20Pt2,biid20Pt3,sba20,vor1,vor2,vor3,vor4,vor5,vor6,vor7);
movekey := sequential(a1,b1,c1,ca1,aa1,bb1,cc1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,hcbuilt,amlrbuilt,amlrbbuilt,amlrbuiltv2,amlrbbuiltv2,idfabuilt,idfcbuilt,idfebuilt,idfibuilt,idfnbuilt,idfpbuilt,idfsbuilt,vobuilt,intlggbuilt,prbobuilt,sbabuilt,sbfebuilt,sbmbuilt,osbuilt, osattributesbuilt, biid20Pt1built,biid20Pt2built,biid20Pt3built,sba20built,vor1built,vor2built,vor3built,vor4built,vor5built,vor6built,vor7built);
movetoqa := sequential(a2,b2,c2,ca2,aa2,bb2,cc2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,hcqa,amlrqa,amlrbqa, amlrqav2,amlrbqav2,idfaqa,idfcqa,idfeqa,idfiqa,idfnqa,idfpqa,idfsqa,voqa,intlggqa,prboqa,sbaqa,sbfeqa,sbmqa,osqa, osattributesqa, biid20Pt1qa,biid20Pt2qa,biid20Pt3qa,sba20qa,vor1qa,vor2qa,vor3qa,vor4qa,vor5qa,vor6qa,vor7qa);


 dops_update := Roxiekeybuild.updateversion('TestseedKeys',filedate,'john.freibaum@lexisnexisrisk.com,Anantha.Venkatachalam@lexisnexisrisk.com',,'N');


return sequential(buildkey,movekey,movetoqa,dops_update);



end;