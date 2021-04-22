IMPORT Database_USA, data_services;

baseFile := DATASET('~thor_data400::base::database_usa::20200811::data',Database_USA.Layouts.Base,THOR);
patchedBaseFile := DATASET('~thor_data400::base::database_usa::20200428::data::patched',Database_USA.Layouts.Base,THOR);

	pDataset_Dist := DISTRIBUTE(baseFile, HASH(dbusa_business_id+dbusa_executive_id));
	
	pDataset_sort := SORT( pDataset_Dist 
												,dbusa_business_id							,dbusa_executive_id						,subhq_parent_id				
												,hq_id													,ind_frm_indicator						,company_name					
												,full_name											,prefix,first_name						,middle_initial				
												,last_name											,suffix,gender								,standardized_title	
												,sourcetitle										,executive_title_rank					,primary_exec_flag			
												,exec_type											,executive_department					,executive_level			
												,phy_addr_standardized					,phy_addr_city								,phy_addr_state				
												,phy_addr_zip										,phy_addr_zip4								,phy_addr_carrierroute
												,phy_addr_deliverypt						,phy_addr_deliveryptchkdig		,mail_addr_standardized	
												,mail_addr_city									,mail_addr_state							,mail_addr_zip
												,mail_addr_zip4									,mail_addr_carrierroute				,mail_addr_deliverypt
												,mail_addr_deliveryptchkdig			,mail_score										,mail_score_desc
												,phone													,area_code										,fax,email
												,email_available_indicator			,url													,url_facebook
												,url_googleplus									,url_instagram								,url_linkedin
												,url_twitter										,url_youtube									,business_status_code
												,business_status_desc						,franchise_flag								,franchise_type
												,franchise_desc									,ticker_symbol								,stock_exchange
												,fortune_1000_flag							,fortune_1000_rank						,fortune_1000_branches
												,num_linked_locations						,county_code									,county_desc
												,cbsa_code											,cbsa_desc										,geo_match_level
												,latitude												,longitude										,scf
												,timezone												,censustract									,censusblock
												,city_population_code						,city_population_descr				,primary_sic
												,primary_sic_desc								,sic02												,sic02_desc
												,sic03													,sic03_desc										,sic04
												,sic04_desc											,sic05												,sic05_desc
												,sic06													,sic06_desc										,primarysic2
												,primary_2_digit_sic_desc				,primarysic4									,primary_4_digit_sic_desc
												,naics01												,naics01_desc									,naics02
												,naics02_desc										,naics03											,naics03_desc
												,naics04												,naics04_desc									,naics05
												,naics05_desc										,naics06											,naics06_desc
												,location_employees_total				,location_employee_code				,location_employee_desc
												,location_sales_total						,location_sales_code					,location_sales_desc
												,corporate_employee_total				,corporate_employee_code			,corporate_employee_desc
												,year_established								,years_in_business_range			,female_owned
												,minority_owned_flag						,minority_type								,home_based_indicator
												,small_business_indicator				,import_export								,manufacturing_location
												,public_indicator								,ein													,non_profit_org
												,square_footage									,square_footage_code					,square_footage_desc
												,creditscore										,creditcode										,credit_desc
												,credit_capacity								,credit_capacity_code					,credit_capacity_desc
												,advertising_expenses_code			,expense_advertising_desc			,technology_expenses_code
												,expense_technology_desc				,office_equip_expenses_code		,expense_office_equip_desc
												,rent_expenses_code							,expense_rent_desc						,telecom_expenses_code
												,expense_telecom_desc						,accounting_expenses_code			,expense_accounting_desc
												,bus_insurance_expense_code			,expense_bus_insurance_desc		,legal_expenses_code
												,expense_legal_desc							,utilities_expenses_code			,expense_utilities_desc
												,number_of_pcs_code							,number_of_pcs_desc						,nb_flag
												,hq_company_name								,hq_city											,hq_state
												,subhq_parent_name							,subhq_parent_city						,subhq_parent_state
												,domestic_foreign_owner_flag		,foreign_parent_company_name	,foreign_parent_city
												,foreign_parent_country					,db_cons_matchkey							,databaseusa_individual_id
												,db_cons_full_name							,db_cons_full_name_prefix			,db_cons_first_name	
												,db_cons_middle_initial					,db_cons_last_name						,db_cons_email
												,db_cons_gender									,db_cons_date_of_birth_year		,db_cons_date_of_birth_month
												,db_cons_age										,db_cons_age_code_desc				,db_cons_age_in_two_year_hh
												,db_cons_ethnic_code						,db_cons_religious_affil			,db_cons_language_pref
												,db_cons_phy_addr_std						,db_cons_phy_addr_city				,db_cons_phy_addr_state
												,db_cons_phy_addr_zip						,db_cons_phy_addr_zip4				,db_cons_phy_addr_carrierroute
												,db_cons_phy_addr_deliverypt		,db_cons_line_of_travel				,db_cons_geocode_results
												,db_cons_latitude								,db_cons_longitude						,db_cons_time_zone_code
												,db_cons_time_zone_desc					,db_cons_census_tract					,db_cons_census_block
												,db_cons_countyfips							,db_countyname								,db_cons_cbsa_code
												,db_cons_cbsa_desc							,db_cons_walk_sequence				,db_cons_phone
												,db_cons_dnc										,db_cons_scrubbed_phoneable		,db_cons_children_present
												,db_cons_home_value_code				,db_cons_home_value_desc			,db_cons_donor_capacity
												,db_cons_donor_capacity_code		,db_cons_donor_capacity_desc	,db_cons_home_owner_renter
												,db_cons_length_of_res					,db_cons_length_of_res_code		,db_cons_length_of_res_desc
												,db_cons_dwelling_type					,db_cons_recent_home_buyer		,db_cons_income_code
												,db_cons_income_desc						,db_cons_unsecuredcredcap			,db_cons_unsecuredcredcapcode
												,db_cons_unsecuredcredcapdesc		,db_cons_networthhomeval			,db_cons_networthhomevalcode
												,db_cons_net_worth_desc					,db_cons_discretincome				,db_cons_discretincomecode
												,db_cons_discretincomedesc			,db_cons_marital_status				,db_cons_new_parent
												,db_cons_child_near_hs_grad			,db_cons_college_graduate			,db_cons_intend_purchase_veh
												,db_cons_recent_divorce					,db_cons_newlywed							,db_cons_new_teen_driver
												,db_cons_home_year_built				,db_cons_home_sqft_ranges			,db_cons_poli_party_ind
												,db_cons_home_sqft_actual				,db_cons_occupation_ind				,db_cons_credit_card_user
												,db_cons_home_property_type			,db_cons_education_hh					,db_cons_education_ind
												,db_cons_other_pet_owner
												,LOCAL );
												
												
	pPatchedDataset_Dist := DISTRIBUTE(PatchedBaseFile, HASH(dbusa_business_id+dbusa_executive_id));
	
	pPatchedDataset_sort := SORT( pPatchedDataset_Dist 
												,dbusa_business_id							,dbusa_executive_id						,subhq_parent_id				
												,hq_id													,ind_frm_indicator						,company_name					
												,full_name											,prefix,first_name						,middle_initial				
												,last_name											,suffix,gender								,standardized_title	
												,sourcetitle										,executive_title_rank					,primary_exec_flag			
												,exec_type											,executive_department					,executive_level			
												,phy_addr_standardized					,phy_addr_city								,phy_addr_state				
												,phy_addr_zip										,phy_addr_zip4								,phy_addr_carrierroute
												,phy_addr_deliverypt						,phy_addr_deliveryptchkdig		,mail_addr_standardized	
												,mail_addr_city									,mail_addr_state							,mail_addr_zip
												,mail_addr_zip4									,mail_addr_carrierroute				,mail_addr_deliverypt
												,mail_addr_deliveryptchkdig			,mail_score										,mail_score_desc
												,phone													,area_code										,fax,email
												,email_available_indicator			,url													,url_facebook
												,url_googleplus									,url_instagram								,url_linkedin
												,url_twitter										,url_youtube									,business_status_code
												,business_status_desc						,franchise_flag								,franchise_type
												,franchise_desc									,ticker_symbol								,stock_exchange
												,fortune_1000_flag							,fortune_1000_rank						,fortune_1000_branches
												,num_linked_locations						,county_code									,county_desc
												,cbsa_code											,cbsa_desc										,geo_match_level
												,latitude												,longitude										,scf
												,timezone												,censustract									,censusblock
												,city_population_code						,city_population_descr				,primary_sic
												,primary_sic_desc								,sic02												,sic02_desc
												,sic03													,sic03_desc										,sic04
												,sic04_desc											,sic05												,sic05_desc
												,sic06													,sic06_desc										,primarysic2
												,primary_2_digit_sic_desc				,primarysic4									,primary_4_digit_sic_desc
												,naics01												,naics01_desc									,naics02
												,naics02_desc										,naics03											,naics03_desc
												,naics04												,naics04_desc									,naics05
												,naics05_desc										,naics06											,naics06_desc
												,location_employees_total				,location_employee_code				,location_employee_desc
												,location_sales_total						,location_sales_code					,location_sales_desc
												,corporate_employee_total				,corporate_employee_code			,corporate_employee_desc
												,year_established								,years_in_business_range			,female_owned
												,minority_owned_flag						,minority_type								,home_based_indicator
												,small_business_indicator				,import_export								,manufacturing_location
												,public_indicator								,ein													,non_profit_org
												,square_footage									,square_footage_code					,square_footage_desc
												,creditscore										,creditcode										,credit_desc
												,credit_capacity								,credit_capacity_code					,credit_capacity_desc
												,advertising_expenses_code			,expense_advertising_desc			,technology_expenses_code
												,expense_technology_desc				,office_equip_expenses_code		,expense_office_equip_desc
												,rent_expenses_code							,expense_rent_desc						,telecom_expenses_code
												,expense_telecom_desc						,accounting_expenses_code			,expense_accounting_desc
												,bus_insurance_expense_code			,expense_bus_insurance_desc		,legal_expenses_code
												,expense_legal_desc							,utilities_expenses_code			,expense_utilities_desc
												,number_of_pcs_code							,number_of_pcs_desc						,nb_flag
												,hq_company_name								,hq_city											,hq_state
												,subhq_parent_name							,subhq_parent_city						,subhq_parent_state
												,domestic_foreign_owner_flag		,foreign_parent_company_name	,foreign_parent_city
												,foreign_parent_country					,db_cons_matchkey							,databaseusa_individual_id
												,db_cons_full_name							,db_cons_full_name_prefix			,db_cons_first_name	
												,db_cons_middle_initial					,db_cons_last_name						,db_cons_email
												,db_cons_gender									,db_cons_date_of_birth_year		,db_cons_date_of_birth_month
												,db_cons_age										,db_cons_age_code_desc				,db_cons_age_in_two_year_hh
												,db_cons_ethnic_code						,db_cons_religious_affil			,db_cons_language_pref
												,db_cons_phy_addr_std						,db_cons_phy_addr_city				,db_cons_phy_addr_state
												,db_cons_phy_addr_zip						,db_cons_phy_addr_zip4				,db_cons_phy_addr_carrierroute
												,db_cons_phy_addr_deliverypt		,db_cons_line_of_travel				,db_cons_geocode_results
												,db_cons_latitude								,db_cons_longitude						,db_cons_time_zone_code
												,db_cons_time_zone_desc					,db_cons_census_tract					,db_cons_census_block
												,db_cons_countyfips							,db_countyname								,db_cons_cbsa_code
												,db_cons_cbsa_desc							,db_cons_walk_sequence				,db_cons_phone
												,db_cons_dnc										,db_cons_scrubbed_phoneable		,db_cons_children_present
												,db_cons_home_value_code				,db_cons_home_value_desc			,db_cons_donor_capacity
												,db_cons_donor_capacity_code		,db_cons_donor_capacity_desc	,db_cons_home_owner_renter
												,db_cons_length_of_res					,db_cons_length_of_res_code		,db_cons_length_of_res_desc
												,db_cons_dwelling_type					,db_cons_recent_home_buyer		,db_cons_income_code
												,db_cons_income_desc						,db_cons_unsecuredcredcap			,db_cons_unsecuredcredcapcode
												,db_cons_unsecuredcredcapdesc		,db_cons_networthhomeval			,db_cons_networthhomevalcode
												,db_cons_net_worth_desc					,db_cons_discretincome				,db_cons_discretincomecode
												,db_cons_discretincomedesc			,db_cons_marital_status				,db_cons_new_parent
												,db_cons_child_near_hs_grad			,db_cons_college_graduate			,db_cons_intend_purchase_veh
												,db_cons_recent_divorce					,db_cons_newlywed							,db_cons_new_teen_driver
												,db_cons_home_year_built				,db_cons_home_sqft_ranges			,db_cons_poli_party_ind
												,db_cons_home_sqft_actual				,db_cons_occupation_ind				,db_cons_credit_card_user
												,db_cons_home_property_type			,db_cons_education_hh					,db_cons_education_ind
												,db_cons_other_pet_owner
												,LOCAL );
												
