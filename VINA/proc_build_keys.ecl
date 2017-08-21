// proc_build_keys

import doxie_files, doxie,ut,Address,did_Add,header_slimsort,watchdog,RoxieKeyBuild;

export proc_build_keys(string filedate) := function

	key_name 	:= '~thor_data400::key::vina::vin';
	// key_name1 := '~thor_data400::key::vina::vintelligence';
	// key_name2	:= '~thor_data400::key::vina::vin_vintelligence';
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VINA.key_vin
												,'~thor_data400::key::vina::vin'
												,'~thor_data400::key::vina::'+filedate+'::vin'
												,build_key_vin);
	// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VINA.key_vintelligence
												// ,'~thor_data400::key::vina::vintelligence'
												// ,'~thor_data400::key::vina::'+filedate+'::vintelligence'
												// ,build_key_vintelligence);
	// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VINA.key_vin_vintelligence
												// ,'~thor_data400::key::vina::vin_vintelligence'
												// ,'~thor_data400::key::vina::'+filedate+'::vin_vintelligence'
												// ,build_key_vin_vintelligence);

//////////////////////////////////////////////////////////////////											
											
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vina::vin'
											 ,'~thor_data400::key::vina::'+filedate+'::vin'
											,mv2blt_vin);		
	// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vina::vintelligence'
											 // ,'~thor_data400::key::vina::'+filedate+'::vintelligence'
										 // ,mv2blt_vintelligence);		
	// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vina::vin_vintelligence'
											 // ,'~thor_data400::key::vina::'+filedate+'::vin_vintelligence'
										 // ,mv2blt_vin_vintelligence);		

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

	ut.MAC_SK_Move_v2('~thor_data400::key::vina::vin' ,'Q',mv2qa_vin);
	// ut.MAC_SK_Move_v2('~thor_data400::key::vina::vintelligence' ,'Q',mv2qa_vintelligence);
	// ut.MAC_SK_Move_v2('~thor_data400::key::vina::vin_vintelligence' ,'Q',mv2qa_vin_vintelligence);


//////////////////////////////

	build_keys := sequential(
		
		if(NOT fileservices.superfileexists(key_name+'_qa'),fileservices.createsuperfile(key_name+'_qa')),
		if(NOT fileservices.superfileexists(key_name+'_father'),fileservices.createsuperfile(key_name+'_father')),
		if(NOT fileservices.superfileexists(key_name+'_grandfather'),fileservices.createsuperfile(key_name+'_grandfather')),
		if(NOT fileservices.superfileexists(key_name+'_built'),fileservices.createsuperfile(key_name+'_built')),
		if(NOT fileservices.superfileexists(key_name+'_delete'),fileservices.createsuperfile(key_name+'_delete')),		
		// if(NOT fileservices.superfileexists(key_name1+'_qa'),fileservices.createsuperfile(key_name1+'_qa')),
		// if(NOT fileservices.superfileexists(key_name1+'_father'),fileservices.createsuperfile(key_name1+'_father')),
		// if(NOT fileservices.superfileexists(key_name1+'_grandfather'),fileservices.createsuperfile(key_name1+'_grandfather')),
		// if(NOT fileservices.superfileexists(key_name1+'_built'),fileservices.createsuperfile(key_name1+'_built')),
		// if(NOT fileservices.superfileexists(key_name1+'_delete'),fileservices.createsuperfile(key_name1+'_delete')),		
		// if(NOT fileservices.superfileexists(key_name2+'_qa'),fileservices.createsuperfile(key_name2+'_qa')),
		// if(NOT fileservices.superfileexists(key_name2+'_father'),fileservices.createsuperfile(key_name2+'_father')),
		// if(NOT fileservices.superfileexists(key_name2+'_grandfather'),fileservices.createsuperfile(key_name2+'_grandfather')),
		// if(NOT fileservices.superfileexists(key_name2+'_built'),fileservices.createsuperfile(key_name2+'_built')),
		// if(NOT fileservices.superfileexists(key_name2+'_delete'),fileservices.createsuperfile(key_name2+'_delete')),		
		parallel(build_key_vin/*,build_key_vintelligence,build_key_vin_vintelligence*/),
		parallel(mv2blt_vin/*,mv2blt_vintelligence,mv2blt_vin_vintelligence*/),
		parallel(mv2qa_vin/*,mv2qa_vintelligence,mv2qa_vin_vintelligence*/)
		
	);
	
return build_keys;	
	
end;			  
							
