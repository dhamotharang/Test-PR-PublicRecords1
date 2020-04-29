import Marketing_List;

// Layouts for Marketing List Gen Files
export Layouts := module

	// Input paramter layout from batch
	export Layout_ParmFile	:= record
		string50			filter_type;
		string50			filter_name;
		string2000  	filter_values;
	end;
	
	// Formated layout of parameters after verification
	export Layout_Valid_ParmFile	:=	record
    string50    	filter_name;
    set of string set_filter_values;
  end;
	
	// County table layout used to convert county name to county number.
	export countyTable_Layout	:=	record
		string				CountyCode;
		string				CountyName;
		string				CountyState;
	end;
	
	// This is a temporary layout of the BusinessInfo file. Depending on Location Search parameter, 
	// we project either the seleid or proxid fields to this layout. 
	export Layout_TempBus	:=	record
		unsigned8			unique_id;
	  unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			address;
    string25			city;
    string2				state;
    string5				zip_code;
    string5				county;
		string31			county_name;
		string3				age;
    string10			phone;
    string60			email;
    integer				annual_revenue;
    integer				num_employees;
    string4				sic_primary;
    string4				sic2;
    string4				sic3;
    string4				sic4;
    string4				sic5;
    string6				naics_primary;
    string6				naics2;
    string6				naics3;
    string6				naics4;
    string6				naics5;
		string100			sic_primary_desc;
		string100			sic2_desc;
		string100			sic3_desc;
		string100			sic4_desc;
		string100			sic5_desc;
		string100			naics_primary_desc;
		string100			naics2_desc;
		string100			naics3_desc;
		string100			naics4_desc;
		string100			naics5_desc;		
	end;
	
	// This is a temporary layout of the full file Business Informatio + Contact.
	export Layout_TempFull	:=	record
		unsigned8			unique_id;
	  unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			address;
    string25			city;
    string2				state;
    string5				zip_code;
    string5				county;
		string31			county_name;
		string3				age;
		unsigned4			dt_first_seen;
		unsigned4			dt_last_seen;
    string10			phone;
    string60			email;
    integer				annual_revenue;
    integer				num_employees;
    string4				sic_primary;
    string4				sic2;
    string4				sic3;
    string4				sic4;
    string4				sic5;
    string6				naics_primary;
    string6				naics2;
    string6				naics3;
    string6				naics4;
    string6				naics5;
		string100			sic_primary_desc;
		string100			sic2_desc;
		string100			sic3_desc;
		string100			sic4_desc;
		string100			sic5_desc;
		string100			naics_primary_desc;
		string100			naics2_desc;
		string100			naics3_desc;
		string100			naics4_desc;
		string100			naics5_desc;
		unsigned6			lexid;
    unsigned6			empid;
    string				fname;
    string				lname;
    string				title;
    string				title2;
    string				title3;
    string				title4;
    string				title5;
		string70			contact_address;
		string25			contact_city;
		string2				contact_state;
		string5				contact_zip5;
		string5				contact_county;
		string31			contact_county_name;
		string60			contact_email_address;		
    unsigned			person_hierarchy;		
	end;
	
	// Temporary layout used for normalizing the industry fields.
	export Layout_NormTemp	:=	record
		unsigned8			unique_id;
		unsigned8			IndustryType;
	  unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			address;
    string25			city;
    string2				state;
    string5				zip_code;
    string5				county;
		string3				age;
    string10			phone;
    string60			email;
    integer				annual_revenue;
    integer				num_employees;
    string4				sic_code;
    string6				naics_code;
		string100			sic_desc;
		string100			naics_desc;
	end;	
	
	// Contact Layout
	export Layout_ContactInfo	:=	record
		unsigned6			lexid;
    unsigned6			empid;
    string				first_name;
    string				last_name;
    string				title;
    string				title_var2;
    string				title_var3;
    string				title_var4;
    string				title_var5;
		string70			contact_street_address;
		string25			contact_city;
		string2				contact_state;
		string5				contact_zip_code;
		string31			contact_county;
		string60			contact_email;		
	end;

	// Company (seleid) Premium Result layout
	export Layout_CompanySearch	:=	record
	  unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			company_business_address;
    string25			company_city;
    string2				company_state;
    string5				company_zip_code;
    string31			company_county;
		string3				age_of_company;
    string10			company_phone;
    string60			email;
    integer				annual_revenue;
    integer				num_employees;
		string100			sic_primary_desc;
		string100			sic2_desc;
		string100			sic3_desc;
		string100			sic4_desc;
		string100			sic5_desc;
		string100			naics_primary_desc;
		string100			naics2_desc;
		string100			naics3_desc;
		string100			naics4_desc;
		string100			naics5_desc;		
		Layout_ContactInfo;
	end;

	// Company (seleid) Basic Result layout
	export Layout_CompanySearchBasic	:=	record
	  unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			company_business_address;
    string25			company_city;
    string2				company_state;
    string5				company_zip_code;
		string31			company_county;
		unsigned6			lexid;
    unsigned6			empid;
    string				first_name;
    string				last_name;
    string				title;
    string				title_var2;
    string				title_var3;
    string				title_var4;
    string				title_var5;
		string70			contact_street_address;
		string25			contact_city;
		string2				contact_state;
		string5				contact_zip_code;
		string31			contact_county;
	end;

	// Location (proxid) Premium Result layout
	export Layout_LocationSearch	:=	record
		unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			location_business_address;
    string25			location_city;
    string2				location_state;
    string5				location_zip_code;
    string31			location_county;
		string3				age_of_location;
    string10			location_phone;
    string60			email;
    integer				annual_revenue;
    integer				num_employees;
		string100			sic_primary_desc;
		string100			sic2_desc;
		string100			sic3_desc;
		string100			sic4_desc;
		string100			sic5_desc;
		string100			naics_primary_desc;
		string100			naics2_desc;
		string100			naics3_desc;
		string100			naics4_desc;
		string100			naics5_desc;		
		Layout_ContactInfo;
	end;	

	// Location (proxid) Basic Result layout
	export Layout_LocationSearchBasic	:=	record
		unsigned6			seleid;
    unsigned6			proxid;
    unsigned6			ultid;
    unsigned6			orgid;
    string100			business_name;
    string70			location_business_address;
    string25			location_city;
    string2				location_state;
    string5				location_zip_code;
    string31			location_county;
		unsigned6			lexid;
    unsigned6			empid;
    string				first_name;
    string				last_name;
    string				title;
    string				title_var2;
    string				title_var3;
    string				title_var4;
    string				title_var5;
		string70			contact_street_address;
		string25			contact_city;
		string2				contact_state;
		string5				contact_zip_code;
		string31			contact_county;
	end;

	// Temporary layout used for stats
	export Layout_Stats_Temp	:=	record
		unsigned8 	unique_id;
		unsigned8		Cnt_Unique_Business_Recs;
		unsigned8		Cnt_Companies_Returned;
		decimal8_2	Per_Companies_Returned;
		unsigned8		Cnt_Phones_Returned;
		decimal8_2	Per_Phones_Returned;		
		unsigned8		Cnt_States_Returned;
		decimal8_2	Per_States_Returned;
		unsigned8		Cnt_Counties_Returned;
		decimal8_2	Per_Counties_Returned;
		unsigned8		Cnt_Cities_Returned;
		decimal8_2	Per_Cities_Returned;		
		unsigned8		Cnt_Zip_Codes_Returned;
		decimal8_2	Per_Zip_Codes_Returned;
		
		unsigned8		Cnt_Bus_Emails_Returned;
		decimal8_2	Per_Bus_Emails_Returned;		

		unsigned8		Cnt_Revenue_Less_150000;
		decimal8_2	Per_Revenue_Less_150000;
		unsigned8		Cnt_Revenue_150000_249999;
		decimal8_2	Per_Revenue_150000_249999;
		unsigned8		Cnt_Revenue_250000_499999;
		decimal8_2	Per_Revenue_250000_499999;
		unsigned8		Cnt_Revenue_500000_999999;
		decimal8_2	Per_Revenue_500000_999999;
		unsigned8		Cnt_Revenue_1000000_2499999;
		decimal8_2	Per_Revenue_1000000_2499999;		
		unsigned8		Cnt_Revenue_2500000_4999999;
		decimal8_2	Per_Revenue_2500000_4999999;	
		unsigned8		Cnt_Revenue_5000000_9999999;
		decimal8_2	Per_Revenue_5000000_9999999;		
		unsigned8		Cnt_Revenue_10000000_and_Above;
		decimal8_2	Per_Revenue_10000000_and_Above;	
		
		unsigned8		Cnt_1_Employee;
		decimal8_2	Per_1_Employee;		
		unsigned8		Cnt_2_4_Employees;
		decimal8_2	Per_2_4_Employees;
		unsigned8		Cnt_5_9_Employees;
		decimal8_2	Per_5_9_Employees;
		unsigned8		Cnt_10_19_Employees;
		decimal8_2	Per_10_19_Employees;
		unsigned8		Cnt_20_49_Employees;
		decimal8_2	Per_20_49_Employees;
		unsigned8		Cnt_50_99_Employees;
		decimal8_2	Per_50_99_Employees;
		unsigned8		Cnt_100_249_Employees;
		decimal8_2	Per_100_249_Employees;
		unsigned8		Cnt_250_499_Employees;
		decimal8_2	Per_250_499_Employees;
		unsigned8		Cnt_500_749_Employees;
		decimal8_2	Per_500_749_Employees;
		unsigned8		Cnt_750_999_Employees;
		decimal8_2	Per_750_999_Employees;
		unsigned8		Cnt_1000_1249_Employees;
		decimal8_2	Per_1000_1249_Employees;
		unsigned8		Cnt_1250_1499_Employees;
		decimal8_2	Per_1250_1499_Employees;
		unsigned8		Cnt_1500_and_Above_Employees;
		decimal8_2	Per_1500_and_Above_Employees;

		unsigned8		Cnt_Less_Than_2_Years;
		decimal8_2	Per_Less_Than_2_Years;		
		unsigned8		Cnt_2_5_Years;
		decimal8_2	Per_2_5_Years;	
		unsigned8		Cnt_6_10_Years;
		decimal8_2	Per_6_10_Years;
		unsigned8		Cnt_More_Than_10_Years;
		decimal8_2	Per_More_Than_10_Years;
		
		unsigned8		Cnt_Total_SIC;
		decimal8_2	Per_Total_SIC;
		unsigned8		Cnt_Total_NAICS;
		decimal8_2	Per_Total_NAICS;
		
		unsigned8		Cnt_SIC_Agriculture_Forestry_And_Fishing;
		decimal8_2	Per_SIC_Agriculture_Forestry_And_Fishing;	
		unsigned8		Cnt_SIC_Mining;
		decimal8_2	Per_SIC_Mining;	
		unsigned8		Cnt_SIC_Construction;
		decimal8_2	Per_SIC_Construction;
		unsigned8		Cnt_SIC_Manufacturing;
		decimal8_2	Per_SIC_Manufacturing;
		unsigned8		Cnt_SIC_Transportation_and_Public_Utilities;
		decimal8_2	Per_SIC_Transportation_and_Public_Utilities;
		unsigned8		Cnt_SIC_Wholesale_Trade;
		decimal8_2	Per_SIC_Wholesale_Trade;
		unsigned8		Cnt_SIC_Retail_Trade;
		decimal8_2	Per_SIC_Retail_Trade;
		unsigned8		Cnt_SIC_Finance_Insurance_and_Real_Estate;
		decimal8_2	Per_SIC_Finance_Insurance_and_Real_Estate;
		unsigned8		Cnt_SIC_Services;
		decimal8_2	Per_SIC_Services;
		unsigned8		Cnt_SIC_Public_Administration;
		decimal8_2	Per_SIC_Public_Administration;	
		
		unsigned8		Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting;
		decimal8_2	Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting;
		unsigned8		Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction;
		decimal8_2	Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction;
		unsigned8		Cnt_NAICS_Utilities;
		decimal8_2	Per_NAICS_Utilities;
		unsigned8		Cnt_NAICS_Construction;
		decimal8_2	Per_NAICS_Construction;
		unsigned8		Cnt_NAICS_Manufacturing;
		decimal8_2	Per_NAICS_Manufacturing;
		unsigned8		Cnt_NAICS_Wholesale_Trade;
		decimal8_2	Per_NAICS_Wholesale_Trade;
		unsigned8		Cnt_NAICS_Retail_Trade;
		decimal8_2	Per_NAICS_Retail_Trade;
		unsigned8		Cnt_NAICS_Transportation_and_Warehousing;
		decimal8_2	Per_NAICS_Transportation_and_Warehousing;
		unsigned8		Cnt_NAICS_Information;
		decimal8_2	Per_NAICS_Information;
		unsigned8		Cnt_NAICS_Finance_and_Insurance;
		decimal8_2	Per_NAICS_Finance_and_Insurance;
		unsigned8		Cnt_NAICS_Real_Estate_Rental_and_Leasing;
		decimal8_2	Per_NAICS_Real_Estate_Rental_and_Leasing;
		unsigned8		Cnt_NAICS_Professional_Scientific_Technical_Services;
		decimal8_2	Per_NAICS_Professional_Scientific_Technical_Services;
		unsigned8		Cnt_NAICS_Management_of_Companies_and_Enterprises;
		decimal8_2	Per_NAICS_Management_of_Companies_and_Enterprises;
		unsigned8		Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices;
		decimal8_2	Per_NAICS_Admin_Support_WasteMgmt_RemediationServices;
		unsigned8		Cnt_NAICS_Educational_Services;
		decimal8_2	Per_NAICS_Educational_Services;
		unsigned8		Cnt_NAICS_HealthCare_and_SocialAssistance;
		decimal8_2	Per_NAICS_HealthCare_and_SocialAssistance;
		unsigned8		Cnt_NAICS_Arts_Entertainment_and_Recreation;
		decimal8_2	Per_NAICS_Arts_Entertainment_and_Recreation;
		unsigned8		Cnt_NAICS_Accommodation_and_Food_Services;
		decimal8_2	Per_NAICS_Accommodation_and_Food_Services;
		unsigned8		Cnt_NAICS_Other_Services_except_Public_Administration;
		decimal8_2	Per_NAICS_Other_Services_except_Public_Administration;
		unsigned8		Cnt_NAICS_Public_Administration;
		decimal8_2	Per_NAICS_Public_Administration;
		
		unsigned8 	Cnt_Unique_Contact_Recs;
		unsigned8		Cnt_Contact_Address;
		decimal8_2	Per_Contact_Address;
		unsigned8		Cnt_Contact_Email;
		decimal8_2	Per_Contact_Email;
		unsigned8		Cnt_Contact_Title;
		decimal8_2	Per_Contact_Title;
		unsigned8		Cnt_Contact_Lexid;
		decimal8_2	Per_Contact_Lexid;
	end;

  // Final Stat Layout
	export Layout_Stats	:=	record
		Layout_Stats_Temp - unique_id;
	end;

  // Log File Layout	
	export Layout_LogFile := RECORD
		string user; 				
		string TimeStamp;
		string JobId; 			
		string WorkunitName;
		string status; 			
		string Description;			
	end;
	
end;