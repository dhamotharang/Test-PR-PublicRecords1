import autokey, sexoffender, doxie, fair_isaac, codes, did_add, didville, VehLic, minibuild, VehicleCodes, header_slimsort, watchdog, vehicle_wildcard, doxie_files,RoxieKeyBuild, doxie_build, promotesupers;

export Proc_Build_SO_Search_Keys(string filedate) := function

pre1 := promotesupers.SF_MaintBuilding('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate);
pre2 := promotesupers.SF_MaintBuilding('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate);
pre3 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,

output('Nothing added to Base::UtilityHeader_Building'),
           fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building',
		                           '~thor_data400::Base::Utility_File',,true));

util_populated 	:= fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0 : stored('utilcheck');
chk_build 			:= output('Checking sex offender building files...') : success(sequential(if(util_populated,output('Util already populated'),output('Util not populated')),parallel(pre1,pre2,pre3)));

//chk_build := parallel(pre1, pre2);

//Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_DID(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::did'+ doxie_build.buildstate,key_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_SPK_Enh(),'',	 
				'~thor_data400::key::sexoffender::'+filedate+'::enh'+ doxie_build.buildstate,key_enh);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_sexoffender_offenses(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::offenses_'+doxie_build.buildstate,key_off);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_SPK(),'',	
				'~thor_data400::key::sexoffender::'+filedate+'::spk'+ doxie_build.buildstate,key_spk);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_Zip_Type_building(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::zip_type_'+ doxie_build.buildstate,key_zip_type);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_FDid_building(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::fdid_'+ doxie_build.buildstate,key_fdid);

//Build fcra-versions of the keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_DID (true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::did'+ doxie_build.buildstate,key_did_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_SPK_Enh (true),'',	 
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::enh'+ doxie_build.buildstate,key_enh_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_sexoffender_offenses (true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses_'+ doxie_build.buildstate,key_off_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_SPK (true),'',	
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::spk'+ doxie_build.buildstate,key_spk_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_Zip_Type_building(true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::zip_type_'+ doxie_build.buildstate,key_zip_type_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_SexOffender_FDid_building(true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::fdid_'+ doxie_build.buildstate,key_fdid_fcra);
						
//Move to built			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_did'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::did'+ doxie_build.buildstate,mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_enh'+ doxie_build.buildstate,	 
				'~thor_data400::key::sexoffender::'+filedate+'::enh'+ doxie_build.buildstate,mv_enh);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_offenses_'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::offenses_'+doxie_build.buildstate,mv_off);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_spk'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::spk'+ doxie_build.buildstate,mv_spk);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_zip_type_'+ doxie_build.buildstate,
        '~thor_data400::key::sexoffender::'+filedate+'::zip_type_'+ doxie_build.buildstate,mv_zip_type);					
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_fdid_'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::fdid_'+ doxie_build.buildstate,mv_fdid);

//Move fcra-versions to built			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::did'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::did'+ doxie_build.buildstate,mv_did_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::enh'+ doxie_build.buildstate,	 
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::enh'+ doxie_build.buildstate,mv_enh_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::offenses_'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses_'+ doxie_build.buildstate,mv_off_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::spk'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::spk'+ doxie_build.buildstate,mv_spk_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::zip_type_'+ doxie_build.buildstate,
        '~thor_data400::key::sexoffender::fcra::'+filedate+'::zip_type_'+ doxie_build.buildstate,mv_zip_type_fcra);					
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::fdid_'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::fdid_'+ doxie_build.buildstate,mv_fdid_fcra);
	
post1 := promotesupers.SF_MaintBuilt('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate);
post2 := promotesupers.SF_MaintBuilt('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate);
//post3 := if(util_populated, output('Dont clear utility super'),fileservices.clearsuperfile('~thor_data400::Base::UtilityHeader_Building'));
		
return sequential(chk_build,
					parallel(key_did, key_enh, key_spk, key_off, key_zip_type),
					key_fdid,
					parallel(key_did_fcra, key_enh_fcra, key_spk_fcra, key_off_fcra, key_zip_type_fcra),
					key_fdid_fcra,
					parallel(mv_did, mv_enh, mv_spk, mv_off, mv_zip_type, mv_fdid),
					parallel(mv_did_fcra, mv_enh_fcra, mv_spk_fcra, mv_off_fcra, mv_zip_type_fcra, mv_fdid_fcra,
					hygenics_soff.Key_SexOffender_Enh_Addr(false, filedate), 
					hygenics_soff.Key_SexOffender_Enh_Addr(true, filedate),
					hygenics_soff.Key_SexOffender_SO_Addr(false, filedate),
					hygenics_soff.Key_SexOffender_SO_Addr(true, filedate),
					post1
					//parallel(post1,post2,post3*/)
					));
end;