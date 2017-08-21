import roxiekeybuild,seed_files;
EXPORT Proc_RiskViewAttr_Keys(string filedate) := function
	
	buildkeys(indexdataset,indexsuffix, retval) := macro
		roxiekeybuild.mac_sk_buildprocess_v2_local(index(indexdataset(dataset_name = 'prte'),{dataset_name,hashvalue},
																	{indexdataset},
																	'~thor_data400::key::testseed::qa::'+indexsuffix),'abc','~prte::key::testseed::'+filedate+'::' + indexsuffix,retval);
	endmacro;
	
	buildkeys(Seed_Files.Key_RVAttributes,'rvattributes',a);
	buildkeys(Seed_Files.Key_RVAuto,'rvauto',b);
	buildkeys(Seed_Files.Key_RVBankcard,'rvbankcard',c);
	buildkeys(Seed_Files.Key_RVRetail,'rvretail',ca);
	buildkeys(Seed_Files.Key_RVTelecom,'rvtelecom',aa);
	buildkeys(Seed_Files.Key_RiskView,'riskview',bb);
	buildkeys(Seed_Files.Key_RVderogs,'rvderogs',cc);
	buildkeys(Seed_Files.Key_FCRA_GongHistory,'fcragonghistory',d);
	
	//buildkeys(Seed_Files.Key_LNSmallBusiness,'lnsmallbusiness',e);
	/*roxiekeybuild.mac_sk_buildprocess_v2_local(index(seed_files.Key_LNSmallBusiness(hashvalue = hashmd5('prte')),{hashvalue}, {seed_files.Key_LNSmallBusiness}, '~thor_data400::key::testseed::qa::lnsmallbusiness'),'abc','~prte::key::testseed::'+filedate+'::lnsmallbusiness',e);
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
														'~thor_data400::key::testseed::qa::identityreport'),'abc','~prte::key::testseed::'+filedate+'::identityreport',j);*/

	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_NCFInsurance(hashvalue = hashmd5('prte')),{hashvalue,table_name,model_name}, {Seed_Files.key_NCFInsurance},
	'~thor_data400::key::testseed::qa::ncfinsurance'),'abc','~prte::key::testseed::'+filedate+'::ncfinsurance',k);

	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_MVRInsurance(hashvalue = hashmd5('prte')),{hashvalue,table_name,model_name}, {Seed_Files.key_MVRInsurance},
	'~thor_data400::key::testseed::qa::mvrinsurance'),'abc','~prte::key::testseed::'+filedate+'::mvrinsurance',l);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_RiskView2(hashvalue = hashmd5('prte')),{TestDataTableName, HashValue}, {Seed_Files.Key_RiskView2},
	'~thor_data400::key::testseed::qa::riskview2'),'abc','~prte::key::testseed::'+filedate+'::riskview2',rv);

	// buildkeys(Seed_Files.key_NCFInsurance,'ncfinsurance',k);
	// buildkeys(Seed_Files.key_MVRInsurance,'mvrinsurance',l);
	buildkeys(Seed_Files.Key_Boca_Shell(true),'boca_shell_fcra',m);
	buildkeys(Seed_Files.Key_Boca_Shell4(true),'boca_shell4_fcra',hc);
	
	
	buildkey := parallel(a,b,c,ca,aa,bb,cc,d/*,e,f,g,h,i,j,*/,k,l,m,hc,rv);
	
	return buildkey;


end;