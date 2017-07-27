import CourtLink,roxiekeybuild,ut,doxie,doxie_files;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(CourtLink.key_CourtID_Docket,
										   '~thor_data400::key::CourtLink::@version@::CourtID_Docket','~thor_data400::key::CourtLink::'+filedate+'::CourtID_Docket',
										   bld_court_key);

// Move key to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CourtLink::@version@::CourtID_Docket','~thor_data400::key::CourtLink::'+filedate+'::CourtID_Docket',mv_court_key);

// Move key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::courtLink::@version@::CourtID_Docket', 'Q', mv_court_key_qa);

build_keys 		:= sequential(bld_court_key, mv_court_key, mv_court_key_qa); 
					
return build_keys;

end;


 
 
 
 