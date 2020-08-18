import RoxieKeyBuild, ut,doxie, PromoteSupers;

export proc_build_cwp_keys(string filedate) := function

/*********************************************************************************
 *Build Keys                                                                     *
 *********************************************************************************/

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_fdids,'','~thor_data400::key::canadianwp_v2::'+filedate+'::fdids',bld_fdid);	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_v2::fdids','~thor_data400::key::canadianwp_v2::'+filedate+'::fdids',mv_fdid_to_blt);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_v2::fdids', 'Q', mv_fdid_to_qa);		//DF-16788

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_did,'','~thor_data400::key::canadianwp_v2::'+filedate+'::did',bld_did);	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_v2::did','~thor_data400::key::canadianwp_v2::'+filedate+'::did',mv_did_to_blt);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_v2::did', 'Q', mv_did_to_qa);		//CCPA-1030

/*********************************************************************************
 *Build Auto Keys                                                                *
 *********************************************************************************/
bld_autokeys := CanadianPhones_V2.Proc_build_autokeys(filedate);

/*********************************************************************************
 *email key build completion                                                     *
 *********************************************************************************/

emailN := fileservices.sendemail('cathy.tio@lexisnexis.com',
								 
'CANADIAN PHONES: BUILD SUCCESS vs.'+ filedate,					
'thor_data400::key::canadianwp_v2::fdids_qa 					thor_data400::key::canadianwp_v2::'+filedate+'::fdids,\n' +
'thor_data400::key::canadianwp_v2::did_qa 					thor_data400::key::canadianwp_v2::'+filedate+'::did,\n' +
'thor_data400::key::canadianwp_v2::qa::autokey::address		thor_data400::key::canadianwp_v2'+filedate+'::autokey::address,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::citystname		thor_data400::key::canadianwp_v2'+filedate+'::autokey::citystname,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::name			thor_data400::key::canadianwp_v2'+filedate+'::autokey::name,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::phone2			thor_data400::key::canadianwp_v2'+filedate+'::autokey::phone2,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::stname			thor_data400::key::canadianwp_v2'+filedate+'::autokey::stname,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::zip			thor_data400::key::canadianwp_v2'+filedate+'::autokey::zip,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::nameb2			thor_data400::key::canadianwp_v2'+filedate+'::autokey::nameb2,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::zipb2			thor_data400::key::canadianwp_v2'+filedate+'::autokey::zipb2,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::citystnameb2	thor_data400::key::canadianwp_v2'+filedate+'::autokey::citystnameb2,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::stnameb2		thor_data400::key::canadianwp_v2'+filedate+'::autokey::stnameb2,\n' +
'thor_data400::key::canadianwp_v2::qa::autokey::addressb2		thor_data400::key::canadianwp_v2'+filedate+'::autokey::addressb2,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::namewords2		thor_data400::key::canadianwp_v2'+filedate+'::autokey::namewords2,\n' + 
'thor_data400::key::canadianwp_v2::qa::autokey::phoneb2		thor_data400::key::canadianwp_v2'+filedate+'::autokey::phoneb2,\n' +
'thor_data400::key::canadianwp_v2::qa::autokey::zipprlname		thor_data400::key::canadianwp_v2'+filedate+'::autokey::zipprlname' 
); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////


return sequential(			     
					bld_fdid,
					mv_fdid_to_blt,
					mv_fdid_to_qa,
					bld_did,
					mv_did_to_blt,
					mv_did_to_qa,
					bld_autokeys,
					emailN
				 );
                 
end;