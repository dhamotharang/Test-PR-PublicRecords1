import STRATA;

export out_STRATA_population_stats(pMain
                                  ,pParty
								  ,pVersion
								  ,zOut) := MACRO

	#uniquename(rPopulationStats_pMain);
	#uniquename(dPopulationStats_pMain);
	#uniquename(zMainStats);
	#uniquename(rPopulationStats_pParty);
	#uniquename(dPopulationStats_pParty);
	#uniquename(zPartyStats);
    #uniquename(rDIDstats_pParty);
    #uniquename(dDIDstats_pParty);
	#uniquename(zPartyDIDStats);

%rPopulationStats_pMain%
 :=
  record
    
	integer countGroup := count(group);

    Vehicle_Key_CountNonBlank                                  := sum(group,if(pMain.Vehicle_Key<>'',1,0));
    Iteration_Key_CountNonBlank                                := sum(group,if(pMain.Iteration_Key<>'',1,0));
    pMain.Source_Code;
    pMain.State_Origin;
    State_Bitmap_Flag_CountNonZero                             := sum(group,if(pMain.State_Bitmap_Flag<>0,1,0));
    Orig_VIN_CountNonBlank                                     := sum(group,if(pMain.Orig_VIN<>'',1,0));
    Orig_Year_CountNonBlank                                    := sum(group,if(pMain.Orig_Year<>'',1,0));
    Orig_Make_Code_CountNonBlank                               := sum(group,if(pMain.Orig_Make_Code<>'',1,0));
    Orig_Make_Desc_CountNonBlank                               := sum(group,if(pMain.Orig_Make_Desc<>'',1,0));
    Orig_Series_Code_CountNonBlank                             := sum(group,if(pMain.Orig_Series_Code<>'',1,0));
    Orig_Series_Desc_CountNonBlank                             := sum(group,if(pMain.Orig_Series_Desc<>'',1,0));
    Orig_Model_Code_CountNonBlank                              := sum(group,if(pMain.Orig_Model_Code<>'',1,0));
    Orig_Model_Desc_CountNonBlank                              := sum(group,if(pMain.Orig_Model_Desc<>'',1,0));
    Orig_Body_Code_CountNonBlank                               := sum(group,if(pMain.Orig_Body_Code<>'',1,0));
    Orig_Body_Desc_CountNonBlank                               := sum(group,if(pMain.Orig_Body_Desc<>'',1,0));
    Orig_Net_Weight_CountNonBlank                              := sum(group,if(pMain.Orig_Net_Weight<>'',1,0));
    Orig_Gross_Weight_CountNonBlank                            := sum(group,if(pMain.Orig_Gross_Weight<>'',1,0));
    Orig_Number_Of_Axles_CountNonBlank                         := sum(group,if(pMain.Orig_Number_Of_Axles<>'',1,0));
    Orig_Vehicle_Use_code_CountNonBlank                        := sum(group,if(pMain.Orig_Vehicle_Use_code<>'',1,0));
    Orig_Vehicle_Use_Desc_CountNonBlank                        := sum(group,if(pMain.Orig_Vehicle_Use_Desc<>'',1,0));
    Orig_Vehicle_Type_Code_CountNonBlank                       := sum(group,if(pMain.Orig_Vehicle_Type_Code<>'',1,0));
    Orig_Vehicle_Type_Desc_CountNonBlank                       := sum(group,if(pMain.Orig_Vehicle_Type_Desc<>'',1,0));
    Orig_Major_Color_Code_CountNonBlank                        := sum(group,if(pMain.Orig_Major_Color_Code<>'',1,0));
    Orig_Major_Color_Desc_CountNonBlank                        := sum(group,if(pMain.Orig_Major_Color_Desc<>'',1,0));
    Orig_Minor_Color_Code_CountNonBlank                        := sum(group,if(pMain.Orig_Minor_Color_Code<>'',1,0));
    Orig_Minor_Color_Desc_CountNonBlank                        := sum(group,if(pMain.Orig_Minor_Color_Desc<>'',1,0));
    VINA_Veh_Type_CountNonBlank                                := sum(group,if(pMain.VINA_Veh_Type<>'',1,0));
    VINA_NCIC_Make_CountNonBlank                               := sum(group,if(pMain.VINA_NCIC_Make<>'',1,0));
    VINA_Model_Year_YY_CountNonBlank                           := sum(group,if(pMain.VINA_Model_Year_YY<>'',1,0));
    VINA_VIN_CountNonBlank                                     := sum(group,if(pMain.VINA_VIN<>'',1,0));
    VINA_VIN_Pattern_Indicator_CountNonBlank                   := sum(group,if(pMain.VINA_VIN_Pattern_Indicator<>'',1,0));
    VINA_Bypass_Code_CountNonBlank                             := sum(group,if(pMain.VINA_Bypass_Code<>'',1,0));
    VINA_VP_Restraint_CountNonBlank                            := sum(group,if(pMain.VINA_VP_Restraint<>'',1,0));
    VINA_VP_Abbrev_Make_Name_CountNonBlank                     := sum(group,if(pMain.VINA_VP_Abbrev_Make_Name<>'',1,0));
    VINA_VP_Year_CountNonBlank                                 := sum(group,if(pMain.VINA_VP_Year<>'',1,0));
    VINA_VP_Series_CountNonBlank                               := sum(group,if(pMain.VINA_VP_Series<>'',1,0));
    VINA_VP_Model_CountNonBlank                                := sum(group,if(pMain.VINA_VP_Model<>'',1,0));
    VINA_VP_Air_Conditioning_CountNonBlank                     := sum(group,if(pMain.VINA_VP_Air_Conditioning<>'',1,0));
    VINA_VP_Power_Steering_CountNonBlank                       := sum(group,if(pMain.VINA_VP_Power_Steering<>'',1,0));
    VINA_VP_Power_Brakes_CountNonBlank                         := sum(group,if(pMain.VINA_VP_Power_Brakes<>'',1,0));
    VINA_VP_Power_Windows_CountNonBlank                        := sum(group,if(pMain.VINA_VP_Power_Windows<>'',1,0));
    VINA_VP_Tilt_Wheel_CountNonBlank                           := sum(group,if(pMain.VINA_VP_Tilt_Wheel<>'',1,0));
    VINA_VP_Roof_CountNonBlank                                 := sum(group,if(pMain.VINA_VP_Roof<>'',1,0));
    VINA_VP_Optional_Roof1_CountNonBlank                       := sum(group,if(pMain.VINA_VP_Optional_Roof1<>'',1,0));
    VINA_VP_Optional_Roof2_CountNonBlank                       := sum(group,if(pMain.VINA_VP_Optional_Roof2<>'',1,0));
    VINA_VP_Radio_CountNonBlank                                := sum(group,if(pMain.VINA_VP_Radio<>'',1,0));
    VINA_VP_Optional_Radio1_CountNonBlank                      := sum(group,if(pMain.VINA_VP_Optional_Radio1<>'',1,0));
    VINA_VP_Optional_Radio2_CountNonBlank                      := sum(group,if(pMain.VINA_VP_Optional_Radio2<>'',1,0));
    VINA_VP_Transmission_CountNonBlank                         := sum(group,if(pMain.VINA_VP_Transmission<>'',1,0));
    VINA_VP_Optional_Transmission1_CountNonBlank               := sum(group,if(pMain.VINA_VP_Optional_Transmission1<>'',1,0));
    VINA_VP_Optional_Transmission2_CountNonBlank               := sum(group,if(pMain.VINA_VP_Optional_Transmission2<>'',1,0));
    VINA_VP_Anti_Lock_Brakes_CountNonBlank                     := sum(group,if(pMain.VINA_VP_Anti_Lock_Brakes<>'',1,0));
    VINA_VP_Front_Wheel_Drive_CountNonBlank                    := sum(group,if(pMain.VINA_VP_Front_Wheel_Drive<>'',1,0));
    VINA_VP_Four_Wheel_Drive_CountNonBlank                     := sum(group,if(pMain.VINA_VP_Four_Wheel_Drive<>'',1,0));
    VINA_VP_Security_System_CountNonBlank                      := sum(group,if(pMain.VINA_VP_Security_System<>'',1,0));
    VINA_VP_Daytime_Running_Lights_CountNonBlank               := sum(group,if(pMain.VINA_VP_Daytime_Running_Lights<>'',1,0));
    VINA_VP_Series_Name_CountNonBlank                          := sum(group,if(pMain.VINA_VP_Series_Name<>'',1,0));
    VINA_Model_Year_CountNonBlank                              := sum(group,if(pMain.VINA_Model_Year<>'',1,0));
    VINA_Series_CountNonBlank                                  := sum(group,if(pMain.VINA_Series<>'',1,0));
    VINA_Model_CountNonBlank                                   := sum(group,if(pMain.VINA_Model<>'',1,0));
    VINA_Body_Style_CountNonBlank                              := sum(group,if(pMain.VINA_Body_Style<>'',1,0));
    VINA_Make_Desc_CountNonBlank                               := sum(group,if(pMain.VINA_Make_Desc<>'',1,0));
    VINA_Model_Desc_CountNonBlank                              := sum(group,if(pMain.VINA_Model_Desc<>'',1,0));
    VINA_Series_Desc_CountNonBlank                             := sum(group,if(pMain.VINA_Series_Desc<>'',1,0));
    VINA_Body_Style_Desc_CountNonBlank                         := sum(group,if(pMain.VINA_Body_Style_Desc<>'',1,0));
    VINA_Number_Of_Cylinders_CountNonBlank                     := sum(group,if(pMain.VINA_Number_Of_Cylinders<>'',1,0));
    VINA_Engine_Size_CountNonBlank                             := sum(group,if(pMain.VINA_Engine_Size<>'',1,0));
    VINA_Fuel_Code_CountNonBlank                               := sum(group,if(pMain.VINA_Fuel_Code<>'',1,0));
    VINA_Price_CountNonBlank                                   := sum(group,if(pMain.VINA_Price<>'',1,0));
    Best_Make_Code_CountNonBlank                               := sum(group,if(pMain.Best_Make_Code<>'',1,0));
    Best_Series_Code_CountNonBlank                             := sum(group,if(pMain.Best_Series_Code<>'',1,0));
    Best_Model_Code_CountNonBlank                              := sum(group,if(pMain.Best_Model_Code<>'',1,0));
    Best_Body_Code_CountNonBlank                               := sum(group,if(pMain.Best_Body_Code<>'',1,0));
    Best_Model_Year_CountNonBlank                              := sum(group,if(pMain.Best_Model_Year<>'',1,0));
    Best_Major_Color_Code_CountNonBlank                        := sum(group,if(pMain.Best_Major_Color_Code<>'',1,0));
    Best_Minor_Color_Code_CountNonBlank                        := sum(group,if(pMain.Best_Minor_Color_Code<>'',1,0));
  end;
    
