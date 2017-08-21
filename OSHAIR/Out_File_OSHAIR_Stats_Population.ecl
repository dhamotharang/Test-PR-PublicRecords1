EXPORT Out_File_OSHAIR_Stats_Population (pInspection
                                        ,pAccident
										,pHazardous_Substance
										,pOptional_Info
										,pProgram
										,pRelated_Activity
										,pViolations
										,pVersion
										,zOut) := MACRO

import STRATA;

#uniquename(rPopulationStats_OSHAIR_Inspection);
#uniquename(rPopulationStats_OSHAIR_Accident);
#uniquename(rPopulationStats_OSHAIR_Hazardous_Substance);
#uniquename(rPopulationStats_OSHAIR_Optional_Info);
#uniquename(rPopulationStats_OSHAIR_Program);
#uniquename(rPopulationStats_OSHAIR_Related_Activity);
#uniquename(rPopulationStats_OSHAIR_Violations);


/* Inspection Record record layout */
%rPopulationStats_OSHAIR_Inspection% := record
    pInspection.Inspected_Site_State;
    CountGroup                                                    := count(group);
    dt_first_seen_CountNonZero																		:= sum(group,if(pInspection.dt_first_seen			 <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero																			:= sum(group,if(pInspection.dt_last_seen			 <> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero													:= sum(group,if(pInspection.dt_vendor_first_reported  <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero													:= sum(group,if(pInspection.dt_vendor_last_reported   <> 0   ,1,0));
		UltID_CountNonZero	                         			            := sum(group,if(pInspection.UltID   <> 0   ,1,0));
		OrgID_CountNonZero 	                         			            := sum(group,if(pInspection.OrgID   <> 0   ,1,0));
		SeleID_CountNonZero                                           := sum(group,if(pInspection.SeleID  <> 0   ,1,0));
 		ProxID_CountNonZero 	                       		              := sum(group,if(pInspection.ProxID  <> 0   ,1,0));
		POWID_CountNonZero 	                         		              := sum(group,if(pInspection.POWID   <> 0   ,1,0));
		EmpID_CountNonZero 	   											 		              := sum(group,if(pInspection.EmpID   <> 0   ,1,0));
	  DotID_CountNonZero 	 												 		              := sum(group,if(pInspection.DotID   <> 0   ,1,0));
		UltScore_CountNonZero 	                     			            := sum(group,if(pInspection.UltScore  <> 0   ,1,0));
    OrgScore_CountNonZero 	                     			            := sum(group,if(pInspection.OrgScore  <> 0   ,1,0));
    SeleScore_CountNonZero 	                     			            := sum(group,if(pInspection.SeleScore <> 0   ,1,0));
	  ProxScore_CountNonZero 	                     			            := sum(group,if(pInspection.ProxScore <> 0   ,1,0));
		POWScore_CountNonZero 	                     	                := sum(group,if(pInspection.POWScore  <> 0   ,1,0));
 		EmpScore_CountNonZero 	 									   		              := sum(group,if(pInspection.EmpScore  <> 0   ,1,0));
		DotScore_CountNonZero 	  									 			            := sum(group,if(pInspection.DotScore  <> 0   ,1,0));
		UltWeight_CountNonZero 	                     		              := sum(group,if(pInspection.UltWeight <> 0   ,1,0));		
		OrgWeight_CountNonZero 	                     		              := sum(group,if(pInspection.OrgWeight <> 0   ,1,0));
		SeleWeight_CountNonZero 	                     		            := sum(group,if(pInspection.SeleWeight <> 0   ,1,0));
		ProxWeight_CountNonZero 	                                    := sum(group,if(pInspection.ProxWeight <> 0   ,1,0));
		POWWeight_CountNonZero 	                     	                := sum(group,if(pInspection.POWWeight  <> 0   ,1,0));
		EmpWeight_CountNonZero 	 				             		              := sum(group,if(pInspection.EmpWeight  <> 0   ,1,0));
    DotWeight_CountNonZero 	 										 		              := sum(group,if(pInspection.DotWeight  <> 0   ,1,0));
    source_rec_id_CountNonZero 	        	                        := sum(group,if(pInspection.source_rec_id <> 0   ,1,0));			 
		Continuation_Flag_CountNonBlank                               := sum(group,if(pInspection.Continuation_Flag<>'',1,0));
    History_Flag_CountNonBlank                                    := sum(group,if(pInspection.History_Flag<>'',1,0));
    History_Desc_CountNonBlank                                    := sum(group,if(pInspection.History_Desc<>'',1,0));
    Last_Activity_Date_CountNonZero                               := sum(group,if(pInspection.Last_Activity_Date<>0,1,0));
    Fed_State_Flag_CountNonBlank                                  := sum(group,if(pInspection.Fed_State_Flag<>'',1,0));
    Previous_Activity_Type_CountNonBlank                          := sum(group,if(pInspection.Previous_Activity_Type<>'',1,0));
    Prev_Activity_Type_Desc_CountNonBlank                         := sum(group,if(pInspection.Prev_Activity_Type_Desc<>'',1,0));
    Previous_Activity_Number_CountNonZero                         := sum(group,if(pInspection.Previous_Activity_Number<>0,1,0));
    Activity_Number_CountNonZero                                  := sum(group,if(pInspection.Activity_Number<>0,1,0));
    Region_Code_CountNonBlank                                     := sum(group,if(pInspection.Region_Code<>'',1,0));
    Area_Code_CountNonBlank                                       := sum(group,if(pInspection.Area_Code<>'',1,0));
    Office_Code_CountNonBlank                                     := sum(group,if(pInspection.Office_Code<>'',1,0));
    Compliance_Officer_ID_CountNonBlank                           := sum(group,if(pInspection.Compliance_Officer_ID<>'',1,0));
    Compliance_Officer_Job_Title_CountNonBlank                    := sum(group,if(pInspection.Compliance_Officer_Job_Title<>'',1,0));
    Compl_Officer_Job_Title_Desc_CountNonBlank                    := sum(group,if(pInspection.Compl_Officer_Job_Title_Desc<>'',1,0));
    Hist_Area_CountNonBlank                                       := sum(group,if(pInspection.Hist_Area<>'',1,0));
    Hist_Report_Number_CountNonBlank                              := sum(group,if(pInspection.Hist_Report_Number<>'',1,0));
    Inspected_Site_Name_CountNonBlank                             := sum(group,if(pInspection.Inspected_Site_Name<>'',1,0));
    Inspected_Site_Street_CountNonBlank                           := sum(group,if(pInspection.Inspected_Site_Street<>'',1,0));
    Inspected_Site_Zip_CountNonZero                               := sum(group,if(pInspection.Inspected_Site_Zip<>0,1,0));
    Inspected_Site_City_Code_CountNonZero                         := sum(group,if(pInspection.Inspected_Site_City_Code<>0,1,0));
    Inspected_Site_City_Name_CountNonBlank                        := sum(group,if(pInspection.Inspected_Site_City_Name<>'',1,0));
    Inspected_Site_County_Code_CountNonZero                       := sum(group,if(pInspection.Inspected_Site_County_Code<>0,1,0));
    DUNS_Number_CountNonZero                                      := sum(group,if(pInspection.DUNS_Number<>0,1,0));
    Host_Establishment_key_CountNonBlank                          := sum(group,if(pInspection.Host_Establishment_key<>'',1,0));
    Owner_Type_CountNonBlank                                      := sum(group,if(pInspection.Owner_Type<>'',1,0));
    Own_Type_Desc_CountNonBlank                                   := sum(group,if(pInspection.Own_Type_Desc<>'',1,0));
    Owner_Code_CountNonZero                                       := sum(group,if(pInspection.Owner_Code<>0,1,0));
    Advance_Notice_Flag_CountNonBlank                             := sum(group,if(pInspection.Advance_Notice_Flag<>'',1,0));
    Inspection_Opening_Date_CountNonZero                          := sum(group,if(pInspection.Inspection_Opening_Date<>0,1,0));
    Inspection_Close_Date_CountNonZero                            := sum(group,if(pInspection.Inspection_Close_Date<>0,1,0));
    Safety_Health_Flag_CountNonBlank                              := sum(group,if(pInspection.Safety_Health_Flag<>'',1,0));
    SIC_Code_CountNonZero                                         := sum(group,if(pInspection.SIC_Code<>0,1,0));
    SIC_Guide_CountNonZero                                        := sum(group,if(pInspection.SIC_Guide<>0,1,0));
    SIC_Inspected_CountNonZero                                    := sum(group,if(pInspection.SIC_Inspected<>0,1,0));
    NAICS_Code_CountNonBlank                                      := sum(group,if(pInspection.NAICS_Code<>'',1,0));
    NAICS_Secondary_Code_CountNonBlank                            := sum(group,if(pInspection.NAICS_Secondary_Code<>'',1,0));
    NAIC_Inspected_CountNonBlank                                  := sum(group,if(pInspection.NAIC_Inspected<>'',1,0));
    Inspection_Type_CountNonBlank                                 := sum(group,if(pInspection.Inspection_Type<>'',1,0));
    Insp_Type_Desc_CountNonBlank                                  := sum(group,if(pInspection.Insp_Type_Desc<>'',1,0));
    Inspection_Scope_CountNonBlank                                := sum(group,if(pInspection.Inspection_Scope<>'',1,0));
    Insp_Scope_Desc_CountNonBlank                                 := sum(group,if(pInspection.Insp_Scope_Desc<>'',1,0));
    Number_In_Establishment_CountNonZero                          := sum(group,if(pInspection.Number_In_Establishment<>0,1,0));
    Number_Covered_CountNonZero                                   := sum(group,if(pInspection.Number_Covered<>0,1,0));
    Number_Total_Employees_CountNonZero                           := sum(group,if(pInspection.Number_Total_Employees<>0,1,0));
    Walk_Around_Flag_CountNonBlank                                := sum(group,if(pInspection.Walk_Around_Flag<>'',1,0));
    Employees_Interviewed_Flag_CountNonBlank                      := sum(group,if(pInspection.Employees_Interviewed_Flag<>'',1,0));
    Union_Flag_CountNonBlank                                      := sum(group,if(pInspection.Union_Flag<>'',1,0));
    Closed_Case_Flag_CountNonBlank                                := sum(group,if(pInspection.Closed_Case_Flag<>'',1,0));
    Why_No_Inspection_Code_CountNonBlank                          := sum(group,if(pInspection.Why_No_Inspection_Code<>'',1,0));
    Close_Case_Date_CountNonZero                                  := sum(group,if(pInspection.Close_Case_Date<>0,1,0));
    Safety_PG_Manufacturing_Insp_Flag_CountNonBlank               := sum(group,if(pInspection.Safety_PG_Manufacturing_Insp_Flag<>'',1,0));
    Safety_PG_Construction_Insp_Flag_CountNonBlank                := sum(group,if(pInspection.Safety_PG_Construction_Insp_Flag<>'',1,0));
    Safety_PG_Maritime_Insp_Flag_CountNonBlank                    := sum(group,if(pInspection.Safety_PG_Maritime_Insp_Flag<>'',1,0));
    Health_PG_Manufacturing_Insp_Flag_CountNonBlank               := sum(group,if(pInspection.Health_PG_Manufacturing_Insp_Flag<>'',1,0));
    Health_PG_Construction_Insp_Flag_CountNonBlank                := sum(group,if(pInspection.Health_PG_Construction_Insp_Flag<>'',1,0));
    Health_PG_Maritime_Insp_Flag_CountNonBlank                    := sum(group,if(pInspection.Health_PG_Maritime_Insp_Flag<>'',1,0));
    Migrant_Farm_Insp_Flag_CountNonBlank                          := sum(group,if(pInspection.Migrant_Farm_Insp_Flag<>'',1,0));
    Antic_Served_CountNonBlank                                    := sum(group,if(pInspection.Antic_Served<>'',1,0));
    First_Denial_Date_CountNonZero                                := sum(group,if(pInspection.First_Denial_Date<>0,1,0));
    Last_Reenter_Date_CountNonZero                                := sum(group,if(pInspection.Last_Reenter_Date<>0,1,0));
    bls_Loss_Workday_Injury_Rate_CountNonZero                     := sum(group,if(pInspection.bls_Loss_Workday_Injury_Rate<>0,1,0));
    Informal_SH_Program_Init_Flag_CountNonBlank                   := sum(group,if(pInspection.Informal_SH_Program_Init_Flag<>'',1,0));
    Informal_Data_Required_CountNonBlank                          := sum(group,if(pInspection.Informal_Data_Required<>'',1,0));
    Penalties_Due_Date_CountNonZero                               := sum(group,if(pInspection.Penalties_Due_Date<>0,1,0));
    FTA_Due_Date_CountNonZero                                     := sum(group,if(pInspection.FTA_Due_Date<>0,1,0));
    Due_Date_Type_CountNonBlank                                   := sum(group,if(pInspection.Due_Date_Type<>'',1,0));
    PA_Prep_Time_CountNonZero                                     := sum(group,if(pInspection.PA_Prep_Time<>0,1,0));
    PA_Travel_Time_CountNonZero                                   := sum(group,if(pInspection.PA_Travel_Time<>0,1,0));
    PA_On_site_Time_CountNonZero                                  := sum(group,if(pInspection.PA_On_site_Time<>0,1,0));
    PA_Tech_supp_Time_CountNonZero                                := sum(group,if(pInspection.PA_Tech_supp_Time<>0,1,0));
    PA_Report_prep_Time_CountNonZero                              := sum(group,if(pInspection.PA_Report_prep_Time<>0,1,0));
    PA_Other_conf_Time_CountNonZero                               := sum(group,if(pInspection.PA_Other_conf_Time<>0,1,0));
    PA_Litigation_Time_CountNonZero                               := sum(group,if(pInspection.PA_Litigation_Time<>0,1,0));
    PA_Denial_Time_CountNonZero                                   := sum(group,if(pInspection.PA_Denial_Time<>0,1,0));
    PA_Sum_hours_CountNonZero                                     := sum(group,if(pInspection.PA_Sum_hours<>0,1,0));
    Earliest_Contest_Date_CountNonZero                            := sum(group,if(pInspection.Earliest_Contest_Date<>0,1,0));
    Remitted_Penalty_Amount_CountNonZero                          := sum(group,if(pInspection.Remitted_Penalty_Amount<>0,1,0));
    Remitted_FTA_Amount_CountNonZero                              := sum(group,if(pInspection.Remitted_FTA_Amount<>0,1,0));
    Total_Penalties_CountNonZero                                  := sum(group,if(pInspection.Total_Penalties<>0,1,0));
    Total_FTA_CountNonZero                                        := sum(group,if(pInspection.Total_FTA<>0,1,0));
    Total_Violations_CountNonZero                                 := sum(group,if(pInspection.Total_Violations<>0,1,0));
    Total_Serious_Violations_CountNonZero                         := sum(group,if(pInspection.Total_Serious_Violations<>0,1,0));
    Number_Program_CountNonZero                                   := sum(group,if(pInspection.Number_Program<>0,1,0));
    Number_Rel_Activity_CountNonZero                              := sum(group,if(pInspection.Number_Rel_Activity<>0,1,0));
    Number_Optional_Info_CountNonZero                             := sum(group,if(pInspection.Number_Optional_Info<>0,1,0));
    Number_Debt_CountNonZero                                      := sum(group,if(pInspection.Number_Debt<>0,1,0));
    Number_Violations_CountNonZero                                := sum(group,if(pInspection.Number_Violations<>0,1,0));
    Number_Event_CountNonZero                                     := sum(group,if(pInspection.Number_Event<>0,1,0));
    Number_Hazardous_Substance_CountNonZero                       := sum(group,if(pInspection.Number_Hazardous_Substance<>0,1,0));
    Number_Accident_CountNonZero                                  := sum(group,if(pInspection.Number_Accident<>0,1,0));
    Number_Admin_Pay_CountNonZero                                 := sum(group,if(pInspection.Number_Admin_Pay<>0,1,0));
    cname_CountNonBlank                                           := sum(group,if(pInspection.cname<>'',1,0));
    bdid_CountNonZero                                             := sum(group,if(pInspection.bdid<>0,1,0));
    BDID_score_CountNonZero                                       := sum(group,if(pInspection.BDID_score<>0,1,0));
    FEIN_append_CountNonBlank                                     := sum(group,if(pInspection.FEIN_append<>'',1,0));
    prim_range_CountNonBlank                                      := sum(group,if(pInspection.prim_range<>'',1,0));
    predir_CountNonBlank                                          := sum(group,if(pInspection.predir<>'',1,0));
    prim_name_CountNonBlank                                       := sum(group,if(pInspection.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                                     := sum(group,if(pInspection.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                         := sum(group,if(pInspection.postdir<>'',1,0));
    unit_desig_CountNonBlank                                      := sum(group,if(pInspection.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                       := sum(group,if(pInspection.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                     := sum(group,if(pInspection.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                     := sum(group,if(pInspection.v_city_name<>'',1,0));
    st_CountNonBlank                                              := sum(group,if(pInspection.st<>'',1,0));
    zip5_CountNonBlank                                            := sum(group,if(pInspection.zip5<>'',1,0));
    zip4_CountNonBlank                                            := sum(group,if(pInspection.zip4<>'',1,0));
    fips_state_CountNonBlank                                      := sum(group,if(pInspection.fips_state<>'',1,0));
    fips_county_CountNonBlank                                     := sum(group,if(pInspection.fips_county<>'',1,0));
    addr_rec_type_CountNonBlank                                   := sum(group,if(pInspection.addr_rec_type<>'',1,0));
    geo_lat_CountNonBlank                                         := sum(group,if(pInspection.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                        := sum(group,if(pInspection.geo_long<>'',1,0));
    cbsa_CountNonBlank                                            := sum(group,if(pInspection.cbsa<>'',1,0));
    geo_blk_CountNonBlank                                         := sum(group,if(pInspection.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                       := sum(group,if(pInspection.geo_match<>'',1,0));
    cart_CountNonBlank                                            := sum(group,if(pInspection.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                      := sum(group,if(pInspection.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                             := sum(group,if(pInspection.lot<>'',1,0));
    lot_order_CountNonBlank                                       := sum(group,if(pInspection.lot_order<>'',1,0));
    dpbc_CountNonBlank                                            := sum(group,if(pInspection.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                       := sum(group,if(pInspection.chk_digit<>'',1,0));
    err_stat_CountNonBlank                                        := sum(group,if(pInspection.err_stat<>'',1,0));
end;

/* Accident Record record layout */
%rPopulationStats_OSHAIR_Accident% := record
    pAccident.Nat_of_Inj_Desc;
    CountGroup                                            := count(group);
    dt_first_seen_CountNonZero														:= sum(group,if(pAccident.dt_first_seen	 <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero															:= sum(group,if(pAccident.dt_last_seen 	 <> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero									:= sum(group,if(pAccident.dt_vendor_first_reported  <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero									:= sum(group,if(pAccident.dt_vendor_last_reported   <> 0   ,1,0));
		Activity_Number_CountNonZero                          := sum(group,if(pAccident.Activity_Number<>0,1,0));
    Name_CountNonBlank                                    := sum(group,if(pAccident.Name<>'',1,0));
    Related_Inspection_Number_CountNonZero                := sum(group,if(pAccident.Related_Inspection_Number<>0,1,0));
    Sex_CountNonBlank                                     := sum(group,if(pAccident.Sex<>'',1,0));
    Age_CountNonZero                                      := sum(group,if(pAccident.Age<>0,1,0));
    Degree_of_Injury_CountNonBlank                        := sum(group,if(pAccident.Degree_of_Injury<>'',1,0));
    Nature_of_Injury_CountNonBlank                        := sum(group,if(pAccident.Nature_of_Injury<>'',1,0));
    Part_of_Body_CountNonBlank                            := sum(group,if(pAccident.Part_of_Body<>'',1,0));
    Source_of_Injury_CountNonBlank                        := sum(group,if(pAccident.Source_of_Injury<>'',1,0));
    Event_Type_CountNonBlank                              := sum(group,if(pAccident.Event_Type<>'',1,0));
    Environmental_Factor_CountNonBlank                    := sum(group,if(pAccident.Environmental_Factor<>'',1,0));
    Human_Factor_CountNonBlank                            := sum(group,if(pAccident.Human_Factor<>'',1,0));
    Task_Assigned_CountNonBlank                           := sum(group,if(pAccident.Task_Assigned<>'',1,0));
    Hazardous_Substance_CountNonBlank                     := sum(group,if(pAccident.Hazardous_Substance<>'',1,0));
    Occupation_Code_CountNonBlank                         := sum(group,if(pAccident.Occupation_Code<>'',1,0));
    title_CountNonBlank                                   := sum(group,if(pAccident.Victim.title<>'',1,0));
    fname_CountNonBlank                                   := sum(group,if(pAccident.Victim.fname<>'',1,0));
    mname_CountNonBlank                                   := sum(group,if(pAccident.Victim.mname<>'',1,0));
    lname_CountNonBlank                                   := sum(group,if(pAccident.Victim.lname<>'',1,0));
    name_suffix_CountNonBlank                             := sum(group,if(pAccident.Victim.name_suffix<>'',1,0));
    name_score_CountNonBlank                              := sum(group,if(pAccident.Victim.name_score<>'',1,0));
    Deg_of_Injury_Desc_CountNonBlank                      := sum(group,if(pAccident.Deg_of_Injury_Desc<>'',1,0));
    Part_of_Body_Desc_CountNonBlank                       := sum(group,if(pAccident.Part_of_Body_Desc<>'',1,0));
    Src_of_Inj_Desc_CountNonBlank                         := sum(group,if(pAccident.Src_of_Inj_Desc<>'',1,0));
    Event_Desc_CountNonBlank                              := sum(group,if(pAccident.Event_Desc<>'',1,0));
    Env_Factor_Desc_CountNonBlank                         := sum(group,if(pAccident.Env_Factor_Desc<>'',1,0));
    Human_Factor_Desc_CountNonBlank                       := sum(group,if(pAccident.Human_Factor_Desc<>'',1,0));
    Task_Assigned_Desc_CountNonBlank                      := sum(group,if(pAccident.Task_Assigned_Desc<>'',1,0));
    Hazardous_Sub_Desc_CountNonBlank                      := sum(group,if(pAccident.Hazardous_Sub_Desc<>'',1,0));
    Occupation_Desc_CountNonBlank                         := sum(group,if(pAccident.Occupation_Desc<>'',1,0));
end;

/* Hazardous Substance record layout */
%rPopulationStats_OSHAIR_Hazardous_Substance% := record
    pHazardous_Substance.Item_group;
    CountGroup                                        := count(group);
    dt_first_seen_CountNonZero												:= sum(group,if(pHazardous_Substance.dt_first_seen					 <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero													:= sum(group,if(pHazardous_Substance.dt_last_seen 					 <> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero							:= sum(group,if(pHazardous_Substance.dt_vendor_first_reported <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero							:= sum(group,if(pHazardous_Substance.dt_vendor_last_reported  <> 0   ,1,0));    
		Citation_Number_CountNonBlank                     := sum(group,if(pHazardous_Substance.Citation_Number<>'',1,0));
    Item_Number_CountNonBlank                         := sum(group,if(pHazardous_Substance.Item_Number<>'',1,0));
    Hazardous_Substance_1_CountNonBlank               := sum(group,if(pHazardous_Substance.Hazardous_Substance_1<>'',1,0));
    Hazardous_Substance_2_CountNonBlank               := sum(group,if(pHazardous_Substance.Hazardous_Substance_2<>'',1,0));
    Hazardous_Substance_3_CountNonBlank               := sum(group,if(pHazardous_Substance.Hazardous_Substance_3<>'',1,0));
    Hazardous_Substance_4_CountNonBlank               := sum(group,if(pHazardous_Substance.Hazardous_Substance_4<>'',1,0));
    Hazardous_Substance_5_CountNonBlank               := sum(group,if(pHazardous_Substance.Hazardous_Substance_5<>'',1,0));
    Hazardous_Sub_Desc_1_CountNonBlank                := sum(group,if(pHazardous_Substance.Hazardous_Sub_Desc_1<>'',1,0));
    Hazardous_Sub_Desc_2_CountNonBlank                := sum(group,if(pHazardous_Substance.Hazardous_Sub_Desc_2<>'',1,0));
    Hazardous_Sub_Desc_3_CountNonBlank                := sum(group,if(pHazardous_Substance.Hazardous_Sub_Desc_3<>'',1,0));
    Hazardous_Sub_Desc_4_CountNonBlank                := sum(group,if(pHazardous_Substance.Hazardous_Sub_Desc_4<>'',1,0));
    Hazardous_Sub_Desc_5_CountNonBlank                := sum(group,if(pHazardous_Substance.Hazardous_Sub_Desc_5<>'',1,0));
end;

/* Optional Information record layout */
%rPopulationStats_OSHAIR_Optional_Info% := record
    pOptional_Info.Opt_ID;
    CountGroup                            := count(group);
    dt_first_seen_CountNonZero						:= sum(group,if(pOptional_Info.dt_first_seen  	 <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero							:= sum(group,if(pOptional_Info.dt_last_seen   	 <> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero	:= sum(group,if(pOptional_Info.dt_vendor_first_reported <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero	:= sum(group,if(pOptional_Info.dt_vendor_last_reported  <> 0   ,1,0)); 
    Opt_Type_CountNonBlank                := sum(group,if(pOptional_Info.Opt_Type<>'',1,0));
    Opt_Value_CountNonBlank               := sum(group,if(pOptional_Info.Opt_Value<>'',1,0));
    Opt_Desc_CountNonBlank                := sum(group,if(pOptional_Info.Opt_Desc<>'',1,0));
end;

/* Program record layout */
%rPopulationStats_OSHAIR_Program% := record
    pProgram.Program_Value;
    CountGroup                                := count(group);
    dt_first_seen_CountNonZero						    := sum(group,if(pProgram.dt_first_seen		 <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero									:= sum(group,if(pProgram.dt_last_seen			 <> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero			:= sum(group,if(pProgram.dt_vendor_first_reported <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero			:= sum(group,if(pProgram.dt_vendor_last_reported  <> 0   ,1,0)); 
		Program_Type_CountNonBlank                := sum(group,if(pProgram.Program_Type<>'',1,0));
  end;

/* Related Activity record layout */
%rPopulationStats_OSHAIR_Related_Activity% := record
    pRelated_Activity.Rel_Activity_Desc;
    CountGroup                                           := count(group);
		dt_first_seen_CountNonZero						    					 := sum(group,if(pRelated_Activity.dt_first_seen  					 <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero														 := sum(group,if(pRelated_Activity.dt_last_seen   					 <> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero								 := sum(group,if(pRelated_Activity.dt_vendor_first_reported <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero								 := sum(group,if(pRelated_Activity.dt_vendor_last_reported  <> 0   ,1,0)); 
 		Rel_Activity_item_Number_CountNonBlank               := sum(group,if(pRelated_Activity.Rel_Activity_item_Number<>'',1,0));
    Rel_Activity_Type_CountNonBlank                      := sum(group,if(pRelated_Activity.Rel_Activity_Type<>'',1,0));
    Rel_Activity_Number_CountNonZero                     := sum(group,if(pRelated_Activity.Rel_Activity_Number<>0,1,0));
    Rel_Activity_Safety_Flag_CountNonBlank               := sum(group,if(pRelated_Activity.Rel_Activity_Safety_Flag<>'',1,0));
    Rel_Activity_Health_Flag_CountNonBlank               := sum(group,if(pRelated_Activity.Rel_Activity_Health_Flag<>'',1,0));
end;

/* Violations record layout */
%rPopulationStats_OSHAIR_Violations% := record
    pViolations.Violation_Desc;
    pViolations.Related_Event_Desc;
    CountGroup                                                 := count(group);
    dt_first_seen_CountNonZero						    					 			 := sum(group,if(pViolations.dt_first_seen 					  <> 0   ,1,0));						 
	  dt_last_seen_CountNonZero														 			 := sum(group,if(pViolations.dt_last_seen   					<> 0   ,1,0));						 
	  dt_vendor_first_reported_CountNonZero								 			 := sum(group,if(pViolations.dt_vendor_first_reported <> 0   ,1,0)); 
	  dt_vendor_last_reported_CountNonZero								 			 := sum(group,if(pViolations.dt_vendor_last_reported  <> 0   ,1,0)); 
		Delete_Flag_CountNonBlank                                  := sum(group,if(pViolations.Delete_Flag<>'',1,0));
    Issuance_Date_CountNonZero                                 := sum(group,if(pViolations.Issuance_Date<>0,1,0));
    Citation_Number_CountNonBlank                              := sum(group,if(pViolations.Citation_Number<>'',1,0));
    Item_Number_CountNonBlank                                  := sum(group,if(pViolations.Item_Number<>'',1,0));
    Item_group_CountNonBlank                                   := sum(group,if(pViolations.Item_group<>'',1,0));
    Emphasis_CountNonBlank                                     := sum(group,if(pViolations.Emphasis<>'',1,0));
    Gravity_CountNonBlank                                      := sum(group,if(pViolations.Gravity<>'',1,0));
    Current_Penalty_CountNonZero                               := sum(group,if(pViolations.Current_Penalty<>0,1,0));
    Initial_Penalty_CountNonZero                               := sum(group,if(pViolations.Initial_Penalty<>0,1,0));
    Violation_Type_CountNonBlank                               := sum(group,if(pViolations.Violation_Type<>'',1,0));
    Initial_Violation_Type_CountNonBlank                       := sum(group,if(pViolations.Initial_Violation_Type<>'',1,0));
    Fed_State_Standard_CountNonBlank                           := sum(group,if(pViolations.Fed_State_Standard<>'',1,0));
    Abatement_Date_CountNonZero                                := sum(group,if(pViolations.Abatement_Date<>0,1,0));
    Number_Instances_CountNonZero                              := sum(group,if(pViolations.Number_Instances<>0,1,0));
    Related_Event_Code_CountNonBlank                           := sum(group,if(pViolations.Related_Event_Code<>'',1,0));
    Number_Exposed_CountNonZero                                := sum(group,if(pViolations.Number_Exposed<>0,1,0));
    Abatement_Complete_CountNonBlank                           := sum(group,if(pViolations.Abatement_Complete<>'',1,0));
    Earliest_Contest_Date_CountNonZero                         := sum(group,if(pViolations.Earliest_Contest_Date<>0,1,0));
    Violation_Contest_CountNonBlank                            := sum(group,if(pViolations.Violation_Contest<>'',1,0));
    Penalty_Contest_CountNonBlank                              := sum(group,if(pViolations.Penalty_Contest<>'',1,0));
    Abatement_Employer_Contest_CountNonBlank                   := sum(group,if(pViolations.Abatement_Employer_Contest<>'',1,0));
    Abatement_Employee_Contest_CountNonBlank                   := sum(group,if(pViolations.Abatement_Employee_Contest<>'',1,0));
    Final_Order_Date_CountNonZero                              := sum(group,if(pViolations.Final_Order_Date<>0,1,0));
    Pet_To_Modify_Abatement_CountNonBlank                      := sum(group,if(pViolations.Pet_To_Modify_Abatement<>'',1,0));
    Citation_Amended_CountNonBlank                             := sum(group,if(pViolations.Citation_Amended<>'',1,0));
    Informal_Settlement_Aggreement_CountNonBlank               := sum(group,if(pViolations.Informal_Settlement_Aggreement<>'',1,0));
    Disposition_Event_CountNonBlank                            := sum(group,if(pViolations.Disposition_Event<>'',1,0));
    FTA_Inspection_Number_CountNonZero                         := sum(group,if(pViolations.FTA_Inspection_Number<>0,1,0));
    FTA_Penalty_CountNonZero                                   := sum(group,if(pViolations.FTA_Penalty<>0,1,0));
    FTA_Issuance_Date_CountNonZero                             := sum(group,if(pViolations.FTA_Issuance_Date<>0,1,0));
    FTA_Contest_Date_CountNonZero                              := sum(group,if(pViolations.FTA_Contest_Date<>0,1,0));
    FTA_Ammended_CountNonBlank                                 := sum(group,if(pViolations.FTA_Ammended<>'',1,0));
    FTA_ISA_CountNonBlank                                      := sum(group,if(pViolations.FTA_ISA<>'',1,0));
    FTA_Disposition_Event_CountNonBlank                        := sum(group,if(pViolations.FTA_Disposition_Event<>'',1,0));
    FTA_Final_Order_Date_CountNonZero                          := sum(group,if(pViolations.FTA_Final_Order_Date<>0,1,0));
    Hazard_Category_CountNonBlank                              := sum(group,if(pViolations.Hazard_Category<>'',1,0));
    Abatement_Verify_Date_CountNonZero                         := sum(group,if(pViolations.Abatement_Verify_Date<>0,1,0));
    Abatement_Comp_Desc_CountNonBlank                          := sum(group,if(pViolations.Abatement_Comp_Desc<>'',1,0));
    Disposition_Event_Desc_CountNonBlank                       := sum(group,if(pViolations.Disposition_Event_Desc<>'',1,0));
    FTA_Disposition_Event_Desc_CountNonBlank                   := sum(group,if(pViolations.FTA_Disposition_Event_Desc<>'',1,0));
end;

#uniquename(dPopulationStats_OSHAIR_Inspection);
#uniquename(dPopulationStats_OSHAIR_Accident);
#uniquename(dPopulationStats_OSHAIR_Hazardous_Substance);
#uniquename(dPopulationStats_OSHAIR_Optional_Info);
#uniquename(dPopulationStats_OSHAIR_Program);
#uniquename(dPopulationStats_OSHAIR_Related_Activity);
#uniquename(dPopulationStats_OSHAIR_Violations);

/* Create the Inspection table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Inspection% := table(pInspection
									         ,%rPopulationStats_OSHAIR_Inspection%
									         ,Inspected_Site_State
									         ,few);
/* Create the Accident table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Accident% := table(pAccident
									,%rPopulationStats_OSHAIR_Accident%
									,Nat_of_Inj_Desc
									,few);
/* Create the Hazardous_Substance table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Hazardous_Substance% := table(pHazardous_Substance
									           ,%rPopulationStats_OSHAIR_Hazardous_Substance%
											   ,Item_group
											   ,few);
/* Create the Optional_Info table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Optional_Info% := table(pOptional_Info
									     ,%rPopulationStats_OSHAIR_Optional_Info%
										 ,Opt_ID
										 ,few);
/* Create the Program table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Program% := table(pProgram
								   ,%rPopulationStats_OSHAIR_Program%
								   ,Program_Value
								   ,few);
/* Create the Related_Activity table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Related_Activity% := table(pRelated_Activity
									        ,%rPopulationStats_OSHAIR_Related_Activity%
											,Rel_Activity_Desc
											,few);
/* Create the Violations table and run the STRATA statistics */
%dPopulationStats_OSHAIR_Violations% := table(pViolations
									  ,%rPopulationStats_OSHAIR_Violations%
									  ,Violation_Desc,Related_Event_Desc
									  ,few);

#uniquename(zInspection);
#uniquename(zAccident);
#uniquename(zHazardous_Substance);
#uniquename(zOptional_Info);
#uniquename(zProgram);
#uniquename(zRelated_Activity);
#uniquename(zViolations);

/* Call the STRATA function to generate the XML stats for Inspection */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Inspection%
					 ,'OSHAIR'
					 ,'Inspection base fileV2'
					 ,pVersion
					 ,''
					 ,%zInspection%
					 ,
					 ,'population');
/* Call the STRATA function to generate the XML stats for Accident */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Accident%
					 ,'OSHAIR'
					 ,'Accident file'
					 ,pVersion
					 ,''
					 ,%zAccident%
					 ,
					 ,'population');
/* Call the STRATA function to generate the XML stats for Hazardous Substance */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Hazardous_Substance%
					 ,'OSHAIR'
					 ,'Hazardous Substance file'
					 ,pVersion
					 ,''
					 ,%zHazardous_Substance%
					 ,
					 ,'population');
/* Call the STRATA function to generate the XML stats for Optional Info */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Optional_Info%
					 ,'OSHAIR'
					 ,'Optional Info file'
					 ,pVersion
					 ,''
					 ,%zOptional_Info%
					 ,
					 ,'population');
/* Call the STRATA function to generate the XML stats for Program */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Program%
					 ,'OSHAIR'
					 ,'Program file'
					 ,pVersion
					 ,''
					 ,%zProgram%
					 ,
					 ,'population');
/* Call the STRATA function to generate the XML stats for Related Activity */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Related_Activity%
					 ,'OSHAIR'
					 ,'Related Activity file'
					 ,pVersion
					 ,''
					 ,%zRelated_Activity%
					 ,
					 ,'population');
/* Call the STRATA function to generate the XML stats for Violations */
STRATA.createXMLStats(%dPopulationStats_OSHAIR_Violations%
					 ,'OSHAIR'
					 ,'Violations file'
					 ,pVersion
					 ,''
					 ,%zViolations%
					 ,
					 ,'population');

zOut := parallel(%zInspection%
                 ,%zAccident%
                 ,%zHazardous_Substance%
                 ,%zOptional_Info%
                 ,%zProgram%
                 ,%zRelated_Activity%
                 ,%zViolations%
				 );

ENDMACRO;