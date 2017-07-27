import strata; 

export Out_Base_Stats_Population(string filedate) :=
function

rPopulationStats_American_student_list__File_american_student_DID
 :=
  record
    CountGroup                                                                                               := count(group);
    KEY_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.KEY<>0,1,0));
    SSN_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.SSN<>'',1,0));
    DID_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.DID<>0,1,0));
    PROCESS_DATE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID.PROCESS_DATE<>'',1,0));
    DATE_FIRST_SEEN_CountNonBlank                             := sum(group,if(American_student_list.File_american_student_DID.DATE_FIRST_SEEN<>'',1,0));
    DATE_LAST_SEEN_CountNonBlank                              := sum(group,if(American_student_list.File_american_student_DID.DATE_LAST_SEEN<>'',1,0));
    DATE_VENDOR_FIRST_REPORTED_CountNonBlank                  := sum(group,if(American_student_list.File_american_student_DID.DATE_VENDOR_FIRST_REPORTED<>'',1,0));
    DATE_VENDOR_LAST_REPORTED_CountNonBlank                   := sum(group,if(American_student_list.File_american_student_DID.DATE_VENDOR_LAST_REPORTED<>'',1,0));
    FULL_NAME_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.FULL_NAME<>'',1,0));
    FIRST_NAME_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID.FIRST_NAME<>'',1,0));
    LAST_NAME_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.LAST_NAME<>'',1,0));
    ADDRESS_1_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.ADDRESS_1<>'',1,0));
    ADDRESS_2_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.ADDRESS_2<>'',1,0));
    CITY_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID.CITY<>'',1,0));
    American_student_list.File_american_student_DID.STATE;
    ZIP_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.ZIP<>'',1,0));
    ZIP_4_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID.ZIP_4<>'',1,0));
    CRRT_CODE_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.CRRT_CODE<>'',1,0));
    DELIVERY_POINT_BARCODE_CountNonBlank                      := sum(group,if(American_student_list.File_american_student_DID.DELIVERY_POINT_BARCODE<>'',1,0));
    ZIP4_CHECK_DIGIT_CountNonBlank                            := sum(group,if(American_student_list.File_american_student_DID.ZIP4_CHECK_DIGIT<>'',1,0));
    ADDRESS_TYPE_CODE_CountNonBlank                           := sum(group,if(American_student_list.File_american_student_DID.ADDRESS_TYPE_CODE<>'',1,0));
    ADDRESS_TYPE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID.ADDRESS_TYPE<>'',1,0));
    COUNTY_NUMBER_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID.COUNTY_NUMBER<>'',1,0));
    COUNTY_NAME_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.COUNTY_NAME<>'',1,0));
    GENDER_CODE_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.GENDER_CODE<>'',1,0));
    GENDER_CountNonBlank                                      := sum(group,if(American_student_list.File_american_student_DID.GENDER<>'',1,0));
    AGE_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.AGE<>'',1,0));
    BIRTH_DATE_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID.BIRTH_DATE<>'',1,0));
    DOB_FORMATTED_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID.DOB_FORMATTED<>'',1,0));
    TELEPHONE_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.TELEPHONE<>'',1,0));
    CLASS_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID.CLASS<>'',1,0));
    COLLEGE_CLASS_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_CLASS<>'',1,0));
    COLLEGE_NAME_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_NAME<>'',1,0));
		COLLEGE_MAJOR_CountNonBlank                               := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_MAJOR<>'',1,0));
    COLLEGE_CODE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_CODE<>'',1,0));
    COLLEGE_CODE_EXPLODED_CountNonBlank                       := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_CODE_EXPLODED<>'',1,0));
    COLLEGE_TYPE_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_TYPE<>'',1,0));
    COLLEGE_TYPE_EXPLODED_CountNonBlank                       := sum(group,if(American_student_list.File_american_student_DID.COLLEGE_TYPE_EXPLODED<>'',1,0));
    HEAD_OF_HOUSEHOLD_FIRST_NAME_CountNonBlank                := sum(group,if(American_student_list.File_american_student_DID.HEAD_OF_HOUSEHOLD_FIRST_NAME<>'',1,0));
    HEAD_OF_HOUSEHOLD_GENDER_CODE_CountNonBlank               := sum(group,if(American_student_list.File_american_student_DID.HEAD_OF_HOUSEHOLD_GENDER_CODE<>'',1,0));
    HEAD_OF_HOUSEHOLD_GENDER_CountNonBlank                    := sum(group,if(American_student_list.File_american_student_DID.HEAD_OF_HOUSEHOLD_GENDER<>'',1,0));
    INCOME_LEVEL_CODE_CountNonBlank                           := sum(group,if(American_student_list.File_american_student_DID.INCOME_LEVEL_CODE<>'',1,0));
    INCOME_LEVEL_CountNonBlank                                := sum(group,if(American_student_list.File_american_student_DID.INCOME_LEVEL<>'',1,0));
    FILE_TYPE_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.FILE_TYPE<>'',1,0));
    title_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID.title<>'',1,0));
    fname_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID.fname<>'',1,0));
    mname_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID.mname<>'',1,0));
    lname_CountNonBlank                                       := sum(group,if(American_student_list.File_american_student_DID.lname<>'',1,0));
    name_suffix_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.name_suffix<>'',1,0));
    name_score_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID.name_score<>'',1,0));
    prim_range_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID.prim_range<>'',1,0));
    predir_CountNonBlank                                      := sum(group,if(American_student_list.File_american_student_DID.predir<>'',1,0));
    prim_name_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                     := sum(group,if(American_student_list.File_american_student_DID.postdir<>'',1,0));
    unit_desig_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.v_city_name<>'',1,0));
    st_CountNonBlank                                          := sum(group,if(American_student_list.File_american_student_DID.st<>'',1,0));
    z5_CountNonBlank                                          := sum(group,if(American_student_list.File_american_student_DID.z5<>'',1,0));
    zip4_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID.zip4<>'',1,0));
    cart_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                  := sum(group,if(American_student_list.File_american_student_DID.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.lot<>'',1,0));
    lot_order_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.lot_order<>'',1,0));
    dpbc_CountNonBlank                                        := sum(group,if(American_student_list.File_american_student_DID.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                    := sum(group,if(American_student_list.File_american_student_DID.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.ace_fips_st<>'',1,0));
    fips_county_CountNonBlank                                 := sum(group,if(American_student_list.File_american_student_DID.fips_county<>'',1,0));
    geo_lat_CountNonBlank                                     := sum(group,if(American_student_list.File_american_student_DID.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                    := sum(group,if(American_student_list.File_american_student_DID.geo_long<>'',1,0));
    msa_CountNonBlank                                         := sum(group,if(American_student_list.File_american_student_DID.msa<>'',1,0));
    geo_blk_CountNonBlank                                     := sum(group,if(American_student_list.File_american_student_DID.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                   := sum(group,if(American_student_list.File_american_student_DID.geo_match<>'',1,0));
    err_stat_CountNonBlank                                    := sum(group,if(American_student_list.File_american_student_DID.err_stat<>'',1,0));
  end;

dPopulationStats_American_student_list__File_american_student_DID := table(American_student_list.File_american_student_DID,
													rPopulationStats_American_student_list__File_american_student_DID,
													STATE,
													few
									               );

STRATA.createXMLStats(dPopulationStats_American_student_list__File_american_student_DID,
                      'American Student List v2',
					  'data',
					  filedate,
					  '',
					  resultsOut,
					  'view',
					  'population'
					 );
					 
return resultsOut;

end;