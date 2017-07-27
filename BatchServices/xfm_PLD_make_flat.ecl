IMPORT BatchServices;
 
EXPORT layout_PLD_Batch_out xfm_PLD_make_flat(BatchServices.Layouts.PLD.rec_results_rawCount le,
                                              DATASET(BatchServices.Layouts.PLD.rec_results_rawCount) allRows) := 
	TRANSFORM
	
		SELF.acctno              := le.acctno;
		
		self.LitigiousDebtor_FLAG  := allRows[1].LitigiousDebtor_Flag;
		SELF.LD_CaseTypeMatch_FDCPA  := if  (count(choosen(allRows,6)(causecode='1')) >=1, 'Y','N');		   
		SELF.LD_CaseTypeMatch_FCRA   := if  (count(choosen(allRows,6)(causecode='2')) >=1, 'Y','N');	 
    SELF.LD_CaseTypeMatch_TCPA   := if  (count(choosen(allRows,6)(causecode='3')) >=1, 'Y','N');																				
				
		self.LD_Additional_party_attorneys_1 := trim(allRows[1].AdditionalAttorneyName, left, right);
	  self.LD_Cause_1                      := trim(allRows[1].Cause, left, right);	
		self.LD_Defendants_Attorney_1        := trim(allRows[1].DAttorneyname, left, right);
																							
	  self.LD_Defendants_1                 := trim(allRows[1].Defendant, left, right);
																								
	  tmp_LD_Demand_1                     := if (allRows[1].DemandAmount <> '', 
		                                              batchservices.functions.convert_to_currency(allRows[1].DemandAmount),
		                                              allRows[1].DemandAmount);
    self.LD_demand_1                     := trim(tmp_LD_demand_1, left, right);
	  self.LD_Docket_Case_Number_1         := trim(allRows[1].DocketNumber, left, right);
	  self.LD_Filing_date_1                := trim(allRows[1].DateFiled, left, right);
	  self.LD_Filing_type_1                := trim(allRows[1].ClassCode, left, right);
		
	  self.LD_Judge_1                      := trim(allRows[1].JudgeName, left, right);
	  self.LD_Jurisdiction_1               := trim(allRows[1].Jurisdiction, left, right);
	  self.LD_Jury_Demand_1                := trim(allRows[1].JuryDemand, left, right);
	  self.LD_Lead_Docket_Case_Number_1    := trim(allRows[1].LeadDocketNumber, left, right);
	  self.LD_Nature_of_Suit_1             := allRows[1].SuitNatureCode + ' ' + allrows[1].suitNatureDesc;
	  self.LD_Other_Docket_Case_Number_1   := trim(allRows[1].OtherDocketNumber, left, right);
	 	  	
		self.LD_Plaintiffs_Attorneys_1       := trim(allRows[1].PAttorneyname, left, right);
																						
	  self.LD_Plaintiffs_1                 :=  trim(allRows[1].plaintiff, left, right);
																							
	  self.LD_Court_Referred_To_1          := allRows[1].referredTojudgeTitle + ' ' + allRows[1].referredToJudge;
	  self.LD_Status_1                     := if (allRows[1].caseclosed ='Y', 'Case Closed', '');		                                         
	  self.LD_Date_Court_Update_Record_1   := allRows[1].asOfDate;  // just a guess ???
	  self.LD_Court_Of_Filing_1            := if (allRows[1].CourtName <> '', allRows[1].CourtName + '; (' + allRows[1].officeName + ')', '');
	  self.LD_Case_Title_1                 := trim(allRows[1].CaseCaption, left, right);
		
		// 2
		self.LD_Additional_party_attorneys_2 := trim(allRows[2].AdditionalAttorneyName, left, right);
	  self.LD_Cause_2                      := trim(allRows[2].Cause, left, right);	
		self.LD_Defendants_Attorney_2        := trim(allRows[2].DAttorneyname, left, right);
																						
	  self.LD_Defendants_2                 :=  trim(allRows[2].Defendant, left, right);
															
    														
		tmp_LD_Demand_2										   := if (allRows[2].DemandAmount <> '', 
		                                              batchservices.functions.convert_to_currency(allRows[2].DemandAmount),
		                                              allRows[2].DemandAmount);
		self.LD_Demand_2 										 := trim(tmp_LD_Demand_2, left, right);
	  self.LD_Docket_Case_Number_2         := trim(allRows[2].DocketNumber, left, right);
	  self.LD_Filing_date_2                := trim(allRows[2].DateFiled, left, right);
	  self.LD_Filing_type_2                := trim(allRows[2].ClassCode, left, right);
		
	  self.LD_Judge_2                      := trim(allRows[2].JudgeName, left, right);
	  self.LD_Jurisdiction_2               := trim(allRows[2].Jurisdiction, left, right);
	  self.LD_Jury_Demand_2                := trim(allRows[2].JuryDemand, left, right);
	  self.LD_Lead_Docket_Case_Number_2    := trim(allRows[2].LeadDocketNumber, left, right);
	  self.LD_Nature_of_Suit_2             := allRows[2].SuitNatureCode + ' ' + allrows[2].suitNatureDesc;
	  self.LD_Other_Docket_Case_Number_2   := trim(allRows[2].OtherDocketNumber, left, right);
	  
		self.LD_Plaintiffs_Attorneys_2       :=  trim(allRows[2].PAttorneyname, left, right);
																								
	  self.LD_Plaintiffs_2                 :=  trim(allRows[2].Plaintiff, left, right);
																								
	  self.LD_Court_Referred_To_2          := allRows[2].referredTojudgeTitle + ' ' + allRows[2].referredToJudge;
	  self.LD_Status_2                     := if (allRows[2].caseclosed ='Y', 'Case Closed', '');	
	  self.LD_Date_Court_Update_Record_2   := trim(allRows[2].asOfDate, left, right);  // just a guess ???
	  self.LD_Court_Of_Filing_2            := if (allRows[2].CourtName <> '', allRows[2].Courtname + '; (' + allRows[2].officeName + ')', '');
	  self.LD_Case_Title_2                 := trim(allRows[2].CaseCaption, left, right);
		
		// 3
		self.LD_Additional_party_attorneys_3 := trim(allRows[3].AdditionalAttorneyName, left, right);
	  self.LD_Cause_3                      := trim(allRows[3].Cause, left, right);	
		self.LD_Defendants_Attorney_3        :=  trim(allRows[3].DAttorneyname, left, right);
																							
	  self.LD_Defendants_3                 := trim(allRows[3].Defendant, left, right);
																								
	   
		tmp_LD_Demand_3 										 :=if (allRows[3].DemandAmount <> '', 
		                                              batchservices.functions.convert_to_currency(allRows[3].DemandAmount),
		                                              allRows[3].DemandAmount);
		self.LD_Demand_3               			 := trim(tmp_LD_Demand_3, left, right);																				
	  self.LD_Docket_Case_Number_3         := trim(allRows[3].DocketNumber, left, right);
	  self.LD_Filing_date_3                := trim(allRows[3].DateFiled, left, right);
	  self.LD_Filing_type_3                := trim(allRows[3].ClassCode, left, right);
		
	  self.LD_Judge_3                      := trim(allRows[3].JudgeName, left, right);
	  self.LD_Jurisdiction_3               := trim(allRows[3].Jurisdiction, left, right);
	  self.LD_Jury_Demand_3                := trim(allRows[3].JuryDemand, left, right);
	  self.LD_Lead_Docket_Case_Number_3    := trim(allRows[3].LeadDocketNumber, left, right);
	  self.LD_Nature_of_Suit_3             := allRows[3].SuitNatureCode + ' ' + allrows[3].suitNatureDesc;
	  self.LD_Other_Docket_Case_Number_3   := trim(allRows[3].OtherDocketNumber, left, right);
	  	
		self.LD_Plaintiffs_Attorneys_3       :=  trim(allRows[3].PAttorneyname, left, right);
																								
	  self.LD_Plaintiffs_3                 :=  trim(allRows[3].Plaintiff, left, right);
																								
	  self.LD_Court_Referred_To_3          := allRows[3].referredTojudgeTitle + ' ' + allRows[3].referredToJudge;
	  self.LD_Status_3                     := if (allRows[3].caseclosed ='Y', 'Case Closed', '');	
	  self.LD_Date_Court_Update_Record_3   := trim(allRows[3].asOfDate, left, right);  // just a guess ???
	  self.LD_Court_Of_Filing_3            := if (allRows[3].CourtName <> '', allRows[3].Courtname + '; (' + allRows[3].officeName + ')', '');
	  self.LD_Case_Title_3                 := trim(allRows[3].CaseCaption, left, right);
		
		// 4
		self.LD_Additional_party_attorneys_4 := trim(allRows[4].AdditionalAttorneyName, left, right);
	  self.LD_Cause_4                      := trim(allRows[4].Cause, left, right);	
		self.LD_Defendants_Attorney_4        := trim(allRows[4].DAttorneyname, left, right);
																								
	  self.LD_Defendants_4                 := trim(allRows[4].defendant, left, right);
																								
	                      
		tmp_LD_Demand_4 										 := if (allRows[4].DemandAmount <> '', 
		                                              batchservices.functions.convert_to_currency(allRows[4].DemandAmount),
		                                              allRows[4].DemandAmount);
    self.LD_Demand_4                     := trim(tmp_LD_Demand_4, left, right);
	  self.LD_Docket_Case_Number_4         := trim(allRows[4].DocketNumber, left, right);
	  self.LD_Filing_date_4                := trim(allRows[4].DateFiled, left, right);
	  self.LD_Filing_type_4                := trim(allRows[4].ClassCode, left, right);
		
	  self.LD_Judge_4                      := trim(allRows[4].JudgeName, left, right); 
	  self.LD_Jurisdiction_4               := trim(allRows[4].Jurisdiction, left, right);
	  self.LD_Jury_Demand_4                := trim(allRows[4].JuryDemand, left, right);
	  self.LD_Lead_Docket_Case_Number_4    := trim(allRows[4].LeadDocketNumber, left, right);
	  self.LD_Nature_of_Suit_4             := allRows[4].SuitNatureCode + ' ' + allrows[4].suitNatureDesc;
	  self.LD_Other_Docket_Case_Number_4   := trim(allRows[4].OtherDocketNumber, left, right);
	  	
		self.LD_Plaintiffs_Attorneys_4       := trim(allRows[4].PAttorneyname, left, right);
																							
	  self.LD_Plaintiffs_4                 := trim(allRows[4].Plaintiff, left, right);
																								
	  self.LD_Court_Referred_To_4          := allRows[4].referredTojudgeTitle + ' ' + allRows[4].referredToJudge;
	  self.LD_Status_4                     := if (allRows[4].caseclosed ='Y', 'Case Closed', '');	
	  self.LD_Date_Court_Update_Record_4   := trim(allRows[4].asOfDate, left, right);  // just a guess ???
	  self.LD_Court_Of_Filing_4            := if (allRows[4].CourtName <> '', allRows[4].Courtname + '; (' + allRows[4].officeName + ')', '');
	  self.LD_Case_Title_4                 := trim(allRows[4].CaseCaption, left, right);
		
		//5
		self.LD_Additional_party_attorneys_5 := trim(allRows[5].AdditionalAttorneyName, left, right);
	  self.LD_Cause_5                      := trim(allRows[5].Cause, left, right);	
		self.LD_Defendants_Attorney_5        :=  trim(allRows[5].DAttorneyname, left, right);
																								
	  self.LD_Defendants_5                 :=  trim(allRows[5].defendant, left, right);
																								
	                       
		tmp_LD_Demand_5                      := if (allRows[5].DemandAmount <> '', 
		                                              batchservices.functions.convert_to_currency(allRows[5].DemandAmount),
		                                              allRows[5].DemandAmount);
    self.LD_Demand_5                     := trim(tmp_LD_Demand_5, left, right);																									
	  self.LD_Docket_Case_Number_5         := trim(allRows[5].DocketNumber, left, right);
	  self.LD_Filing_date_5                := trim(allRows[5].DateFiled, left, right);
	  self.LD_Filing_type_5                := trim(allRows[5].ClassCode, left, right);
		
	  self.LD_Judge_5                      := trim(allRows[5].JudgeName, left, right); 
	  self.LD_Jurisdiction_5               := trim(allRows[5].Jurisdiction, left, right);
	  self.LD_Jury_Demand_5                := trim(allRows[5].JuryDemand, left, right);
	  self.LD_Lead_Docket_Case_Number_5    := trim(allRows[5].LeadDocketNumber, left, right);
	  self.LD_Nature_of_Suit_5             := allRows[5].SuitNatureCode + ' ' + allrows[5].suitNatureDesc;
	  self.LD_Other_Docket_Case_Number_5   := trim(allRows[5].OtherDocketNumber, left, right);
	  	
		self.LD_Plaintiffs_Attorneys_5       := trim(allRows[5].PAttorneyname, left, right);
																								
	  self.LD_Plaintiffs_5                 := trim(allRows[5].Plaintiff, left, right);
																							
	  self.LD_Court_Referred_To_5          := allRows[5].referredTojudgeTitle + ' ' + allRows[5].referredToJudge;
	  self.LD_Status_5                     := if (allRows[5].caseclosed ='Y', 'Case Closed', '');	
	  self.LD_Date_Court_Update_Record_5   := trim(allRows[5].asOfDate, left, right);  // just a guess ???
	  self.LD_Court_Of_Filing_5            := if (allRows[5].CourtName <> '', allRows[5].Courtname + '; (' + allRows[5].officeName + ')', '');

	  self.LD_Case_Title_5                 := trim(allRows[5].CaseCaption, left, right);
		
		//6
		self.LD_Additional_party_attorneys_6 := trim(allRows[6].AdditionalAttorneyName, left, right);
	  self.LD_Cause_6                      := trim(allRows[6].Cause, left, right);	
		self.LD_Defendants_Attorney_6        := trim(allRows[6].DAttorneyname, left, right);
																							
	  self.LD_Defendants_6                 := trim(allRows[6].Defendant, left, right);
																							
	                      
		tmp_LD_Demand_6                      := if (allRows[6].DemandAmount <> '', 
		                                              batchservices.functions.convert_to_currency(allRows[6].DemandAmount),
		                                              allRows[6].DemandAmount);
    self.LD_Demand_6                     := trim(tmp_LD_Demand_6, left, right);
	  self.LD_Docket_Case_Number_6         := trim(allRows[6].DocketNumber, left, right);
	  self.LD_Filing_date_6                := trim(allRows[6].DateFiled, left, right);
	  self.LD_Filing_type_6                := trim(allRows[6].ClassCode, left, right);
		
	  self.LD_Judge_6                      := trim(allRows[6].JudgeName, left, right);
	  self.LD_Jurisdiction_6               := trim(allRows[6].Jurisdiction, left, right);
	  self.LD_Jury_Demand_6                := trim(allRows[6].JuryDemand, left, right);
	  self.LD_Lead_Docket_Case_Number_6    := trim(allRows[6].LeadDocketNumber, left, right);
	  self.LD_Nature_of_Suit_6             := allRows[6].SuitNatureCode + ' ' + allrows[6].suitNatureDesc;
	  self.LD_Other_Docket_Case_Number_6   := trim(allRows[6].OtherDocketNumber, left, right);
	  	
		self.LD_Plaintiffs_Attorneys_6       :=  trim(allRows[6].PAttorneyname, left, right);
																							
	  self.LD_Plaintiffs_6                 :=  trim(allRows[6].plaintiff, left, right);
																						
	  self.LD_Court_Referred_To_6          := allRows[6].referredTojudgeTitle + ' ' + allRows[6].referredToJudge;
	  self.LD_Status_6                     := if (allRows[6].caseclosed ='Y', 'Case Closed', '');	
	  self.LD_Date_Court_Update_Record_6   := trim(allRows[6].asOfDate, left, right);  // just a guess ???
	  self.LD_Court_Of_Filing_6            := if (allRows[6].CourtName <> '', allRows[6].Courtname + '; (' + allRows[6].officeName + ')', '');
	  self.LD_Case_Title_6                 := trim(allRows[6].CaseCaption, left, right);
				
		SELF                       := le;		
	END;