RESprayed_Input := record
			string	DBUSA_Business_ID;
			string	DBUSA_Executive_ID;
			string	SubHQ_Parent_ID;
			string	HQ_ID;
			string	Ind_Frm_Indicator;
			string	Company_Name;
			string	Full_Name;
			string	Prefix;
			string	First_Name;
			string	Middle_Initial;
			string	Last_Name;
			string	Suffix;
			string	Gender;
			string	Standardized_Title;
			string	SourceTitle;
			string	Executive_Title_Rank;
			string	Primary_Exec_Flag;
			string	Exec_Type;
			string	Executive_Department;
			string	Executive_Level;
			string	Phy_Addr_Standardized;
			string	Phy_Addr_City;
			string	Phy_Addr_State;
			string	Phy_Addr_Zip;
			string	Phy_Addr_Zip4;
			string	Phy_Addr_CarrierRoute;
			string	Phy_Addr_DeliveryPt;
			string	Phy_Addr_DeliveryPtChkDig;
			string	Mail_Addr_Standardized;
			string	Mail_Addr_City;
			string	Mail_Addr_State;
			string	Mail_Addr_Zip;
			string	Mail_Addr_Zip4;
			string	Mail_Addr_CarrierRoute;
			string	Mail_Addr_DeliveryPt;
			string	Mail_Addr_DeliveryPtChkDig;
			string	Mail_Score;
			string	Mail_Score_Desc;
			string	Phone;
			string	Area_Code;
			string	Fax;
			string	Email;
			string	Email_Available_Indicator;
			string	URL;
			string	URL_facebook;
			string	URL_googlePlus;
			string	URL_instagram;
			string	URL_linkedIN;
			string	URL_twitter;
			string	URL_youtube;
			string	Business_Status_Code;
			string	Business_Status_Desc;
			string	Franchise_Flag;
			string	Franchise_Type;
			string	Franchise_Desc;
			string	Ticker_Symbol;
			string	Stock_Exchange;
			string	Fortune_1000_Flag;
			string	Fortune_1000_Rank;
			string	Fortune_1000_branches;
			string	Num_Linked_Locations;
			string	County_Code;
			string	County_Desc;
			string	CBSA_Code;
			string	CBSA_Desc;
			string	Geo_Match_Level;
			string	Latitude;
			string	Longitude;
			string	SCF;
			string	TimeZone;
			string	CensusTract;
			string	CensusBlock;
			string	City_Population_Code;
			string	City_Population_Descr;
			string	Primary_SIC;
			string	Primary_SIC_Desc;
			string	SIC02;
			string	SIC02_Desc;
			string	SIC03;
			string	SIC03_Desc;
			string	SIC04;
			string	SIC04_Desc;
			string	SIC05;
			string	SIC05_Desc;
			string	SIC06;
			string	SIC06_Desc;
			string	PrimarySIC2;
			string	Primary_2_Digit_SIC_Desc;
			string	PrimarySIC4;
			string	Primary_4_Digit_SIC_Desc;
			string	NAICS01;
			string	NAICS01_Desc;
			string	NAICS02;
			string	NAICS02_Desc;
			string	NAICS03;
			string	NAICS03_Desc;
			string	NAICS04;
			string	NAICS04_Desc;
			string	NAICS05;
			string	NAICS05_Desc;
			string	NAICS06;
			string	NAICS06_Desc;
			string	Location_Employees_Total;
			string	Location_Employee_Code;
			string	Location_Employee_Desc;
			string	Location_Sales_Total;
			string	Location_Sales_Code;
			string	Location_Sales_Desc;
			string	Corporate_Employee_Total;
			string	Corporate_Employee_Code;
			string	Corporate_Employee_Desc;
			string	Year_Established;
			string	Years_In_Business_Range;
			string	Female_Owned;
			string	Minority_Owned_Flag;
			string	Minority_Type;
			string	Home_Based_Indicator;
			string	Small_Business_Indicator;
			string	Import_Export;
			string	Manufacturing_Location;
			string	Public_Indicator;
			string	EIN;
			string	Non_Profit_Org;
			string	Square_Footage;
			string	Square_Footage_Code;
			string	Square_Footage_Desc;
			string	CreditScore;
			string	CreditCode;
			string	Credit_Desc;
			string	Credit_Capacity;
			string	Credit_Capacity_Code;
			string	Credit_Capacity_Desc;
			string	Advertising_Expenses_Code;
			string	Expense_Advertising_Desc;
			string	Technology_Expenses_Code;
			string	Expense_Technology_Desc;
			string	Office_Equip_Expenses_Code;
			string	Expense_Office_Equip_Desc;
			string	Rent_Expenses_Code;
			string	Expense_Rent_Desc;
			string	Telecom_Expenses_Code;
			string	Expense_Telecom_Desc;
			string	Accounting_Expenses_Code;
			string	Expense_Accounting_Desc;
			string	Bus_Insurance_Expense_Code;
			string	Expense_Bus_Insurance_Desc;
			string	Legal_Expenses_Code;
			string	Expense_Legal_Desc;
			string	Utilities_Expenses_Code;
			string	Expense_Utilities_Desc;
			string	Number_Of_PCs_Code;
			string	Number_Of_PCs_Desc;
			string	NB_Flag;
			string	HQ_Company_Name;
			string	HQ_City;
			string	HQ_State;
			string	SubHQ_Parent_Name;
			string	SubHQ_Parent_City;
			string	SubHQ_Parent_State;
			string	Domestic_Foreign_Owner_Flag;
			string	Foreign_Parent_Company_Name;
			string	Foreign_Parent_City;
			string	Foreign_Parent_Country;
			string	Last_Update_Verification_DT;
			string	DB_Cons_Matchkey;
			string	DatabaseUSA_Individual_ID;
			string	DB_Cons_Full_Name;
			string	DB_Cons_Full_Name_Prefix;
			string	DB_Cons_First_Name;
			string	DB_Cons_Middle_Initial;
			string	DB_Cons_Last_Name;
			string	DB_Cons_Email;
			
			string	DB_Cons_Gender;
			
			string	DB_Cons_Date_Of_Birth_Year;
			string	DB_Cons_Date_Of_Birth_Month;
			string	DB_Cons_age;
			string	DB_Cons_Age_Code_Desc;
			string	DB_Cons_Age_In_Two_Year_HH;
			
			string	DB_Cons_Ethnic_Code;

			string	DB_Cons_Religious_Affil;
			
			string	DB_Cons_Language_Pref;

			string	DB_Cons_Phy_Addr_Std;
			string	DB_Cons_Phy_Addr_City;
			string	DB_Cons_Phy_Addr_State;
			string	DB_Cons_Phy_Addr_Zip;
			string	DB_Cons_Phy_Addr_zip4;
			string	DB_Cons_Phy_Addr_CarrierRoute;
			string	DB_Cons_Phy_Addr_DeliveryPt;
			string	DB_Cons_Line_Of_Travel;
			string	DB_Cons_GeoCode_Results;
			string	DB_Cons_Latitude;
			string	DB_Cons_Longitude;
			
			string	DB_Cons_Time_Zone_Code;
			
			string	DB_Cons_Time_Zone_Desc;
			string	DB_Cons_Census_Tract;
			string	DB_Cons_Census_Block;
			string	DB_Cons_CountyFIPs;
			string	DB_CountyName;
			string	DB_Cons_CBSA_Code;
			string	DB_Cons_CBSA_Desc;
			string	DB_Cons_Walk_Sequence;
			string	DB_Cons_Phone;
			string	DB_Cons_DNC;
			string	DB_Cons_Scrubbed_Phoneable;
			
			string	DB_Cons_Children_Present;

			string	DB_Cons_Home_Value_Code;
			string	DB_Cons_Home_Value_Desc;
			
			string	DB_Cons_Donor_Capacity;
			string	DB_Cons_Donor_Capacity_Code;
			string	DB_Cons_Donor_Capacity_Desc;
			
			string	DB_Cons_Home_Owner_Renter;
			
			string	DB_Cons_Length_Of_Res;
			string	DB_Cons_Length_of_Res_Code;
			string	DB_Cons_Length_of_Res_Desc;
			
			string	DB_Cons_Dwelling_Type;
			string	DB_Cons_Recent_Home_Buyer;
			
			string	DB_Cons_Income_Code;
			string	DB_Cons_Income_Desc;
			
			string	DB_Cons_UnsecuredCredCap;
			string	DB_Cons_UnsecuredCredCapCode;
			string	DB_Cons_UnsecuredCredCapDesc;
			
			string	DB_Cons_NetWorthHomeVal;
			string	DB_Cons_NetWorthHomeValCode;
			string	DB_Cons_Net_Worth_Desc;
			
			string	DB_Cons_DiscretIncome;
			string	DB_Cons_DiscretIncomeCode;
			string	DB_Cons_DiscretIncomeDesc;
			
			string	DB_Cons_Marital_Status;
			string	DB_Cons_New_Parent;
			string	DB_Cons_Child_Near_HS_Grad;
			string	DB_Cons_College_Graduate;
			string	DB_Cons_Intend_Purchase_Veh;
			string	DB_Cons_Recent_Divorce;
			string	DB_Cons_Newlywed;
			
			string	DB_Cons_New_Teen_Driver;
			
			string	DB_Cons_Home_Year_Built;
			string	DB_Cons_Home_SqFt_Ranges;
			string	DB_Cons_Poli_Party_Ind;
			string	DB_Cons_Home_SqFt_Actual;
			string	DB_Cons_Occupation_Ind;
			string	DB_Cons_Credit_Card_User;
			string	DB_Cons_Home_Property_Type;
			
			string	DB_Cons_Education_HH;
			string	DB_Cons_Education_Ind;
			
			string	DB_Cons_Other_Pet_Owner;
			string	SourceData;
			string	ProductionDate;
			
			string dbconsgenderdesc;
			string dbconsethnicdesc;
			string dbconslangprefdesc;
	end;

