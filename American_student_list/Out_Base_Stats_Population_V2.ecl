//Populate strata for American_student_list DID2
IMPORT strata; 

EXPORT Out_Base_Stats_Population_V2(STRING filedate) := FUNCTION



rPopulationStats_American_student_list__File_american_student_DID_v2 := record

		American_student_list.File_american_student_DID_v2.STATE;
    CountGroup                                                := count(group);
    KEY_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.KEY<>0,1,0));
    SSN_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.SSN<>'',1,0));
    DID_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.DID<>0,1,0));
    PROCESS_DATE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.PROCESS_DATE<>'',1,0));
    DATE_FIRST_SEEN_CountNonBlank                             := sum(group,if(American_student_list.File_american_student_DID_v2.DATE_FIRST_SEEN<>'',1,0));
    DATE_LAST_SEEN_CountNonBlank                              := sum(group,if(American_student_list.File_american_student_DID_v2.DATE_LAST_SEEN<>'',1,0));
    DATE_VENDOR_FIRST_REPORTED_CountNonBlank                  := sum(group,if(American_student_list.File_american_student_DID_v2.DATE_VENDOR_FIRST_REPORTED<>'',1,0));
    DATE_VENDOR_LAST_REPORTED_CountNonBlank                   := sum(group,if(American_student_list.File_american_student_DID_v2.DATE_VENDOR_LAST_REPORTED<>'',1,0));
		//V2 field
    HISTORICAL_FLAG_CountNonBlank                   					:= sum(group,if(American_student_list.File_american_student_DID_v2.HISTORICAL_FLAG<>'',1,0));
    FULL_NAME_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.FULL_NAME<>'',1,0));
    FIRST_NAME_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID_v2.FIRST_NAME<>'',1,0));
    LAST_NAME_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.LAST_NAME<>'',1,0));
    ADDRESS_1_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.ADDRESS_1<>'',1,0));
    ADDRESS_2_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.ADDRESS_2<>'',1,0));
    CITY_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID_v2.CITY<>'',1,0));
    //STATE_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.STATE<>'',1,0));
    ZIP_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.ZIP<>'',1,0));
    ZIP_4_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.ZIP_4<>'',1,0));
		CRRT_CODE_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.CRRT_CODE<>'',1,0));
    DELIVERY_POINT_BARCODE_CountNonBlank                      := sum(group,if(American_student_list.File_american_student_DID_v2.DELIVERY_POINT_BARCODE<>'',1,0));
    ZIP4_CHECK_DIGIT_CountNonBlank                            := sum(group,if(American_student_list.File_american_student_DID_v2.ZIP4_CHECK_DIGIT<>'',1,0));
    ADDRESS_TYPE_CODE_CountNonBlank                           := sum(group,if(American_student_list.File_american_student_DID_v2.ADDRESS_TYPE_CODE<>'',1,0));
    ADDRESS_TYPE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.ADDRESS_TYPE<>'',1,0));
    COUNTY_NUMBER_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID_v2.COUNTY_NUMBER<>'',1,0));
    COUNTY_NAME_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.COUNTY_NAME<>'',1,0));
    GENDER_CODE_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.GENDER_CODE<>'',1,0));
    GENDER_CountNonBlank                                      := sum(group,if(American_student_list.File_american_student_DID_v2.GENDER<>'',1,0));
    AGE_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.AGE<>'',1,0));
    BIRTH_DATE_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID_v2.BIRTH_DATE<>'',1,0));
    DOB_FORMATTED_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID_v2.DOB_FORMATTED<>'',1,0));
    TELEPHONE_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.TELEPHONE<>'',1,0));
    CLASS_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.CLASS<>'',1,0));
    COLLEGE_CLASS_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_CLASS<>'',1,0));
    COLLEGE_NAME_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_NAME<>'',1,0));
 		//V2 field
    LN_COLLEGE_NAME_CountNonBlank                             := sum(group,if(American_student_list.File_american_student_DID_v2.LN_COLLEGE_NAME<>'',1,0));
		COLLEGE_MAJOR_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_MAJOR<>'',1,0));
    COLLEGE_CODE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_CODE<>'',1,0));
    COLLEGE_CODE_EXPLODED_CountNonBlank                       := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_CODE_EXPLODED<>'',1,0));
    COLLEGE_TYPE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_TYPE<>'',1,0));
    COLLEGE_TYPE_EXPLODED_CountNonBlank                       := sum(group,if(American_student_list.File_american_student_DID_v2.COLLEGE_TYPE_EXPLODED<>'',1,0));
    HEAD_OF_HOUSEHOLD_FIRST_NAME_CountNonBlank                := sum(group,if(American_student_list.File_american_student_DID_v2.HEAD_OF_HOUSEHOLD_FIRST_NAME<>'',1,0));
    HEAD_OF_HOUSEHOLD_GENDER_CODE_CountNonBlank               := sum(group,if(American_student_list.File_american_student_DID_v2.HEAD_OF_HOUSEHOLD_GENDER_CODE<>'',1,0));
    HEAD_OF_HOUSEHOLD_GENDER_CountNonBlank                    := sum(group,if(American_student_list.File_american_student_DID_v2.HEAD_OF_HOUSEHOLD_GENDER<>'',1,0));
    INCOME_LEVEL_CODE_CountNonBlank                           := sum(group,if(American_student_list.File_american_student_DID_v2.INCOME_LEVEL_CODE<>'',1,0));
    INCOME_LEVEL_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.INCOME_LEVEL<>'',1,0));
    FILE_TYPE_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.FILE_TYPE<>'',1,0));
 		//V2 fields - being
    tier_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID_v2.tier<>'',1,0));
    school_size_code_CountNonBlank                            := sum(group,if(American_student_list.File_american_student_DID_v2.school_size_code<>'',1,0));
    competitive_code_CountNonBlank                            := sum(group,if(American_student_list.File_american_student_DID_v2.competitive_code<>'',1,0));
    tuition_code_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID_v2.tuition_code<>'',1,0));
 		//V2 fields - end
    title_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.title<>'',1,0));
    fname_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.fname<>'',1,0));
    mname_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.mname<>'',1,0));
    lname_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID_v2.lname<>'',1,0));
    name_suffix_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.name_suffix<>'',1,0));
    name_score_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID_v2.name_score<>'',1,0));
 		//V2 field
    RawAID_CountNonBlank                                  		:= sum(group,if(American_student_list.File_american_student_DID_v2.RawAID<>0,1,0));
    prim_range_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID_v2.prim_range<>'',1,0));
    predir_CountNonBlank                                      := sum(group,if(American_student_list.File_american_student_DID_v2.predir<>'',1,0));
    prim_name_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                     := sum(group,if(American_student_list.File_american_student_DID_v2.postdir<>'',1,0));
    unit_desig_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID_v2.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.v_city_name<>'',1,0));
    st_CountNonBlank                                          := sum(group,if(American_student_list.File_american_student_DID_v2.st<>'',1,0));
    z5_CountNonBlank                                          := sum(group,if(American_student_list.File_american_student_DID_v2.z5<>'',1,0));
    zip4_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID_v2.zip4<>'',1,0));
    cart_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID_v2.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID_v2.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.lot<>'',1,0));
    lot_order_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.lot_order<>'',1,0));
    dpbc_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID_v2.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                    := sum(group,if(American_student_list.File_american_student_DID_v2.rec_type<>'',1,0));
 		//V2 field
    county_CountNonBlank                                    	:= sum(group,if(American_student_list.File_american_student_DID_v2.county<>'',1,0));
    ace_fips_st_CountNonBlank                                 	:= sum(group,if(American_student_list.File_american_student_DID_v2.ace_fips_st<>'',1,0));
    fips_county_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID_v2.fips_county<>'',1,0));
    geo_lat_CountNonBlank                                     := sum(group,if(American_student_list.File_american_student_DID_v2.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                    := sum(group,if(American_student_list.File_american_student_DID_v2.geo_long<>'',1,0));
    msa_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID_v2.msa<>'',1,0));
    geo_blk_CountNonBlank                                     := sum(group,if(American_student_list.File_american_student_DID_v2.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID_v2.geo_match<>'',1,0));
    err_stat_CountNonBlank                                    := sum(group,if(American_student_list.File_american_student_DID_v2.err_stat<>'',1,0));
		//Added for Shell 5.0 project 6/11/13
    tier2_CountNonBlank                                    		:= sum(group,if(American_student_list.File_american_student_DID_v2.tier2<>'',1,0));

  END;

dPopulationStats_American_student_list__File_american_student_DID_v2 := 
                    table(American_student_list.File_american_student_DID_v2,
													rPopulationStats_American_student_list__File_american_student_DID_v2,
													STATE,
													few
									        );



STRATA.createXMLStats(dPopulationStats_American_student_list__File_american_student_DID_v2,
                      'American Student List Version 2',
											'data',
											filedate,
											'',
											resultsOut,
											'view2',
											'population'
										 );
					 
return resultsOut;

end;