IMPORT PRTE2_DEADCO, PRTE, PRTE2_Common, RoxieKeyBuild, ut, AutoKeyB2, VersionControl, _control;

EXPORT proc_build_keys (string filedate) := FUNCTION

//Build Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_DEADCO.Key_LinkIds.key, Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkid_key);

//Move Key
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::linkids', Constants.KEY_PREFIX + filedate +'::linkids',mv_linkid_key);

//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q', mv_linkid_QA);

//Build Autokeys	
	b := Files.fSearchAutokey;
	
	AutoKeyB2.MAC_Build(b,
					name.fname, name.mname, name.lname,
					zero,
					zero,
					phone,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					fdid,
					//personal above.  business below
					company_name,
					zero,
					phone,
          addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					bdid,
					Constants.ak_keyname,
					Constants.ak_logical(filedate),
					outaction, false,
					Constants.ak_skipSet,true,Constants.ak_typeStr,
					true,,,zero);

	AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, mymove,, Constants.ak_skipSet)

	build_autokeys := sequential(outaction,mymove);
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('DEADCOKeys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,updatedops,NoUpdate);

// -- Actions
buildKey	:=	sequential(linkid_key
												,mv_linkid_key
												,mv_linkid_QA
												,build_autokeys
												,PerformUpdateOrNot
												);
									
RETURN	buildKey;
END;
