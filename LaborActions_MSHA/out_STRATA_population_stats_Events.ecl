import STRATA, LaborActions_MSHA;

export out_STRATA_population_stats_Events(string pVersion) := function

rPopulationStats_LaborActions_MSHA_Events := record
    LaborActions_MSHA.files().base_events_base.qa.Dart_Id;    		// field to group by --  all values are "10003"
    CountGroup                                                       := count(group);
    Date_FirstSeen_CountNonZero                                      := sum(group,if(files().base_events_base.qa.Date_FirstSeen<>0,1,0));
    Date_LastSeen_CountNonZero                                       := sum(group,if(files().base_events_base.qa.Date_LastSeen<>0,1,0));
    Dart_Id_CountNonBlank                                            := sum(group,if(files().base_events_base.qa.Dart_Id<>'',1,0));
    Mine_Id_CountNonBlank                                            := sum(group,if(files().base_events_base.qa.Mine_Id<>'',1,0));
    Mine_Id_Cleaned_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.Mine_Id_Cleaned<>'',1,0));		
    Event_No_CountNonBlank                                           := sum(group,if(files().base_events_base.qa.Event_No<>'',1,0));
    Event_No_Cleaned_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Event_No_Cleaned<>'',1,0));		
    Contractor_Id_CountNonBlank                                      := sum(group,if(files().base_events_base.qa.Contractor_Id<>'',1,0));
    Contractor_Id_Cleaned_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Contractor_Id_Cleaned<>'',1,0));				
    Inspection_Activity_Code_CountNonBlank                           := sum(group,if(files().base_events_base.qa.Inspection_Activity_Code<>'',1,0));
    Inspection_Activity_Code_Cleaned_CountNonBlank                   := sum(group,if(files().base_events_base.qa.Inspection_Activity_Code_Cleaned<>'',1,0));		
    Inspection_Activity_Code_Description_CountNonBlank               := sum(group,if(files().base_events_base.qa.Inspection_Activity_Code_Description<>'',1,0));
    Inspection_Begin_Date_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Inspection_Begin_Date<>'',1,0));
    Inspection_End_Date_CountNonBlank                                := sum(group,if(files().base_events_base.qa.Inspection_End_Date<>'',1,0));
		Inspector_Office_Code_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Inspector_Office_Code<>'',1,0));
    Active_Sections_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.Active_Sections<>'',1,0));
    Idle_Sections_CountNonBlank                                      := sum(group,if(files().base_events_base.qa.Idle_Sections<>'',1,0));
    Number_Of_Shaft_Slope_Sinking_CountNonBlank                      := sum(group,if(files().base_events_base.qa.Number_Of_Shaft_Slope_Sinking<>'',1,0));
    Impoundment_Construction_CountNonBlank                           := sum(group,if(files().base_events_base.qa.Impoundment_Construction<>'',1,0));
    Building_Construction_Sites_CountNonBlank                        := sum(group,if(files().base_events_base.qa.Building_Construction_Sites<>'',1,0));
    Drag_Lines_CountNonBlank                                         := sum(group,if(files().base_events_base.qa.Drag_Lines<>'',1,0));
    Number_Of_Unclassified_Construction_CountNonBlank                := sum(group,if(files().base_events_base.qa.Number_Of_Unclassified_Construction<>'',1,0));
    Company_Records_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.Company_Records<>'',1,0));
    Surface_Underground_Indicator_CountNonBlank                      := sum(group,if(files().base_events_base.qa.Surface_Underground_Indicator<>'',1,0));
    Surf_Facility_Indicator_CountNonBlank                            := sum(group,if(files().base_events_base.qa.Surf_Facility_Indicator<>'',1,0));
    Refuse_Pile_Indicator_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Refuse_Pile_Indicator<>'',1,0));
    Explosive_Storage_CountNonBlank                                  := sum(group,if(files().base_events_base.qa.Explosive_Storage<>'',1,0));
    Out_By_Area_Indicator_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Out_By_Area_Indicator<>'',1,0));
    Major_Construction_Indicator_CountNonBlank                       := sum(group,if(files().base_events_base.qa.Major_Construction_Indicator<>'',1,0));
    Shaft_Slope_Indicator_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Shaft_Slope_Indicator<>'',1,0));
    Impoundment_Indicator_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Impoundment_Indicator<>'',1,0));
    Miscellaneous_Area_CountNonBlank                                 := sum(group,if(files().base_events_base.qa.Miscellaneous_Area<>'',1,0));
    Program_Area_CountNonBlank                                       := sum(group,if(files().base_events_base.qa.Program_Area<>'',1,0));
    Number_Of_Air_Samples_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Number_Of_Air_Samples<>'',1,0));
    Number_Of_Dust_Samples_CountNonBlank                             := sum(group,if(files().base_events_base.qa.Number_Of_Dust_Samples<>'',1,0));
    Number_Of_Survey_Samples_CountNonBlank                           := sum(group,if(files().base_events_base.qa.Number_Of_Survey_Samples<>'',1,0));
    Number_Of_Respiratory_Dust_Samples_CountNonBlank                 := sum(group,if(files().base_events_base.qa.Number_Of_Respiratory_Dust_Samples<>'',1,0));
    Number_Of_Noise_Samples_CountNonBlank                            := sum(group,if(files().base_events_base.qa.Number_Of_Noise_Samples<>'',1,0));
    Number_Of_Other_Samples_CountNonBlank                            := sum(group,if(files().base_events_base.qa.Number_Of_Other_Samples<>'',1,0));
    Number_Of_Inspectors_CountNonBlank                               := sum(group,if(files().base_events_base.qa.Number_Of_Inspectors<>'',1,0));
    Total_On_Site_Hours_CountNonBlank                                := sum(group,if(files().base_events_base.qa.Total_On_Site_Hours<>'',1,0));
    Total_Inspection_Hours_CountNonBlank                             := sum(group,if(files().base_events_base.qa.Total_Inspection_Hours<>'',1,0));
    Coal_Metal_Indicator_CountNonBlank                               := sum(group,if(files().base_events_base.qa.Coal_Metal_Indicator<>'',1,0));
    Violation_No_CountNonBlank                                       := sum(group,if(files().base_events_base.qa.Violation_No<>'',1,0));
    Violation_No_Cleaned_CountNonBlank                               := sum(group,if(files().base_events_base.qa.Violation_No_Cleaned<>'',1,0));		
    Date_Issued_CountNonBlank                                        := sum(group,if(files().base_events_base.qa.Date_Issued<>'',1,0));
    S_S_Designation_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.S_S_Designation<>'',1,0));
		Part_Section_CountNonBlank                                       := sum(group,if(files().base_events_base.qa.Part_Section<>'',1,0));
    Type_of_Issuance_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Type_of_Issuance<>'',1,0));
    CFR_30_CountNonBlank                                             := sum(group,if(files().base_events_base.qa.CFR_30<>'',1,0));
    Date_Terminated_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.Date_Terminated<>'',1,0));
    Violator_ID_CountNonBlank                                        := sum(group,if(files().base_events_base.qa.Violator_ID<>'',1,0));
    Violator_ID_Cleaned_CountNonBlank                                := sum(group,if(files().base_events_base.qa.Violator_ID_Cleaned<>'',1,0));		
    Violator_Name_CountNonBlank                                      := sum(group,if(files().base_events_base.qa.Violator_Name<>'',1,0));
    Proposed_Penalty_Amount_CountNonBlank                            := sum(group,if(files().base_events_base.qa.Proposed_Penalty_Amount<>'',1,0));
    Current_Assessment_Amount_CountNonBlank                          := sum(group,if(files().base_events_base.qa.Current_Assessment_Amount<>'',1,0));
    Paid_Proposed_Penalty_Amount_CountNonBlank                       := sum(group,if(files().base_events_base.qa.Paid_Proposed_Penalty_Amount<>'',1,0));
    Last_Action_Code_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Last_Action_Code<>'',1,0));
    Final_Order_Date_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Final_Order_Date<>'',1,0));
    Violator_Type_CountNonBlank                                      := sum(group,if(files().base_events_base.qa.Violator_Type<>'',1,0));
    Violation_Occur_Date_CountNonBlank                               := sum(group,if(files().base_events_base.qa.Violation_Occur_Date<>'',1,0));
    Violation_Calendar_Year_CountNonBlank                            := sum(group,if(files().base_events_base.qa.Violation_Calendar_Year<>'',1,0));
    Violation_Calendar_Quarter_CountNonBlank                         := sum(group,if(files().base_events_base.qa.Violation_Calendar_Quarter<>'',1,0));
    Violation_Fiscal_Year_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Violation_Fiscal_Year<>'',1,0));
    Violation_Fiscal_Quarter_CountNonBlank                           := sum(group,if(files().base_events_base.qa.Violation_Fiscal_Quarter<>'',1,0));
    Violation_Issue_Time_CountNonBlank                               := sum(group,if(files().base_events_base.qa.Violation_Issue_Time<>'',1,0));
    Section_of_Act_CountNonBlank                                     := sum(group,if(files().base_events_base.qa.Section_of_Act<>'',1,0));
    Section_Of_Act2_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.Section_Of_Act2<>'',1,0));
    Orig_Termination_Due_Date_CountNonBlank                          := sum(group,if(files().base_events_base.qa.Orig_Termination_Due_Date<>'',1,0));
    Orig_Termination_Due_Time_CountNonBlank                          := sum(group,if(files().base_events_base.qa.Orig_Termination_Due_Time<>'',1,0));
    Latest_Termination_Due_Date_CountNonBlank                        := sum(group,if(files().base_events_base.qa.Latest_Termination_Due_Date<>'',1,0));
    Latest_Termination_Due_Time_CountNonBlank                        := sum(group,if(files().base_events_base.qa.Latest_Termination_Due_Time<>'',1,0));
    Termination_Time_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Termination_Time<>'',1,0));
    Termination_Type_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Termination_Type<>'',1,0));
    Initial_Violation_No_CountNonBlank                               := sum(group,if(files().base_events_base.qa.Initial_Violation_No<>'',1,0));
    Replaced_Order_No_CountNonBlank                                  := sum(group,if(files().base_events_base.qa.Replaced_Order_No<>'',1,0));
    Likelihood_CountNonBlank                                         := sum(group,if(files().base_events_base.qa.Likelihood<>'',1,0));
    Injury_Illness_CountNonBlank                                     := sum(group,if(files().base_events_base.qa.Injury_Illness<>'',1,0));
    No_Of_Person_Affected_CountNonBlank                              := sum(group,if(files().base_events_base.qa.No_Of_Person_Affected<>'',1,0));
    Negligence_CountNonBlank                                         := sum(group,if(files().base_events_base.qa.Negligence<>'',1,0));
    Written_Notice_CountNonBlank                                     := sum(group,if(files().base_events_base.qa.Written_Notice<>'',1,0));
    Enforcement_Area_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Enforcement_Area<>'',1,0));
    Special_Assess_CountNonBlank                                     := sum(group,if(files().base_events_base.qa.Special_Assess<>'',1,0));
    Primary_Or_Assoc_Mill_CountNonBlank                              := sum(group,if(files().base_events_base.qa.Primary_Or_Assoc_Mill<>'',1,0));
    Right_To_Conference_Date_CountNonBlank                           := sum(group,if(files().base_events_base.qa.Right_To_Conference_Date<>'',1,0));
    Violator_Type_Indicator_CountNonBlank                            := sum(group,if(files().base_events_base.qa.Violator_Type_Indicator<>'',1,0));
    Bill_Print_Date_CountNonBlank                                    := sum(group,if(files().base_events_base.qa.Bill_Print_Date<>'',1,0));
    Last_Action_Date_CountNonBlank                                   := sum(group,if(files().base_events_base.qa.Last_Action_Date<>'',1,0));
    Docket_No_CountNonBlank                                          := sum(group,if(files().base_events_base.qa.Docket_No<>'',1,0));
    Docket_Status_Code_CountNonBlank                                 := sum(group,if(files().base_events_base.qa.Docket_Status_Code<>'',1,0));
    Contested_Indicator_CountNonBlank                                := sum(group,if(files().base_events_base.qa.Contested_Indicator<>'',1,0));
    Contested_Date_CountNonBlank                                     := sum(group,if(files().base_events_base.qa.Contested_Date<>'',1,0));
  end;

dPopulationStats_LaborActions_MSHA_Events := table(files().base_events_base.qa,rPopulationStats_LaborActions_MSHA_Events,few);

STRATA.createXMLStats(dPopulationStats_LaborActions_MSHA_Events
             ,_Dataset().name,
						'base_eventsV1',
						pVersion,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;

 end;