
IMPORT AutoKeyB2, _control, DCA; 

EXPORT Proc_Build_Autokey(STRING filedate) :=
	FUNCTION

		cnst       := DCA.Constants(filedate);
		ak_dataset := cnst.ak_dataset;
		ak_keyname := cnst.ak_keyname; // @version@
		ak_logical := cnst.ak_logical;
		ak_skipSet := cnst.ak_skipSet;
		ak_typeStr := cnst.ak_typeStr;
		
		jobComplete := FileServices.sendemail(_control.MyInfo.EmailAddressNotify, ' DCA Roxie autokey build succeeded.', '');									 
		jobFailed   := FileServices.sendemail(_control.MyInfo.EmailAddressNotify, ' DCA Roxie autokey build failed - ' + filedate, failmessage);		

		AutoKeyB2.MAC_Build(ak_dataset,blank,blank,blank,
												blank,
												zero,
												zero,
												blank_prim_name, blank_prim_range, blank_st, blank_city, blank_zip5, blank_sec_range, 
												zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,
												zero,
												company_name,
												zero,
												company_phone,
												Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.p_city_name,Bus_addr.zip5,Bus_addr.sec_range,
												bdid,
												ak_keyname,
												ak_logical,
												build_dca_autokeys,false,
												ak_skipSet,true,ak_typeStr,
												true,,,bdid,false) 
		
		/* Create autokeys and move them to 'built'. */
		build_action :=	sequential( build_dca_autokeys );

		/* Move autokeys to QA--business keys only; no person keys, so we can't use AutoKeyB2.MAC_AcceptSK_to_QA() */
		RoxieKeyBuild.MAC_SK_Move_v2(ak_keyname + 'payload'     ,'Q', mv_autokey_payload);
		RoxieKeyBuild.Mac_SK_Move_V2(ak_keyname + 'AddressB2'   ,'Q', mv_autokey_addrB2);
		RoxieKeyBuild.Mac_SK_Move_V2(ak_keyname + 'NameB2'      ,'Q', mv_autokey_nameB2);
		RoxieKeyBuild.Mac_SK_Move_V2(ak_keyname + 'StNameB2'    ,'Q', mv_autokey_stnamB2);
		RoxieKeyBuild.Mac_SK_Move_V2(ak_keyname + 'CityStNameB2','Q', mv_autokey_cityB2);
		RoxieKeyBuild.Mac_SK_Move_V2(ak_keyname + 'ZipB2'       ,'Q', mv_autokey_zipB2);
		RoxieKeyBuild.Mac_SK_Move_V2(ak_keyname + 'NameWords2'  ,'Q', mv_autokey_Namewords2);
		
		move_action := parallel(mv_autokey_payload,
										        mv_autokey_addrB2,
										        mv_autokey_nameB2,
										        mv_autokey_stnamB2,
										        mv_autokey_cityB2,
										        mv_autokey_zipB2,
										        mv_autokey_Namewords2);
											
		retval := sequential( build_action, move_action ) : success(jobComplete), failure(jobFailed);
		
		return retval;

	end;
	