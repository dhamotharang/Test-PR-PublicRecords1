import doxie, Tools, VersionControl,roxiekeybuild, ut, business_risk_bip;

export proc_build_AllowedSources(string	pversion) := module

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
								Business_Risk_BIP.key_AllowedSources,
								'~thor_data400::key::bip::business_risk::allowedsources_@version@',
								'~thor_data400::key::bip::business_risk::'+Pversion+'::allowedsources',
								build_key);
	
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
								'~thor_data400::key::bip::business_risk::allowedsources_@version@',
								'~thor_data400::key::bip::business_risk::'+Pversion+'::allowedsources',
								mv_to_built); 
		
	RoxieKeyBuild.MAC_SK_Move_v2(
								'~thor_data400::key::bip::business_risk::allowedsources_@version@',
								'Q', mv_to_qa);
											
	export All := 	sequential(build_key ,mv_to_built	,mv_to_qa);
		
end;
	
	
	

																					

	
