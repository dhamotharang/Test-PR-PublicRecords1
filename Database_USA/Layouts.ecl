﻿import BIPV2, Address;

EXPORT Layouts := module

 	export Sprayed_Input := record
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
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=	record
	  string6			source									:= '';
		unsigned4		global_sid; //this is a unique source ID that will be coming from Orbit.
		unsigned8		record_sid; //this is a source specific unique and persistent record id (from SALT).  
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6		did											:=  0;
	  unsigned1		did_score								:=  0;
  	unsigned4		dt_first_seen;
		unsigned4		dt_last_seen;
		unsigned4		dt_vendor_first_reported;
		unsigned4		dt_vendor_last_reported;
    unsigned4		process_date;																											
 		string1			record_type							:= '';
		Sprayed_Input;
		string20		BusinessTypeDesc;
		string10		GenderDesc;
		string30		ExecutiveTypeDesc;
		string10		DBConsGenderDesc;	
		string100		DBConsEthnicDesc;		
		string20		DBConsReligiousDesc;		
		string20		DBConsLangPrefDesc;		
		string15		DBConsOwnerRenter;		
		string40		DBConsDwellingTypeDesc;		
		string20		DBConsMaritalDesc;	
		string35		DBConsNewParentDesc;		
		string40		DBConsTeenDriverDesc;		
		string30		DBConsPoliPartyDesc;		
		string40		DBConsOccupationDesc;		
		string30		DBConsPropertyTypeDesc;		
		string30		DBConsHeadHouseEducDesc;		
		string30		DBConsEducationDesc;			
		Address.Layout_Clean_Name; 
		string10		phy_prim_range; 
		string2			phy_predir;
		string28		phy_prim_name;
		string4     phy_addr_suffix;
		string2			phy_postdir;	
		string10		phy_unit_desig;
		string8			phy_sec_range;
		string25		phy_p_city_name;
		string25		phy_v_city_name;
		string2			phy_st;
		string5			phy_zip;
		string4			phy_zip4;
		string4			phy_cart;
		string1			phy_cr_sort_sz;
		string4			phy_lot;
		string1			phy_lot_order;
		string2			phy_dbpc;
		string1			phy_chk_digit;
		string2			phy_rec_type;
		string2			phy_fips_state;
		string3			phy_fips_county;
		string10		phy_geo_lat;
		string11		phy_geo_long;
		string4			phy_msa;
		string7			phy_geo_blk;
		string1			phy_geo_match;
		string4			phy_err_stat;
		unsigned8		phy_raw_aid	:=  0;
		unsigned8		phy_ace_aid	:=  0;
		string100		phy_prep_address_line1			:= '';
		string50		phy_prep_address_line_last	:= '';
		string10		mail_prim_range; 
		string2			mail_predir;
		string28		mail_prim_name;
		string4     mail_addr_suffix;
		string2			mail_postdir;	
		string10		mail_unit_desig;
		string8			mail_sec_range;
		string25		mail_p_city_name;
		string25		mail_v_city_name;
		string2			mail_st;
		string5			mail_zip;
		string4			mail_zip4;
		string4			mail_cart;
		string1			mail_cr_sort_sz;
		string4			mail_lot;
		string1			mail_lot_order;
		string2			mail_dbpc;
		string1			mail_chk_digit;
		string2			mail_rec_type;
		string2			mail_fips_state;
		string3			mail_fips_county;
		string10		mail_geo_lat;
		string11		mail_geo_long;
		string4			mail_msa;
		string7			mail_geo_blk;
		string1			mail_geo_match;
		string4			mail_err_stat;
		unsigned8		mail_raw_aid	:=  0;
		unsigned8		mail_ace_aid	:=  0;
		string100		mail_prep_address_line1			:= '';
		string50		mail_prep_address_line_last	:= '';		
		string10		DB_cons_prim_range; 
		string2			DB_cons_predir;
		string28		DB_cons_prim_name;
		string4     DB_cons_addr_suffix;
		string2			DB_cons_postdir;	
		string10		DB_cons_unit_desig;
		string8			DB_cons_sec_range;
		string25		DB_cons_p_city_name;
		string25		DB_cons_v_city_name;
		string2			DB_cons_st;
		string5			DB_cons_zip;
		string4			DB_cons_zip4;
		string4			DB_cons_cart;
		string1			DB_cons_cr_sort_sz;
		string4			DB_cons_lot;
		string1			DB_cons_lot_order;
		string2			DB_cons_dbpc;
		string1			DB_cons_chk_digit;
		string2			DB_cons_rec_type;
		string2			DB_cons_fips_state;
		string3			DB_cons_fips_county;
		string10		DB_cons_geo_lat;
		string11		DB_cons_geo_long;
		string4			DB_cons_msa;
		string7			DB_cons_geo_blk;
		string1			DB_cons_geo_match;
		string4			DB_cons_err_stat;
		unsigned8		DB_cons_raw_aid	:=  0;
		unsigned8		DB_cons_ace_aid	:=  0;
		string100		DB_cons_prep_address_line1			:= '';
		string50		DB_cons_prep_address_line_last	:= '';		
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layout
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=record	
	  Base;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temp := module
	
		export StandardizeInput := record
			unsigned8		unique_id	;
			Base ;
		end;
		
		export DidSlim := record
			unsigned8		unique_id   := 0;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string5  		name_suffix;
			string10  	prim_range;
			string28		prim_name;
			string8			sec_range;
			string5			zip5;
			string2			state;
			string10		phone;
			unsigned6		did         := 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BIPSlim := record
			unsigned8		unique_id;
			string80  	company;
			string10  	prim_range;
			string28		prim_name;
			string8			sec_range;
			string25 		city;   		      // p_city
			string2			state;
			string5			zip5;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string10		phone;
			string      url;
			string      email;
			BIPV2.IDlayouts.l_xlink_ids;
	  end;
		
	  export UniqueId := record
 		  unsigned8		unique_id;
		  Base;
		end;
		
	end;  //Temporary
end;