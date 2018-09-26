IMPORT ut;

EXPORT fBuild_Key_Huntfish_Rid(BOOLEAN  IsFCRA = FALSE) := FUNCTION

		dBase_temp    := eMerges.huntfish_searchfile;
    
     // DF-21635 - Blank out fields in FCRA file thor_data400::key::hunting_fishing::fcra::qa::rid
     fields_to_clear  := 'ace_fips_st,active_other,active_status,agecat,antelope,anterless,archery,bear,' +
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
                      
     ut.MAC_CLEAR_FIELDS(dBase_temp, dBase_FilterFCRA, fields_to_clear);
     dBase		:= IF(isFCRA,
                    DEDUP(SORT(DISTRIBUTE(dBase_FilterFCRA,rid), RECORD, LOCAL), RECORD, LOCAL),
                    dBase_temp);
     
		RETURN(dBase); 

END;		