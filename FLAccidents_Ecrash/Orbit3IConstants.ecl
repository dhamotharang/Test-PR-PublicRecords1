IMPORT  _Control,Orbit3Insurance;
EXPORT Orbit3IConstants(string product,string emailme = '') := module
	export datasetname := case(
															product, 															
															'ecrashCRU_Delta'  =>'eCrashCRUAcidentsDelta',
															'NA'
														);
	export sourcename := case(
															product, 
															'ecrashCRU_Delta' => 'eCrashCRUAcidentsDelta',//CC Attributes Delta Log History
															'NA'	
														);

	export media 			:= case(
															product, 
															'ecrashCRU_Delta' => 'SFTP',
															'NA'	
														);
	export updatetype := case(
															product,
															'ecrashCRU_Delta' => 'Update-Append',
															'NA'	
														);
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	
	export platform := case(
															product, 
															'ecrashCRU_Delta' => 'Non FCRA Roxie',
														'NA'
														);	
														
	export platformstatus := case(
																product,
																'ecrashCRU_Delta' => 'On Development',
																'NA'
														);

	export buildstatus				:= 'BUILD_AVAILABLE_FOR_USE';
	
	export buildname := case(
															product, 
															'ecrashCRU_Delta' => 'eCrashCRUAcidentsDelta', //FCRA CCAttrDeltaKeys
															'NA'	
														);
	export masterbuildname := case(
															product, 
															'ecrashCRU_Delta' => 'eCrashCRUAcidentsDelta', //FCRA CCAttrDeltaKeys
															'NA'	
														);
	export orbitfilename := case(
															product, 
															'ecrashCRU_Delta' => 'delta_attribute_log.txt',
															'NA'	
														);
	export orbitpathname(string pdate) := case(
															product, 
															'ecrashCRU_Delta' => Orbit3Insurance.EnvironmentVariables.orbitpathprefix + 'delta_cc_attributes\\process\\' + pdate + '\\',
															'NA'	
														);
	export componentfilename(string pdate) := case(
															product, 
															'ecrashCRU_Delta' => Orbit3Insurance.EnvironmentVariables.orbitcomponentpathprefix + 'delta_cc_attributes\\\\process\\\\' + pdate + '\\\\' + stringlib.stringtolowercase(orbitfilename),
															'NA'	
														);
														
												
  export dev_email_target     := 'DataDevelopment-Ins@lexisnexis.com';
  export data_qa_email        := 'alp-qadata.team@lexisnexis.com';
  export ins_data_ops_email   := 'InsDataOps@lexisnexis.com, Sudhir.Kasavajjala@lexisnexis.com';
  export prod_email_target    := 'DataDevelopment-Ins@lexisnexis.com' + ', ' + ins_data_ops_email;
												
  export orbit_createBuild_email := if(_Control.ThisEnvironment.Name = 'Prod_Thor', data_qa_email,
                                       dev_email_target);
  export orbit_creBuildErr_email := if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                                        data_qa_email + ', ' + prod_email_target,
                                       dev_email_target);
end;