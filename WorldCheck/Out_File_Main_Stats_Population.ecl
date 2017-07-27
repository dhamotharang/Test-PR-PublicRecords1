EXPORT Out_File_Main_Stats_Population (pMain
                                      ,pVersion
									  ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_WorldCheck_file_Main);
	#uniquename(dPopulationStats_WorldCheck_file_Main);
	#uniquename(zMain);

%rPopulationStats_WorldCheck_file_Main% := record
    pMain.Category;
    CountGroup                                         := count(group);
    Key_CountNonZero                                   := sum(group,if(pMain.Key<>0,1,0));
    UID_CountNonZero                                   := sum(group,if(pMain.UID<>0,1,0));
    Name_Orig_CountNonBlank                            := sum(group,if(pMain.Name_Orig<>'',1,0));
    Name_Type_CountNonBlank                            := sum(group,if(pMain.Name_Type<>'',1,0));
    Last_Name_CountNonBlank                            := sum(group,if(pMain.Last_Name<>'',1,0));
    First_Name_CountNonBlank                           := sum(group,if(pMain.First_Name<>'',1,0));
    WC_Title_CountNonBlank                             := sum(group,if(pMain.WC_Title<>'',1,0));
    Sub_Category_CountNonBlank                         := sum(group,if(pMain.Sub_Category<>'',1,0));
    Position_CountNonBlank                             := sum(group,if(pMain.Position<>'',1,0));
    Age_CountNonBlank                                  := sum(group,if(pMain.Age<>'',1,0));
    Date_Of_Birth_CountNonBlank                        := sum(group,if(pMain.Date_Of_Birth<>'',1,0));
    // POB_detail_CountNonZero                            := sum(group,if(pMain.POB_detail<>0,1,0));
    Date_Of_Death_CountNonBlank                        := sum(group,if(pMain.Date_Of_Death<>'',1,0));
    // Passport_detail_CountNonZero                       := sum(group,if(pMain.Passport_detail<>0,1,0));
    Social_Security_Number_CountNonBlank               := sum(group,if(pMain.Social_Security_Number<>'',1,0));
    Address_1_CountNonBlank                            := sum(group,if(pMain.Address_1<>'',1,0));
    Address_2_CountNonBlank                            := sum(group,if(pMain.Address_2<>'',1,0));
    Address_3_CountNonBlank                            := sum(group,if(pMain.Address_3<>'',1,0));
    Address_Country_CountNonBlank                      := sum(group,if(pMain.Address_Country<>'',1,0));
    // Country_detail_CountNonZero                        := sum(group,if(pMain.Country_detail<>0,1,0));
    // Company_detail_CountNonZero                        := sum(group,if(pMain.Company_detail<>0,1,0));
    E_I_Ind_CountNonBlank                              := sum(group,if(pMain.E_I_Ind<>'',1,0));
    // Linked_To_detail_CountNonZero                      := sum(group,if(pMain.Linked_To_detail<>0,1,0));
    Further_Information_CountNonBlank                  := sum(group,if(pMain.Further_Information<>'',1,0));
    // Keyword_detail_CountNonZero                        := sum(group,if(pMain.Keyword_detail<>0,1,0));
    Entered_CountNonBlank                              := sum(group,if(pMain.Entered<>'',1,0));
    Updated_CountNonBlank                              := sum(group,if(pMain.Updated<>'',1,0));
    Editor_CountNonBlank                               := sum(group,if(pMain.Editor<>'',1,0));
    Age_As_Of_Date_CountNonBlank                       := sum(group,if(pMain.Age_As_Of_Date<>'',1,0));
    title_CountNonBlank                                := sum(group,if(pMain.title<>'',1,0));
    fname_CountNonBlank                                := sum(group,if(pMain.fname<>'',1,0));
    mname_CountNonBlank                                := sum(group,if(pMain.mname<>'',1,0));
    lname_CountNonBlank                                := sum(group,if(pMain.lname<>'',1,0));
    name_suffix_CountNonBlank                          := sum(group,if(pMain.name_suffix<>'',1,0));
    name_score_CountNonBlank                           := sum(group,if(pMain.name_score<>'',1,0));
    cname_CountNonBlank                                := sum(group,if(pMain.cname<>'',1,0));
    prim_range_CountNonBlank                           := sum(group,if(pMain.prim_range<>'',1,0));
    predir_CountNonBlank                               := sum(group,if(pMain.predir<>'',1,0));
    prim_name_CountNonBlank                            := sum(group,if(pMain.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                          := sum(group,if(pMain.addr_suffix<>'',1,0));
    postdir_CountNonBlank                              := sum(group,if(pMain.postdir<>'',1,0));
    unit_desig_CountNonBlank                           := sum(group,if(pMain.unit_desig<>'',1,0));
    sec_range_CountNonBlank                            := sum(group,if(pMain.sec_range<>'',1,0));
    p_city_name_CountNonBlank                          := sum(group,if(pMain.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                          := sum(group,if(pMain.v_city_name<>'',1,0));
    st_CountNonBlank                                   := sum(group,if(pMain.st<>'',1,0));
    zip5_CountNonBlank                                 := sum(group,if(pMain.zip5<>'',1,0));
    zip4_CountNonBlank                                 := sum(group,if(pMain.zip4<>'',1,0));
    fips_state_CountNonBlank                           := sum(group,if(pMain.fips_state<>'',1,0));
    fips_county_CountNonBlank                          := sum(group,if(pMain.fips_county<>'',1,0));
    addr_rec_type_CountNonBlank                        := sum(group,if(pMain.addr_rec_type<>'',1,0));
    geo_lat_CountNonBlank                              := sum(group,if(pMain.geo_lat<>'',1,0));
    geo_long_CountNonBlank                             := sum(group,if(pMain.geo_long<>'',1,0));
    cbsa_CountNonBlank                                 := sum(group,if(pMain.cbsa<>'',1,0));
    geo_blk_CountNonBlank                              := sum(group,if(pMain.geo_blk<>'',1,0));
    geo_match_CountNonBlank                            := sum(group,if(pMain.geo_match<>'',1,0));
    cart_CountNonBlank                                 := sum(group,if(pMain.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                           := sum(group,if(pMain.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                  := sum(group,if(pMain.lot<>'',1,0));
    lot_order_CountNonBlank                            := sum(group,if(pMain.lot_order<>'',1,0));
    dpbc_CountNonBlank                                 := sum(group,if(pMain.dpbc<>'',1,0));
    chk_digit_CountNonBlank                            := sum(group,if(pMain.chk_digit<>'',1,0));
    err_stat_CountNonBlank                             := sum(group,if(pMain.err_stat<>'',1,0));
end;
    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_file_Main% := table(pMain
											     ,%rPopulationStats_WorldCheck_file_Main%
											     ,Category
											     ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_file_Main%
					 ,'World Check'
					 ,'Main file'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;