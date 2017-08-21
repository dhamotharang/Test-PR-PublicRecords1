IMPORT PRTE2_PhonesPlus, AutoKeyB2, Autokey, RoxieKeyBuild, phonesplus_v2, NID, ut, doxie;

EXPORT proc_build_autokeys(string filedate) := FUNCTION

		AutoKey.Keys(Files.dist_DSphonesplus,fname,mname,lname,
							zero,
							zero,
							cellphone,
							prim_name,prim_range,state,p_city_name,zip5,sec_range,
							zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,zero,zero,
							lookups,
							fdid,
							'~prte::key::phonesplusv2',
							Address_Key,CityStName_Key,Name_Key,Phone_Key,Phone_Key2,SSN_Key,SSN_Key2,StName_Key,Zip_Key,ZipPRLname_Key
							,4,true,0,Phonesplus_v2)	

//Build royalty autokeys - NOTE - blank keys so using autokey.key macro to just build needed keys
			AutoKey.Keys(Files.dist_DSphonesplus_roy,fname,mname,lname,
							zero,
							zero,
							cellphone,
							prim_name,prim_range,state,p_city_name,zip5,sec_range,
							zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,zero,zero,
							lookups,
							fdid,
							'~prte::key::phonesplusv2_royalty',
							roy_Address_Key,roy_CityStName_Key,roy_Name_Key,roy_Phone_Key,roy_Phone_Key2,roy_SSN_Key,roy_SSN_Key2,roy_StName_Key,roy_Zip_Key,roy_ZipPRLname_Key
							,4,true,0,Phonesplus_v2);

//Move keys to built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::address', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::address',mv_address_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::citystname', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::citystname',mv_citystname_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::name', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::name',mv_name_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::phone', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::phone',mv_phone_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::ssn', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::ssn',mv_ssn_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::stname', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::stname',mv_stname_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::zip', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::zip',mv_zip_key);

//Move keys to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::address','Q', mv_address_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::citystname','Q', mv_citystname_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::name','Q', mv_name_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::phone','Q', mv_phone_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::ssn','Q', mv_ssn_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::stname','Q', mv_stname_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::zip','Q', mv_zip_QA);
	
	RETURN Sequential(
								Parallel(build(Address_Key, '~prte::key::phonesplusv2::' + filedate+ '::address',sorted)
												,build(CityStName_Key, '~prte::key::phonesplusv2::' + filedate+ '::citystname',sorted)			
												,build(Name_Key, '~prte::key::phonesplusv2::' + filedate+ '::name',sorted)	
												,build(Phone_Key, '~prte::key::phonesplusv2::' + filedate+ '::phone',sorted)				
												,build(SSN_Key, '~prte::key::phonesplusv2::' + filedate+ '::ssn',sorted)	
												,build(Stname_Key, '~prte::key::phonesplusv2::' + filedate+ '::stname',sorted)	
												,build(Zip_Key, '~prte::key::phonesplusv2::' + filedate+ '::zip',sorted)
	//blank keys, no need to version
												,build(roy_Address_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::address',sorted)
												,build(roy_CityStName_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::citystname',sorted)			
												,build(roy_Name_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::name',sorted)	
												,build(roy_Phone_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::phone',sorted)				
												,build(roy_SSN_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::ssn',sorted)	
												,build(roy_Stname_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::stname',sorted)	
												,build(roy_Zip_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::zip',sorted)),
								Parallel(mv_address_key, mv_citystname_key, mv_name_key, mv_phone_key, mv_ssn_key, mv_stname_key, mv_zip_key),
								Parallel(mv_address_QA, mv_citystname_QA, mv_name_QA, mv_phone_QA, mv_ssn_QA, mv_stname_QA, mv_zip_QA)
								);
END;