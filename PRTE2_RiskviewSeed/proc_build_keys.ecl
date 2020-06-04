import roxiekeybuild,seed_files, _control, dops, prte, prte2, prte2_common;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function
	
	buildkeys(indexdataset,indexsuffix, retval) := macro
		roxiekeybuild.mac_sk_buildprocess_v2_local(index(indexdataset(dataset_name = 'prte'),{dataset_name,hashvalue},
																	{indexdataset},
																	'~thor_data400::key::testseed::qa::'+indexsuffix),'abc','~prte::key::testseed::'+filedate+'::' + indexsuffix,retval);
	endmacro;
	
	buildkeys(Seed_Files.Key_RVAttributes,'rvattributes',a);
	buildkeys(Seed_Files.Key_RiskView,'riskview',bb);
	buildkeys(Seed_Files.Key_RVderogs,'rvderogs',cc);
	buildkeys(Seed_Files.Key_FCRA_GongHistory,'fcragonghistory',d);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_NCFInsurance(hashvalue = hashmd5('prte')),{hashvalue,table_name,model_name}, {Seed_Files.key_NCFInsurance},
	'~thor_data400::key::testseed::qa::ncfinsurance'),'abc','~prte::key::testseed::'+filedate+'::ncfinsurance',k);

	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.key_MVRInsurance(hashvalue = hashmd5('prte')),{hashvalue,table_name,model_name}, {Seed_Files.key_MVRInsurance},
	'~thor_data400::key::testseed::qa::mvrinsurance'),'abc','~prte::key::testseed::'+filedate+'::mvrinsurance',l);
	
	roxiekeybuild.mac_sk_buildprocess_v2_local(index(Seed_Files.Key_RiskView2(hashvalue = hashmd5('prte')),{TestDataTableName, HashValue}, {Seed_Files.Key_RiskView2},
	'~thor_data400::key::testseed::qa::riskview2'),'abc','~prte::key::testseed::'+filedate+'::riskview2',rv);

	buildkeys(Seed_Files.Key_Boca_Shell(true),'boca_shell_fcra',m);
	buildkeys(Seed_Files.Key_Boca_Shell4(true),'boca_shell4_fcra',hc);

	build_key := parallel(a,bb,cc,d,k,l,m,hc,rv);	
	
	//---------- making DOPS optional and only in PROD build -------------------------------	
		dataset_name	:= 'RiskviewseedKeys';
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 				:= is_running_in_prod AND NOT skipDOPS;		
		notifyEmail 	:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 			:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate := PRTE.UpdateVersion(dataset_name, filedate, notifyEmail, l_inloc:='B', l_inenvment:='F', l_includeboolean :='N');
		PerformUpdateOrNot := IF(doDOPS,PerformUpdate,NoUpdate);
		//--------------------------------------------------------------------------------------
		key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,dataset_name, 'F'), named(dataset_name+'Validation'));
		
		return sequential( build_key, key_validation, PerformUpdateOrNot);

		END;

