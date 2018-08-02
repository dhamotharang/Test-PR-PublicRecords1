IMPORT  _Control;
EXPORT OrbitIConstants(string product,string emailme = '') := module
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

	export orbittoken := Orbit3Insurance.GetToken;
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
															'CC_Attr_Delta' => 'delta_attribute_log.txt',
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
	export emaillist := emailme;
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com,'+emailme,
												emailme);
end;