RESprayed_Input xrfBackToSpray(Database_USA.Layouts.Base L) := TRANSFORM
 SELF := L;
 SELF := [];
END;

SprayedBackBase := PROJECT(pDataset_sort,xrfBackToSpray(LEFT));
SprayedBackPatchedFile := PROJECT(pPatchedDataset_sort,xrfBackToSpray(LEFT));

diffREC := RECORD
  string 		dbusa_business_id;
  string 		dbusa_executive_id;	
	varstring diff1;
END;

diffREC xrfDiff(SprayedBackBase L, SprayedBackPatchedFile R) := TRANSFORM
  self.dbusa_business_id := l.dbusa_business_id;
	self.dbusa_executive_id := l.dbusa_executive_id;
	self.diff1 := ROWDIFF(L, R);
END;

diffFile := JOIN(SprayedBackBase, SprayedBackPatchedFile, 
            LEFT.dbusa_business_id = RIGHT.dbusa_business_id
						AND LEFT.dbusa_executive_id = RIGHT.dbusa_executive_id
						, 
						xrfDiff(LEFT,RIGHT));
						
OUTPUT(diffFile(diff1 != ''),,named('diffFile'));						
OUTPUT(count(diffFile(diff1 != '')),named('countDiffFile'));						
						
						
OUTPUT(pDataset_sort(dbusa_business_id = '11132541471061' and dbusa_executive_id = '103519852'),,named('filteredBaseFile'));		
					
OUTPUT(pPatchedDataset_sort(dbusa_business_id = '11132541471061' and dbusa_executive_id = '103519852'),,named('filteredPatchedBaseFile'));										