IMPORT  ut, _Validate, std, mdr;

EXPORT Standardize_Input := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess(DATASET(Database_USA.Layouts.Sprayed_Input) pRawInput, STRING pversion) := FUNCTION
		
		Database_USA.Layouts.Base tPreProcess(Database_USA.Layouts.Sprayed_Input L) := TRANSFORM
		
		 	self.process_date                 := 	STD.Date.CurrentDate(TRUE);
			UpdateDate												:=	Stringlib.StringFilterOut(l.Last_Update_Verification_DT, '-');
			self.dt_first_seen								:= 	if(_validate.date.fIsValid(UpdateDate) and _validate.date.fIsValid(UpdateDate,_validate.date.rules.DateInPast), (UNSIGNED4)UpdateDate, 0);
			self.dt_last_seen									:= 	if(_validate.date.fIsValid(UpdateDate) and _validate.date.fIsValid(UpdateDate,_validate.date.rules.DateInPast), (UNSIGNED4)UpdateDate, 0);
			self.dt_vendor_first_reported			:= 	if(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			self.dt_vendor_last_reported			:= 	if(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			self.record_type            			:= 	'C';
			self.source 											:= 	MDR.sourceTools.src_Database_USA;

			//Populate the raw input fields
			self.DBUSA_Business_ID						:=	trim(l.DBUSA_Business_ID);
			self.DBUSA_Executive_ID						:=	trim(l.DBUSA_Executive_ID);
			self.SubHQ_Parent_ID							:=	trim(l.SubHQ_Parent_ID);
			self.HQ_ID												:=	trim(l.HQ_ID);
			self.Ind_Frm_Indicator						:= 	ut.CleanSpacesAndUpper(l.Ind_Frm_Indicator);
			self.Company_Name									:= 	ut.CleanSpacesAndUpper(l.Company_Name);
			self.Full_Name										:= 	ut.CleanSpacesAndUpper(l.Full_Name);
			self.Prefix												:= 	ut.CleanSpacesAndUpper(l.Prefix);
			self.First_Name	  								:= 	ut.CleanSpacesAndUpper(l.First_Name);
			self.Middle_Initial								:= 	ut.CleanSpacesAndUpper(l.Middle_Initial);
			self.Last_name										:= 	ut.CleanSpacesAndUpper(l.Last_name);
			self.Suffix		      				  		:= 	ut.CleanSpacesAndUpper(l.Suffix);
			self.Gender												:= 	ut.CleanSpacesAndUpper(l.Gender);
			self.Standardized_Title						:=	ut.CleanSpacesAndUpper(l.Standardized_Title);
			self.SourceTitle									:=	ut.CleanSpacesAndUpper(l.SourceTitle);
			self.Executive_Title_Rank					:=	ut.CleanSpacesAndUpper(l.Executive_Title_Rank);
			self.Primary_Exec_Flag						:=	ut.CleanSpacesAndUpper(l.Primary_Exec_Flag);
			self.Exec_Type										:=	ut.CleanSpacesAndUpper(l.Exec_Type);
			self.Executive_Department					:=	ut.CleanSpacesAndUpper(l.Executive_Department);
			self.Executive_Level							:=	ut.CleanSpacesAndUpper(l.Executive_Level);
			self.Phy_Addr_Standardized				:=	ut.CleanSpacesAndUpper(l.Phy_Addr_Standardized);
			self.Phy_Addr_City								:=	ut.CleanSpacesAndUpper(l.Phy_Addr_City);
			self.Phy_Addr_State								:=	ut.CleanSpacesAndUpper(l.Phy_Addr_State);
			self.Phy_Addr_Zip									:=	ut.CleanSpacesAndUpper(l.Phy_Addr_Zip);
			self.Phy_Addr_Zip4								:=	ut.CleanSpacesAndUpper(l.Phy_Addr_Zip4);
			self.Phy_Addr_CarrierRoute				:=	ut.CleanSpacesAndUpper(l.Phy_Addr_CarrierRoute);
			self.Phy_Addr_DeliveryPt					:=	ut.CleanSpacesAndUpper(l.Phy_Addr_DeliveryPt);
			self.Phy_Addr_DeliveryPtChkDig		:=	ut.CleanSpacesAndUpper(l.Phy_Addr_DeliveryPtChkDig);
			self.Mail_Addr_Standardized				:=	ut.CleanSpacesAndUpper(l.Mail_Addr_Standardized);
			self.Mail_Addr_City								:=	ut.CleanSpacesAndUpper(l.Mail_Addr_City);
			self.Mail_Addr_State							:=	ut.CleanSpacesAndUpper(l.Mail_Addr_State);
			self.Mail_Addr_Zip								:=	ut.CleanSpacesAndUpper(l.Mail_Addr_Zip);
			self.Mail_Addr_Zip4								:=	ut.CleanSpacesAndUpper(l.Mail_Addr_Zip4);
			self.Mail_Addr_CarrierRoute				:=	ut.CleanSpacesAndUpper(l.Mail_Addr_CarrierRoute);
			self.Mail_Addr_DeliveryPt					:=	ut.CleanSpacesAndUpper(l.Mail_Addr_DeliveryPt);
			self.Mail_Addr_DeliveryPtChkDig		:=	ut.CleanSpacesAndUpper(l.Mail_Addr_DeliveryPtChkDig);
			self.Mail_Score										:=	ut.CleanSpacesAndUpper(l.Mail_Score);
			self.Mail_Score_Desc							:=	ut.CleanSpacesAndUpper(l.Mail_Score_Desc);
			self.Phone												:= 	ut.CleanSpacesAndUpper(l.Phone);
			self.Area_Code										:= 	ut.CleanSpacesAndUpper(l.Area_Code);
			self.Fax													:= 	ut.CleanSpacesAndUpper(l.Fax);
			self.Email												:= 	ut.CleanSpacesAndUpper(l.Email);
			self.Email_Available_Indicator		:= 	ut.CleanSpacesAndUpper(l.Email_Available_Indicator);
			self.URL													:= 	ut.CleanSpacesAndUpper(l.URL);	
			self.URL_facebook									:= 	ut.CleanSpacesAndUpper(l.URL_facebook);
			self.URL_googlePlus								:= 	ut.CleanSpacesAndUpper(l.URL_googlePlus);
			self.URL_instagram								:= 	ut.CleanSpacesAndUpper(l.URL_instagram);
			self.URL_linkedIN									:= 	ut.CleanSpacesAndUpper(l.URL_linkedIN);
			self.URL_twitter									:= 	ut.CleanSpacesAndUpper(l.URL_twitter);
			self.URL_youtube									:= 	ut.CleanSpacesAndUpper(l.URL_youtube);
			self.Business_Status_Code					:= 	ut.CleanSpacesAndUpper(l.Business_Status_Code);
			self.Business_Status_Desc					:= 	ut.CleanSpacesAndUpper(l.Business_Status_Desc);
			self.Franchise_Flag								:= 	ut.CleanSpacesAndUpper(l.Franchise_Flag);
			self.Franchise_Type								:= 	ut.CleanSpacesAndUpper(l.Franchise_Type);
			self.Franchise_Desc								:= 	ut.CleanSpacesAndUpper(l.Franchise_Desc);
			self.Ticker_Symbol								:= 	ut.CleanSpacesAndUpper(l.Ticker_Symbol);
			self.Stock_Exchange								:= 	ut.CleanSpacesAndUpper(l.Stock_Exchange);
			self.Fortune_1000_Flag						:= 	ut.CleanSpacesAndUpper(l.Fortune_1000_Flag);
			self.Fortune_1000_Rank						:= 	ut.CleanSpacesAndUpper(l.Fortune_1000_Rank);
			self.Fortune_1000_branches				:= 	ut.CleanSpacesAndUpper(l.Fortune_1000_branches);
			self.Num_Linked_Locations					:= 	ut.CleanSpacesAndUpper(l.Num_Linked_Locations); 	
			self.County_Code									:= 	ut.CleanSpacesAndUpper(l.County_Code);
			self.County_Desc									:= 	ut.CleanSpacesAndUpper(l.County_Desc);
			self.CBSA_Code										:= 	ut.CleanSpacesAndUpper(l.CBSA_Code);
			self.CBSA_Desc										:= 	ut.CleanSpacesAndUpper(l.CBSA_Desc);
			self.Geo_Match_Level							:= 	ut.CleanSpacesAndUpper(l.Geo_Match_Level);
			self.Latitude											:= 	ut.CleanSpacesAndUpper(l.Latitude);
			self.Longitude										:= 	ut.CleanSpacesAndUpper(l.Longitude);
			self.SCF													:= 	ut.CleanSpacesAndUpper(l.SCF);
			self.TimeZone											:= 	ut.CleanSpacesAndUpper(l.TimeZone);
			self.CensusTract									:= 	ut.CleanSpacesAndUpper(l.CensusTract);
			self.CensusBlock									:= 	ut.CleanSpacesAndUpper(l.CensusBlock);
			self.City_Population_Code					:= 	ut.CleanSpacesAndUpper(l.City_Population_Code);
			self.City_Population_Descr				:= 	ut.CleanSpacesAndUpper(l.City_Population_Descr);
			self.Primary_SIC									:= 	ut.CleanSpacesAndUpper(l.Primary_SIC);
			self.Primary_SIC_Desc							:= 	ut.CleanSpacesAndUpper(l.Primary_SIC_Desc);
			self.SIC02												:= 	ut.CleanSpacesAndUpper(l.SIC02);
			self.SIC02_Desc										:= 	ut.CleanSpacesAndUpper(l.SIC02_Desc);
			self.SIC03												:= 	ut.CleanSpacesAndUpper(l.SIC03);
			self.SIC03_Desc										:= 	ut.CleanSpacesAndUpper(l.SIC03_Desc);
			self.SIC04												:= 	ut.CleanSpacesAndUpper(l.SIC04);
			self.SIC04_Desc										:= 	ut.CleanSpacesAndUpper(l.SIC04_Desc);
			self.SIC05												:= 	ut.CleanSpacesAndUpper(l.SIC05);
			self.SIC05_Desc										:= 	ut.CleanSpacesAndUpper(l.SIC05_Desc);
			self.SIC06												:= 	ut.CleanSpacesAndUpper(l.SIC06);
			self.SIC06_Desc										:= 	ut.CleanSpacesAndUpper(l.SIC06_Desc);
			self.PrimarySIC2									:= 	ut.CleanSpacesAndUpper(l.PrimarySIC2);
			self.Primary_2_Digit_SIC_Desc			:= 	ut.CleanSpacesAndUpper(l.Primary_2_Digit_SIC_Desc);
			self.PrimarySIC4									:= 	ut.CleanSpacesAndUpper(l.PrimarySIC4);
			self.Primary_4_Digit_SIC_Desc			:= 	ut.CleanSpacesAndUpper(l.Primary_4_Digit_SIC_Desc);
			self.NAICS01                      := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS01) = 1,ut.CleanSpacesAndUpper(l.NAICS01),'');
			self.NAICS02                      := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS02) = 1,ut.CleanSpacesAndUpper(l.NAICS02),'');
			self.NAICS03                      := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS03) = 1,ut.CleanSpacesAndUpper(l.NAICS03),'');
			self.NAICS04                      := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS04) = 1,ut.CleanSpacesAndUpper(l.NAICS04),'');
			self.NAICS05                      := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS05) = 1,ut.CleanSpacesAndUpper(l.NAICS05),'');
			self.NAICS06                      := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS06) = 1,ut.CleanSpacesAndUpper(l.NAICS06),'');
			self.NAICS01_Desc									:= 	ut.CleanSpacesAndUpper(l.NAICS01_Desc);
			self.NAICS02_Desc									:= 	ut.CleanSpacesAndUpper(l.NAICS02_Desc);
			self.NAICS03_Desc									:= 	ut.CleanSpacesAndUpper(l.NAICS03_Desc);
			self.NAICS04_Desc									:= 	ut.CleanSpacesAndUpper(l.NAICS04_Desc);
			self.NAICS05_Desc									:= 	ut.CleanSpacesAndUpper(l.NAICS05_Desc);
			self.NAICS06_Desc									:= 	ut.CleanSpacesAndUpper(l.NAICS06_Desc);
			self.Location_Employees_Total			:= 	ut.CleanSpacesAndUpper(l.Location_Employees_Total);
			self.Location_Employee_Code				:= 	ut.CleanSpacesAndUpper(l.Location_Employee_Code);
			self.Location_Employee_Desc				:= 	ut.CleanSpacesAndUpper(l.Location_Employee_Desc);
			self.Location_Sales_Total					:= 	ut.CleanSpacesAndUpper(l.Location_Sales_Total);
			self.Location_Sales_Code					:= 	ut.CleanSpacesAndUpper(l.Location_Sales_Code);
			self.Location_Sales_Desc					:= 	ut.CleanSpacesAndUpper(l.Location_Sales_Desc);
			self.Corporate_Employee_Total			:= 	ut.CleanSpacesAndUpper(l.Corporate_Employee_Total);
			self.Corporate_Employee_Code			:= 	ut.CleanSpacesAndUpper(l.Corporate_Employee_Code);
			self.Corporate_Employee_Desc			:= 	ut.CleanSpacesAndUpper(l.Corporate_Employee_Desc);
			self.Year_Established							:= 	ut.CleanSpacesAndUpper(l.Year_Established);
			self.Years_In_Business_Range			:= 	ut.CleanSpacesAndUpper(l.Years_In_Business_Range);
			self.Female_Owned									:= 	ut.CleanSpacesAndUpper(l.Female_Owned);
			self.Minority_Owned_Flag					:= 	ut.CleanSpacesAndUpper(l.Minority_Owned_Flag);
			self.Minority_Type								:= 	ut.CleanSpacesAndUpper(l.Minority_Type);
			self.Home_Based_Indicator					:= 	ut.CleanSpacesAndUpper(l.Home_Based_Indicator);
			self.Small_Business_Indicator			:= 	ut.CleanSpacesAndUpper(l.Small_Business_Indicator);
			self.Import_Export								:= 	ut.CleanSpacesAndUpper(l.Import_Export);
			self.Manufacturing_Location				:= 	ut.CleanSpacesAndUpper(l.Manufacturing_Location);
			self.Public_Indicator							:= 	ut.CleanSpacesAndUpper(l.Public_Indicator);
			self.EIN													:= 	ut.CleanSpacesAndUpper(l.EIN);
			self.Non_Profit_Org								:= 	ut.CleanSpacesAndUpper(l.Non_Profit_Org);
			self.Square_Footage								:= 	ut.CleanSpacesAndUpper(l.Square_Footage);
			self.Square_Footage_Code					:= 	ut.CleanSpacesAndUpper(l.Square_Footage_Code);
			self.Square_Footage_Desc					:= 	ut.CleanSpacesAndUpper(l.Square_Footage_Desc);
			self.CreditScore									:= 	ut.CleanSpacesAndUpper(l.CreditScore);
			self.CreditCode										:= 	ut.CleanSpacesAndUpper(l.CreditCode);
			self.Credit_Desc									:= 	ut.CleanSpacesAndUpper(l.Credit_Desc);
			self.Credit_Capacity							:= 	ut.CleanSpacesAndUpper(l.Credit_Capacity);
			self.Credit_Capacity_Code					:= 	ut.CleanSpacesAndUpper(l.Credit_Capacity_Code);
			self.Credit_Capacity_Desc					:= 	ut.CleanSpacesAndUpper(l.Credit_Capacity_Desc);
			self.Advertising_Expenses_Code		:= 	ut.CleanSpacesAndUpper(l.Advertising_Expenses_Code);
			self.Expense_Advertising_Desc			:= 	ut.CleanSpacesAndUpper(l.Expense_Advertising_Desc);
			self.Technology_Expenses_Code			:= 	ut.CleanSpacesAndUpper(l.Technology_Expenses_Code);
			self.Expense_Technology_Desc			:= 	ut.CleanSpacesAndUpper(l.Expense_Technology_Desc);
			self.Office_Equip_Expenses_Code		:= 	ut.CleanSpacesAndUpper(l.Office_Equip_Expenses_Code);
			self.Expense_Office_Equip_Desc		:= 	ut.CleanSpacesAndUpper(l.Expense_Office_Equip_Desc);
			self.Rent_Expenses_Code						:= 	ut.CleanSpacesAndUpper(l.Rent_Expenses_Code);
			self.Expense_Rent_Desc						:= 	ut.CleanSpacesAndUpper(l.Expense_Rent_Desc);
			self.Telecom_Expenses_Code				:= 	ut.CleanSpacesAndUpper(l.Telecom_Expenses_Code);
			self.Expense_Telecom_Desc					:= 	ut.CleanSpacesAndUpper(l.Expense_Telecom_Desc);
			self.Accounting_Expenses_Code			:= 	ut.CleanSpacesAndUpper(l.Accounting_Expenses_Code);
			self.Expense_Accounting_Desc			:= 	ut.CleanSpacesAndUpper(l.Expense_Accounting_Desc);
			self.Bus_Insurance_Expense_Code		:= 	ut.CleanSpacesAndUpper(l.Bus_Insurance_Expense_Code);
			self.Expense_Bus_Insurance_Desc		:= 	ut.CleanSpacesAndUpper(l.Expense_Bus_Insurance_Desc);
			self.Legal_Expenses_Code					:= 	ut.CleanSpacesAndUpper(l.Legal_Expenses_Code);
			self.Expense_Legal_Desc						:= 	ut.CleanSpacesAndUpper(l.Expense_Legal_Desc);
			self.Utilities_Expenses_Code			:= 	ut.CleanSpacesAndUpper(l.Utilities_Expenses_Code);
			self.Expense_Utilities_Desc				:= 	ut.CleanSpacesAndUpper(l.Expense_Utilities_Desc);
			self.Number_Of_PCs_Code						:= 	ut.CleanSpacesAndUpper(l.Number_Of_PCs_Code);
			self.Number_Of_PCs_Desc						:= 	ut.CleanSpacesAndUpper(l.Number_Of_PCs_Desc);
			self.NB_Flag											:= 	ut.CleanSpacesAndUpper(l.NB_Flag);
			self.HQ_Company_Name							:= 	ut.CleanSpacesAndUpper(l.HQ_Company_Name);
			self.HQ_City											:= 	ut.CleanSpacesAndUpper(l.HQ_City);
			self.HQ_State											:= 	ut.CleanSpacesAndUpper(l.HQ_State);
			self.SubHQ_Parent_Name						:= 	ut.CleanSpacesAndUpper(l.SubHQ_Parent_Name);
			self.SubHQ_Parent_City						:= 	ut.CleanSpacesAndUpper(l.SubHQ_Parent_City);
			self.SubHQ_Parent_State						:= 	ut.CleanSpacesAndUpper(l.SubHQ_Parent_State);
			self.Domestic_Foreign_Owner_Flag	:= 	ut.CleanSpacesAndUpper(l.Domestic_Foreign_Owner_Flag);
			self.Foreign_Parent_Company_Name	:= 	ut.CleanSpacesAndUpper(l.Foreign_Parent_Company_Name);
			self.Foreign_Parent_City					:= 	ut.CleanSpacesAndUpper(l.Foreign_Parent_City);
			self.Foreign_Parent_Country				:= 	ut.CleanSpacesAndUpper(l.Foreign_Parent_Country);
			self.Last_Update_Verification_DT	:= 	ut.CleanSpacesAndUpper(l.Last_Update_Verification_DT);
			self.DB_Cons_Matchkey							:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Matchkey);
			self.DatabaseUSA_Individual_ID		:= 	ut.CleanSpacesAndUpper(l.DatabaseUSA_Individual_ID);
			self.DB_Cons_Full_Name						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Full_Name);
			self.DB_Cons_Full_Name_Prefix			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Full_Name_Prefix);
			self.DB_Cons_First_Name						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_First_Name);
			self.DB_Cons_Middle_Initial				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Middle_Initial);
			self.DB_Cons_Last_Name						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Last_Name);
			self.DB_Cons_Email								:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Email);
			self.DB_Cons_Gender								:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Gender);
			self.DB_Cons_Date_Of_Birth_Year		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Date_Of_Birth_Year);
			self.DB_Cons_Date_Of_Birth_Month	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Date_Of_Birth_Month);
			self.DB_Cons_age									:= 	ut.CleanSpacesAndUpper(l.DB_Cons_age);
			self.DB_Cons_Age_Code_Desc				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Age_Code_Desc);
			self.DB_Cons_Age_In_Two_Year_HH		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Age_In_Two_Year_HH);
			self.DB_Cons_Ethnic_Code					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Ethnic_Code);
			self.DB_Cons_Religious_Affil			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Religious_Affil);
			self.DB_Cons_Language_Pref				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Language_Pref);
			self.DB_Cons_Phy_Addr_Std					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_Std);
			self.DB_Cons_Phy_Addr_City				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_City);
			self.DB_Cons_Phy_Addr_State				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_State);
			self.DB_Cons_Phy_Addr_Zip					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_Zip);
			self.DB_Cons_Phy_Addr_zip4				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_zip4);
			self.DB_Cons_Phy_Addr_CarrierRoute:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_CarrierRoute);
			self.DB_Cons_Phy_Addr_DeliveryPt	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_DeliveryPt);
			self.DB_Cons_Line_Of_Travel				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Line_Of_Travel);
			self.DB_Cons_GeoCode_Results			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_GeoCode_Results);
			self.DB_Cons_Latitude							:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Latitude);
			self.DB_Cons_Longitude						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Longitude);
			self.DB_Cons_Time_Zone_Code				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Time_Zone_Code);
			self.DB_Cons_Time_Zone_Desc				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Time_Zone_Desc);
			self.DB_Cons_Census_Tract					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Census_Tract);
			self.DB_Cons_Census_Block					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Census_Block);
			self.DB_Cons_CountyFIPs						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_CountyFIPs);
			self.DB_CountyName								:= 	ut.CleanSpacesAndUpper(l.DB_CountyName);
			self.DB_Cons_CBSA_Code						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_CBSA_Code);
			self.DB_Cons_CBSA_Desc						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_CBSA_Desc);
			self.DB_Cons_Walk_Sequence				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Walk_Sequence);
			self.DB_Cons_Phone								:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Phone);
			self.DB_Cons_DNC									:= 	ut.CleanSpacesAndUpper(l.DB_Cons_DNC);
			self.DB_Cons_Scrubbed_Phoneable		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Scrubbed_Phoneable);
			self.DB_Cons_Children_Present			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Children_Present);
			self.DB_Cons_Home_Value_Code			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_Value_Code);
			self.DB_Cons_Home_Value_Desc			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_Value_Desc);
			self.DB_Cons_Donor_Capacity				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Donor_Capacity);
			self.DB_Cons_Donor_Capacity_Code	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Donor_Capacity_Code);
			self.DB_Cons_Donor_Capacity_Desc	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Donor_Capacity_Desc);
			self.DB_Cons_Home_Owner_Renter		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_Owner_Renter);
			self.DB_Cons_Length_Of_Res				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Length_Of_Res);
			self.DB_Cons_Length_of_Res_Code		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Length_of_Res_Code);
			self.DB_Cons_Length_of_Res_Desc		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Length_of_Res_Desc);
			self.DB_Cons_Dwelling_Type				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Dwelling_Type);
			self.DB_Cons_Recent_Home_Buyer		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Recent_Home_Buyer);
			self.DB_Cons_Income_Code					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Income_Code);
			self.DB_Cons_Income_Desc					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Income_Desc);
			self.DB_Cons_UnsecuredCredCap			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_UnsecuredCredCap);
			self.DB_Cons_UnsecuredCredCapCode	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_UnsecuredCredCapCode);
			self.DB_Cons_UnsecuredCredCapDesc	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_UnsecuredCredCapDesc);
			self.DB_Cons_NetWorthHomeVal			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_NetWorthHomeVal);
			self.DB_Cons_NetWorthHomeValCode	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_NetWorthHomeValCode);
			self.DB_Cons_Net_Worth_Desc				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Net_Worth_Desc);
			self.DB_Cons_DiscretIncome				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_DiscretIncome);
			self.DB_Cons_DiscretIncomeCode		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_DiscretIncomeCode);
			self.DB_Cons_DiscretIncomeDesc		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_DiscretIncomeDesc);
			self.DB_Cons_Marital_Status				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Marital_Status);
			self.DB_Cons_New_Parent						:= 	ut.CleanSpacesAndUpper(l.DB_Cons_New_Parent);
			self.DB_Cons_Child_Near_HS_Grad		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Child_Near_HS_Grad);
			self.DB_Cons_College_Graduate			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_College_Graduate);
			self.DB_Cons_Intend_Purchase_Veh	:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Intend_Purchase_Veh);
			self.DB_Cons_Recent_Divorce				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Recent_Divorce);
			self.DB_Cons_Newlywed							:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Newlywed);
			self.DB_Cons_New_Teen_Driver			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_New_Teen_Driver);
			self.DB_Cons_Home_Year_Built			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_Year_Built);
			self.DB_Cons_Home_SqFt_Ranges			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_SqFt_Ranges);
			self.DB_Cons_Poli_Party_Ind				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Poli_Party_Ind);
			self.DB_Cons_Home_SqFt_Actual			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_SqFt_Actual);
			self.DB_Cons_Occupation_Ind				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Occupation_Ind);
			self.DB_Cons_Credit_Card_User			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Credit_Card_User);
			self.DB_Cons_Home_Property_Type		:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Home_Property_Type);
			self.DB_Cons_Education_HH					:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Education_HH);
			self.DB_Cons_Education_Ind				:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Education_Ind);
			self.DB_Cons_Other_Pet_Owner			:= 	ut.CleanSpacesAndUpper(l.DB_Cons_Other_Pet_Owner);
			self.SourceData										:= 	ut.CleanSpacesAndUpper(l.SourceData);
			self.ProductionDate								:= 	ut.CleanSpacesAndUpper(l.ProductionDate);

			//************ EXPLODED VALUES
			self.BusinessTypeDesc							:= Database_USA.Functions.fGetBusTypeDesc(l.Ind_Frm_Indicator);
			self.GenderDesc 			            := Database_USA.Functions.fGetGenderDesc(l.Gender);
			self.ExecutiveTypeDesc            := Database_USA.Functions.fExecutiveTypeDesc(l.Exec_Type);
			self.DBConsGenderDesc	            := Database_USA.Functions.fGetGenderDesc(l.DB_Cons_Gender);
			self.DBConsEthnicDesc             := Database_USA.Functions.fDBConsEthnicDesc(l.DB_Cons_Ethnic_Code);
			self.DBConsReligiousDesc					:= Database_USA.Functions.fDBConsReligiousDesc(l.DB_Cons_Religious_Affil);              
			self.DBConsLangPrefDesc						:= Database_USA.Functions.fDBConsLangPrefDesc(l.DB_Cons_Language_Pref);
			self.DBConsOwnerRenter						:= Database_USA.Functions.fDBConsOwnerRenter(l.DB_Cons_Home_Owner_Renter);
			self.DBConsDwellingTypeDesc				:= Database_USA.Functions.fDBConsDwellingTypeDesc(l.DB_Cons_Dwelling_Type);
			self.DBConsMaritalDesc						:= Database_USA.Functions.fDBConsMaritalDesc(l.DB_Cons_Marital_Status);
			self.DBConsNewParentDesc					:= Database_USA.Functions.fDBConsNewParentDesc(l.DB_Cons_New_Parent);
			self.DBConsTeenDriverDesc					:= Database_USA.Functions.fDBConsTeenDriverDesc(l.DB_Cons_New_Teen_Driver);
			self.DBConsPoliPartyDesc					:= Database_USA.Functions.fDBConsPoliPartyDesc(l.DB_Cons_Poli_Party_Ind);
			self.DBConsOccupationDesc					:= Database_USA.Functions.fDBConsOccupationDesc(l.DB_Cons_Occupation_Ind);
			self.DBConsPropertyTypeDesc				:= Database_USA.Functions.fDBConsPropertyTypeDesc(l.DB_Cons_Home_Property_Type);
			self.DBConsHeadHouseEducDesc			:= Database_USA.Functions.fDBConsEducationDesc(l.DB_Cons_Education_HH);
			self.DBConsEducationDesc					:= Database_USA.Functions.fDBConsEducationDesc(l.DB_Cons_Education_Ind);
			self.phy_prep_address_line1				:= ut.CleanSpacesAndUpper(l.Phy_Addr_Standardized);
			self.phy_prep_address_line_last		:= ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.Phy_Addr_City) + 
																																	IF(L.Phy_Addr_City <> '' and L.Phy_Addr_State <> '', ', ', '') + 
																																	L.Phy_Addr_State + ' ' + IF(LENGTH(L.Phy_Addr_Zip) = 5, L.Phy_Addr_Zip, '')
																																	);		
			self.mail_prep_address_line1			:= ut.CleanSpacesAndUpper(l.Mail_Addr_Standardized);
			self.mail_prep_address_line_last	:= ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.Mail_Addr_City) + 
																																	IF(L.Mail_Addr_City <> '' and L.Mail_Addr_State <> '', ', ', '') + 
																																	L.Mail_Addr_State + ' ' + IF(LENGTH(L.Mail_Addr_Zip) = 5, L.Mail_Addr_Zip, '')
																																	);	
			self.DB_cons_prep_address_line1		:= ut.CleanSpacesAndUpper(l.DB_Cons_Phy_Addr_Std);
			self.DB_cons_prep_address_line_last	:= ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.DB_Cons_Phy_Addr_City) + 
																																	IF(L.DB_Cons_Phy_Addr_City <> '' and L.DB_Cons_Phy_Addr_State <> '', ', ', '') + 
																																	L.DB_Cons_Phy_Addr_State + ' ' + IF(LENGTH(L.DB_Cons_Phy_Addr_Zip) = 5, L.DB_Cons_Phy_Addr_Zip, '')
																																	);			
			self 															:= L;
			self 															:= [];
		END;
		
		dPreProcess := PROJECT(pRawInput,tPreProcess(LEFT));

    dPreProcess_dedup  := DEDUP( SORT( DISTRIBUTE(dPreProcess, HASH(DBUSA_Business_ID) ), RECORD, LOCAL ), RECORD, LOCAL );		
	
		RETURN dPreProcess_dedup;

	END;  //End fPreProcess
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Database_USA.Layouts.Sprayed_Input) pRawInput
							,STRING  pversion
							) := FUNCTION
	
		dPreprocess	:= fPreProcess(pRawInput,pversion	) : PERSIST(Database_USA.Persist_Names().StandardizeInput);

		RETURN dPreprocess;
	
	END;

END;