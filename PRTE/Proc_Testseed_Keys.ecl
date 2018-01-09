import roxiekeybuild,seed_files;
EXPORT Proc_Testseed_Keys(string filedate) := function
	
	buildkeys(indexdataset,indexsuffix, retval) := macro
		roxiekeybuild.mac_sk_buildprocess_v2_local(index(indexdataset(dataset_name = 'prte'),{dataset_name,hashvalue},
																	{indexdataset},
																	'~thor_data400::key::testseed::qa::'+indexsuffix),'abc','~prte::key::testseed::'+filedate+'::' + indexsuffix,retval);
	endmacro;
	
	buildkeys(Seed_Files.Key_InstantID,'instantid',instantid);
buildkeys(Seed_Files.Key_BInstantID,'binstantid',binstantid);
buildkeys(Seed_Files.Key_CBD,'cbd',cbd);
buildkeys(Seed_Files.Key_CBDAttributes,'cbdattributes',cbdattributes);
buildkeys(Seed_Files.Key_BusinessDefender,'businessdefender',businessdefender);
buildkeys(Seed_Files.Key_frauddefender,'frauddefender',frauddefender);
buildkeys(Seed_Files.Key_redflags,'redflags',redflags);
buildkeys(Seed_Files.Key_IntlIID,'intliid',intliid);

buildkeys(Seed_Files.Key_BS_Services,'bs_services_iid_address_history',bs_services_iid_address_history);

buildkeys(Seed_Files.key_FOVInteractive,'FOV_Interactive',FOV_Interactive);
buildkeys(Seed_Files.key_FOVRenewal,'FOV_Renewal',FOV_Renewal);

buildkeys(Seed_Files.Key_FlexID,'flexid',flexid);
buildkeys(Seed_Files.Key_LeadIntegrityAttributes,'leadintegrityattributes',leadintegrityattributes);
buildkeys(Seed_Files.Key_Boca_Shell(),'boca_shell',boca_shell);
buildkeys(Seed_Files.Key_Boca_Shell4(),'boca_shell4',boca_shell4);
buildkeys(Seed_Files.Key_HealthCareAttributes,'healthcareattributes',healthcareattributes);
buildkeys(Seed_Files.key_AMLRiskAttributes,'amlriskattributes',amlriskattributes);
buildkeys(Seed_Files.key_AMLRiskAttributesBusn,'amlriskattributesbusn',amlriskattributesbusn);
buildkeys(Seed_Files.key_AMLRiskAttributesV2,'amlriskattributesV2',amlriskattributesV2);
buildkeys(Seed_Files.key_AMLRiskAttributesBusnV2,'amlriskattributesbusnV2',amlriskattributesbusnV2);
buildkeys(Seed_Files.Key_VerificationOfOccupancy,'verificationofoccupancy',verificationofoccupancy);

buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.Summary,'VOOReport::Summary',Summary);
buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.TargetSummary,'VOOReport::TargetSummary',TargetSummary);
buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.Sources,'VOOReport::Sources',Sources);
buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.OwnedProperties,'VOOReport::OwnedProperties',OwnedProperties);
buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.OwnedPropertiesAsOf,'VOOReport::OwnedPropertiesAsOf',OwnedPropertiesAsOf);
buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.PhoneAndUtility,'VOOReport::PhoneAndUtility',PhoneAndUtility);
buildkeys(Seed_Files.VerificationOfOccupancy_Report_keys.AssociatedIdentities ,'VOOReport::AssociatedIdentities',AssociatedIdentities);

buildkeys(Seed_Files.Key_ProfileBooster,'profilebooster',profilebooster);


	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_LNSmallBusiness(hashvalue = hashmd5('prte')),{hashvalue}, {Seed_Files.Key_LNSmallBusiness},
	'~thor_data400::key::testseed::qa::lnsmallbusiness'),'abc','~prte::key::testseed::'+filedate+'::lnsmallbusiness',lnsmallbusiness);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_Identifier2(hashvalue = hashmd5('prte')),{table_name,hashvalue}, {Seed_Files.Key_Identifier2},
	'~thor_data400::key::testseed::qa::identifier2'),'abc','~prte::key::testseed::'+filedate+'::identifier2',identifier2);
	
roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_identityreport(hashvalue = hashmd5('prte')),{hashvalue}, {Seed_Files.key_identityreport},
	'~thor_data400::key::testseed::qa::identityreport'),'abc','~prte::key::testseed::'+filedate+'::identityreport',identityreport);
	

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Address(TestDataTableName = 'prte'),{TestDataTableName, StreetAddress1, Zip5}, {Seed_Files.Key_IdentityFraudNetwork_Address},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_address'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_address',identityfraudnetwork_address);


roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Combination(TestDataTableName = 'prte'),{TestDataTableName, LastName, FirstName, StreetAddress1, Zip5, Phone10, SSN, Email, IPAddress}, {Seed_Files.Key_IdentityFraudNetwork_Combination},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_combination'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_combination',identityfraudnetwork_combination);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Email(TestDataTableName = 'prte'),{TestDataTableName, Email}, {Seed_Files.Key_IdentityFraudNetwork_Email},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_email'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_email',identityfraudnetwork_email);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_IPAddress(TestDataTableName = 'prte'),{TestDataTableName, IPAddress}, {Seed_Files.Key_IdentityFraudNetwork_IPAddress},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_ipaddress'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_ipaddress',identityfraudnetwork_ipaddress);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Name(TestDataTableName = 'prte'),{TestDataTableName, LastName, FirstName}, {Seed_Files.Key_IdentityFraudNetwork_Name},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_name'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_name',identityfraudnetwork_name);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Phone(TestDataTableName = 'prte'),{TestDataTableName,  Phone10}, {Seed_Files.Key_IdentityFraudNetwork_Phone},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_phone'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_phone',identityfraudnetwork_phone);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_SSN(TestDataTableName = 'prte'),{TestDataTableName, SSN}, {Seed_Files.Key_IdentityFraudNetwork_SSN},
	'~thor_data400::key::testseed::qa::identityfraudnetwork_ssn'),'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_ssn',identityfraudnetwork_ssn);


roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IntlIID_GG2(DatasetName = 'prte'),{DatasetName,hashvalue}, {Seed_Files.Key_IntlIID_GG2},
	'~thor_data400::key::testseed::qa::intliid_gg2'),'abc','~prte::key::testseed::'+filedate+'::intliid_gg2',intliid_gg2);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_SmallBusinessAnalytics(TestDataTableName = 'prte'),{TestDataTableName, HashValue}, {Seed_Files.key_SmallBusinessAnalytics},
	'~thor_data400::key::testseed::qa::smallbusinessanalytics'),'abc','~prte::key::testseed::'+filedate+'::smallbusinessanalytics',smallbusinessanalytics);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_SmallBusinessAnalyticsv20(TestDataTableName = 'prte'),{TestDataTableName, HashValue}, {Seed_Files.key_SmallBusinessAnalyticsv20},
	'~thor_data400::key::testseed::qa::smallbusinessanalyticsv20'),'abc','~prte::key::testseed::'+filedate+'::smallbusinessanalyticsv20',smallbusinessanalyticsv20);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_SmallBusFinancialExchange(TestDataTableName = 'prte'),{TestDataTableName, HashValue}, {Seed_Files.key_SmallBusFinancialExchange},
	'~thor_data400::key::testseed::qa::smallbusfinancialexchange'),'abc','~prte::key::testseed::'+filedate+'::smallbusfinancialexchange',smallbusfinancialexchange);	

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_os(hashvalue = hashmd5('prte')),{table_name,hashvalue}, {Seed_Files.Key_os},
	'~thor_data400::key::testseed::qa::os'),'abc','~prte::key::testseed::'+filedate+'::os',os);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_osattributes(hashvalue = hashmd5('prte')),{table_name,hashvalue}, {Seed_Files.Key_osattributes},
	'~thor_data400::key::testseed::qa::osattributes'),'abc','~prte::key::testseed::'+filedate+'::osattributes',osattributes);

	
buildkey := parallel(
																			instantid,
																			binstantid,
																			cbd,
																			cbdattributes,
																			businessdefender,
																			frauddefender,
																			redflags,
																			intliid,
																			lnsmallbusiness,
																			bs_services_iid_address_history,
																			identifier2,
																			FOV_Interactive,
																			FOV_Renewal,
																			identityreport,
																			flexid,
																			leadintegrityattributes,
																			boca_shell,
																			boca_shell4,
																			healthcareattributes,
																			amlriskattributes,
																			amlriskattributesbusn,
																			amlriskattributesV2,
																			amlriskattributesbusnV2,
																			identityfraudnetwork_address,
																			identityfraudnetwork_combination,
																			identityfraudnetwork_email,
																			identityfraudnetwork_ipaddress,
																			identityfraudnetwork_name,
																			identityfraudnetwork_phone,
																			identityfraudnetwork_ssn,
																			verificationofoccupancy,
																			intliid_gg2,
																			profilebooster,
																			smallbusinessanalytics,
																			smallbusfinancialexchange,
																			os,
																			Summary,
																			TargetSummary,
																			Sources,
																			OwnedProperties,
																			OwnedPropertiesAsOf,
																			PhoneAndUtility,
																			AssociatedIdentities,
																			smallbusinessanalyticsv20,
																			osattributes
																		
);
	
	return buildkey;


end;