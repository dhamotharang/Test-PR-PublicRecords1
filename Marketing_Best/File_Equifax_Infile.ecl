Import Marketing_Best,  ut;

file_in := dataset('~thor_data400::in::marketing_best_equifax', Marketing_Best.Layout_Equifax_Infile.NewLayout, flat);

Marketing_Best.Layout_Equifax_Infile.CombinedLayout xForm(file_in L) := Transform

			Self.State_Code := L.FIPS_State_Code;
			Self.Status_Code_of_Records := L.Record_Quality_Code;
			Self.primary_given_name := L.Given_Name_1; 
			Self.Primary_Middle_Initial := L.Middle_Initial_1;
			Self.Primary_Name_Suffix := '';
			Self.Primary_Title_Code :=  L.Title_Code_1;
			Self.Primary_Gender :=   L.Gender_1;
			Self.Home_OwnerRenter_Code :=  L.AdvHome_Owner;
			Self.Marital_Status := L.AdvHousehold_Marital_Status;
			Self.Structure_Age_Year := L.Year_Home_Built;
			Self.Narrow_Band_Household_Income_Identifier :=  L.AdvHousehold_Income_Identifier;
			//  		Due to licensing changes with our supplier, we will need to remove the following auto variables, so made them null
			//Self.Combined_Market_Value_of_All_Vehicles := '';					//Deleted from vendor input file. 11/6/13
			//Self.Number_of_Cars_Currently_Registered_Owned := '';			//Deleted from vendor input file. 11/6/13			
			//Self.Truck_Owner_Code := '';															//Deleted from vendor input file. 11/6/13
			//Self.New_Vehicle_Purchase_Code := '';											//Deleted from vendor input file. 11/6/13
			//Self.Motorcycle_Ownership_Code := '';											//Deleted from vendor input file. 11/6/13
			//Self.Recreational_Vehicle_Ownership_Code := '';						//Deleted from vendor input file. 11/6/13
			//-------------------------------------------------------------------------------------
			Self.Household_Age_Code := L.AdvHousehold_Age;
			Self.Number_of_Persons_in_Household :=  L.AdvHousehold_Size;
			Self.Number_of_Adults_in_Household := L.AdvNumber_of_Adults;
			Self.Age_1 :=If(L.Individual_Exact_Age_1[1] = '0', L.Individual_Exact_Age_1[2..3], L.Individual_Exact_Age_1);
			Self.Age_2 :=If(L.Individual_Exact_Age_2[1] = '0', L.Individual_Exact_Age_2[2..3], L.Individual_Exact_Age_2);
			Self.Age_3 :=If(L.Individual_Exact_Age_3[1] = '0', L.Individual_Exact_Age_3[2..3], L.Individual_Exact_Age_3);
			Self.Age_4 :=If(L.Individual_Exact_Age_4[1] = '0', L.Individual_Exact_Age_4[2..3], L.Individual_Exact_Age_4);
			Self.Age_5 :=If(L.Individual_Exact_Age_5[1] = '0', L.Individual_Exact_Age_5[2..3], L.Individual_Exact_Age_5);
			Self.Percent_in_Single_Unit_Structures := L.Single_Unit_Structures;
			Self.Percent_Owner_Occupied_Structures_Built_Since_1990 := L.Owner_Occ_Structures_Built_Since_1990;
			Self.Percent_Persons_Move_In_Since_1995 := L.Persons_Move_In_Since_1995;
			//Self.Percent_of_Motor_Vehicle_Ownership := L.Households_With_1Vehicles;  //Deleted from vendor input file. 11/6/13
			Self.Percent_White := L.White_Alone;
			Self.Credit_Card_Usage_Miscellaneous  :=L.TCC_Miscellaneous;
			Self.Credit_Card_Usage_Standard_Retail  :=L.TCC_Standard_Retail;
			Self.Credit_Card_Usage_Standard_Specialty_Card  :=L.TCC_Standard_Specialty_Card;
			Self.Credit_Card_Usage_Upscale_Retail  :=L.TCC_Upscale_Retail;
			Self.Credit_Card_Usage_Upscale_Spec_Retail  :=L.TCC_Upscale_Spec_Retail;
			Self.Credit_Card_Usage_Bank_Card  :=L.TCC_Bank_Card;
			Self.Credit_Card_Usage_Oil__Gas_Card  :=L.TCC_Oil_Gas_Card;
			Self.Credit_Card_Usage_Finance_Co_Card  :=L.TCC_Finance_Co_Card;
			Self.Credit_Card_Usage_Travel__Entertainment  :=L.TCC_Travel_Entertainment;
			Self.Responder_Education_Code_1 :=  L.AdvHousehold_Education;
			Self.Responder_Education_Code_2 := L.AdvHousehold_Education;
			Self.Responder_Education_Code_3 := L.AdvHousehold_Education ;
			Self.Responder_Education_Code_4 :=  L.AdvHousehold_Education_Indicator ;
			Self.Spouse_Education_Code_1 := L.AdvHousehold_Education ;
			Self.Spouse_Education_Code_2 := L.AdvHousehold_Education;
			Self.Spouse_Education_Code_3 := L.AdvHousehold_Education;
			Self.Spouse_Education_Code_4 :=  L.AdvHousehold_Education_Indicator;		
			Self.Household_Income_Identifier :=  L.AdvHousehold_Income_Identifier;
			Self.Household_Occupation := L.Occupation;
			Self.Length_of_Residence :=L.AdvLength_of_Residence;
			Self.Dwelling_Type :=L.AdvDwelling_Type;
			Self.Narrow_Band_Income_Predictor := L.AdvHousehold_Income_Identifier;
			Self.Mail_Responsive_Buyer_Indicator :=L.Mail_Order_Buyer;
			//Self.Mail_Responsive_Donor_Indicator := L.Mail_Order_Donor;				//Deleted from vendor input file. 11/6/13			
			Self.Age_Indicator :=L.AdvHousehold_Age_Indicator;
			Self.Estimated_Home_Income_Predictor := L.AdvHousehold_Income_Identifier;
			Self.Income_Model_Indicator :=  L.AdvHousehold_Income_Identifier_Indicator;
			Self.Income_Model_Indicator2 :=  L.AdvHousehold_Income_Identifier_Indicator;
			//Self.Niches :=L.Niches_20;																				//Niches_20 is renamed to Niches_30. 11/6/13
			Self.Niches :=L.Niches_30;
			Self := L;
			Self := [];
End;
Export File_Equifax_Infile := Project(file_in, xForm(Left));