%rPopulationStats_pParty%
 :=

  record
    
	integer countGroup := count(group);

    Vehicle_Key_CountNonBlank                                 := sum(group,if(pParty.Vehicle_Key<>'',1,0));
    Iteration_Key_CountNonBlank                               := sum(group,if(pParty.Iteration_Key<>'',1,0));
    Sequence_Key_CountNonBlank                                := sum(group,if(pParty.Sequence_Key<>'',1,0));
    pParty.Source_Code;
    pParty.State_Origin;
    State_Bitmap_Flag_CountNonZero                            := sum(group,if(pParty.State_Bitmap_Flag<>0,1,0));
    Latest_Vehicle_Flag_CountNonBlank                         := sum(group,if(pParty.Latest_Vehicle_Flag<>'',1,0));
    Latest_Vehicle_Iteration_Flag_CountNonBlank               := sum(group,if(pParty.Latest_Vehicle_Iteration_Flag<>'',1,0));
    History_CountNonBlank                                     := sum(group,if(pParty.History<>'',1,0));
    Date_First_Seen_CountNonZero                              := sum(group,if(pParty.Date_First_Seen<>0,1,0));
    Date_Last_Seen_CountNonZero                               := sum(group,if(pParty.Date_Last_Seen<>0,1,0));
    Date_Vendor_First_Reported_CountNonZero                   := sum(group,if(pParty.Date_Vendor_First_Reported<>0,1,0));
    Date_Vendor_Last_Reported_CountNonZero                    := sum(group,if(pParty.Date_Vendor_Last_Reported<>0,1,0));
    Orig_Party_Type_CountNonBlank                             := sum(group,if(pParty.Orig_Party_Type<>'',1,0));
    Orig_Name_Type_CountNonBlank                              := sum(group,if(pParty.Orig_Name_Type<>'',1,0));
    Orig_Conjunction_CountNonBlank                            := sum(group,if(pParty.Orig_Conjunction<>'',1,0));
    Orig_Name_CountNonBlank                                   := sum(group,if(pParty.Orig_Name<>'',1,0));
    Orig_Address_CountNonBlank                                := sum(group,if(pParty.Orig_Address<>'',1,0));
    Orig_City_CountNonBlank                                   := sum(group,if(pParty.Orig_City<>'',1,0));
    Orig_State_CountNonBlank                                  := sum(group,if(pParty.Orig_State<>'',1,0));
    orig_province_CountNonZero                                := sum(group,if(pParty.orig_province<> '',1,0));
    orig_country_CountNonZero                                 := sum(group,if(pParty.orig_country<> '',1,0));
    Orig_Zip_CountNonBlank                                    := sum(group,if(pParty.Orig_Zip<>'',1,0));
    Orig_SSN_CountNonBlank                                    := sum(group,if(pParty.Orig_SSN<>'',1,0));
    Orig_FEIN_CountNonBlank                                   := sum(group,if(pParty.Orig_FEIN<>'',1,0));
    Orig_DL_Number_CountNonBlank                              := sum(group,if(pParty.Orig_DL_Number<>'',1,0));
    Orig_DOB_CountNonBlank                                    := sum(group,if(pParty.Orig_DOB<>'',1,0));
    Orig_Sex_CountNonBlank                                    := sum(group,if(pParty.Orig_Sex<>'',1,0));
    Orig_Lien_Date_CountNonBlank                              := sum(group,if(pParty.Orig_Lien_Date<>'',1,0));
    title_CountNonBlank                                    := sum(group,if(pParty.Append_Clean_Name.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pParty.Append_Clean_Name.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pParty.Append_Clean_Name.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pParty.Append_Clean_Name.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pParty.Append_Clean_Name.name_suffix<>'',1,0));
    name_score_CountNonBlank                               := sum(group,if(pParty.Append_Clean_Name.name_score<>'',1,0));
    Append_Clean_CName_CountNonBlank                       := sum(group,if(pParty.Append_Clean_CName<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(pParty.Append_Clean_Address.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(pParty.Append_Clean_Address.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(pParty.Append_Clean_Address.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                              := sum(group,if(pParty.Append_Clean_Address.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(pParty.Append_Clean_Address.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(pParty.Append_Clean_Address.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(pParty.Append_Clean_Address.sec_range<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(pParty.Append_Clean_Address.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(pParty.Append_Clean_Address.st<>'',1,0));
    zip_CountNonBlank                                      := sum(group,if(pParty.Append_Clean_Address.zip5<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(pParty.Append_Clean_Address.zip4<>'',1,0));
    addr_rec_type_CountNonBlank                            := sum(group,if(pParty.Append_Clean_Address.addr_rec_type<>'',1,0));
	fips_state_CountNonBlank                               := sum(group,if(pParty.Append_Clean_Address.fips_state<>'',1,0));
    fips_county_CountNonBlank                              := sum(group,if(pParty.Append_Clean_Address.fips_county<>'',1,0));
    geo_lat_CountNonBlank                                  := sum(group,if(pParty.Append_Clean_Address.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                 := sum(group,if(pParty.Append_Clean_Address.geo_long<>'',1,0));
    cbsa_CountNonBlank                                     := sum(group,if(pParty.Append_Clean_Address.cbsa<>'',1,0));
	geo_blk_CountNonBlank                                  := sum(group,if(pParty.Append_Clean_Address.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                := sum(group,if(pParty.Append_Clean_Address.geo_match<>'',1,0));
    err_stat_CountNonBlank                                 := sum(group,if(pParty.Append_Clean_Address.err_stat<>'',1,0));
    Append_DID_CountNonZero                                   := sum(group,if(pParty.Append_DID<>0,1,0));
    Append_DID_Score_CountNonZero                             := sum(group,if(pParty.Append_DID_Score<>0,1,0));
    Append_BDID_CountNonZero                                  := sum(group,if(pParty.Append_BDID<>0,1,0));
    Append_BDID_Score_CountNonZero                            := sum(group,if(pParty.Append_BDID_Score<>0,1,0));
    Append_DL_Number_CountNonBlank                            := sum(group,if(pParty.Append_DL_Number<>'',1,0));
    Append_SSN_CountNonBlank                                  := sum(group,if(pParty.Append_SSN<>'',1,0));
    Append_FEIN_CountNonBlank                                 := sum(group,if(pParty.Append_FEIN<>'',1,0));
    Append_DOB_CountNonBlank                                  := sum(group,if(pParty.Append_DOB<>'',1,0));
    Reg_First_Date_CountNonBlank                              := sum(group,if(pParty.Reg_First_Date<>'',1,0));
    Reg_Earliest_Effective_Date_CountNonBlank                 := sum(group,if(pParty.Reg_Earliest_Effective_Date<>'',1,0));
    Reg_Latest_Effective_Date_CountNonBlank                   := sum(group,if(pParty.Reg_Latest_Effective_Date<>'',1,0));
    Reg_Latest_Expiration_Date_CountNonBlank                  := sum(group,if(pParty.Reg_Latest_Expiration_Date<>'',1,0));
    Reg_Rollup_Count_CountNonZero                             := sum(group,if(pParty.Reg_Rollup_Count<>0,1,0));
    Reg_Decal_Number_CountNonBlank                            := sum(group,if(pParty.Reg_Decal_Number<>'',1,0));
    Reg_Decal_Year_CountNonBlank                              := sum(group,if(pParty.Reg_Decal_Year<>'',1,0));
    Reg_Status_Code_CountNonBlank                             := sum(group,if(pParty.Reg_Status_Code<>'',1,0));
    Reg_Status_Desc_CountNonBlank                             := sum(group,if(pParty.Reg_Status_Desc<>'',1,0));
    Reg_True_License_Plate_CountNonBlank                      := sum(group,if(pParty.Reg_True_License_Plate<>'',1,0));
    Reg_License_Plate_CountNonBlank                           := sum(group,if(pParty.Reg_License_Plate<>'',1,0));
    Reg_License_State_CountNonBlank                           := sum(group,if(pParty.Reg_License_State<>'',1,0));
    Reg_License_Plate_Type_Code_CountNonBlank                 := sum(group,if(pParty.Reg_License_Plate_Type_Code<>'',1,0));
    Reg_License_Plate_Type_Desc_CountNonBlank                 := sum(group,if(pParty.Reg_License_Plate_Type_Desc<>'',1,0));
    Reg_Previous_License_State_CountNonBlank                  := sum(group,if(pParty.Reg_Previous_License_State<>'',1,0));
    Reg_Previous_License_Plate_CountNonBlank                  := sum(group,if(pParty.Reg_Previous_License_Plate<>'',1,0));
    Ttl_Number_CountNonBlank                                  := sum(group,if(pParty.Ttl_Number<>'',1,0));
    Ttl_Earliest_Issue_Date_CountNonBlank                     := sum(group,if(pParty.Ttl_Earliest_Issue_Date<>'',1,0));
    Ttl_Latest_Issue_Date_CountNonBlank                       := sum(group,if(pParty.Ttl_Latest_Issue_Date<>'',1,0));
    Ttl_Previous_Issue_Date_CountNonBlank                     := sum(group,if(pParty.Ttl_Previous_Issue_Date<>'',1,0));
    Ttl_Rollup_Count_CountNonZero                             := sum(group,if(pParty.Ttl_Rollup_Count<>0,1,0));
    Ttl_Status_Code_CountNonBlank                             := sum(group,if(pParty.Ttl_Status_Code<>'',1,0));
    Ttl_Status_Desc_CountNonBlank                             := sum(group,if(pParty.Ttl_Status_Desc<>'',1,0));
    Ttl_Odometer_Mileage_CountNonBlank                        := sum(group,if(pParty.Ttl_Odometer_Mileage<>'',1,0));
    Ttl_Odometer_Status_Code_CountNonBlank                    := sum(group,if(pParty.Ttl_Odometer_Status_Code<>'',1,0));
    Ttl_Odometer_Status_Desc_CountNonBlank                    := sum(group,if(pParty.Ttl_Odometer_Status_Desc<>'',1,0));
    Ttl_Odometer_Date_CountNonBlank                           := sum(group,if(pParty.Ttl_Odometer_Date<>'',1,0));
		DotID_CountNonBlank																				:= sum(group,if(pParty.DotID<>0,1,0));
		DotScore_CountNonBlank																		:= sum(group,if(pParty.DotScore<>0,1,0));
		DotWeight_CountNonBlank																		:= sum(group,if(pParty.DotWeight<>0,1,0));
		EmpID_CountNonBlank																				:= sum(group,if(pParty.EmpID<>0,1,0));
		EmpScore_CountNonBlank																		:= sum(group,if(pParty.EmpScore<>0,1,0));
		EmpWeight_CountNonBlank																		:= sum(group,if(pParty.EmpWeight<>0,1,0));
		POWID_CountNonBlank																				:= sum(group,if(pParty.POWID<>0,1,0));
		POWScore_CountNonBlank																		:= sum(group,if(pParty.POWScore<>0,1,0));
		POWWeight_CountNonBlank																		:= sum(group,if(pParty.POWWeight<>0,1,0));
		ProxID_CountNonBlank																			:= sum(group,if(pParty.ProxID<>0,1,0));
		ProxScore_CountNonBlank																		:= sum(group,if(pParty.ProxScore<>0,1,0));
		ProxWeight_CountNonBlank																	:= sum(group,if(pParty.ProxWeight<>0,1,0));
		SELEID_CountNonBlank																			:= sum(group,if(pParty.SELEID<>0,1,0));
		SELEScore_CountNonBlank																		:= sum(group,if(pParty.SELEScore<>0,1,0));
		SELEWeight_CountNonBlank																	:= sum(group,if(pParty.SELEWeight<>0,1,0));		
		OrgID_CountNonBlank																				:= sum(group,if(pParty.OrgID<>0,1,0));
		OrgScore_CountNonBlank																		:= sum(group,if(pParty.OrgScore<>0,1,0));
		OrgWeight_CountNonBlank																		:= sum(group,if(pParty.OrgWeight<>0,1,0));
		UltID_CountNonBlank																				:= sum(group,if(pParty.UltID<>0,1,0));
		UltScore_CountNonBlank																		:= sum(group,if(pParty.UltScore<>0,1,0));
		UltWeight_CountNonBlank																		:= sum(group,if(pParty.UltWeight<>0,1,0));	
		Source_rec_id_CountNonBlank																:= sum(group,if(pParty.Source_Rec_ID<>0,1,0));	
  end;
 
%rDIDstats_pParty% := record
  integer countGroup := count(group);
  pParty.Source_Code;
  pParty.State_Origin;
  Has_DID 	 := sum(group,IF(pParty(append_clean_name.lname <> '').append_did <> 0,1,0))/sum(group,IF(pParty.append_clean_name.lname <> '',1,0)) * 100;
  has_bdid   := sum(group,IF(pParty(Append_Clean_CName <> '').append_bdid <> 0,1,0))/sum(group,IF(pParty.Append_Clean_CName <> '',1,0)) * 100;
	has_DotID  := sum(group,IF(pParty.DotID <> 0, 1, 0))/sum(group,IF(pParty.DotID <> 0,1,0)) * 100;
	has_EmpID  := sum(group,IF(pParty.EmpID <> 0, 1, 0))/sum(group,IF(pParty.EmpID <> 0,1,0)) * 100;
	has_POWID  := sum(group,IF(pParty.POWID <> 0, 1, 0))/sum(group,IF(pParty.POWID <> 0,1,0)) * 100;
	has_ProxID := sum(group,IF(pParty.ProxID<> 0, 1, 0))/sum(group,IF(pParty.ProxID<> 0,1,0)) * 100;
	has_SELEID := sum(group,IF(pParty.SELEID<> 0, 1, 0))/sum(group,IF(pParty.SELEID<> 0,1,0)) * 100;
	has_OrgID  := sum(group,IF(pParty.OrgID <> 0, 1, 0))/sum(group,IF(pParty.OrgID <> 0,1,0)) * 100;
	has_UltID  := sum(group,IF(pParty.UltID <> 0, 1, 0))/sum(group,IF(pParty.UltID <> 0,1,0)) * 100;
	
end;

//output main stats
	%dPopulationStats_pMain% := table(pMain
	                                  ,%rPopulationStats_pMain%
									  ,Source_Code
									  ,State_Origin
                                      ,few);

	STRATA.createXMLStats(%dPopulationStats_pMain%
	                     ,'Vehicle V2'
						 ,'Main'
						 ,pVersion
						 ,''
						 ,%zMainStats%
						 ,'view'
						 ,'PopulationV2');

//output party stats
	%dPopulationStats_pParty% := table(pParty
	                                  ,%rPopulationStats_pParty%
									  ,Source_Code
									  ,State_Origin
                                      ,few);
	STRATA.createXMLStats(%dPopulationStats_pParty%
	                     ,'Vehicle V2'
						 ,'Party_baseV1'
						 ,pVersion
						 ,''
						 ,%zPartyStats%
						 ,'view'
					 ,'PopulationV2');
					 
//output party DID stats	
				 
	%dDIDstats_pParty% := table(pParty, %rDIDstats_pParty%,Source_Code,State_Origin, few);
    
	STRATA.createXMLStats(%dDIDstats_pParty%
	                     ,'Vehicle V2'
						 ,'Party_baseV1'
						 ,pVersion
						 ,''
						 ,%zPartyDIDStats%
						 ,'view'
					     ,'DIDStats');

zOut := parallel(%zMainStats%,%zPartyStats%,%zPartyDIDStats%)


ENDMACRO;