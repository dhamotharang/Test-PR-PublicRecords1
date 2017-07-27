import roxiekeybuild,seed_files;
EXPORT Proc_Build_InstantID_Keys(string filedate) := function
	
	buildkeys(indexdataset,indexsuffix, retval) := macro
		roxiekeybuild.mac_sk_buildprocess_v2_local(index(indexdataset(dataset_name = 'prte'),{dataset_name,hashvalue},
																	{indexdataset},
																	'~thor_data400::key::testseed::qa::'+indexsuffix),'abc','~prte::key::testseed::'+filedate+'::' + indexsuffix,retval);
	endmacro;
	
	buildkeys(seed_files.Key_InstantID,'instantid',a);
	buildkeys(seed_files.Key_BInstantID,'binstantid',b);
	buildkeys(Seed_Files.Key_CBD,'cbd',c);
	buildkeys(Seed_Files.Key_CBDAttributes,'cbdattributes',ca);
	buildkeys(Seed_Files.Key_BusinessDefender,'businessdefender',aa);
	buildkeys(Seed_Files.Key_frauddefender,'frauddefender',bb);
	buildkeys(Seed_Files.Key_redflags,'redflags',cc);
	buildkeys(Seed_Files.Key_IntlIID,'intliid',d);
	//buildkeys(Seed_Files.Key_LNSmallBusiness,'lnsmallbusiness',e);
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(seed_files.Key_LNSmallBusiness(hashvalue = hashmd5('prte')),{hashvalue}, {seed_files.Key_LNSmallBusiness}, '~thor_data400::key::testseed::qa::lnsmallbusiness'),'abc','~prte::key::testseed::'+filedate+'::lnsmallbusiness',e);
	buildkeys(Seed_Files.Key_BS_Services,'bs_services_iid_address_history',f);
	//buildkeys(Seed_Files.Key_Identifier2,'identifier2',g);
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_Identifier2(table_name = 'prte'),{table_name,hashvalue},
                                  {Seed_Files.Key_Identifier2},
																	'~thor_data400::key::testseed::qa::identifier2'),'abc','~prte::key::testseed::'+filedate+'::identifier2',g);
	//buildkeys(Seed_Files.key_FOVInteractive,'FOV_Interactive',h);
	//buildkeys(Seed_Files.key_FOVRenewal,'FOV_Renewal',i);
	//buildkeys(Seed_Files.key_identityreport,'identityreport',j);
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_FOVInteractive(hashvalue = hashmd5('prte')),{hashvalue,dataset_name},
																	{Seed_Files.key_FOVInteractive},
																	'~thor_data400::key::testseed::qa::FOV_Interactive'),'abc','~prte::key::testseed::'+filedate+'::FOV_Interactive',h);
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_FOVRenewal(hashvalue = hashmd5('prte')),{hashvalue,dataset_name},
																	{Seed_Files.key_FOVRenewal},
																	'~thor_data400::key::testseed::qa::FOV_Renewal'),'abc','~prte::key::testseed::'+filedate+'::FOV_Renewal',i);
	roxiekeybuild.mac_sk_buildprocess_v2_local(INDEX (Seed_Files.key_identityreport(hashvalue = hashmd5('prte')), {hashvalue}, {Seed_Files.key_identityreport},
														'~thor_data400::key::testseed::qa::identityreport'),'abc','~prte::key::testseed::'+filedate+'::identityreport',j);

	roxiekeybuild.mac_sk_buildprocess_v2_local(INDEX (Seed_Files.key_ProfileBooster(hashvalue = hashmd5('prte')), {dataset_name,hashvalue}, {Seed_Files.key_ProfileBooster},
														'~thor_data400::key::testseed::qa::profilebooster'),'abc','~prte::key::testseed::'+filedate+'::profilebooster',PB);				
														
	roxiekeybuild.mac_sk_buildprocess_v2_local(INDEX (Seed_Files.Key_VerificationOfOccupancy(hashvalue = hashmd5('prte')), {dataset_name,hashvalue}, {Seed_Files.Key_VerificationOfOccupancy},
														'~thor_data400::key::testseed::qa::verificationofoccupancy'),'abc','~prte::key::testseed::'+filedate+'::verificationofoccupancy',VO);															
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(INDEX (Seed_Files.BIID20_keys.BIID20keypart1(hashvalue = hashmd5('prte')), {dataset_name,hashvalue}, {Seed_Files.BIID20_keys.BIID20keypart1},
														'~thor_data400::key::testseed::qa::Part1::BIID_V2'),'abc','~prte::key::testseed::'+filedate+'::Part1::BIID_V2',biid20Pt1);
	roxiekeybuild.mac_sk_buildprocess_v2_local(INDEX (Seed_Files.BIID20_keys.BIID20keypart2(hashvalue = hashmd5('prte')), {dataset_name,hashvalue}, {Seed_Files.BIID20_keys.BIID20keypart2},
													'~thor_data400::key::testseed::qa::Part2::BIID_V2'),'abc','~prte::key::testseed::'+filedate+'::Part2::BIID_V2',biid20Pt2);	
	roxiekeybuild.mac_sk_buildprocess_v2_local(INDEX (Seed_Files.BIID20_keys.BIID20keypart3(hashvalue = hashmd5('prte')), {dataset_name,hashvalue}, {Seed_Files.BIID20_keys.BIID20keypart3},
													'~thor_data400::key::testseed::qa::Part3::BIID_V2'),'abc','~prte::key::testseed::'+filedate+'::Part3::BIID_V2',biid20Pt3);	
														


	buildkeys(Seed_Files.Key_FlexID,'flexid',k);
	buildkeys(Seed_Files.Key_LeadIntegrityAttributes,'leadintegrityattributes',l);
	buildkeys(Seed_Files.Key_Boca_Shell(),'boca_shell',m);
	buildkeys(Seed_Files.Key_HealthCareAttributes,'healthcareattributes',hc);
	buildkeys(Seed_Files.key_AMLRiskAttributes,'amlriskattributes',amlr);
	buildkeys(Seed_Files.key_AMLRiskAttributesBusn,'amlriskattributesbusn',amlrb);
	buildkeys(Seed_Files.key_AMLRiskAttributesV2,'amlriskattributesV2',amlrV2);
  buildkeys(Seed_Files.key_AMLRiskAttributesBusnV2,'amlriskattributesbusnV2',amlrbV2);
	
	buildkeys(Seed_Files.Key_Boca_Shell4(),'boca_shell4',bs4);
		
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Address(TestDataTableName = 'prte'),{TestDataTableName, StreetAddress1, Zip5},
									{Seed_Files.Key_IdentityFraudNetwork_Address},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_address')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_address',idfa);
									
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Combination(TestDataTableName = 'prte'),{TestDataTableName, LastName, FirstName, StreetAddress1, Zip5, Phone10, SSN, Email, IPAddress},
									{Seed_Files.Key_IdentityFraudNetwork_Combination},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_combination')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_combination',idfc);
									
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Email(TestDataTableName = 'prte'),{TestDataTableName, Email},
									{Seed_Files.Key_IdentityFraudNetwork_Email},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_email')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_email',idfe);		
									
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_IPAddress(TestDataTableName = 'prte'),{TestDataTableName, IPAddress},
									{Seed_Files.Key_IdentityFraudNetwork_IPAddress},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_ipaddress')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_ipaddress',idfi);			
									
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Name(TestDataTableName = 'prte'),{TestDataTableName, LastName, FirstName},
									{Seed_Files.Key_IdentityFraudNetwork_Name},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_name')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_name',idfn);		
									
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_Phone(TestDataTableName = 'prte'),{TestDataTableName, Phone10},
									{Seed_Files.Key_IdentityFraudNetwork_Phone},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_phone')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_phone',idfp);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IdentityFraudNetwork_SSN(TestDataTableName = 'prte'),{TestDataTableName, SSN},
									{Seed_Files.Key_IdentityFraudNetwork_SSN},
									'~thor_data400::key::testseed::qa::identityfraudnetwork_ssn')
									,'abc','~prte::key::testseed::'+filedate+'::identityfraudnetwork_ssn',idfs);	
	
	//buildkeys(Seed_Files.Key_IntlIID_gg2,'intliid_gg2',intlgg);				
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_IntlIID_GG2(DatasetName = 'prte'),{DatasetName,hashvalue},
									{Seed_Files.Key_IntlIID_GG2},
									'~thor_data400::key::testseed::qa::intliid_gg2')
									,'abc','~prte::key::testseed::'+filedate+'::intliid_gg2',intlgg);	
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_SmallBusFinancialExchange(TestDataTableName = 'prte'),{TestDataTableName,hashvalue},
									{Seed_Files.key_SmallBusFinancialExchange},
									'~thor_data400::key::testseed::qa::smallbusfinancialexchange')
									,'abc','~prte::key::testseed::'+filedate+'::smallbusfinancialexchange',smallbusfin);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_SmallBusinessAnalytics(TestDataTableName = 'prte'),{TestDataTableName,hashvalue},
									{Seed_Files.key_SmallBusinessAnalytics},
									'~thor_data400::key::testseed::qa::smallbusinessanalytics')
									,'abc','~prte::key::testseed::'+filedate+'::smallbusinessanalytics',smallbusana);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_SmallBusModels(tablename = 'prte'),{tablename,hashvalue},
									{Seed_Files.key_SmallBusModels},
									'~thor_data400::key::testseed::qa::smallbusmodels')
									,'abc','~prte::key::testseed::'+filedate+'::smallbusmodels',smallbusmodels);
									
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_os(hashvalue = hashmd5('prte')),{table_name,hashvalue}, {Seed_Files.Key_os},
	'~thor_data400::key::testseed::qa::os'),'abc','~prte::key::testseed::'+filedate+'::os',os);

roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_osattributes(hashvalue = hashmd5('prte')),{table_name,hashvalue}, {Seed_Files.Key_osattributes},
	'~thor_data400::key::testseed::qa::osattributes'),'abc','~prte::key::testseed::'+filedate+'::osattributes',osattributes);

									
	buildkey := parallel(a,b,c,ca,aa,bb,cc,d,e,f,g,h,i,j,k,l,m,hc,amlr,amlrb,amlrV2
												,amlrbV2, bs4,idfa, idfc, idfe
												, idfi, idfn, idfp, idfs,intlgg,PB,VO,smallbusfin
												,smallbusana,smallbusmodels,os,
																			osattributes, biid20Pt1, biid20Pt2, biid20Pt3);
	
	return buildkey;


end;