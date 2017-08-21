import STRATA, LaborActions_MSHA;

export out_STRATA_population_stats_Accident(string pVersion) := function

rPopulationStats_LaborActions_MSHA_Accident := record
    LaborActions_MSHA.files().base_accident_base.qa.Dart_Id;    		// field to group by --  all values are "10003"
    CountGroup                                                      := count(group);
    Date_FirstSeen_CountNonZero                                     := sum(group,if(files().base_accident_base.qa.Date_FirstSeen<>0,1,0));
    Date_LastSeen_CountNonZero                                      := sum(group,if(files().base_accident_base.qa.Date_LastSeen<>0,1,0));
    Dart_Id_CountNonBlank                                           := sum(group,if(files().base_accident_base.qa.Dart_Id<>'',1,0));
    Mine_Id_CountNonBlank                                           := sum(group,if(files().base_accident_base.qa.Mine_Id<>'',1,0));		
    Mine_Id_Cleaned_CountNonBlank                                   := sum(group,if(files().base_accident_base.qa.Mine_Id_Cleaned<>'',1,0));
    Contractor_Id_CountNonBlank                                     := sum(group,if(files().base_accident_base.qa.Contractor_Id<>'',1,0));
    Contractor_Id_Cleaned_CountNonBlank                             := sum(group,if(files().base_accident_base.qa.Contractor_Id_Cleaned<>'',1,0));		
    Sub_Unit_CountNonBlank                                          := sum(group,if(files().base_accident_base.qa.Sub_Unit<>'',1,0));
    Sub_Unit_Cleaned_CountNonBlank                                  := sum(group,if(files().base_accident_base.qa.Sub_Unit_Cleaned<>'',1,0));		
    Sub_Unit_Description_CountNonBlank                              := sum(group,if(files().base_accident_base.qa.Sub_Unit_Description<>'',1,0));
    Accident_Date_CountNonBlank                                     := sum(group,if(files().base_accident_base.qa.Accident_Date<>'',1,0));
    Degree_of_Injury_CountNonBlank                                  := sum(group,if(files().base_accident_base.qa.Degree_of_Injury<>'',1,0));
    Accident_Classification_Description_CountNonBlank               := sum(group,if(files().base_accident_base.qa.Accident_Classification_Description<>'',1,0));
    Occupation_Code_Description_CountNonBlank                       := sum(group,if(files().base_accident_base.qa.Occupation_Code_Description<>'',1,0));
    Miner_Activity_CountNonBlank                                    := sum(group,if(files().base_accident_base.qa.Miner_Activity<>'',1,0));
    Total_Experience_CountNonZero                                   := sum(group,if(files().base_accident_base.qa.Total_Experience<>0,1,0));
    Mine_Experience_CountNonZero                                    := sum(group,if(files().base_accident_base.qa.Mine_Experience<>0,1,0));
    Job_Experience_CountNonZero                                     := sum(group,if(files().base_accident_base.qa.Job_Experience<>0,1,0));
    Accident_Narrative_CountNonBlank                                := sum(group,if(files().base_accident_base.qa.Accident_Narrative<>'',1,0));
  end;

dPopulationStats_LaborActions_MSHA_Accident := table(files().base_accident_base.qa,rPopulationStats_LaborActions_MSHA_Accident,few);

STRATA.createXMLStats(dPopulationStats_LaborActions_MSHA_Accident
             ,_Dataset().name,
						'base_Accident',
						pVersion,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;

 end;