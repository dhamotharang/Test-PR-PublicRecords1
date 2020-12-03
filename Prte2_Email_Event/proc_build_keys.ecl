
IMPORT _control, RoxieKeyBuild, PRTE, _control, ut, doxie, PRTE2_Common, dops,Prte2, orbit3;


EXPORT proc_build_keys(string filedate,boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_emailevent,
	'~prte::key::email_datav2::@version@::email_event_lkp',
	'~prte::key::email_datav2::' + filedate + '::email_event_lkp', build_key_emailevent);
 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::email_datav2::@version@::email_event_lkp', 
	'~prte::key::email_datav2::' + filedate + '::email_event_lkp', move_built_key_emailevent);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::email_datav2::@version@::email_event_lkp',  
	'Q', 
	move_qa_key_emailevent);
	
	//Domain
 
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_domainevent,
	'~prte::key::email_datav2::@version@::domain_lkp',
	'~prte::key::email_datav2::' + filedate + '::domain_lkp', build_key_domainevent);
 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::email_datav2::@version@::domain_lkp', 
	'~prte::key::email_datav2::' + filedate + '::domain_lkp', move_built_key_domainevent);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::email_datav2::@version@::domain_lkp',  
	'Q', 
	move_qa_key_domainevent);
  
	orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - EmailDataV2EventKeys', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);
	
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(constants.dops_dataset, filedate, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');	
	
	PerformUpdateOrNot	:= IF(not skipDops,parallel(updatedops,orbit_update),NoUpdate);
	
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
 
 
 RETURN 	Sequential(
              Parallel (Build_key_emailevent,Build_key_domainevent),
							Parallel (move_built_key_emailevent,move_built_key_domainevent),
					    Parallel (move_qa_key_emailevent,move_qa_key_domainevent),
					    PerformUpdateorNot,
							key_validation);
			
	END;

 