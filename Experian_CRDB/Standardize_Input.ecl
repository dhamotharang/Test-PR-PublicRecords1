import  _Control, MDR, lib_stringlib, ut, _validate, Address, aid, NID, Std;

export Standardize_Input :=	module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.input.Sprayed) pRawFileInput, string pversion) :=function
	
	 Layouts.base trans_PreProcessor(layouts.Input.Sprayed l) :=	transform	
	    temp_first_seen											              := if (_validate.date.fIsValid(l.Establish_Date) and _validate.date.fIsValid(l.Establish_Date,_validate.date.rules.DateInPast), (unsigned8)l.Establish_Date,(unsigned8)pversion);
			temp_last_seen																		:= if (_validate.date.fIsValid(l.Latest_Reported_Date) and _validate.date.fIsValid(l.Latest_Reported_Date,_validate.date.rules.DateInPast),(unsigned8)l.Latest_Reported_Date,(unsigned8)pversion);
			self.prep_addr_line1										          := ut.CleanSpacesAndUpper(l.Address); 
			self.prep_addr_line_last								          := ut.CleanSpacesAndUpper(l.City)+ if (trim(l.City) <> '',', ','') + 
																													 ut.CleanSpacesAndUpper(l.State)+ ' '	+trim(l.Zip_Code,left,right);
			self.dt_first_seen	                              := if (temp_first_seen > temp_last_seen and temp_last_seen<>0 , temp_last_seen, temp_first_seen); //Since raw dates "Establish_Date" is greater "Latest_Reported_Date" for some records, making sure we have always lowest date in Ã¢â‚¬Å“first_seen Ã¢â‚¬Â field!    
			self.dt_last_seen												          := temp_last_seen;
			self.dt_vendor_first_reported											:= (unsigned8)pversion;
			self.dt_vendor_last_reported											:= (unsigned8)pversion;			
			self.Experian_Bus_Id                              := trim(l.Experian_Bus_Id,left,right);
			self.Business_Name	                              := ut.CleanSpacesAndUpper(l.Business_Name);	
			self.Address														          := ut.CleanSpacesAndUpper(l.Address);
			self.City																          := ut.CleanSpacesAndUpper(l.City);
			self.State															          := ut.CleanSpacesAndUpper(l.State);
			self.Zip_Code														          := trim(l.Zip_Code,left,right);
			self.ZIP_Plus_4													          := trim(l.ZIP_Plus_4,left,right);
			self.Carrier_Route											          := ut.CleanSpacesAndUpper(l.Carrier_Route); //AlphaNumerical
			self.County_Code	 											          := if((integer)l.County_Code <>0 ,(string)(integer)l.County_Code,'0');
			self.County_Name	 											          := ut.CleanSpacesAndUpper(l.County_Name	);
			self.Phone_Number	 											          := ut.CleanPhone(l.Phone_Number);
			self.MSA_Code	 													          := if((integer)l.msa_code <>0 ,trim(l.msa_code,left,right),'0');
			self.MSA_Description	 									          := ut.CleanSpacesAndUpper(l.MSA_Description	);
			self.Establish_Date	 										          := if(_validate.date.fIsValid(trim(l.Establish_Date,left,right)),trim(l.Establish_Date,left,right),'');
			self.Latest_Reported_Date	 							          := if(_validate.date.fIsValid(trim(l.Latest_Reported_Date,left,right)),trim(l.Latest_Reported_Date,left,right),'');
			self.Years_in_File	 										          := if((integer)l.Years_in_File <> 0,(string)(integer)l.Years_in_File ,'0');
			self.GEO_Code_Latitude	 								          := if( (DECIMAL5_2)l.GEO_Code_Latitude	<> 0 ,(string) (DECIMAL5_2)l.GEO_Code_Latitude,'0'); 
			self.GEO_Code_Latitude_Direction	 			          := ut.CleanSpacesAndUpper(l.GEO_Code_Latitude_Direction);
			self.GEO_Code_Longitude	 								          := if((DECIMAL5_2)l.GEO_Code_Longitude	<> 0,(string) (DECIMAL5_2)l.GEO_Code_Longitude,'0'); 
			self.GEO_Code_Longitude_Direction	 			          := ut.CleanSpacesAndUpper(l.GEO_Code_Longitude_Direction	);
			self.Recent_Update_Code	 								          := ut.CleanSpacesAndUpper(l.Recent_Update_Code	);
			self.Recent_Update_Desc                           := map( ut.CleanSpacesAndUpper(l.Recent_Update_Code	)='A'=>'LESS THAN 6 MONTHS'
			                                                         ,ut.CleanSpacesAndUpper(l.Recent_Update_Code	)='B'=>'6 TO 12 MONTHS'
																															 ,ut.CleanSpacesAndUpper(l.Recent_Update_Code	)='C'=>'13 TO 18 MONTHS'
																															 ,ut.CleanSpacesAndUpper(l.Recent_Update_Code	)=''=>'OVER 18 MONTHS','');
			self.Years_in_Business_Code	 						          := ut.CleanSpacesAndUpper(l.Years_in_Business_Code	);
			self.Years_in_Business_Desc 											:= map( ut.CleanSpacesAndUpper(l.Years_in_Business_Code)='A'=>'UNDER 1 YEAR'
			                                                         ,ut.CleanSpacesAndUpper(l.Years_in_Business_Code)='B'=>'1 YEAR'
																															 ,ut.CleanSpacesAndUpper(l.Years_in_Business_Code)='C'=>'2 YEARS'
																															 ,ut.CleanSpacesAndUpper(l.Years_in_Business_Code)='D'=>'3 TO 5 YEARS'
																															 ,ut.CleanSpacesAndUpper(l.Years_in_Business_Code)='E'=>'6 TO 10 YEARS'
																															 ,ut.CleanSpacesAndUpper(l.Years_in_Business_Code)='F'=>'OVER 10 YEARS','');
			self.Year_Business_Started	 						          := trim(l.Year_Business_Started,left,right);
			self.Months_in_File	 										          := trim(l.Months_in_File,left,right);
			self.Address_Type_Code	 								          := ut.CleanSpacesAndUpper(l.Address_Type_Code	);
			self.Address_Type_Desc 														:= map( ut.CleanSpacesAndUpper(l.Address_Type_Code)='F'=>'FIRM DELIVERY POINT'
			                                                         ,ut.CleanSpacesAndUpper(l.Address_Type_Code)='G'=>'GENERAL DELIVERY'
																															 ,ut.CleanSpacesAndUpper(l.Address_Type_Code)='H'=>'HIGH RISE'
																															 ,ut.CleanSpacesAndUpper(l.Address_Type_Code)='M'=>'POSTMASTER'
																															 ,ut.CleanSpacesAndUpper(l.Address_Type_Code)='P'=>'POST OFFICE BOX'
																															 ,ut.CleanSpacesAndUpper(l.Address_Type_Code)='R'=>'RURAL ROUTE OR HWY'
																															 ,ut.CleanSpacesAndUpper(l.Address_Type_Code)='S'=>'STREET ADDRESS','');                           
			self.Estimated_Number_of_Employees	 					    := if((integer)l.Estimated_Number_of_Employees	<>0 ,(string)(integer)l.Estimated_Number_of_Employees,'0');
			self.Employee_Size_Code	 											    := ut.CleanSpacesAndUpper(l.Employee_Size_Code	);
			self.Employee_Size_Desc 													:= map( ut.CleanSpacesAndUpper(l.Employee_Size_Code)='A'=>'1 TO 4 EMPLOYEES'
			                                                         ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='B'=>'5 TO 9 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='C'=>'10 TO 19 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='D'=>'20 TO 49 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='E'=>'50 TO 99 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='F'=>'100 TO 249 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='G'=>'250 TO 499 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='H'=>'500 TO 999 EMPLOYEES'
																															 ,ut.CleanSpacesAndUpper(l.Employee_Size_Code)='I'=>'OVER 1000 EMPLOYEES', '');
			self.Estimated_Annual_Sales_Amount_Sign				    := trim(l.Estimated_Annual_Sales_Amount_Sign,left,right	);
			self.Estimated_Annual_Sales_Amount	 					    := if((integer)l.Estimated_Annual_Sales_Amount<> 0 , (string)((integer) l.Estimated_Annual_Sales_Amount * 1000) ,'0');
			self.Annual_Sales_Size_Code	 									    := ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code	);
			self.Annual_Sales_Size_Desc	 									    := map( ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='A'=>'$1  TO  $499 M'
			                                                         ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='B'=>'$500  TO  $999.9 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='C'=>'$1M  TO  $4.9 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='D'=>'$5M  TO  $9.9 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='E'=>'N/A'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='F'=>'$10M  TO  $24 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='G'=>'$25M  TO  $74.9 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='H'=>'$75M  TO  $199.9M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='I'=>'$200M  TO  $499.9 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='J'=>'$500M  TO  $999.9 M'
																															 ,ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code)='K'=>'$OVER 1 BILLION','');
			self.Location_Code	 													    := ut.CleanSpacesAndUpper(l.Location_Code	);
			self.Location_Desc	 													    := map( ut.CleanSpacesAndUpper(l.Location_Code)='B'=>'BRANCH'
			                                                         ,ut.CleanSpacesAndUpper(l.Location_Code)='H'=>'HEADQUARTERS'
																															 ,ut.CleanSpacesAndUpper(l.Location_Code)='S'=>'SINGLE LOCATION SUBSIDIARY'
																															 ,trim(l.Location_Code)=''=>'SINGLE ENTITY','');
			self.Primary_SIC_Code_Industry_Classification     := ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification	);
			self.Primary_SIC_Code_Industry_Class_Desc         :=map( ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='A'=>'AGRICULTURE/FORESTRY'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='B'=>'MINING'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='C'=>'CONSTRUCTION'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='D'=>'MANUFACTURING'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='E'=>'TRANSPORTATION/UTILITY'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='F'=>'WHOLESALE'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='G'=>'RETAIL'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='H'=>'FINANCIAL/INSURANCE/REAL ESTATE'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='I'=>'SERVICES'
																															,ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification)='J'=>'PUBLIC ADMINISTRATION','');
			self.Primary_SIC_Code_4_Digit	 							      := trim(l.Primary_SIC_Code_4_Digit,left,right);
			self.Primary_SIC_Code	 											      := trim(l.Primary_SIC_Code,left,right);
			self.Second_SIC_Code	 											      := trim(l.Second_SIC_Code,left,right);
			self.Third_SIC_Code	 											        := trim(l.Third_SIC_Code,left,right);
			self.Fourth_SIC_Code	 											      := trim(l.Fourth_SIC_Code,left,right);
			self.Fifth_SIC_Code	 											        := trim(l.Fifth_SIC_Code,left,right);
			self.Sixth_SIC_Code	 											        := trim(l.Sixth_SIC_Code,left,right);
			self.Primary_NAICS_Code	 											    := trim(l.Primary_NAICS_Code,left,right);
			self.Second_NAICS_Code	 											    := trim(l.Second_NAICS_Code,left,right);
			self.Third_NAICS_Code	 											      := trim(l.Third_NAICS_Code,left,right);
			self.Fourth_NAICS_Code	 											    := trim(l.Fourth_NAICS_Code,left,right);
			self.Executive_Count	 											      :=if((integer)l.Executive_Count<>0,(string)(integer)l.Executive_Count,'0'	);
			self.Executive_Last_Name	 											  := ut.CleanSpacesAndUpper(l.Executive_Last_Name	);
			self.Executive_First_Name	 											  := ut.CleanSpacesAndUpper(l.Executive_First_Name	);
			self.Executive_Middle_Initial	 								    := if( trim(l.Executive_Middle_Initial,left,right) not in ['#','&','?','(','-'] , ut.CleanSpacesAndUpper(l.Executive_Middle_Initial),'');
			self.Executive_Title	 											      := ut.CleanSpacesAndUpper(l.Executive_Title	);
			self.Business_Type	 											        := ut.CleanSpacesAndUpper(l.Business_Type	);
			self.Business_Type_Desc	 											    := map( ut.CleanSpacesAndUpper(l.Business_Type)='C'=>'CORPORATION'
			                                                         ,ut.CleanSpacesAndUpper(l.Business_Type)='P'=>'PARTNERSHIP'
																															 ,ut.CleanSpacesAndUpper(l.Business_Type)='S'=>'SOLE PROPRIETOR'
																															 ,ut.CleanSpacesAndUpper(l.Business_Type)='G'=>'GOVERNMENT','');
			self.Ownership_Code	 											        := if((integer)l.Ownership_Code<>0 ,(string) (integer)l.Ownership_Code,'0');
			self.Ownership_Code_Desc                          := if((integer)l.Ownership_Code= 0 ,'PRIVATE',if((integer)l.Ownership_Code= 1,'PUBLIC',''));
			self.URL	 																        := trim(l.URL,left,right);
			self.Derogatory_Indicator	 											  := ut.CleanSpacesAndUpper(l.Derogatory_Indicator	);
			self.Recent_Derogatory_Filed_Date	 				        := if(_validate.date.fIsValid(trim(l.Recent_Derogatory_Filed_Date,left,right)),trim(l.Recent_Derogatory_Filed_Date,left,right),'');
			self.Derogatory_Liability_Amount_Sign	 		        := trim(l.Derogatory_Liability_Amount_Sign,left,right	);
			self.Derogatory_Liability_Amount	 			          :=if((integer)l.Derogatory_Liability_Amount<> 0, (string)(integer)l.Derogatory_Liability_Amount,'0');
			self.UCC_Data_Indicator	 								          := ut.CleanSpacesAndUpper(l.UCC_Data_Indicator	);
			self.UCC_Data_Indicator_Desc											:=map( ut.CleanSpacesAndUpper(l.UCC_Data_Indicator)='D'=>'CAUTIONARY UCC PRESENT'
			                                                         ,ut.CleanSpacesAndUpper(l.UCC_Data_Indicator)='Y'=>'UCC PRESENT'
																															 ,ut.CleanSpacesAndUpper(l.UCC_Data_Indicator)='N'=>'NO UCC','');
			self.UCC_Count	 											          	:= if((integer)l.UCC_Count<>0, (string) (integer)l.UCC_Count,'0');
			self.Number_of_Legal_Items	 					          	:= if((integer)l.Number_of_Legal_Items<>0, (string) (integer)l.Number_of_Legal_Items,'0');
			self.Legal_Balance_Sign	 							          	:= trim(l.Legal_Balance_Sign,left,right);
			self.Legal_Balance_Amount	 						          	:= if((integer) l.Legal_Balance_Amount<> 0 , (string)(integer) l.Legal_Balance_Amount ,'0');
			self.PMTKBankruptcy	 											        := ut.CleanSpacesAndUpper(l.PMTKBankruptcy	);
			self.PMTKJudgment	 											          := ut.CleanSpacesAndUpper(l.PMTKJudgment	);
			self.PMTKTaxlien	 											          := ut.CleanSpacesAndUpper(l.PMTKTaxlien	);
			self.PMTKPayment	 											          := ut.CleanSpacesAndUpper(l.PMTKPayment	);
			self.Bankruptcy_filed	 											      := ut.CleanSpacesAndUpper(l.Bankruptcy_filed	);
			self.Number_of_Derogatory_Legal_Items	            := if((integer)l.Number_of_Derogatory_Legal_Items<>0, (string) (integer)l.Number_of_Derogatory_Legal_Items,'0'	);
			self.Lien_count	 									          			:= if((integer)l.Lien_count<>0, (string) (integer)l.Lien_count,'0');
			self.Judgment_count	 							          			:= if((integer)l.Judgment_count<>0, (string) (integer)l.Judgment_count,'0');
			self.BKC006	 											          			:= if((integer)l.BKC006<>0, (string) (integer)l.BKC006,'0');
			self.BKC007	 											          			:= if((integer)l.BKC007<>0, (string) (integer)l.BKC007,'0');
			self.BKC008	 											          			:= if((integer)l.BKC008<>0, (string) (integer)l.BKC008,'0');
		  self.BKO009	 											          			:= if((integer)l.BKO009<>0, (string) (integer)l.BKO009,'0');
			self.BKB001_Sign	 								          			:= trim(l.BKB001_Sign,left,right);
			self.BKB001	 											          			:= if((integer)l.BKB001<>0, (string) (integer)l.BKB001,'0');
			self.BKB003_Sign	 								         				:= trim(l.BKB003_Sign,left,right);
			self.BKB003	 											          			:= if((integer)l.BKB003<>0, (string) (integer)l.BKB003,'0');
			self.BKO010	 											          			:= if((integer)l.BKO010<>0, (string) (integer)l.BKO010,'0');
			self.BKO011	 											          			:= if((integer)l.BKO011<>0, (string) (integer)l.BKO011,'0');
			self.JDC010	 											         				:= if((integer)l.JDC010<>0, (string) (integer)l.JDC010,'0');
			self.JDC011	 											          			:= if((integer)l.JDC011<>0, (string) (integer)l.JDC011,'0');
			self.JDC012	 											          			:= if((integer)l.JDC012<>0, (string) (integer)l.JDC012,'0');
			self.JDB004	 											         				:= if((integer)l.JDB004<>0, (string) (integer)l.JDB004,'0');
			self.JDB005	 											          			:= if((integer)l.JDB005<>0, (string) (integer)l.JDB005,'0');
			self.JDB006	 											          			:= if((integer)l.JDB006<>0, (string) (integer)l.JDB006,'0');
			self.JDO013	 											          			:= if((integer)l.JDO013<>0, (string) (integer)l.JDO013,'0');
			self.JDO014	 											          			:= if((integer)l.JDO014<>0, (string) (integer)l.JDO014,'0');
			self.JDB002	 											          			:= if((integer)l.JDB002<>0, (string) (integer)l.JDB002,'0');
			self.JDP016	 											          			:= if((integer)l.JDP016<>0, (string) (integer)l.JDP016,'0');
			self.LGC004	 											          			:= if((integer)l.LGC004<>0, (string) (integer)l.LGC004,'0');
			self.PRO001	 											         				:= if((integer)l.PRO001<>0, (string) (integer)l.PRO001,'0');
			self.PRO003	 											          			:= if((integer)l.PRO003<>0, (string) (integer)l.PRO003,'0');
			self.TXC010	 											          			:= if((integer)l.TXC010<>0, (string) (integer)l.TXC010,'0');
			self.TXC011	 											          			:= if((integer)l.TXC011<>0, (string) (integer)l.TXC011,'0');
			self.TXB004_Sign	 								         			  := trim(l.TXB004_Sign,left,right	);
			self.TXB004	 											          			:= if((integer)l.TXB004<>0, (string) (integer)l.TXB004,'0');;
			self.TXO013	 											          			:= if((integer)l.TXO013<>0, (string) (integer)l.TXO013,'0');;
			self.TXB002_Sign	 								          			:= trim(l.TXB002_Sign,left,right	);
			self.TXB002	 											          			:= if((integer)l.TXB002<>0, (string) (integer)l.TXB002,'0');
			self.TXP016	 											          			:= if((integer)l.TXP016<>0, (string) (integer)l.TXP016,'0');
			self.UCC001	 											          			:= if((integer)l.UCC001<>0, (string) (integer)l.UCC001,'0');
			self.UCC002	 											          			:= if((integer)l.UCC002<>0, (string) (integer)l.UCC002,'0');
			self.UCC003	 											          			:= if((integer)l.UCC003<>0, (string) (integer)l.UCC003,'0');
			self.Intelliscore_Plus	 					          			:= if( (DECIMAL5_2)l.Intelliscore_Plus<> 0,(string) (DECIMAL5_2)l.Intelliscore_Plus,'0');
			self.Percentile_model	 						          			:=trim(l.Percentile_model,left,right);
			self.Model_action 	 							          			:= ut.CleanSpacesAndUpper(l.Model_action );
			self.Score_Factor_1	 								          		:=trim(l.Score_Factor_1,left,right);
			self.Score_Factor_2	 									          	:=trim(l.Score_Factor_2,left,right);
			self.Score_Factor_3	 									          	:=trim(l.Score_Factor_3,left,right);
			self.Score_Factor_4	 									          	:=trim(l.Score_Factor_4,left,right);
			self.Model_Code	 												          :=if((integer)l.Model_Code<>0,(string)(integer)l.Model_Code,'0'	);
			self.Model_type	 												          :=trim(l.Model_type,left,right);
			self.Last_Experian_Inquiry_Date	 			          	:=if(_validate.date.fIsValid(trim(l.Last_Experian_Inquiry_Date,left,right)),trim(l.Last_Experian_Inquiry_Date,left,right),'');
			self.Recent_High_Credit_Sign	 				          	:=trim(l.Recent_High_Credit_Sign,left,right);
			self.Recent_High_Credit	 							          	:= if((integer)l.Recent_High_Credit<>0,(string)(integer)l.Recent_High_Credit,'0');
			self.Median_Credit_Amount_Sign				          	:=trim(l.Median_Credit_Amount_Sign,left,right);
			self.Median_Credit_Amount	 						          	:= if((integer)l.Median_Credit_Amount<> 0,(string)(integer)l.Median_Credit_Amount,'0');
			self.Total_Combined_Trade_Lines_Count	           	:= if((integer)l.Total_Combined_Trade_Lines_Count<>0,(string)(integer)l.Total_Combined_Trade_Lines_Count,'0');
			self.DBT_of_Combined_Trade_Totals	 	          		:= map((integer)l.DBT_of_Combined_Trade_Totals = 999 =>'0'       //populating these values based on venodor's document
																															 ,(integer)l.DBT_of_Combined_Trade_Totals = 105 =>'95'
																															 ,(string)(integer)l.DBT_of_Combined_Trade_Totals);
			self.Combined_Trade_Balance	 				          		:= if((string) (integer)l.Combined_Trade_Balance<> '0',(string) (integer)l.Combined_Trade_Balance,'0');
			self.Aged_Trade_Lines	 								          	:= if((integer)l.Aged_Trade_Lines<>0,(string)(integer)l.Aged_Trade_Lines,'0');
			self.Experian_Credit_Rating	 					          	:=trim(l.Experian_Credit_Rating,left,right);
			self.Experian_Credit_Rating_Desc	 					      :=map( trim(l.Experian_Credit_Rating,left,right)='0'=>'NOT EVALUATED'
																															,trim(l.Experian_Credit_Rating,left,right)='1'=>'GOOD CREDIT RISK (0 - 15 DBT)'
																															,trim(l.Experian_Credit_Rating,left,right)='2'=>'REASONABLE CREDIT RISK (16 - 30 DBT)'
																															,trim(l.Experian_Credit_Rating,left,right)='3'=>'POTENTIAL CREDIT RISK (31 - 45 DBT)'
																															,trim(l.Experian_Credit_Rating,left,right)='4'=>'PROBABLE CREDIT RISK (46 - 60 DBT)'
																															,trim(l.Experian_Credit_Rating,left,right)='5'=>'SIGNIFICANT CREDIT RISK (61 -75 DBT)'
																															,trim(l.Experian_Credit_Rating,left,right)='6'=>'SIGNIFICANT CREDIT RISK (76 - 90 DBT)'
																															,trim(l.Experian_Credit_Rating,left,right)='7'=>'SERIOUS CREDIT RISK (91 - 105 DBT AND/OR DEROGATORY LEGAL INDICATOR SET TO Y, OR C)','');
			self.Quarter_1_Average_DBT	 					          	:= if((integer)l.Quarter_1_Average_DBT<>0,(string)(integer)l.Quarter_1_Average_DBT,'0');
			self.Quarter_2_Average_DBT	 					          	:= if((integer)l.Quarter_2_Average_DBT<>0,(string)(integer)l.Quarter_2_Average_DBT,'0');
			self.Quarter_3_Average_DBT	 					          	:= if((integer)l.Quarter_3_Average_DBT<>0,(string)(integer)l.Quarter_3_Average_DBT,'0');
			self.Quarter_4_Average_DBT	 					          	:= if((integer)l.Quarter_4_Average_DBT<>0,(string)(integer)l.Quarter_4_Average_DBT,'0');
			self.Quarter_5_Average_DBT	 					          	:= if((integer)l.Quarter_5_Average_DBT<>0,(string)(integer)l.Quarter_5_Average_DBT,'0');
			self.Combined_DBT	 										          	:= if((integer)l.Combined_DBT<>0,(string)(integer)l.Combined_DBT,'0');
			self.Total_Account_Balance_Sign	 		            	:=trim(l.Total_Account_Balance_Sign,left,right);
			self.Total_Account_Balance	 					          	:= if((string) (integer)l.Total_Account_Balance<> '0',(string) (integer)l.Total_Account_Balance,'0');
			self.Combined_Account_Balance_Sign	 	          	:=trim(l.Combined_Account_Balance_Sign,left,right);
			self.Combined_Account_Balance	 				          	:= if((string) (integer)l.Combined_Account_Balance<> '0',(string) (integer)l.Combined_Account_Balance,'0');
			self.Collection_count	 								          	:= if((integer)l.Collection_count<>0, (string) (integer)l.Collection_count,'0');
			self.ATC021	 											          			:= if((integer)l.ATC021<>0,(string)(integer)l.ATC021,'0');
			self.ATC022	 											          			:= if((integer)l.ATC022<>0,(string)(integer)l.ATC022,'0');
			self.ATC023	 											          			:= if((integer)l.ATC023<>0,(string)(integer)l.ATC023,'0');
			self.ATC024	 											          			:= if((integer)l.ATC024<>0,(string)(integer)l.ATC024,'0');
			self.ATC025	 											          			:= if((integer)l.ATC025<>0,(string)(integer)l.ATC025,'0');
			self.Last_Activity_Age_Code	 											:= ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code	);
			self.Last_Activity_Age_Desc												:=map( ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='A'=>'0 TO 3 MONTHS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='B'=>'3 TO 6 MONTHS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='C'=>'6 TO 9 MONTHS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='D'=>'9 TO 12 MONTHS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='E'=>'12 TO 18 MONTHS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='F'=>'18 TO 24 MONTHS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='G'=>'3 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='H'=>'4 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='I'=>'5 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='J'=>'6 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='K'=>'7 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='L'=>'8 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='M'=>'9 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='N'=>'10 YEARS'
																															,ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code)='O'=>'11 YEARS','');
			self.Cottage_Indicator	 											    := ut.CleanSpacesAndUpper(l.Cottage_Indicator	);
			self.Cottage_Indicator_Desc                       := if (ut.CleanSpacesAndUpper(l.Cottage_Indicator)='Y','RESIDENTIAL/SOHO BUSINESS','');		//Small Office Home Office (SOHO)
			self.NonProfit_Indicator	 											  := ut.CleanSpacesAndUpper(l.NonProfit_Indicator	);
			self.NonProfit_Indicator_Desc                     :=map(ut.CleanSpacesAndUpper(l.NonProfit_Indicator)='N'=>'NON-PROFIT'
																															,ut.CleanSpacesAndUpper(l.NonProfit_Indicator)='P'=>'PROFIT'
																															,ut.CleanSpacesAndUpper(l.NonProfit_Indicator)='U'=>'UNDETERMINED','');
			self.Financial_Stability_Risk_Score	 	          	:=if((DECIMAL5_2)l.Financial_Stability_Risk_Score<> 0,(string) (DECIMAL5_2)l.Financial_Stability_Risk_Score,'0');
			self.FSR_Risk_Class	 										          :=trim(l.FSR_Risk_Class,left,right);
			self.FSR_Score_Factor_1	 							          	:=trim(l.FSR_Score_Factor_1,left,right);
			self.FSR_Score_Factor_2	 							         		:=trim(l.FSR_Score_Factor_2,left,right);
			self.FSR_Score_Factor_3	 								          :=trim(l.FSR_Score_Factor_3,left,right);
			self.FSR_Score_Factor_4	 								          :=trim(l.FSR_Score_Factor_4,left,right);
			self.IP_Score_change_sign	 							          :=trim(l.IP_Score_change_sign,left,right);
			self.IP_Score_change	 							          		:=if((integer)l.IP_Score_change<>0,(string)(integer)l.IP_Score_change,'0');
			self.FSR_Score_change_sign	 				          		:=trim(l.FSR_Score_change_sign,left,right	);
			self.FSR_Score_change	 							         			:=if((integer)l.FSR_Score_change<>0,(string)(integer)l.FSR_Score_change,'0');
			self.DBA_Name	 											          		:=ut.CleanSpacesAndUpper(l.DBA_Name);
			self.Clean_DBA_Name	 											        :=if(stringlib.StringCleanSpaces(stringlib.StringFilter(ut.CleanSpacesAndUpper(l.dba_name),'01234567890ABCEDFGHIJKLMNOPQRSTUVWXYZ-.,#$@&*;"?/() ')) <>'',ut.CleanSpacesAndUpper(l.dba_name),'');// cleaning the non-viewable characters 
			self 																						  := l;
			self 																							:= [];
			
		end;
		
		dPreProcess 	:= project(pRawFileInput, trans_PreProcessor(left));
		
		//Add Global_SID
		addGlobalSID	:= MDR.macGetGlobalSid(dPreProcess, 'ExperianCRDB', '', 'global_sid'); //DF-25404
		
	  return addGlobalSID;

end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
		export fAll( dataset(Layouts.Input.Sprayed	)	pRawFileInput 
								,string														pversion
								,string														pPersistname = persistnames().StandardizeInput
								) := function
		
						ds_Preprocess					:= fPreProcess(pRawFileInput,pversion	) ;

						#if(_flags.UseStandardizePersists)
							dAppendBusinessInfo	:= ds_Preprocess :  persist(pPersistname);
						#else
							dAppendBusinessInfo	:= ds_Preprocess;
						#end
			
			return dAppendBusinessInfo;
		
		end;


end;