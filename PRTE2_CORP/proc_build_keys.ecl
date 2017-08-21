IMPORT RoxieKeyBuild,AutoKeyB2,PRTE,_control, autokeyb,Business_Header_SS,business_header,ut,corp2,doxie,address,corp2_services, PRTE2_Common;


EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp_ar,
	'~prte::key::corp2::@version@::ar::corp_key.record_type',
	'~prte::key::corp2::' + filedate + '::ar::corp_key.record_type', build_key_corp2_arcorp_key);
	
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp_event,
 '~prte::key::corp2::@version@::event::corp_key.record_type',
 '~prte::key::corp2::' + filedate + '::event::corp_key.record_type', build_key_corp2_eventcorp_key);
 
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp_stock,
	'~prte::key::corp2::@version@::stock::corp_key.record_type',
	'~prte::key::corp2::' + filedate + '::stock::corp_key.record_type', build_key_corp2_stockcorp_key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp_cont_did,
	'~prte::key::corp2::@version@::cont::did',
	'~prte::key::corp2::' + filedate + '::cont::did', build_key_corp2_contdid);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp_corp_bdid,
	'~prte::key::corp2::@version@::corp::bdid',
	'~prte::key::corp2::' + filedate + '::corp::bdid', build_key_corp2_corpbdid);
	
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp_corp_record_key,
	'~prte::key::corp2::@version@::corp::corp_key.record_type',
	 '~prte::key::corp2::' + filedate + '::corp::corp_key.record_type', build_key_corp2_corpcorp_key);
	 
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp2_corpst,
	'~prte::key::corp2::@version@::corp::st.charter_number',
	'~prte::key::corp2::' + filedate + '::corp::st.charter_number', build_key_corp2_corpst);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp2_corpbdidpl,
	 '~prte::key::corp2::@version@::corp::bdid.pl',
	 '~prte::key::corp2::' + filedate + '::corp::bdid.pl', build_key_corp2_corpbdidpl);
	 
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp2_contbdid,
	 '~prte::key::corp2::@version@::cont::bdid',
	 '~prte::key::corp2::' + filedate + '::cont::bdid', build_key_corp2_contbdid);
	 
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corp2_contcorp,
	'~prte::key::corp2::@version@::cont::corp_key.record_type',
	'~prte::key::corp2::' + filedate + '::cont::corp_key.record_type', build_key_corp2_contcorp_key);
	
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_Corp2_LinkIDs.key,
	 '~prte::key::corp2::@version@::corp::linkids',
	 '~prte::key::corp2::' + filedate + '::corp::linkids', build_key_corp2_corplinkids);
	
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::ar::corp_key.record_type', 
	'~prte::key::corp2::' + filedate + '::ar::corp_key.record_type',
	move_built_key_corp2_arcorp_key);
	
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::event::corp_key.record_type', 
 '~prte::key::corp2::' + filedate + '::event::corp_key.record_type',
 move_built_key_corp2_eventcorp_key);
 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::stock::corp_key.record_type', 
 '~prte::key::corp2::' + filedate + '::stock::corp_key.record_type',
 move_built_key_corp2_stockcorp_key);
 
  RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::cont::did', 
	'~prte::key::corp2::' + filedate + '::cont::did',
	move_built_key_corp2_contdid);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::corp::bdid', 
	'~prte::key::corp2::' + filedate + '::corp::bdid',
	move_built_key_corp2_corpbdid);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::corp::corp_key.record_type', 
	'~prte::key::corp2::' + filedate + '::corp::corp_key.record_type',
	move_built_key_corp2_corpcorp_key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::corp::st.charter_number', 
	'~prte::key::corp2::' + filedate + '::corp::st.charter_number',
	move_built_key_corp2_corpst);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::corp::bdid.pl', 
	'~prte::key::corp2::' + filedate + '::corp::bdid.pl',
	move_built_key_corp2_corpbdidpl);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::cont::bdid', 
 '~prte::key::corp2::' + filedate + '::cont::bdid',
 move_built_key_corp2_contbdid);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::cont::corp_key.record_type', 
 '~prte::key::corp2::' + filedate + '::cont::corp_key.record_type',
 move_built_key_corp2_contcorp_key);
 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corp2::@version@::corp::linkids', 
	'~prte::key::corp2::' + filedate + '::corp::linkids',
	move_built_key_corp2_corplinkids);


RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::ar::corp_key.record_type', 
	'Q', 
	move_qa_key_corp2_arcorp_key);
	
RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::event::corp_key.record_type', 
	 'Q', 
 move_qa_key_corp2_eventcorp_key);
 
 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::stock::corp_key.record_type', 
	'Q', 
	move_qa_key_corp2_stockcorp_key);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::cont::did', 
	'Q', 
	move_qa_key_corp2_contdid);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::corp::bdid', 
	'Q', 
	move_qa_key_corp2_corpbdid);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::corp::corp_key.record_type', 
	 'Q', 
	move_qa_key_corp2_corpcorp_key);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::corp::st.charter_number',
 'Q', 
  move_qa_key_corp2_corpst);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::corp::bdid.pl', 
	'Q', 
	move_qa_key_corp2_corpbdidpl);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::cont::bdid', 
 'Q', 
 move_qa_key_corp2_contbdid);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::cont::corp_key.record_type', 
 'Q', 
 move_qa_key_corp2_contcorp_key);
 
 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corp2::@version@::corp::linkids', 
	 'Q', 
	 move_qa_key_corp2_corplinkids);
	 
 	//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops					:= PRTE.UpdateVersion('Corp2Keys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,updatedops,NoUpdate);
  
 RETURN 		SEQUENTIAL(
     	build_key_corp2_arcorp_key, 
			build_key_corp2_eventcorp_key, 
			build_key_corp2_stockcorp_key, 
			build_key_corp2_contdid,
			build_key_corp2_corpbdid,
			build_key_corp2_corpcorp_key,
			build_key_corp2_corpst, 
			build_key_corp2_corpbdidpl, 
			build_key_corp2_contbdid, 
			build_key_corp2_contcorp_key, 
			build_key_corp2_corplinkids, 
			
			move_built_key_corp2_arcorp_key, 
			move_built_key_corp2_eventcorp_key,
			move_built_key_corp2_stockcorp_key, 
			move_built_key_corp2_contdid, 
			move_built_key_corp2_corpbdid,
			move_built_key_corp2_corpcorp_key, 
			move_built_key_corp2_corpst, 
			move_built_key_corp2_corpbdidpl, 
		  move_built_key_corp2_contbdid, 
			move_built_key_corp2_contcorp_key, 
			move_built_key_corp2_corplinkids, 
						
			move_qa_key_corp2_arcorp_key,
			move_qa_key_corp2_eventcorp_key,
			move_qa_key_corp2_stockcorp_key,
			move_qa_key_corp2_contdid,
			move_qa_key_corp2_corpbdid,
			move_qa_key_corp2_corpcorp_key,
			move_qa_key_corp2_corpst, 
			move_qa_key_corp2_corpbdidpl, 
			move_qa_key_corp2_contbdid,
			move_qa_key_corp2_contcorp_key,
			move_qa_key_corp2_corplinkids,
			proc_build_autokeys(filedate),
      PerformUpdateOrNot);
    		
		END;
