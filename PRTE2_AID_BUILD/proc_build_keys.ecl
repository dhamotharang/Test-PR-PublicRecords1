IMPORT PRTE, PRTE2_Common, roxiekeybuild, ut, promotesupers, VersionControl, _control, std;

EXPORT proc_build_keys(STRING filedate = (STRING8)Std.Date.Today()) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_AID_BUILD.Keys.AID_Base_AddressLookup(), 		'', '~prte::key::aid::' 			+filedate+ '::addrline1_addrlinelast',aid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_AID_BUILD.Keys.AID_Base_AddressLookup(true), '',	'~prte::key::aid::fcra::' +filedate+ '::addrline1_addrlinelast',aid_key_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~prte::key::aid::@version@::addrline1_addrlinelast', 				'~prte::key::aid::' 			+ filedate + '::addrline1_addrlinelast',mv_aid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~prte::key::aid::fcra::@version@::addrline1_addrlinelast', 	'~prte::key::aid::fcra::' + filedate + '::addrline1_addrlinelast',mv_aid_key_fcra);

RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::aid::' 				+ '@version@::addrline1_addrlinelast','Q', mv_aid_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::aid::fcra::' 	+ '@version@::addrline1_addrlinelast','Q', mv_aid_QA_fcra);


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
updatedops					:= PRTE.UpdateVersion('AddressLineAIDKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');

// -- Actions
buildKey	:=	ordered(parallel(aid_key, aid_key_fcra),
											parallel(mv_aid_key, mv_aid_key_fcra),
											parallel(mv_aid_QA, mv_aid_QA_fcra)
										 ,if(not is_running_in_prod, DOPS_Comment, updatedops)												 
											);
									
return	buildKey;
end;
