import STRATA, LaborActions_MSHA;

export out_STRATA_population_stats_Operator(string pVersion) := function

rPopulationStats_LaborActions_MSHA_Operator := record
    LaborActions_MSHA.files().base_operator_base.qa.Dart_Id;    		// field to group by --  all values are "10003"
    CountGroup                                          := count(group);
    Date_FirstSeen_CountNonZero                         := sum(group,if(files().base_operator_base.qa.Date_FirstSeen<>0,1,0));
    Date_LastSeen_CountNonZero                          := sum(group,if(files().base_operator_base.qa.Date_LastSeen<>0,1,0));
    Dart_Id_CountNonBlank                               := sum(group,if(files().base_operator_base.qa.Dart_Id<>'',1,0));
    Mine_Id_CountNonBlank                               := sum(group,if(files().base_operator_base.qa.Mine_Id<>'',1,0));
    Mine_Id_Cleaned_CountNonBlank                       := sum(group,if(files().base_operator_base.qa.Mine_Id_Cleaned<>'',1,0));
		Sub_Unit_CountNonBlank                              := sum(group,if(files().base_operator_base.qa.Sub_Unit<>'',1,0));
    Sub_Unit_Cleaned_CountNonBlank                      := sum(group,if(files().base_operator_base.qa.Sub_Unit_Cleaned<>'',1,0));		
    Calendar_Year_CountNonBlank                         := sum(group,if(files().base_operator_base.qa.Calendar_Year<>'',1,0));
    Hours_Reported_for_Year_CountNonBlank               := sum(group,if(files().base_operator_base.qa.Hours_Reported_for_Year<>'',1,0));
    Annual_Coal_Production_CountNonBlank                := sum(group,if(files().base_operator_base.qa.Annual_Coal_Production<>'',1,0));
    Avg_Annual_Employee_Ct_CountNonBlank                := sum(group,if(files().base_operator_base.qa.Avg_Annual_Employee_Ct<>'',1,0));
    Sub_Unit_Description_CountNonBlank                  := sum(group,if(files().base_operator_base.qa.Sub_Unit_Description<>'',1,0));
    Production_Year_CountNonBlank                       := sum(group,if(files().base_operator_base.qa.Production_Year<>'',1,0));
    Production_Quarter_CountNonBlank                    := sum(group,if(files().base_operator_base.qa.Production_Quarter<>'',1,0));
    QT_Fiscal_Year_CountNonBlank                        := sum(group,if(files().base_operator_base.qa.QT_Fiscal_Year<>'',1,0));
    QT_Fiscal_Quarter_CountNonBlank                     := sum(group,if(files().base_operator_base.qa.QT_Fiscal_Quarter<>'',1,0));
    Avg_Employee_Ct_CountNonBlank                       := sum(group,if(files().base_operator_base.qa.Avg_Employee_Ct<>'',1,0));
    Employee_Hours_Worked_CountNonBlank                 := sum(group,if(files().base_operator_base.qa.Employee_Hours_Worked<>'',1,0));
    Coal_Production_CountNonBlank                       := sum(group,if(files().base_operator_base.qa.Coal_Production<>'',1,0));
  end;

dPopulationStats_LaborActions_MSHA_Operator := table(files().base_operator_base.qa,rPopulationStats_LaborActions_MSHA_Operator,few);

STRATA.createXMLStats(dPopulationStats_LaborActions_MSHA_Operator
             ,_Dataset().name,
						'base_operator',
						pVersion,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;

 end;