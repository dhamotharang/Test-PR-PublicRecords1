import RoxieKeyBuild;

export proc_build_smart_jury_key(string filedate):=function

// build index file
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_smart_jury, 
																					'~thor_400::key::smart_jury::@version@::data',  
																					'~thor_400::key::smart_jury::'+filedate+'::data',       
																					easi_census_key);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_400::key::smart_jury::@version@::data'
																			,'~thor_400::key::smart_jury::'+filedate+'::data'
																			,mv_easi_census_key);


RoxieKeyBuild.MAC_SK_Move_v2('~thor_400::key::smart_jury::@version@::data', 'Q', mv_easi_census_key_qa);


build_key := sequential( easi_census_key,
												 mv_easi_census_key,
												 mv_easi_census_key_qa
											  );

return build_key;

end;
