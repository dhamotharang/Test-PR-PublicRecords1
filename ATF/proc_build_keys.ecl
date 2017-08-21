import ut, roxiekeybuild, autokeyb2;

export proc_build_keys(string filedate) := function
	a := sequential(
			fileservices.startsuperfiletransaction(),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::atf_firearms_explosives_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::atf_firearms_explosives_BUILDING','~thor_data400::base::atf_firearms_explosives',0,true)),
			fileservices.finishsuperfiletransaction()
			);

	pre := output(atf.file_firearms_explosives_keybase,,'~thor_data400::base::atf::firearms_expl::phone_suppression',overwrite);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(ATF.key_atf_did,'~thor_Data400::key::atf::firearms::did','~thor_Data400::key::atf::firearms::'+filedate+'::did',b_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(ATF.key_atf_lnum,'~thor_data400::key::atf::firearms::lnum','~thor_Data400::key::atf::firearms::'+filedate+'::lnum',c_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(ATF.key_atf_bdid,'~thor_data400::key::atf::firearms::bdid','~thor_data400::key::atf::firearms::'+filedate+'::bdid',d_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(ATF.key_atf_records,'~thor_data400::key::atf::firearms::records','~thor_Data400::key::atf::firearms::'+filedate+'::records',e_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(ATF.key_ATF_id,'~thor_data400::key::atf::firearms::atfid','~thor_data400::key::atf::firearms::'+filedate+'::atfid',f_key);

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::atf::firearms::did','~thor_Data400::key::atf::firearms::'+filedate+'::did',b);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::lnum','~thor_Data400::key::atf::firearms::'+filedate+'::lnum',c);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::bdid','~thor_Data400::key::atf::firearms::'+filedate+'::bdid',d);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::records','~thor_Data400::key::atf::firearms::'+filedate+'::records',e);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::atfid','~thor_Data400::key::atf::firearms::'+filedate+'::atfid',f);
	
	ak_const := ATF.atf_autokey_constants(filedate); 

	ak_keyname  := ak_const.str_autokeyname;
	ak_logical  := ak_const.ak_logical;
	ak_dataset  := ak_const.ak_dataset;
	ak_skipSet  := ak_const.ak_skipSet;
	ak_typeStr  := ak_const.ak_typeStr;


	AutoKeyB2.MAC_Build (ak_dataset,license1_fname,license1_mname,license1_lname,
						 best_ssn,
						 zero,
						 blank,
						 premise_prim_name,
						 premise_prim_range,
						 premise_st,
						 premise_p_city_name,
						 premise_zip,
						 premise_sec_range,
						 zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,
						 did_out6,
						 Business_Name, // compname which is string thus "blank"
						 zero,
						 zero,
						 premise_prim_name,premise_prim_range,premise_st,premise_p_city_name,premise_zip,premise_sec_range,
						 bdid6, // bdid_out
						 ak_keyname,
						 ak_logical,
						 bld_auto_keys,false,
						 ak_skipSet,true,ak_typeStr,
						 true,,,zero);
						 
	move_qa := atf.accept_sk_to_qa;
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move_auto_keys,, ak_skipSet);
						 
	j := sequential(
			fileservices.startsuperfiletransaction(),
			fileservices.clearsuperfile('~thor_data400::base::atf_firearms_explosives_BUILT'),
			fileservices.addsuperfile('~thor_data400::base::atf_firearms_explosives_BUILT','~thor_data400::base::atf_firearms_explosives_BUILDING',0,true),
			fileservices.clearsuperfile('~thor_Data400::base::atf_firearms_explosives_BUILDING'),
			fileservices.finishsuperfiletransaction()
			);
	
	update_dops := roxiekeybuild.updateversion('ATFKeys',filedate,atf.Spray_Notification_Email_Address,,'N');
		
	return if (fileservices.getsuperfilesubname('~thor_data400::base::atf_firearms_explosives',1) = fileservices.getsuperfilesubname('~thor_data400::base::atf_firearms_explosives_BUILT',1),
					output('BASE = BUILT, Nothing done.'),
					sequential(a,pre,parallel(b_key,c_key,d_key,e_key,f_key),parallel(b,c,d,e,f),bld_auto_keys,parallel(move_qa,move_auto_keys),j,update_dops));
end;