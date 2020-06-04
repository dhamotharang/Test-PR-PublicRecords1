import Address, BIPV2;

export Layouts := module

	export Input := module
	
			export Sprayed := record
					string9				Experian_Bus_Id; //Experian_Business_Identification_Number	
					string9				Filler_1	;
					string120			Business_Name	;
					string60			Address	;
					string40			City	;
					string2				State	;
					string5				ZIP_Code	;
					string4				ZIP_Plus_4	;
					string4				Carrier_Route	;
					string3				County_Code	;
					string30			County_Name	;
					string10			Phone_Number	;
					string4				MSA_Code	;
					string50			MSA_Description	;
					string8				Establish_Date	;
					string8				Latest_Reported_Date	;
					string2				Years_in_File	;
					string10			GEO_Code_Latitude	;
					string1				GEO_Code_Latitude_Direction	;
					string10			GEO_Code_Longitude	;
					string1				GEO_Code_Longitude_Direction	;
					string1				Recent_Update_Code	;
					string1				Years_in_Business_Code	;
					string4				Year_Business_Started	;
					string4				Months_in_File	;
					string1				Address_Type_Code	;
					string7				Estimated_Number_of_Employees	;
					string1				Employee_Size_Code	;
					string1				Estimated_Annual_Sales_Amount_Sign	;
					string8				Estimated_Annual_Sales_Amount	;
					string1				Annual_Sales_Size_Code	;
					string1				Location_Code	;
					string1				Primary_SIC_Code_Industry_Classification	;
					string4				Primary_SIC_Code_4_Digit	;
					string8				Primary_SIC_Code	;
					string8				Second_SIC_Code	;
					string8				Third_SIC_Code	;
					string8				Fourth_SIC_Code	;
					string8				Fifth_SIC_Code	;
					string8				Sixth_SIC_Code	;
					string6				Primary_NAICS_Code	;
					string6				Second_NAICS_Code	;
					string6				Third_NAICS_Code	;
					string6				Fourth_NAICS_Code	;
					string3				Executive_Count	;
					string3				Filler_2	;
					string20			Executive_Last_Name	;
					string10			Executive_First_Name	;
					string1				Executive_Middle_Initial	;
					string10			Executive_Title	;
					string9				Filler_3	;
					string1				Business_Type	;
					string1				Ownership_Code	;
					string50			URL	;
					string1				Derogatory_Indicator	;
					string8				Recent_Derogatory_Filed_Date	;
					string1				Derogatory_Liability_Amount_Sign	;
					string10			Derogatory_Liability_Amount;
					string1				UCC_Data_Indicator	;
					string5				UCC_Count	;
					string3				Number_of_Legal_Items	;
					string1				Legal_Balance_Sign	;
					string10			Legal_Balance_Amount	;
					string1				PMTKBankruptcy	;
					string1				PMTKJudgment	;
					string1				PMTKTaxlien	;
					string1				PMTKPayment	;
					string1				Filler_4	;
					string1				Bankruptcy_filed	;
					string3				Number_of_Derogatory_Legal_Items	;
					string3				Lien_count	;
					string3				Judgment_count	;
					string5				BKC006	;
					string5				BKC007	;
					string5				BKC008	;
					string1				BKO009	;
					string1				BKB001_Sign	;
					string11			BKB001	;
					string12			Filler_5	;
					string1				BKB003_Sign	;
					string11			BKB003	;
					string5				BKO010	;
					string5				BKO011	;
					string10			Filler_6	;
					string5				JDC010	;
					string5				JDC011	;
					string5				JDC012	;
					string10			JDB004	;
					string10			JDB005	;
					string10			JDB006	;
					string5				JDO013	;
					string5				JDO014	;
					string10			Filler_7	;
					string10			JDB002	;
					string30			Filler_8	;
					string10			JDP016	;
					string10			Filler_9	;
					string5				LGC004	;
					string10			Filler_10	;
					string5				PRO001	;
					string5				Filler_11	;
					string5				PRO003	;
					string5				TXC010	;
					string5				TXC011	;
					string5				Filler_12	;
					string1				TXB004_Sign	;
					string11			TXB004	;
					string12			Filler_13	;
					string5				TXO013	;
					string17			Filler_14	;
					string1				TXB002_Sign	;
					string11			TXB002	;
					string32			Filler_15	;
					string10			TXP016	;
					string10			Filler_16	;
					string5				UCC001	;
					string5				UCC002	;
					string5				UCC003	;
					string185			Filler_17	;
					string8				Intelliscore_Plus	;
					string3				Percentile_model	;
					string30			Model_action ;
					string3				Score_Factor_1	;
					string3				Score_Factor_2	;
					string3				Score_Factor_3	;
					string3				Score_Factor_4	;
					string6				Model_Code	;
					string1				Model_type	;
					string8				Last_Experian_Inquiry_Date	;
					string15			Filler_18	;
					string1				Recent_High_Credit_Sign	;
					string9				Recent_High_Credit	;
					string1				Median_Credit_Amount_Sign	;
					string9				Median_Credit_Amount	;
					string3				Total_Combined_Trade_Lines_Count	;
					string3				DBT_of_Combined_Trade_Totals	;
					string9				Combined_Trade_Balance	;
					string5				Aged_Trade_Lines	;
					string9				Filler_19	;
					string1				Experian_Credit_Rating	;
					string5				Quarter_1_Average_DBT	;
					string5				Quarter_2_Average_DBT	;
					string5				Quarter_3_Average_DBT	;
					string5				Quarter_4_Average_DBT	;
					string5				Quarter_5_Average_DBT	;
					string3				Combined_DBT	;
					string1				Total_Account_Balance_Sign	;
					string10			Total_Account_Balance	;
					string1				Combined_Account_Balance_Sign	;
					string10			Combined_Account_Balance	;
					string3				Collection_count	;
					string257			Filler_20	;
					string5				ATC021	;
					string5				ATC022	;
					string5				ATC023	;
					string5				ATC024	;
					string5				ATC025	;
					string2560		Filler_21	;
					string1				Last_Activity_Age_Code	;
					string1				Filler_22	;
					string1				Cottage_Indicator	;
					string8				Filler_23	;
					string1				NonProfit_Indicator	;
					string355			Filler_24	;
					string8				Financial_Stability_Risk_Score	;
					string1				FSR_Risk_Class	;
					string3				FSR_Score_Factor_1	;
					string3				FSR_Score_Factor_2	;
					string3				FSR_Score_Factor_3	;
					string3				FSR_Score_Factor_4	;
					string21			Filler_25	;
					string1				IP_Score_change_sign	;
					string2				IP_Score_change	;
					string1				FSR_Score_change_sign	;
					string2				FSR_Score_change	;
					string122			DBA_Name	;
			end;
			
			export Sprayed_Fixed := record
				Sprayed - Filler_1 -Filler_2 - Filler_3 - Filler_4 - Filler_5 - Filler_6 - Filler_7 - Filler_8 - Filler_9 - Filler_10 - Filler_11
								- Filler_12 -Filler_13 - Filler_14 - Filler_15 - Filler_16 - Filler_17 - Filler_18 - Filler_19 - Filler_20 - Filler_21 - Filler_22 - Filler_23 - Filler_24 - Filler_25;
			end;

  end;
	
	export CCPA_fields := 
		record
			// Jira# CCPA-99, Experian CRDB
			// The below 2 fields are added for CCPA (California Consumer Protection Act) project.
			// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
			unsigned4 											global_sid 									:= 0;
			unsigned8 											record_sid 									:= 0;
		end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=	record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned6												did													:= 0;
		unsigned4 											dt_first_seen								:= 0;
		unsigned4 											dt_last_seen								:= 0;
		unsigned4 											dt_vendor_first_reported		:= 0;
		unsigned4 											dt_vendor_last_reported			:= 0;
		Input.Sprayed																										;
		string122			                  Clean_DBA_Name; // this is a Clean DBA name field, we have Non view able characters in the vendor sending "DBA_Name" field! 
		string10												clean_phone									:='';
		Address.Layout_Clean182_fips; 
		string30      								  Recent_Update_Desc;
		string30     										Years_in_Business_Desc	;
		string30     										Address_Type_Desc	;
		string20												Employee_Size_Desc	;
		string30												Annual_Sales_Size_Desc	;
		string30												Location_Desc	;
		string30												Primary_SIC_Code_Industry_Class_Desc	;
		string30												Business_Type_Desc	;
		string10												Ownership_Code_Desc	;
		string30											  UCC_Data_Indicator_Desc	;
		string30												Experian_Credit_Rating_Desc	;
		string20												Last_Activity_Age_Desc	;
		string20												Cottage_Indicator_Desc	;
		string20												NonProfit_Indicator_Desc	;
		string100											  Company_name; //  Only Busines names
		string5   											P_title;
		string20  											P_fname; //Clean name fields for peoples, which are in Business_name field
		string20  											P_mname;
		string20  											P_lname;
		string5   											P_name_suffix;
		string5   											title;
		string20  											fname;
		string20  											mname;
		string20  											lname;
		string5   											name_suffix;
		unsigned8												raw_aid											:= 0;
		unsigned8												ace_aid										 	:= 0;
		string100												prep_addr_line1						 	:='';
		string50												prep_addr_line_last				 	:='';
		unsigned8												source_rec_id								:= 0;
		//** Added CCPA fields as per Jira# CCPA-99
		CCPA_fields;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=record	
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6														Bdid				:= 0;
		unsigned1														Bdid_score	:= 0;
		unsigned6														did					:= 0;
		unsigned4 													dt_first_seen								;
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		input.Sprayed_Fixed;
		string122			                  Clean_DBA_Name;
		string10												clean_phone									:='';
		Address.Layout_Clean182_fips; 
		string30      								  Recent_Update_Desc;
		string30     										Years_in_Business_Desc	;
		string30     										Address_Type_Desc	;
		string20												Employee_Size_Desc	;
		string30												Annual_Sales_Size_Desc	;
		string30												Location_Desc	;
		string30												Primary_SIC_Code_Industry_Class_Desc	;
		string30												Business_Type_Desc	;
		string10												Ownership_Code_Desc	;
		string30											  UCC_Data_Indicator_Desc	;
		string30												Experian_Credit_Rating_Desc	;
		string20												Last_Activity_Age_Desc	;
		string20												Cottage_Indicator_Desc	;
		string20												NonProfit_Indicator_Desc	;
		string100											  Company_name; //  Only Busines names
		string5   											title;
		string20  											fname;
		string20  											mname;
		string20  											lname;
		unsigned8												raw_aid											:= 0;
		unsigned8												ace_aid										 	:= 0;
		string100												prep_addr_line1						 	:='';
		string50												prep_addr_line_last				 	:='';
		unsigned8												source_rec_id								:= 0;
		//** Added CCPA fields as per Jira# CCPA-99
		CCPA_fields;
	end;
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary := module
	  export StandardizeInput := record
			unsigned8		unique_id	;
									base ;
	  end;
	
		export didSlim :=  record
			unsigned8		unique_id					;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25 		p_City_name				;   		 
			string2			state		 					;
			unsigned6		did					  := 0;
			unsigned1		did_score		  := 0;
			string20  	fname;
			string20  	mname;
			string20    lname;
			string5   	name_suffix;
	  end;
		
	  export BdidSlim :=  record
			unsigned8		unique_id					;
			string100		Company_name;
			string100 	Business_Name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25 		p_City_name				;   		 
			string2			state		 					;
			string10		phone		  		    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string20  	fname;
		  string20  	mname;
		  string20  	lname;
			string2 		source				:='';
			string50		url						:='';
			unsigned8   source_rec_id := 0;
			BIPV2.IDlayouts.l_xlink_ids		;
	  end;
		
  end;

end;	