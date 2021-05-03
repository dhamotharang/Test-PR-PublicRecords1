import RoxieKeyBuild, PromoteSupers, doxie;

export proc_build_cwp_keys(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
                     key_fdids,'',
				 '~thor_data400::key::canadianwp::'+filedate+'::fdids',bld_fdid);
				 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
                     key_did,'',
				 '~thor_data400::key::canadianwp::'+filedate+'::did',bld_did);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
                     CanadianPhones.Key_CWP_Addr,'',
				 '~thor_data400::key::canadianwp::'+filedate+'::addr',bld_addr);
				 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
                     CanadianPhones.Key_CWP_Phone,'',
				 '~thor_data400::key::canadianwp::'+filedate+'::phone_payload',bld_phone_payload);
		
/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////		


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_fdids',
				'~thor_data400::key::canadianwp::'+filedate+'::fdids',mv_fdid_to_blt);
				
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_did',
				'~thor_data400::key::canadianwp::'+filedate+'::did',mv_did_to_blt);
				
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_addr',
				'~thor_data400::key::canadianwp::'+filedate+'::addr',mv_addr_to_blt);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_phone_payload',
				'~thor_data400::key::canadianwp::'+filedate+'::phone_payload',mv_phone_payload_to_blt);
		
/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////	

PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_fdids', 'Q', mv_fdid_to_qa);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_did', 'Q', mv_did_to_qa);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_addr', 'Q', mv_addr_to_qa);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_phone_payload', 'Q', mv_phone_payload_to_qa);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

bld_autokeys := CanadianPhones.Proc_build_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

emailN := fileservices.sendemail('tgibson@seisint.com',
								 
'CANADIAN PHONES: BUILD SUCCESS vs.'+ filedate,					
'thor_data400::key::canadianwp_fdids_qa 					thor_data400::key::canadianwp::'+filedate+'::fdids,\n' +
'thor_data400::key::canadianwp_did_qa 					thor_data400::key::canadianwp::'+filedate+'::did,\n' +
'thor_data400::key::canadianwp_addr_qa 						thor_data400::key::canadianwp::'+filedate+'::addr,\n' + 
'thor_data400::key::canadianwp_phone_payload_qa 			thor_data400::key::canadianwp::'+filedate+'::phone_payload,\n' + 
'thor_data400::key::canadianwp::qa::autokey::address		thor_data400::key::canadianwp::'+filedate+'::autokey::address,\n' + 
'thor_data400::key::canadianwp::qa::autokey::citystname		thor_data400::key::canadianwp::'+filedate+'::autokey::citystname,\n' + 
'thor_data400::key::canadianwp::qa::autokey::name			thor_data400::key::canadianwp::'+filedate+'::autokey::name,\n' + 
'thor_data400::key::canadianwp::qa::autokey::phone2			thor_data400::key::canadianwp::'+filedate+'::autokey::phone2,\n' + 
'thor_data400::key::canadianwp::qa::autokey::stname			thor_data400::key::canadianwp::'+filedate+'::autokey::stname,\n' + 
'thor_data400::key::canadianwp::qa::autokey::zip			thor_data400::key::canadianwp::'+filedate+'::autokey::zip,\n' + 
'thor_data400::key::canadianwp::qa::autokey::nameb2			thor_data400::key::canadianwp::'+filedate+'::autokey::nameb2,\n' + 
'thor_data400::key::canadianwp::qa::autokey::zipb2			thor_data400::key::canadianwp::'+filedate+'::autokey::zipb2,\n' + 
'thor_data400::key::canadianwp::qa::autokey::citystnameb2	thor_data400::key::canadianwp::'+filedate+'::autokey::citystnameb2,\n' + 
'thor_data400::key::canadianwp::qa::autokey::stnameb2		thor_data400::key::canadianwp::'+filedate+'::autokey::stnameb2,\n' +
'thor_data400::key::canadianwp::qa::autokey::addressb2		thor_data400::key::canadianwp::'+filedate+'::autokey::addressb2,\n' + 
'thor_data400::key::canadianwp::qa::autokey::namewords2		thor_data400::key::canadianwp::'+filedate+'::autokey::namewords2,\n' + 
'thor_data400::key::canadianwp::qa::autokey::phoneb2		thor_data400::key::canadianwp::'+filedate+'::autokey::phoneb2,\n' +
'thor_data400::key::canadianwp::qa::autokey::zipprlname		thor_data400::key::canadianwp::'+filedate+'::autokey::zipprlname' 
); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////


return sequential(
				     
					parallel(bld_fdid,
								bld_did,
							  bld_addr,
							  bld_phone_payload),
					parallel(mv_fdid_to_blt,
								mv_did_to_blt,
							  mv_addr_to_blt,
							  mv_phone_payload_to_blt),
					parallel(mv_fdid_to_qa,
								mv_did_to_qa,
							  mv_addr_to_qa,
							  mv_phone_payload_to_qa),
					bld_autokeys,
					emailN
				 );
                 
end;