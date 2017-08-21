IMPORT ut,RoxieKeyBuild,AutoKeyB2, prte2_busreg,PRTE,_control,PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_busreg_company_bdid,
	Constants.KeyName_busreg + '_bdid_@version@',
	Constants.KeyName_busreg2 + filedate + '::company_bdid', build_key_busreg_company_bdid);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_busreg_company_linkids.Key,
	 	Constants.KeyName_busreg + '_linkids_@version@',
	 	 Constants.KeyName_busreg2 + filedate + '::company_linkids', build_key_busreg_company_linkids);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_busreg + '_bdid_@version@', 
	Constants.KeyName_busreg2 + filedate + '::company_bdid',
	move_built_key_busreg_company_bdid);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_busreg + '_linkids_@version@',  
 Constants.KeyName_busreg2 + filedate + '::company_linkids',
 move_built_key_busreg_company_linkids);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_busreg + '_bdid_@version@', 
	'Q', 
	move_qa_key_busreg_company_bdid);

 RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_busreg + '_linkids_@version@',  
 'Q', 
 move_qa_key_busreg_company_linkids);

 //---------- making DOPS optional and only in PROD build -------------------------------
 is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
 NoUpdate           := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
 updatedops         := PRTE.UpdateVersion('Businessregkeys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
 PerformUpdateOrNot := IF(is_running_in_prod,updatedops,NoUpdate);


RETURN 		sequential(			build_key_busreg_company_bdid, 
			build_key_busreg_company_linkids, 
			move_built_key_busreg_company_bdid, 
			move_built_key_busreg_company_linkids, 
			move_qa_key_busreg_company_bdid, 
			move_qa_key_busreg_company_linkids,
			PerformUpdateOrNot); 
			

END;
