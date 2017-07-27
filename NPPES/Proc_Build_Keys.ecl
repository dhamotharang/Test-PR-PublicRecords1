import roxiekeybuild, ut;

export Proc_Build_Keys(string filedate) := function
	
	//Build the npi key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_NPPES_npi,
											   '~thor_data400::key::NPPES::@version@::npi',
											   '~thor_data400::key::NPPES::'+filedate+'::npi',
											   build_npi_key);
											   
	//Move npi key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NPPES::@version@::npi',
										  '~thor_data400::key::NPPES::'+filedate+'::npi',
										  mv_npi_key_to_built);     											   
	//Move npi key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NPPES::@version@::npi', 'Q', mv_npi_key_to_qa);
										  										   
    build_npi_Keys := sequential(build_npi_key,
								 mv_npi_key_to_built,	
								 mv_npi_key_to_qa);
								            
	return build_npi_Keys;
	end;