import STRATA, LaborActions_MSHA;

export out_STRATA_population_stats_Mine(string pVersion) := function

rPopulationStats_LaborActions_MSHA_Mine := record
    LaborActions_MSHA.files().base_mine_base.qa.Mine_Id;    		// field to group by --  all values are "10003"
    CountGroup                                             := count(group);
    Date_FirstSeen_CountNonZero                            := sum(group,if(files().base_mine_base.qa.Date_FirstSeen<>0,1,0));
    Date_LastSeen_CountNonZero                             := sum(group,if(files().base_mine_base.qa.Date_LastSeen<>0,1,0));
    Dart_Id_CountNonBlank                                  := sum(group,if(files().base_mine_base.qa.Dart_Id<>'',1,0));
    Mine_Id_CountNonBlank                                  := sum(group,if(files().base_mine_base.qa.Mine_Id<>'',1,0));
    Mine_Id_Cleaned_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.Mine_Id_Cleaned<>'',1,0));		
    Mine_Name_CountNonBlank                                := sum(group,if(files().base_mine_base.qa.Mine_Name<>'',1,0));		
    Controller_Id_CountNonBlank                            := sum(group,if(files().base_mine_base.qa.Controller_Id<>'',1,0));
    Controller_Id_Cleaned_CountNonBlank                    := sum(group,if(files().base_mine_base.qa.Controller_Id_Cleaned<>'',1,0));
    Controller_Name_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.Controller_Name<>'',1,0));
    Controller_Name_Cleaned_CountNonBlank                  := sum(group,if(files().base_mine_base.qa.Controller_Name_Cleaned<>'',1,0));		
    Controller_Name_Business_CountNonBlank                 := sum(group,if(files().base_mine_base.qa.Controller_Name_Business<>'',1,0));		
		Controller_Name_Name_Flag_CountNonBlank                := sum(group,if(files().base_mine_base.qa.Controller_Name_Name_Flag<>'',1,0));		
		Controller_Name_CLN_FName_CountNonBlank                := sum(group,if(files().base_mine_base.qa.Controller_Name_CLN_FName<>'',1,0));		
		Controller_Name_CLN_MName_CountNonBlank                := sum(group,if(files().base_mine_base.qa.Controller_Name_CLN_MName<>'',1,0));		
		Controller_Name_CLN_LName_CountNonBlank                := sum(group,if(files().base_mine_base.qa.Controller_Name_CLN_LName<>'',1,0));		
		Controller_Name_CLN_Suffix_CountNonBlank               := sum(group,if(files().base_mine_base.qa.Controller_Name_CLN_Suffix<>'',1,0));		
    Operator_Id_CountNonBlank                              := sum(group,if(files().base_mine_base.qa.Operator_Id<>'',1,0));
    Operator_Id_Cleaned_CountNonBlank                 	   := sum(group,if(files().base_mine_base.qa.Operator_Id_Cleaned<>'',1,0));		
    Operator_Name_CountNonBlank                            := sum(group,if(files().base_mine_base.qa.Operator_Name<>'',1,0));
    Operator_Name_Cleaned_CountNonBlank              	     := sum(group,if(files().base_mine_base.qa.Operator_Name_Cleaned<>'',1,0));		
    Operator_Name_Business_CountNonBlank            	     := sum(group,if(files().base_mine_base.qa.Operator_Name_Business<>'',1,0));		
		Operator_Name_Name_Flag_CountNonBlank             	   := sum(group,if(files().base_mine_base.qa.Operator_Name_Name_Flag<>'',1,0));		
		Operator_Name_CLN_FName_CountNonBlank               	 := sum(group,if(files().base_mine_base.qa.Operator_Name_CLN_FName<>'',1,0));		
		Operator_Name_CLN_MName_CountNonBlank       	         := sum(group,if(files().base_mine_base.qa.Operator_Name_CLN_MName<>'',1,0));		
		Operator_Name_CLN_LName_CountNonBlank         	       := sum(group,if(files().base_mine_base.qa.Operator_Name_CLN_LName<>'',1,0));		
		Operator_Name_CLN_Suffix_CountNonBlank          	     := sum(group,if(files().base_mine_base.qa.Operator_Name_CLN_Suffix<>'',1,0));				
    Website_CountNonBlank                                  := sum(group,if(files().base_mine_base.qa.Website<>'',1,0));
    State_CountNonBlank                                    := sum(group,if(files().base_mine_base.qa.State<>'',1,0));
    Coal_or_Metal_Mine_CountNonBlank                       := sum(group,if(files().base_mine_base.qa.Coal_or_Metal_Mine<>'',1,0));
    Mine_Type_CountNonBlank                                := sum(group,if(files().base_mine_base.qa.Mine_Type<>'',1,0));
    Mine_Status_CountNonBlank                              := sum(group,if(files().base_mine_base.qa.Mine_Status<>'',1,0));
    Mine_Status_Date_CountNonBlank                         := sum(group,if(files().base_mine_base.qa.Mine_Status_Date<>'',1,0));
    Mine_State_CountNonBlank                               := sum(group,if(files().base_mine_base.qa.Mine_State<>'',1,0));
    County_CountNonBlank                                   := sum(group,if(files().base_mine_base.qa.County<>'',1,0));
    Begin_Date_CountNonBlank                               := sum(group,if(files().base_mine_base.qa.Begin_Date<>'',1,0));
    SIC_CountNonBlank                                      := sum(group,if(files().base_mine_base.qa.SIC<>'',1,0));
    SIC_Description_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.SIC_Description<>'',1,0));
    Commodity_Code_CountNonBlank                           := sum(group,if(files().base_mine_base.qa.Commodity_Code<>'',1,0));
    Commodity_Description_CountNonBlank                    := sum(group,if(files().base_mine_base.qa.Commodity_Description<>'',1,0));
    NAICS_Code_CountNonBlank                               := sum(group,if(files().base_mine_base.qa.NAICS_Code<>'',1,0));
    SIC_Code_CountNonBlank                                 := sum(group,if(files().base_mine_base.qa.SIC_Code<>'',1,0));
    Suffix_Code_CountNonBlank                              := sum(group,if(files().base_mine_base.qa.Suffix_Code<>'',1,0));
    Old_SIC_Code_CountNonBlank                             := sum(group,if(files().base_mine_base.qa.Old_SIC_Code<>'',1,0));
    Activity_Indicator_CountNonBlank                       := sum(group,if(files().base_mine_base.qa.Activity_Indicator<>'',1,0));
    Activity_Date_CountNonBlank                            := sum(group,if(files().base_mine_base.qa.Activity_Date<>'',1,0));
    InActivity_Date_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.InActivity_Date<>'',1,0));
    Bureau_Mines_State_Code_CountNonBlank                  := sum(group,if(files().base_mine_base.qa.Bureau_Mines_State_Code<>'',1,0));
    FIPS_County_Code_CountNonBlank                         := sum(group,if(files().base_mine_base.qa.FIPS_County_Code<>'',1,0));
    Congress_Dist_Code_CountNonBlank                       := sum(group,if(files().base_mine_base.qa.Congress_Dist_Code<>'',1,0));
    Company_Type_CountNonBlank                             := sum(group,if(files().base_mine_base.qa.Company_Type<>'',1,0));
    District_CountNonBlank                                 := sum(group,if(files().base_mine_base.qa.District<>'',1,0));
    Office_Code_CountNonBlank                              := sum(group,if(files().base_mine_base.qa.Office_Code<>'',1,0));
    Office_Name_CountNonBlank                              := sum(group,if(files().base_mine_base.qa.Office_Name<>'',1,0));
    Assess_Control_No_CountNonBlank                        := sum(group,if(files().base_mine_base.qa.Assess_Control_No<>'',1,0));
    SIC_Suffix_CountNonBlank                               := sum(group,if(files().base_mine_base.qa.SIC_Suffix<>'',1,0));
    Second_SIC_Code_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.Second_SIC_Code<>'',1,0));
    Second_SIC_Description_CountNonBlank                   := sum(group,if(files().base_mine_base.qa.Second_SIC_Description<>'',1,0));
    Second_SIC_Suffix_CountNonBlank                        := sum(group,if(files().base_mine_base.qa.Second_SIC_Suffix<>'',1,0));
    Second_SIC_Group_CountNonBlank                         := sum(group,if(files().base_mine_base.qa.Second_SIC_Group<>'',1,0));
    Primary_Industry_Group_CountNonBlank                   := sum(group,if(files().base_mine_base.qa.Primary_Industry_Group<>'',1,0));
    Primary_Industry_Code_Desc_CountNonBlank               := sum(group,if(files().base_mine_base.qa.Primary_Industry_Code_Desc<>'',1,0));
    Second_Industry_Group_CountNonBlank                    := sum(group,if(files().base_mine_base.qa.Second_Industry_Group<>'',1,0));
    Second_Industry_Code_Desc_CountNonBlank                := sum(group,if(files().base_mine_base.qa.Second_Industry_Code_Desc<>'',1,0));
    Classification_Desc_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Classification_Desc<>'',1,0));
    Classification_Code_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Classification_Code<>'',1,0));
    Classification_Date_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Classification_Date<>'',1,0));
    Portable_Mine_Indicator_CountNonBlank                  := sum(group,if(files().base_mine_base.qa.Portable_Mine_Indicator<>'',1,0));
    Portable_Mine_FIPS_CountNonBlank                       := sum(group,if(files().base_mine_base.qa.Portable_Mine_FIPS<>'',1,0));
    Days_Per_Week_CountNonBlank                            := sum(group,if(files().base_mine_base.qa.Days_Per_Week<>'',1,0));
    Hours_Per_Shift_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.Hours_Per_Shift<>'',1,0));
    Production_Shifts_Per_Day_CountNonBlank                := sum(group,if(files().base_mine_base.qa.Production_Shifts_Per_Day<>'',1,0));
    Maintenance_Shifts_Per_Day_CountNonBlank               := sum(group,if(files().base_mine_base.qa.Maintenance_Shifts_Per_Day<>'',1,0));
    Number_Of_Emp_CountNonBlank                            := sum(group,if(files().base_mine_base.qa.Number_Of_Emp<>'',1,0));
    Training_Indicator_CountNonBlank                       := sum(group,if(files().base_mine_base.qa.Training_Indicator<>'',1,0));
    Longitude_CountNonBlank                                := sum(group,if(files().base_mine_base.qa.Longitude<>'',1,0));
    Latitude_CountNonBlank                                 := sum(group,if(files().base_mine_base.qa.Latitude<>'',1,0));
    Average_Mine_Height_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Average_Mine_Height<>'',1,0));
    Mine_Gas_Category_CountNonBlank                        := sum(group,if(files().base_mine_base.qa.Mine_Gas_Category<>'',1,0));
    Methane_Liberation_CountNonBlank                       := sum(group,if(files().base_mine_base.qa.Methane_Liberation<>'',1,0));
    No_Of_Producing_Pits_CountNonBlank                     := sum(group,if(files().base_mine_base.qa.No_Of_Producing_Pits<>'',1,0));
    No_Of_Non_Producing_Pits_CountNonBlank                 := sum(group,if(files().base_mine_base.qa.No_Of_Non_Producing_Pits<>'',1,0));
    No_Of_Tailing_Ponds_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.No_Of_Tailing_Ponds<>'',1,0));
    Pilliar_Recovery_Indicator_CountNonBlank               := sum(group,if(files().base_mine_base.qa.Pilliar_Recovery_Indicator<>'',1,0));
    Highwall_Mine_Indicator_CountNonBlank                  := sum(group,if(files().base_mine_base.qa.Highwall_Mine_Indicator<>'',1,0));
    Multiple_Pits_Indicator_CountNonBlank                  := sum(group,if(files().base_mine_base.qa.Multiple_Pits_Indicator<>'',1,0));
    Miner_Rep_Indicator_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Miner_Rep_Indicator<>'',1,0));
    Safety_Committee_Indicator_CountNonBlank               := sum(group,if(files().base_mine_base.qa.Safety_Committee_Indicator<>'',1,0));
    Miles_From_Mine_CountNonBlank                          := sum(group,if(files().base_mine_base.qa.Miles_From_Mine<>'',1,0));
    Direction_To_Mine_CountNonBlank                        := sum(group,if(files().base_mine_base.qa.Direction_To_Mine<>'',1,0));
    Nearest_Town_CountNonBlank                             := sum(group,if(files().base_mine_base.qa.Nearest_Town<>'',1,0));
    Controller_Start_Date_CountNonBlank                    := sum(group,if(files().base_mine_base.qa.Controller_Start_Date<>'',1,0));
    Controller_End_Date_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Controller_End_Date<>'',1,0));
    Operator_Start_Date_CountNonBlank                      := sum(group,if(files().base_mine_base.qa.Operator_Start_Date<>'',1,0));
    Operator_End_Date_CountNonBlank                        := sum(group,if(files().base_mine_base.qa.Operator_End_Date<>'',1,0));
  end;

dPopulationStats_LaborActions_MSHA_Mine := table(files().base_mine_base.qa,rPopulationStats_LaborActions_MSHA_Mine,few);

STRATA.createXMLStats(dPopulationStats_LaborActions_MSHA_Mine
             ,_Dataset().name,
						'base_mine',
						pVersion,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;

 end;