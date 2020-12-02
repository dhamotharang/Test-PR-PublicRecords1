IMPORT RoxieKeyBuild,PRTE,_control, ut,doxie,address, PRTE2_Common, dops, prte2, orbit3;


EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_linkids,
	'~prte::key::inquiry_table::linkids_@version@',
	'~prte::key::inquiry::' + filedate + '::linkids', build_linkid_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fein,
	'~prte::key::inquiry_table::fein_@version@',
	'~prte::key::inquiry::' + filedate + '::fein', build_fein_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_did,
	'~prte::key::inquiry_table::did_@version@',
	'~prte::key::inquiry::' + filedate + '::did', build_did_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_address,
	'~prte::key::inquiry_table::address_@version@',
	'~prte::key::inquiry::' + filedate + '::address', build_address_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_phone,
	'~prte::key::inquiry_table::phone_@version@',
	'~prte::key::inquiry::' + filedate + '::phone', build_phone_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_email,
	'~prte::key::inquiry_table::email_@version@',
	'~prte::key::inquiry::' + filedate + '::email', build_email_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_ssn,
	'~prte::key::inquiry_table::ssn_@version@',
	'~prte::key::inquiry::' + filedate + '::ssn', build_ssn_keys);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_transaction_id,
	'~prte::key::inquiry_table::transaction_id_@version@',
	'~prte::key::inquiry::' + filedate + '::transaction_id', build_transaction_id_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_ipaddr,
	'~prte::key::inquiry_table::ipaddr_@version@',
	'~prte::key::inquiry::' + filedate + '::ipaddr', build_ipaddr_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_name,
	'~prte::key::inquiry_table::name_@version@',
	'~prte::key::inquiry::' + filedate + '::name', build_name_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_bill,
	'~prte::key::inquiry_table::billgroups_did_@version@',
	'~prte::key::inquiry::' + filedate + '::billgroups_did', build_bill_keys);
	
	
 	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_address,
	'~prte::key::inquiry_table::fcra::address_@version@',
	'~prte::key::inquiry::fcra::' + filedate + '::address', build_fcra_address_keys);
	
		RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_did,
	'~prte::key::inquiry_table::fcra::did_@version@',
	'~prte::key::inquiry::fcra::' + filedate + '::did', build_fcra_did_keys);
	
		RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_ssn,
	'~prte::key::inquiry_table::fcra::ssn_@version@',
	'~prte::key::inquiry::fcra::' + filedate + '::ssn', build_fcra_ssn_keys);
	
		RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_phone,
	'~prte::key::inquiry_table::fcra::phone_@version@',
	'~prte::key::inquiry::fcra::' + filedate + '::phone', build_fcra_phone_keys);
	
		RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_login,
	'~prte::key::inquiry_table::fcra::industry_use_vertical_login_@version@',
	'~prte::key::inquiry_table::fcra::' + filedate + '::industry_use_vertical_login', build_fcra_login_keys);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_bill,
	'~prte::key::inquiry_table::fcra::billgroups_did_@version@',
	'~prte::key::inquiry::fcra::' + filedate + '::billgroups_did', build_fcra_bill_keys);
	
		RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_fcra_vertical,
	'~prte::key::inquiry_table::fcra::industry_use_vertical_@version@',
	'~prte::key::inquiry_table::fcra::' + filedate + '::industry_use_vertical', build_fcra_vertical_keys);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::linkids_@version@', 
		'~prte::key::inquiry::' + filedate + '::linkids',
	move_built_linkid);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fein_@version@', 
		'~prte::key::inquiry::' + filedate + '::fein',
	move_built_fein);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::did_@version@', 
		'~prte::key::inquiry::' + filedate + '::did',
	move_built_did);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::address_@version@', 
		'~prte::key::inquiry::' + filedate + '::address',
	move_built_address);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::phone_@version@', 
		'~prte::key::inquiry::' + filedate + '::phone',
	move_built_phone);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::email_@version@', 
		'~prte::key::inquiry::' + filedate + '::email',
	move_built_email);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::ssn_@version@', 
		'~prte::key::inquiry::' + filedate + '::ssn',
	move_built_ssn);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::transaction_id_@version@', 
		'~prte::key::inquiry::' + filedate + '::transaction_id',
	move_built_transaction_id);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::ipaddr_@version@', 
		'~prte::key::inquiry::' + filedate + '::ipaddr',
	move_built_ipaddr);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::name_@version@', 
		'~prte::key::inquiry::' + filedate + '::name',
	move_built_name);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::billgroups_did_@version@', 
		'~prte::key::inquiry::' + filedate + '::billgroups_did',
	move_built_bill);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::address_@version@', 
		'~prte::key::inquiry::fcra::' + filedate + '::address',
	move_built_fcra_address);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::did_@version@', 
		'~prte::key::inquiry::fcra::' + filedate + '::did',
	move_built_fcra_did);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::ssn_@version@', 
		'~prte::key::inquiry::fcra::' + filedate + '::ssn',
	move_built_fcra_ssn);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::phone_@version@', 
		'~prte::key::inquiry::fcra::' + filedate + '::phone',
	move_built_fcra_phone);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::industry_use_vertical_login_@version@', 
		'~prte::key::inquiry_table::fcra::' + filedate + '::industry_use_vertical_login',
	move_built_fcra_login);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::billgroups_did_@version@', 
		'~prte::key::inquiry::fcra::' + filedate + '::billgroups_did',
	move_built_fcra_bill);	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::inquiry_table::fcra::industry_use_vertical_@version@', 
		'~prte::key::inquiry_table::fcra::' + filedate + '::industry_use_vertical',
	move_built_fcra_vertical);	
 	
RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::linkids_@version@', 
	'Q', 
	move_qa_linkid_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fein_@version@', 
	'Q', 
	move_qa_fein_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::did_@version@', 
	'Q', 
	move_qa_did_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::address_@version@', 
	'Q', 
	move_qa_address_key);
	
		RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::phone_@version@', 
	'Q', 
	move_qa_phone_key);

	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::email_@version@', 
	'Q', 
	move_qa_email_key);	
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::ssn_@version@', 
	'Q', 
	move_qa_ssn_key);	
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::transaction_id_@version@', 
	'Q', 
	move_qa_transaction_id_key);	
	
		RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::ipaddr_@version@', 
	'Q', 
	move_qa_ipaddr_key);	
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::name_@version@', 
	'Q', 
	move_qa_name_key);	
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::billgroups_did_@version@', 
	'Q', 
	move_qa_bill_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::address_@version@', 
	'Q', 
	move_qa_fcra_address_key);	
	 
	 RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::did_@version@', 
	'Q', 
	move_qa_fcra_did_key);	
	 
	  RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::ssn_@version@', 
	'Q', 
	move_qa_fcra_ssn_key);	
	
	  RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::phone_@version@', 
	'Q', 
	move_qa_fcra_phone_key);	
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::industry_use_vertical_login_@version@', 
	'Q', 
	move_qa_fcra_login_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::billgroups_did_@version@', 
	'Q', 
	move_qa_fcra_bill_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	'~prte::key::inquiry_table::fcra::industry_use_vertical_@version@', 
	'Q', 
	move_qa_fcra_vertical_key);
	
 	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
  doDOPS              := is_running_in_prod AND NOT skipDOPS;
  DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
  updatedops					:= PRTE.UpdateVersion('Inquirytablekeys',filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
  updatedops_fcra			:= PRTE.UpdateVersion('FCRA_Inquirytablekeys',filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='F',l_includeboolean :='N');

key_validations :=  parallel(output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation')),
                    output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,Constants.fcra_dops_name, 'F'), named(Constants.fcra_dops_name+'Validation')));	

create_orbit_build := parallel(
                                Orbit3.proc_Orbit3_CreateBuild('PRTE - Inquiry_Table_Keys', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal),
																Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_Inquiry_Table_Keys', filedate, 'PF', email_list:= _control.MyInfo.EmailAddressNormal),
															);
																
 
 RETURN 		SEQUENTIAL(
            PARALLEL(
            build_linkid_keys
			     ,build_fein_keys
		    	 ,build_did_keys
			     ,build_address_keys
			     ,build_phone_keys
			     ,build_email_keys
			     ,build_ssn_keys
			     ,build_transaction_id_keys
			     ,build_ipaddr_keys
			     ,build_name_keys
			     ,build_bill_keys
			     ,build_fcra_address_keys
			     ,build_fcra_did_keys
			     ,build_fcra_ssn_keys
				   ,build_fcra_phone_keys
				   ,build_fcra_login_keys
				   ,build_fcra_bill_keys
					 ,build_fcra_vertical_keys
					 )
					,PARALLEL(
			     move_built_linkid	
			    ,move_built_fein	
			    ,move_built_did	
			    ,move_built_address	
			    ,move_built_phone	
			    ,move_built_email	
			    ,move_built_ssn	
		      ,move_built_transaction_id	
			    ,move_built_ipaddr	
			    ,move_built_name	
				  ,move_built_bill	
			    ,move_built_fcra_address	
			    ,move_built_fcra_did
				  ,move_built_fcra_ssn
				  ,move_built_fcra_phone
				  ,move_built_fcra_login
				  ,move_built_fcra_bill
					,move_built_fcra_vertical
					)
			 ,PARALLEL(
			   move_qa_linkid_key
			  ,move_qa_fein_key
			  ,move_qa_did_key
			  ,move_qa_address_key
			  ,move_qa_phone_key
			  ,move_qa_email_key
  		  ,move_qa_ssn_key
				,move_qa_transaction_id_key
				,move_qa_ipaddr_key
				,move_qa_name_key
				,move_qa_bill_key
				,move_qa_fcra_address_key
				,move_qa_fcra_did_key
				,move_qa_fcra_ssn_key
				,move_qa_fcra_phone_key
				,move_qa_fcra_login_key
				,move_qa_fcra_bill_key 
				,move_qa_fcra_vertical_key 
				)
			 ,if(not doDOPS, DOPS_Comment, parallel(updatedops, updatedops_fcra))		
				,key_validations
				,create_orbit_build
			
			 );
   
		       		
		END;
