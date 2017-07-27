import roxiekeybuild,autokey,doxie;

export proc_build_all_keys(string filedate) := function

// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_address, 
																					 '~thor_200::key::ERO::@version@::Facility_address',  
																					 '~thor_200::key::ERO::'+filedate+'::Facility_address',       
																					 ERO_fac_key);

// Move keys to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::ERO::@version@::Facility_address',  
																			'~thor_200::key::ERO::'+filedate+'::Facility_address',
																			mv_ERO_fac_key);

// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::ERO::@version@::Facility_address', 'Q', mv_ERO_fac_key_qa);

return sequential(ERO_fac_key,
												 mv_ERO_fac_key,
												 mv_ERO_fac_key_qa
												 );


end;