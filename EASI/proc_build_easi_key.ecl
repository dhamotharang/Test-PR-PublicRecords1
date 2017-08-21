import RoxieKeyBuild;

export proc_build_easi_key(string filedate):=function

// build index file
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Easi_Census, 
																					'~thor_400::key::easi::@version@::census',  
																					'~thor_400::key::easi::'+filedate+'::census',       
																					easi_census_key);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_400::key::easi::@version@::census'
																			,'~thor_400::key::easi::'+filedate+'::census'
																			,mv_easi_census_key);


RoxieKeyBuild.MAC_SK_Move_v2('~thor_400::key::easi::@version@::census', 'Q', mv_easi_census_key_qa);


build_key := sequential( easi_census_key,
												 mv_easi_census_key,
												 mv_easi_census_key_qa
											  );

return build_key;

end;
