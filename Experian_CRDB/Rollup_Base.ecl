import ut;

export Rollup_Base( dataset(Layouts.Base) pDataset) := function

	Layouts.Base  trans_RecID(Layouts.Base l ):=transform
	
	DATA temp_record_id := HASHMD5(ut.CleanSpacesAndUpper(l.Experian_Bus_Id) + ','  +
																 ut.CleanSpacesAndUpper(l.Business_Name) + ','  + 
																 ut.CleanSpacesAndUpper(l.Address) + ','  + 
																 ut.CleanSpacesAndUpper(l.City) + ','  + 
																 ut.CleanSpacesAndUpper(l.State) + ','  +
																 ut.CleanSpacesAndUpper(l.ZIP_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.ZIP_Plus_4) + ','  +
																 ut.CleanSpacesAndUpper(l.Carrier_Route) + ','  +
																 ut.CleanSpacesAndUpper(l.County_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.County_Name) + ','  + 
																 ut.CleanSpacesAndUpper(l.Phone_Number) + ','  + 
																 ut.CleanSpacesAndUpper(l.MSA_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.MSA_Description) + ',' +
																 ut.CleanSpacesAndUpper(l.GEO_Code_Latitude) + ','  +
																 ut.CleanSpacesAndUpper(l.GEO_Code_Latitude_Direction) + ','  +
																 ut.CleanSpacesAndUpper(l.GEO_Code_Longitude) + ',' +
																 ut.CleanSpacesAndUpper(l.GEO_Code_Longitude_Direction) + ','  +
																 ut.CleanSpacesAndUpper(l.Recent_Update_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Year_Business_Started) + ','  +
																 ut.CleanSpacesAndUpper(l.Address_Type_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Estimated_Number_of_Employees) + ','  +
																 ut.CleanSpacesAndUpper(l.Employee_Size_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Estimated_Annual_Sales_Amount_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Estimated_Annual_Sales_Amount) + ','  +
																 ut.CleanSpacesAndUpper(l.Annual_Sales_Size_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Location_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Primary_SIC_Code_Industry_Classification) + ','  +
																 ut.CleanSpacesAndUpper(l.Primary_SIC_Code_4_Digit) + ','  +
																 ut.CleanSpacesAndUpper(l.Primary_SIC_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Second_SIC_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Third_SIC_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Fourth_SIC_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Fifth_SIC_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Sixth_SIC_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Primary_NAICS_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Second_NAICS_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Third_NAICS_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Fourth_NAICS_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Executive_Count) + ','  +
																 ut.CleanSpacesAndUpper(l.Executive_Last_Name) + ','  + 
																 ut.CleanSpacesAndUpper(l.Executive_First_Name) + ','  + 
																 ut.CleanSpacesAndUpper(l.Executive_Middle_Initial) + ','  +
																 ut.CleanSpacesAndUpper(l.Executive_Title) + ','  + 
																 ut.CleanSpacesAndUpper(l.Business_Type) + ','  +
																 ut.CleanSpacesAndUpper(l.Ownership_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.URL) + ','  + 
																 ut.CleanSpacesAndUpper(l.Derogatory_Indicator) + ','  +
																 ut.CleanSpacesAndUpper(l.Recent_Derogatory_Filed_Date) + ','  +
																 ut.CleanSpacesAndUpper(l.Derogatory_Liability_Amount_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Derogatory_Liability_Amount) + ','  +
																 ut.CleanSpacesAndUpper(l.UCC_Data_Indicator) + ','  +
																 ut.CleanSpacesAndUpper(l.UCC_Count) + ','  +
																 ut.CleanSpacesAndUpper(l.Number_of_Legal_Items) + ','  +
																 ut.CleanSpacesAndUpper(l.Legal_Balance_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Legal_Balance_Amount) + ','  + 
																 ut.CleanSpacesAndUpper(l.PMTKBankruptcy) + ','  +
																 ut.CleanSpacesAndUpper(l.PMTKJudgment) + ','  +
																 ut.CleanSpacesAndUpper(l.PMTKTaxlien) + ','  +
																 ut.CleanSpacesAndUpper(l.PMTKPayment) + ','  +
																 ut.CleanSpacesAndUpper(l.Bankruptcy_filed) + ','  +
																 ut.CleanSpacesAndUpper(l.Number_of_Derogatory_Legal_Items) + ','  +
																 ut.CleanSpacesAndUpper(l.Lien_count) + ','  +
																 ut.CleanSpacesAndUpper(l.Judgment_count) + ','  +
																 ut.CleanSpacesAndUpper(l.BKC006) + ','  +
																 ut.CleanSpacesAndUpper(l.BKC007) + ','  +
																 ut.CleanSpacesAndUpper(l.BKC008) + ','  +
																 ut.CleanSpacesAndUpper(l.BKO009) + ','  +
																 ut.CleanSpacesAndUpper(l.BKB001_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.BKB001) + ','  + 
																 ut.CleanSpacesAndUpper(l.BKB003_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.BKB003) + ','  +
																 ut.CleanSpacesAndUpper(l.BKO010) + ','  +
																 ut.CleanSpacesAndUpper(l.BKO011) + ','  +
																 ut.CleanSpacesAndUpper(l.JDC010) + ','  +
																 ut.CleanSpacesAndUpper(l.JDC011) + ','  +
																 ut.CleanSpacesAndUpper(l.JDC012) + ','  +
																 ut.CleanSpacesAndUpper(l.JDB004) + ','  + 
																 ut.CleanSpacesAndUpper(l.JDB005) + ','  + 
																 ut.CleanSpacesAndUpper(l.JDB006) + ','  +
																 ut.CleanSpacesAndUpper(l.JDO013) + ','  +
																 ut.CleanSpacesAndUpper(l.JDO014) + ','  +
																 ut.CleanSpacesAndUpper(l.JDB002) + ','  + 
																 ut.CleanSpacesAndUpper(l.JDP016) + ','  +
																 ut.CleanSpacesAndUpper(l.LGC004) + ','  +
																 ut.CleanSpacesAndUpper(l.PRO001) + ','  +
																 ut.CleanSpacesAndUpper(l.PRO003) + ','  +
																 ut.CleanSpacesAndUpper(l.TXC010) + ','  +
																 ut.CleanSpacesAndUpper(l.TXC011) + ','  +
																 ut.CleanSpacesAndUpper(l.TXB004_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.TXB004) + ','  + 
																 ut.CleanSpacesAndUpper(l.TXO013) + ','  +
																 ut.CleanSpacesAndUpper(l.TXB002_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.TXB002) + ','  + 
																 ut.CleanSpacesAndUpper(l.TXP016) + ','  +
																 ut.CleanSpacesAndUpper(l.Model_action ) + ',' +
																 ut.CleanSpacesAndUpper(l.Score_Factor_1) + ','  +
																 ut.CleanSpacesAndUpper(l.Score_Factor_2) + ','  +
																 ut.CleanSpacesAndUpper(l.Score_Factor_3) + ','  +
																 ut.CleanSpacesAndUpper(l.Score_Factor_4) + ','  +
																 ut.CleanSpacesAndUpper(l.Model_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Model_type) + ','  +
																 ut.CleanSpacesAndUpper(l.Last_Experian_Inquiry_Date) + ','  +
																 ut.CleanSpacesAndUpper(l.Recent_High_Credit_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Recent_High_Credit) + ','  +
																 ut.CleanSpacesAndUpper(l.Median_Credit_Amount_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Median_Credit_Amount) + ','  +
																 ut.CleanSpacesAndUpper(l.Total_Combined_Trade_Lines_Count) + ','  +
																 ut.CleanSpacesAndUpper(l.DBT_of_Combined_Trade_Totals) + ','  +
																 ut.CleanSpacesAndUpper(l.Combined_Trade_Balance) + ','  +
																 ut.CleanSpacesAndUpper(l.Aged_Trade_Lines) + ','  +
																 ut.CleanSpacesAndUpper(l.Experian_Credit_Rating) + ','  +
																 ut.CleanSpacesAndUpper(l.Quarter_1_Average_DBT) + ','  +
																 ut.CleanSpacesAndUpper(l.Quarter_2_Average_DBT) + ','  +
																 ut.CleanSpacesAndUpper(l.Quarter_3_Average_DBT) + ','  +
																 ut.CleanSpacesAndUpper(l.Quarter_4_Average_DBT) + ','  +
																 ut.CleanSpacesAndUpper(l.Quarter_5_Average_DBT) + ','  +
																 ut.CleanSpacesAndUpper(l.Combined_DBT) + ','  +
																 ut.CleanSpacesAndUpper(l.Total_Account_Balance_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Total_Account_Balance) + ','  + 
																 ut.CleanSpacesAndUpper(l.Combined_Account_Balance_Sign) + ','  +
																 ut.CleanSpacesAndUpper(l.Combined_Account_Balance) + ','  + 
																 ut.CleanSpacesAndUpper(l.Collection_count) + ','  +
																 ut.CleanSpacesAndUpper(l.ATC021) + ','  +
																 ut.CleanSpacesAndUpper(l.ATC022) + ','  +
																 ut.CleanSpacesAndUpper(l.ATC023) + ','  +
																 ut.CleanSpacesAndUpper(l.ATC024) + ','  +
																 ut.CleanSpacesAndUpper(l.ATC025) + ','  +
																 ut.CleanSpacesAndUpper(l.Last_Activity_Age_Code) + ','  +
																 ut.CleanSpacesAndUpper(l.Cottage_Indicator) + ','  +
																 ut.CleanSpacesAndUpper(l.NonProfit_Indicator) + ','  +
																 ut.CleanSpacesAndUpper(l.Financial_Stability_Risk_Score) + ','  +
																 ut.CleanSpacesAndUpper(l.FSR_Risk_Class) + ','  +
																 ut.CleanSpacesAndUpper(l.FSR_Score_Factor_1) + ','  +
																 ut.CleanSpacesAndUpper(l.FSR_Score_Factor_2) + ','  +
																 ut.CleanSpacesAndUpper(l.FSR_Score_Factor_3) + ','  +
																 ut.CleanSpacesAndUpper(l.FSR_Score_Factor_4) + ','  + 
																 ut.CleanSpacesAndUpper(l.DBA_Name)
																);																	
		self.Source_rec_id := hash64(temp_record_id); 
		self							 := l;
	end;
	
  DS_RecID      := project(pDataset ,trans_RecID(left));
	
	pDataset_sort := sort(distribute(DS_RecID, hash64(Experian_Bus_Id)),
											  experian_bus_id, source_rec_id, local
											  );
	
	Experian_CRDB.Layouts.Base RollupUpdate(Experian_CRDB.Layouts.Base l, Experian_CRDB.Layouts.Base r) := transform
		SELF.dt_first_seen 						:= ut.EarliestDate(l.dt_first_seen , r.dt_first_seen);
	  SELF.dt_last_seen							:= Max(l.dt_last_seen	, r.dt_last_seen);
		SELF.Establish_Date 					:= (string) ut.EarliestDate((unsigned4)l.Establish_Date , (unsigned4)r.Establish_Date);
	  SELF.Latest_Reported_Date			:= (string) Max((unsigned4)l.Latest_Reported_Date	,(unsigned4) r.Latest_Reported_Date);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	, r.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported 	:= Max(l.dt_vendor_last_reported	, r.dt_vendor_last_reported	);
		self 													:= l;
	end;

	pDataset_rollup := rollup( pdataset_sort,
														 rollupupdate(left, right),
														 experian_bus_id, source_rec_id, local
													  );

	
	return pDataset_rollup;

end;