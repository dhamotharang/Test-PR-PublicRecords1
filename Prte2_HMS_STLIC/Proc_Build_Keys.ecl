IMPORT _control, RoxieKeyBuild,AutoKeyB2,PRTE,_control, autokeyb,Business_Header_SS,business_header,ut,corp2,doxie,address,corp2_services, PRTE2_Common;


EXPORT proc_build_keys(string filedate,boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_sourcekey,
	'~prte::key::hms_stl::hms_stlicrollup::@version@::source_rid',
	'~prte::key::hms_stl::hms_stlicrollup::' + filedate + '::source_rid', build_key_source_rid);
 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::hms_stl::hms_stlicrollup::@version@::source_rid', 
	'~prte::key::hms_stl::hms_stlicrollup::' + filedate + '::source_rid',
	move_built_key_source_rid);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::hms_stl::hms_stlicrollup::@version@::source_rid', 
	'Q', 
	move_qa_key_corp2_Source_rid);
 //
 
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_lnpidkey,
	'~prte::key::kop_trgt_harv::trgt_harv_results::@version@::lnpid',
	'~prte::key::kop_trgt_harv::trgt_harv_results::' + filedate + '::lnpid', build_key_lnpid);
        

  RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::kop_trgt_harv::trgt_harv_results::@version@::lnpid', 
	 '~prte::key::kop_trgt_harv::trgt_harv_results::' + filedate + '::lnpid',
	 move_built_key_lnpid);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::kop_trgt_harv::trgt_harv_results::@version@::lnpid', 
	'Q', 
	move_qa_key_lnpid);
	
	//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(constants.dops_dataset, filedate, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
 
 RETURN 	Sequential
          (Build_key_source_rid, 
           move_built_key_source_rid,
					 move_qa_key_corp2_Source_rid,
					 build_key_lnpid, 
           move_built_key_lnpid,
					 move_qa_key_lnpid,
					 PerformUpdateorNot
					 );
			
			
			
			
			
    		
		END;

 