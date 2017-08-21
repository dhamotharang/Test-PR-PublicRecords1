import RoxieKeyBuild, ut,doxie, PromoteSupers;

export proc_build_keys(string filedate) := function

/*********************************************************************************
 *Build Keys                                                                     *
 *********************************************************************************/

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_phonemart_did,'','~thor_data400::key::phonemart::'+filedate+'::did',bld_did);	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonemart::did','~thor_data400::key::phonemart::'+filedate+'::did',mv_did_to_blt);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phonemart::did', 'Q', mv_did_to_qa);

/*********************************************************************************
 *Build Auto Keys                                                                *
 *********************************************************************************/


/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////


return sequential(			     
					bld_did,
					mv_did_to_blt,
					mv_did_to_qa
				 );
                 
end;