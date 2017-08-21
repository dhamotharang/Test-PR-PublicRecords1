EXPORT Out_SearchFile_Stats_Population(pVersion,zOut) := MACRO

import STRATA;

rPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_SearchFile
 :=
  record
    CountGroup                                                                                         := count(group);
    seisint_primary_key_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.seisint_primary_key<>'',1,0));
    dt_last_reported_CountNonBlank                     := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.dt_last_reported<>'',1,0));
    vendor_code_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.vendor_code<>'',1,0));
    OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.source_file;
    OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.orig_state;
    name_orig_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.name_orig<>'',1,0));
    name_type_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.name_type<>'',1,0));
    ssn_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.ssn<>'',1,0));
    dob_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.dob<>'',1,0));
    dob_aka_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.dob_aka<>'',1,0));
    registration_address_1_CountNonBlank               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.registration_address_1<>'',1,0));
    registration_address_2_CountNonBlank               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.registration_address_2<>'',1,0));
    registration_address_3_CountNonBlank               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.registration_address_3<>'',1,0));
    registration_address_4_CountNonBlank               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.registration_address_4<>'',1,0));
    registration_address_5_CountNonBlank               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.registration_address_5<>'',1,0));
    title_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.title<>'',1,0));
    fname_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.fname<>'',1,0));
    mname_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.mname<>'',1,0));
    lname_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.lname<>'',1,0));
    name_suffix_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.name_suffix<>'',1,0));
    cleaning_score_CountNonBlank                       := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.cleaning_score<>'',1,0));
    prim_range_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.prim_range<>'',1,0));
    predir_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.predir<>'',1,0));
    prim_name_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.addr_suffix<>'',1,0));
    postdir_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.postdir<>'',1,0));
    unit_desig_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.unit_desig<>'',1,0));
    sec_range_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.sec_range<>'',1,0));
    p_city_name_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.v_city_name<>'',1,0));
    st_CountNonBlank                                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.st<>'',1,0));
    zip_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.zip<>'',1,0));
    zip4_CountNonBlank                                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.zip4<>'',1,0));
    cart_CountNonBlank                                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.lot<>'',1,0));
    lot_order_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.lot_order<>'',1,0));
    dpbc_CountNonBlank                                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.dpbc<>'',1,0));
    chk_digit_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.chk_digit<>'',1,0));
    rec_type_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.rec_type<>'',1,0));
    fips_st_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.fips_st<>'',1,0));
    fips_county_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.fips_county<>'',1,0));
    geo_lat_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.geo_lat<>'',1,0));
    geo_long_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.geo_long<>'',1,0));
    msa_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.msa<>'',1,0));
    geo_blk_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.geo_blk<>'',1,0));
    geo_match_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.geo_match<>'',1,0));
    err_stat_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.err_stat<>'',1,0));
    did_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.did<>'',1,0));
    did_score_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.did_score<>'',1,0));
    ssn_appended_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile.ssn_appended<>'',1,0));
  end;

dPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_SearchFile
	:= table(OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile
			,rPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_SearchFile
			,source_file, orig_state
			,few
			);

STRATA.createXMLStats(dPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_SearchFile
					 ,'Sex Offenders'
					 ,'Search File'
					 ,pVersion
					 ,''
					 ,zOut
					 );

ENDMACRO;
