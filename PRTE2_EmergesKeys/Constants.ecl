import data_services;

EXPORT Constants := module

Export In_Hunters := '~PRTE::In::CCW::hunting_fishing';
EXPORT Base_Hunters := data_services.foreign_prod + 'PRTE::Base::CCW::hunting_fishing';

Export In_CCW := '~PRTE::In::CCW::CCW';
EXPORT Base_CCW := data_services.foreign_prod +'PRTE::Base::CCW::CCW';

EXPORT KeyName_CCW := 	'~prte::key::CCW::'; 
EXPORT KeyName_Hunting := 	'~prte::key::hunting_fishing::'; 

Export KeyName_CCW_doxie_did := '~prte::key::ccw_doxie_did_';
Export KeyName_CCW_doxie_did_FCRA := '~prte::key::ccw_doxie_did_fcra_';

Export KeyName_Hunting_doxie_did := '~prte::key::hunters_doxie_did_';
Export KeyName_Hunting_doxie_did_FCRA := '~prte::key::hunters_doxie_did_fcra_';

Export KeyName_Emerges := '~prte::key::emerges::';

EXPORT ak_keyname := KeyName_CCW +'@version@::autokey::';

EXPORT ak_keyname_hunting := KeyName_Hunting +'@version@::autokey::';

EXPORT ak_logical(string filedate) := KeyName_CCW + filedate + '::autokey::'; 
EXPORT ak_logical_hunting (string filedate) := KeyName_hunting + filedate + '::autokey::'; 

export ak_skipSet:= ['P','Q','F','B'];  // B is for no business autokeys to be built
export ak_skip_set_hunting := ['P','B'];

EXPORT ak_typestr := 'BC'; 

// DF-22634: FCRA Consumer Data Field Depreciation
EXPORT  fields_to_clear_hunter_rid  := 'ace_fips_st,active_other,active_status,agecat,antelope,anterless,archery,bear,' +
																			 'biggame,bighorn,blind,bonus,buffalo,combosuper,cougar,crewmemeber,' +
																			 'day1,day14to15,day3,day7,dayfiller,deer,disabled,drawing,' +
																			 'duck,elk,fallfishing,family,fish,freshwater,goose,gun,' +
																			 'headhousehold,historyfiller,hunt,huntfill1,huntfiller,indian,javelina,junior,' +
																			 'lakesandresevoirs,landowner,lifetimepermit,lottery,lowincome,maiden_name,maiden_prior,mail_ace_fips_st,' +
																			 'mail_ace_zip,mail_addr_suffix,mail_addr1,mail_addr2,mail_cart,mail_chk_digit,mail_city,' +
																			 'mail_county,mail_cr_sort_sz,mail_dpbc,mail_err_stat,mail_fipscounty,mail_geo_blk,mail_geo_lat,' +
																			 'mail_geo_long,mail_geo_match,mail_lot,mail_lot_order,mail_msa,mail_p_city_name,mail_postdir,' +
																			 'mail_predir,mail_prim_name,mail_prim_range,mail_record_type,mail_sec_range,mail_st,mail_state,' +
																			 'mail_unit_desig,mail_v_city_name,mail_zip,mail_zip4,migbird,moose,motorvoterid,' +
																			 'muzzle,nonresident,occupation,other_phone,otherbirds,pheasant,phone,place_of_birth,' +
																			 'poliparty,race,record_type,regdate,regioncounty,regsource,res_county,resident,' +
																			 'retarded,salmon,saltwater,seasonannual,seniorcit,serviceman,setlinefish,shellfishcrab,' +
																			 'shellfishlobster,sikebull,skipass,smallgame,snowmobile,source_voterid,sportsman,steelhead,' +
																			 'sturgeon,sturgeon2,trap,trout,turkey,votefiller,votefiller2,voterstatus,whitejubherring,work_phone';

EXPORT fields_to_clear_doxie_did := 'ace_fips_st,active_other,active_status,agecat,antelope,anterless,archery,bear,biggame,'+
																		'bighorn,blind,bonus,buffalo,combosuper,cougar,crewmemeber,day1,day14to15,day3,day7,dayfiller,'+
																		'deer,disabled,drawing,duck,elk,fallfishing,family,fish,freshwater,goose,gun,headhousehold,'+
																		'historyfiller,hunt,huntfill1,huntfiller,indian,javelina,junior,lakesandresevoirs,landowner,'+
																		'lifetimepermit,lottery,lowincome,maiden_name,maiden_prior,mail_ace_fips_st,mail_ace_zip,'+
																		'mail_addr_suffix,mail_addr1,mail_addr2,mail_cart,mail_chk_digit,mail_city,mail_county,mail_cr_sort_sz,'+
																		'mail_dpbc,mail_err_stat,mail_fipscounty,mail_geo_blk,mail_geo_lat,mail_geo_long,mail_geo_match,'+
																		'mail_lot,mail_lot_order,mail_msa,mail_p_city_name,mail_postdir,mail_predir,mail_prim_name,'+
																		'mail_prim_range,mail_record_type,mail_sec_range,mail_st,mail_state,mail_unit_desig,mail_v_city_name,'+
																		'mail_zip,mail_zip4,migbird,moose,motorvoterid,muzzle,nonresident,occupation,other_phone,'+
																		'otherbirds,pheasant,phone,place_of_birth,poliparty,race,record_type,regdate,regioncounty,'+
																		'regsource,res_county,resident,retarded,salmon,saltwater,seasonannual,eniorcit,serviceman,'+
																		'setlinefish,shellfishcrab,shellfishlobster,sikebull,skipass,smallgame,snowmobile,source_voterid,'+
																		'sportsman,steelhead,sturgeon,sturgeon2,trap,trout,turkey,votefiller,votefiller2,voterstatus,'+
																		'whitejubherring,work_phone';
                      
     
END;