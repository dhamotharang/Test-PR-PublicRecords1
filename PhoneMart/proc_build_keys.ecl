import RoxieKeyBuild, ut,doxie, PromoteSupers;

export proc_build_keys(string filedate) := function

/*********************************************************************************
 *Build Keys                                                                     *
 *********************************************************************************/

	//Build Keys	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_phonemart_did,'','~thor_data400::key::phonemart::'+filedate+'::did',bld_did);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_phonemart_phone,'','~thor_data400::key::phonemart::'+filedate+'::phone',bld_phone);

	//Move Keys to Built
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonemart::did','~thor_data400::key::phonemart::'+filedate+'::did',mv_did_to_blt);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonemart::phone','~thor_data400::key::phonemart::'+filedate+'::phone',mv_phone_to_blt);

	//Move Key to Superfiles
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phonemart::did', 'Q', mv_did_to_qa);
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phonemart::phone', 'Q', mv_phone_to_qa);

/*********************************************************************************
 *Build Auto Keys                                                                *
 *********************************************************************************/


/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

return sequential(			     
					bld_did, bld_phone,
					mv_did_to_blt, mv_phone_to_blt,
					mv_did_to_qa, mv_phone_to_qa
				 );
                 
end;