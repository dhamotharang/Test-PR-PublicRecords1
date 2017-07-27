import autokey, sexoffender, doxie, fair_isaac, codes, did_add, didville, VehLic, minibuild, ut, VehicleCodes, header_slimsort, watchdog, vehicle_wildcard, doxie_files,RoxieKeyBuild;

export Proc_Build_SO_Search_Keys(string filedate) := function

pre1 := ut.SF_MaintBuilding('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate);
pre2 := ut.SF_MaintBuilding('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate);
pre3 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,
output('Nothing added to Base::UtilityHeader_Building'),
           fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building',
		                           '~thor_data400::Base::Utility_File',,true));

util_populated := fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0 : stored('utilcheck');



chk_build := output('Checking sex offender building files...') : success(sequential(if(util_populated,output('Util already populated'),output('Util not populated')),parallel(pre1,pre2,pre3)));

//chk_build := parallel(pre1, pre2);

//Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_DID(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::did'+ doxie_build.buildstate,key_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK_Enh(),'',	 
				'~thor_data400::key::sexoffender::'+filedate+'::enh'+ doxie_build.buildstate,key_enh);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_sexoffender_offenses(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::offenses_'+doxie_build.buildstate,key_off);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK(),'',	
				'~thor_data400::key::sexoffender::'+filedate+'::spk'+ doxie_build.buildstate,key_spk);

//Build fcra-versions of the keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_DID (true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::did',key_did_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK_Enh (true),'',	 
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::enh',key_enh_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_sexoffender_offenses (true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses',key_off_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK (true),'',	
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::spk',key_spk_fcra);
						
//Move to built			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_did'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::did'+ doxie_build.buildstate,mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_enh'+ doxie_build.buildstate,	 
				'~thor_data400::key::sexoffender::'+filedate+'::enh'+ doxie_build.buildstate,mv_enh);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_offenses_'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::offenses_'+doxie_build.buildstate,mv_off);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_spk'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::spk'+ doxie_build.buildstate,mv_spk);

//Move fcra-versions to built			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::did',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::did',mv_did_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::enh',	 
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::enh',mv_enh_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::offenses',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses',mv_off_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::spk',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::spk',mv_spk_fcra);

f := file_SO_Enh_keybuilding;

xl :=
RECORD
	f;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SEX'))| ut.bit_set(0,0);
	real lat;
	real long;
END;
xl xpand(f le,integer cntr) := 
TRANSFORM 
	SELF.did := cntr + autokey.did_adder('SEX'); 
	self.lat := (real)(ziplib.ZipToGeo21(le.alt_zip)[1..9]),
	self.long := (real)(ziplib.ZipToGeo21(le.alt_zip)[11..]),
	SELF := le; 
END;
DS := PROJECT(f,xpand(LEFT,COUNTER)) : PERSIST('persist::sex_offender_enh_fdids');

f_zip_type_base := project(DS,transform(SexOffender.layout_zip_type_key,
                                        self.alt_zip := (INTEGER4)left.alt_zip,
																				self.yob := (UNSIGNED2)(left.dob[1..4]),
                                        self.dob := (INTEGER4)left.dob, 
																				self := left))(alt_zip<>0);

idx_zip_type := index(f_zip_type_base,{alt_zip, alt_type, yob, dob}, {did},
                      '~thor_data400::key::sexoffender_zip_type_'+ doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(idx_zip_type,'',
					'~thor_data400::key::sexoffender::'+filedate+'::zip_type_'+ doxie_build.buildstate,key_zip_type);
					
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_zip_type_'+ doxie_build.buildstate,
                                      '~thor_data400::key::sexoffender::'+filedate+'::zip_type_'+ doxie_build.buildstate,mv_zip_type);					
					
AutoKey.MAC_Build_version(DS,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						'~thor_data400::key::so_enh'+doxie_build.buildstate,
						'~thor_data400::key::sexoffender::'+filedate+'::enh'+doxie_build.buildstate,outaction1,false) // Diffing originally true

ds_orig := project(ds(alt_type='S'),
                   transform({ds},
		                   self.alt_st := if(left.alt_st='',left.orig_state_code, left.alt_st);
					    self := left)) : PERSIST('persist::sex_offender_fdids');

AutoKey.MAC_Build_version(ds_orig,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						'~thor_data400::key::so_'+doxie_build.buildstate,
						'~thor_data400::key::sexoffender::'+filedate+'::'+doxie_build.buildstate,outaction2,false) // Diffing originally true

in_common := project(ds,transform(SexOffender.Layout_fdid,self := left));

i := index(in_common,{did},{seisint_primary_key, lat, long},'~thor_data400::key::sexoffender_fdid'+ doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(i,'',
					'~thor_data400::key::sexoffender::'+filedate+'::fdid_'+ doxie_build.buildstate,key_fdid); // Diffing originally true
					
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_fdid_'+ doxie_build.buildstate,'~thor_data400::key::sexoffender::'+filedate+'::fdid_'+ doxie_build.buildstate,mv_fdid);

post1 := ut.SF_MaintBuilt('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate);
post2 := ut.SF_MaintBuilt('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate);
post3 := if(util_populated, output('Dont clear utility super'),fileservices.clearsuperfile('~thor_data400::Base::UtilityHeader_Building'));


return sequential(chk_build,
  parallel(key_did,key_enh,key_spk,key_off,key_did_fcra,key_enh_fcra,key_spk_fcra,key_off_fcra),
  parallel(mv_did,mv_enh,mv_spk,mv_off,mv_did_fcra,mv_enh_fcra,mv_spk_fcra,mv_off_fcra),
  outaction1,outaction2,key_fdid,mv_fdid,key_zip_type,mv_zip_type,parallel(post1,post2,post3));

end;