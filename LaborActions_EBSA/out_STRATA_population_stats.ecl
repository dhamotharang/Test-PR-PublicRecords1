import STRATA, LaborActions_EBSA;

export out_STRATA_population_stats(string pVersion) := function

rPopulationStats_LaborActions_EBSA := record
    LaborActions_EBSA.Files().Base.Built.Dart_Id;    			// field to group by --  all values are "10002"
    CountGroup                                           := count(group);
    Date_FirstSeen_CountNonZero                          := sum(group,if(LaborActions_EBSA.Files().Base.Built.Date_FirstSeen<>0,1,0));
    Date_LastSeen_CountNonZero                           := sum(group,if(LaborActions_EBSA.Files().Base.Built.Date_LastSeen<>0,1,0));
    Dart_Id_CountNonBlank                                := sum(group,if(LaborActions_EBSA.Files().Base.Built.Dart_Id<>'',1,0));
    Date_Added_CountNonBlank                             := sum(group,if(LaborActions_EBSA.Files().Base.Built.Date_Added<>'',1,0));
    Date_Updated_CountNonBlank                           := sum(group,if(LaborActions_EBSA.Files().Base.Built.Date_Updated<>'',1,0));
    Website_CountNonBlank                                := sum(group,if(LaborActions_EBSA.Files().Base.Built.Website<>'',1,0));
    State_CountNonBlank                                  := sum(group,if(LaborActions_EBSA.Files().Base.Built.State<>'',1,0));
    Casetype_CountNonBlank                               := sum(group,if(LaborActions_EBSA.Files().Base.Built.Casetype<>'',1,0));
    Plan_Ein_CountNonBlank                               := sum(group,if(LaborActions_EBSA.Files().Base.Built.Plan_Ein<>'',1,0));
    Plan_No_CountNonBlank                                := sum(group,if(LaborActions_EBSA.Files().Base.Built.Plan_No<>'',1,0));
    Plan_Year_CountNonBlank                              := sum(group,if(LaborActions_EBSA.Files().Base.Built.Plan_Year<>'',1,0));
    Plan_Name_CountNonBlank                              := sum(group,if(LaborActions_EBSA.Files().Base.Built.Plan_Name<>'',1,0));
    Plan_Administrator_CountNonBlank                     := sum(group,if(LaborActions_EBSA.Files().Base.Built.Plan_Administrator<>'',1,0));
    Admin_State_CountNonBlank                            := sum(group,if(LaborActions_EBSA.Files().Base.Built.Admin_State<>'',1,0));
    Admin_Zip_Code_CountNonBlank                         := sum(group,if(LaborActions_EBSA.Files().Base.Built.Admin_Zip_Code<>'',1,0));
    Admin_Zip_Code4_CountNonBlank                        := sum(group,if(LaborActions_EBSA.Files().Base.Built.Admin_Zip_Code4<>'',1,0));
    Closing_Reason_CountNonBlank                         := sum(group,if(LaborActions_EBSA.Files().Base.Built.Closing_Reason<>'',1,0));
    Closing_Date_CountNonBlank                           := sum(group,if(LaborActions_EBSA.Files().Base.Built.Closing_Date<>'',1,0));
    Penalty_Amount_CountNonBlank                         := sum(group,if(LaborActions_EBSA.Files().Base.Built.Penalty_Amount<>'',1,0));
    Clean_Plan_Name_CountNonBlank                        := sum(group,if(LaborActions_EBSA.Files().Base.Built.Clean_Plan_Name<>'',1,0));
    Clean_Plan_Administrator_CountNonBlank               := sum(group,if(LaborActions_EBSA.Files().Base.Built.Clean_Plan_Administrator<>'',1,0));
end;

dPopulationStats_LaborActions_EBSA := table(LaborActions_EBSA.Files().Base.Built,rPopulationStats_LaborActions_EBSA,few);

STRATA.createXMLStats(dPopulationStats_LaborActions_EBSA
             ,_Dataset().name,
						'base',
						pVersion,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;

 end;