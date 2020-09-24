import ut,roxiekeybuild, doxie_files;

export proc_build_keys_bdid(string version_date) := module

	RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_airmen_did(),'~thor_data400::key::faa::'+version_date+'::airmen_did','~thor_data400::key::airmen_did',export a_key);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_aircraft_did(),'~thor_data400::key::faa::'+version_date+'::aircraft_reg_did','~thor_data400::key::aircraft_reg_did',export b_key);
	
	//RoxieKeyBuild.MAC_SK_BuildProcess_Local(doxie_files.key_aircraft_did_FCRA,'~thor_data400::key::faa::fcra::'+version_date+'::aircraft_reg_did','~thor_data400::key::fcra::aircraft_reg_did',export b1_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_reg_bdid,'~thor_data400::key::aircraft_reg_bdid','~thor_data400::key::faa::'+version_date+'::aircraft_reg_bdid',export b2_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_reg_nnum(),'~thor_data400::key::aircraft_reg_nnum','~thor_data400::key::faa::'+version_date+'::aircraft_reg_nnum',export b3_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_id(),'~thor_data400::key::aircraft_id','~thor_data400::key::faa::'+version_date+'::aircraft_id',export b4_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_airmen_rid(),'~thor_data400::key::faa::airmen_rid','~thor_data400::key::faa::'+version_date+'::airmen_rid',export b6_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_airmen_id(),'~thor_data400::key::faa::airmen_id','~thor_data400::key::faa::'+version_date+'::airmen_id',export b7_key);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_certifications(),'~thor_data400::key::faa::'+version_date+'::airmen_certs','~thor_data400::key::faa_airmen_certs',export b5_key);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_engine_info(),'~thor_data400::key::faa::'+version_date+'::engine_info','~thor_data400::key::faa_engine_info',export c_key,2);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_aircraft_info(),'~thor_data400::key::faa::'+version_date+'::aircraft_info','~thor_data400::key::faa_aircraft_info',export c2_key,2);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_aircraft_linkids.Key,'~thor_data400::key::faa::'+version_date+'::aircraft_linkids','~thor_data400::key::aircraft_linkids',export d_key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::'+version_date+'::airmen_did','~thor_data400::key::airmen_did',export a);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::'+version_date+'::aircraft_reg_did','~thor_data400::key::aircraft_reg_did',export b);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aircraft_reg_bdid','~thor_data400::key::faa::'+version_date+'::aircraft_reg_bdid',export b2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aircraft_reg_nnum','~thor_data400::key::faa::'+version_date+'::aircraft_reg_nnum',export b3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aircraft_id','~thor_data400::key::faa::'+version_date+'::aircraft_id',export b4);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::airmen_rid','~thor_data400::key::faa::'+ version_date +'::airmen_rid',export b6);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::airmen_id','~thor_data400::key::faa::'+ version_date +'::airmen_id',export b7);
  RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::'+version_date+'::airmen_certs','~thor_data400::key::faa_airmen_certs',export b5);
  RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::'+version_date+'::engine_info','~thor_data400::key::faa_engine_info',export c,2);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::'+version_date+'::aircraft_info','~thor_data400::key::faa_aircraft_info',export c2,2);
  //RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::fcra::'+version_date+'::aircraft_reg_did','~thor_data400::key::fcra::aircraft_reg_did',export b1);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::'+version_date+'::aircraft_linkids','~thor_data400::key::aircraft_linkids',export d);
	// FCRA
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(faa.key_aircraft_id(true),'~thor_data400::key::faa::FCRA::aircraft_id','~thor_data400::key::faa::fcra::'+version_date+'::aircraft_id', export fcra_b4_key);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(faa.key_aircraft_did(true),'~thor_data400::key::faa::FCRA::aircraftreg_did', '~thor_data400::key::faa::FCRA::'+version_date+'::aircraftreg_did', export FCRA_did_key);
  RoxieKeyBuild.MAC_SK_BuildProcess_Local(faa.Key_Aircraft_Reg_NNum(true),'~thor_data400::key::faa::FCRA::'+version_date+'::aircraft_reg_nnum','~thor_data400::key::faa::FCRA::aircraft_reg_nnum', export FCRA_reg_nm_key);
  RoxieKeyBuild.MAC_SK_BuildProcess_Local(faa.key_engine_info(true),'~thor_data400::key::faa::FCRA::'+version_date+'::engine_info','~thor_data400::key::faa::FCRA::engine_info',   export FCRA_engine_key);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(faa.key_aircraft_info(true),'~thor_data400::key::faa::fcra::'+version_date+'::aircraft_info','~thor_data400::key::faa::FCRA::aircraft_info',  export FCRA_aircraft_key);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(faa.key_airmen_did(true),'~thor_data400::key::faa::fcra::'+version_date+'::airmen_did','~thor_data400::key::faa::fcra::airmen_did', export fcra_a_key);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(faa.key_airmen_rid(true),'~thor_data400::key::faa::fcra::airmen_rid','~thor_data400::key::faa::fcra::'+version_date+'::airmen_rid', export fcra_b6_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(faa.key_airmen_id(true),'~thor_data400::key::faa::fcra::airmen_id','~thor_data400::key::faa::fcra::'+version_date+'::airmen_id', export fcra_b7_key);
	RoxieKeyBuild.MAC_SK_BuildProcess_Local(faa.key_airmen_certs(true),'~thor_data400::key::faa::fcra::'+version_date+'::airmen_certs','~thor_data400::key::faa::fcra::airmen_certs', export fcra_b5_key);

  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::fcra::aircraft_id','~thor_data400::key::faa::fcra::'+version_date+'::aircraft_id', export mv_fcra_b4);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::FCRA::'+version_date+'::aircraftreg_did','~thor_data400::key::faa::FCRA::aircraftreg_did', export mv_FCRA_did_key);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::FCRA::'+version_date+'::aircraft_reg_nnum','~thor_data400::key::faa::FCRA::aircraft_reg_nnum', export mv_FCRA_reg_nm_key);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::FCRA::'+version_date+'::engine_info','~thor_data400::key::faa::FCRA::engine_info',  export mv_FCRA_engine_key);
	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::fcra::'+version_date+'::aircraft_info','~thor_data400::key::faa::FCRA::aircraft_info', export  mv_FCRA_aircraft_key);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::fcra::airmen_rid','~thor_data400::key::faa::fcra::'+ version_date +'::airmen_rid', export mv_fcra_b6);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::fcra::airmen_id','~thor_data400::key::faa::fcra::'+ version_date +'::airmen_id',export mv_fcra_b7);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::fcra::airmen_did','~thor_data400::key::faa::fcra::'+version_date+'::airmen_did', export mv_fcra_a);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::faa::fcra::airmen_certs','~thor_data400::key::faa::fcra::'+version_date+'::airmen_certs',export mv_fcra_b5);

	export build_autokeys := proc_build_autokeys(version_date);
	export build_airmen_autokeys := proc_build_autokeys_airmen(version_date);
	 
	export mv_keys := faa.proc_accept_sk_to_QA ;
										 
end;