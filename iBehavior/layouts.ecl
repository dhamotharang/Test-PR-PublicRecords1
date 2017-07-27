IMPORT AID, NID;

//Length 1090
EXPORT layouts :=
	MODULE
		EXPORT layout_in := 
					RECORD
						string30	Last_Name;
						string30	First_Name;
						string1		Middle_Initial;
						string10	Maturity_Title;
						string20	Title;
						string40	CO_Address;
						string30	Apt_No;
						string40	Address_Line1;
						string40	Address_Line2;
						string40	City;
						string2		State;
						string7		Zip_Code;
						string4		Zip_4;
						string1		Gender_Code;
						string10	IB_Individual_ID;
						string10	IB_Household_ID;
						string8		First_Order_Date;
						string8		Last_Order_Date;
						string8		First_Online_Order_Date;
						string8		Last_Online_Order_Date;
						string8		First_Offline_Order_Date;
						string8		Last_Offline_Order_Date;
						string8		First_Retail_Order_Date;
						string8		Last_Retail_Order_Date;
						string3		number_of_sources;
						string4		Total_Number_of_Orders;
						string9		Total_Dollars;
						string4		Online_Orders;
						string9		Online_Dollars;
						string4		Offline_Orders;
						string9		Offline_Dollars;
						string4		Retail_Orders;
						string9		Retail_Dollars;
						string4		Average_Days_Between_Orders;
						string4		Average_Days_Between_Online_Orders;
						string4		Average_Days_Between_Offline_Orders;
						string4		Average_Days_Between_Retail_Orders;
						string9		Average_Amount_Per_Order;
						string9		Online_Average_Amount_Per_Order;
						string9		Offline_Average_Amount_Per_Order;
						string9		Retail_Average_Amount_Per_Order;
						string4		Online_Orders_Under_50_Range;
						string4		Online_Orders_50_to_99_dot_99_Range;
						string4		Online_Orders_100_to_249_dot_99_Range;
						string4		Online_Orders_250_to_499_dot_99_Range;
						string4		Online_Orders_500_to_999_dot_99_Range;
						string4		Online_Orders_1000_plus_Range;
						string4		Offline_Orders_Under_50_Range;
						string4		Offline_Orders_50_to_99_dot_99_Range;
						string4		Offline_Orders_100_to_249_dot_99_Range;
						string4		Offline_Orders_250_to_499_dot_99_Range;
						string4		Offline_Orders_500_to_999_dot_99_Range;
						string4		Offline_Orders_1000_plus_Range;
						string4		Retail_Orders_Under_50_Range;
						string4		Retail_Orders_50_to_99_dot_99_Range;
						string4		Retail_Orders_100_to_249_dot_99_Range;
						string4		Retail_Orders_250_to_499_dot_99_Range;
						string4		Retail_Orders_500_to_999_dot_99_Range;
						string4		Retail_Orders_1000_plus_Range;
						string3		Weeks_Since_Last_Order_Apparel_General;
						string3		Weeks_Since_Last_Order_Novelty;
						string3		Weeks_Since_Last_Order_Books;
						string3		Weeks_Since_Last_Order_Childrens_Products;
						string3		Weeks_Since_Last_Order_Crafts_or_Hobbies;
						string3		Weeks_Since_Last_Order_Gift;
						string3		Weeks_Since_Last_Order_Holiday_Items;
						string3		Weeks_Since_Last_Order_Specialty_Gifts;
						string3		Weeks_Since_Last_Order_Home_Furnishings;
						string3		Weeks_Since_Last_Order_Housewares;
						string3		Weeks_Since_Last_Order_Homecare;
						string3		Weeks_Since_Last_Order_Garden;
						string3		Weeks_Since_Last_Order_Sports_and_Leiser;
						string3		Weeks_Since_Last_Order_Travel;
						string3		Orders_Apparel_General;
						string3		Orders_Novelty;
						string3		Orders_Books;
						string3		Orders_Childrens_Products;
						string3		Orders_Crafts_or_Hobbies;
						string3		Orders_Gift;
						string3		Orders_Holiday_Items;
						string3		Orders_Specialty_Gifts;
						string3		Orders_Home_Furnishings;
						string3		Orders_Housewares;
						string3		Orders_Homecare;
						string3		Orders_Garden;
						string3		Orders_Sports_and_Leiser;
						string3		Orders_Travel;
						string9		Dollars_Apparel_General;
						string9		Dollars_Novelty;
						string9		Dollars_Books;
						string9		Dollars_Childrens_Products;
						string9		Dollars_Crafts_or_Hobbies;
						string9		Dollars_Gift;
						string9		Dollars_Holiday_Items;
						string9		Dollars_Specialty_Gifts;
						string9		Dollars_Home_Furnishings;
						string9		Dollars_Housewares;
						string9		Dollars_Homecare;
						string9		Dollars_Garden;
						string9		Dollars_Sports_and_Leiser;
						string9		Dollars_Travel;
						string100	Email_Address_1;
						string100	Email_Address_2;
						string100	Email_Address_3;
						string10	Primary_Phone_Number;
						string10	Secondary_Phone_Number;
						string1		X_End_of_Line;
						string1		LF;
					END;
					
			EXPORT Layout_base := 
					RECORD
						Layout_in  - [X_End_of_Line, LF];

						// Record ID field
						unsigned8	persistent_record_id := 0;
						
						//DID fields
						unsigned8 DID;
						unsigned8 DID_Score;

						// NID Fields
						NID.Common.xNID nameID;
						NID.Common.xNameType	nameType;
						NID.Common.xNameString fullname;
						
						//Clean name fields
						string5		prefix;
						string20	fname;
						string20	mname;
						string20	lname;
						string5		name_suffix;
						// string3		clean_name_score;
						unsigned2	name_ind;
						
						//AID Fields
						AID.Common.xAID	RawAID;
						string77	Append_Prep_Address;
						string54	Append_Prep_Address_Last;
						
						//Clean phone number
						string10	phone_1;
						string10	phone_2;
						
						//Clean address fields
						string10  prim_range;
						string2   predir;
						string28  prim_name;
						string4   addr_suffix;
						string2   postdir;
						string10  unit_desig;
						string8   sec_range;
						string25  p_city_name;
						string25  v_city_name;
						string2   st;
						string5   zip5;
						string4   zip4;
						string4   cart;
						string1   cr_sort_sz;
						string4   lot;
						string1   lot_order;
						string2   dbpc;
						string1   chk_digit;
						string2   rec_type;
						string5 	county;
						string2   ace_fips_st;
						string3		fips_county;
						string10  geo_lat;
						string11  geo_long;
						string4   msa;
						string7   geo_blk;
						string1   geo_match;
						string4   err_stat;
						
						// Instance tracking fields
						string8		process_date;
						string8		date_first_seen;
						string8		date_last_seen;
						string8		date_vendor_first_reported;
						string8		date_vendor_last_reported;
					END;

			EXPORT Layout_consumer := 
					RECORD
						//Record_id
						unsigned8	persistent_record_id;
						
						string10	IB_Individual_ID;
						string10	IB_Household_ID;
						string30	Last_Name;
						string30	First_Name;
						string1		Middle_Initial;
						string10	Maturity_Title;
						string20	Title;
						string40	CO_Address;
						string30	Apt_No;
						string40	Address_Line1;
						string40	Address_Line2;
						string40	City;
						string2		State;
						string7		Zip_Code;
						string4		Zip_4;
						string1		Gender_Code;
						string100	Email_Address_1;
						string100	Email_Address_2;
						string100	Email_Address_3;
						string10	Primary_Phone_Number;
						string10	Secondary_Phone_Number;
						
						//DID fields
						unsigned8 DID;
						unsigned8 DID_Score;

					 //NID Fields
						NID.Common.xNID nameID;
						NID.Common.xNameType	nameType;
						NID.Common.xNameString fullname;

						//Clean name fields
						string5		prefix;
						string20	fname;
						string20	mname;
						string20	lname;
						string5		name_suffix;
						// string3		clean_name_score;
						unsigned2	name_ind;
						
						//AID Fields
						AID.Common.xAID	RawAID;
						string77	Append_Prep_Address;
						string54	Append_Prep_Address_Last;
						
						//Clean phone number
						string10	phone_1;
						string10	phone_2;
						
						//Clean address fields
						string10  prim_range;
						string2   predir;
						string28  prim_name;
						string4   addr_suffix;
						string2   postdir;
						string10  unit_desig;
						string8   sec_range;
						string25  p_city_name;
						string25  v_city_name;
						string2   st;
						string5   zip5;
						string4   zip4;
						string4   cart;
						string1   cr_sort_sz;
						string4   lot;
						string1   lot_order;
						string2   dbpc;
						string1   chk_digit;
						string2   rec_type;
						string5 	county;
						string2   ace_fips_st;
						string3		fips_county;
						string10  geo_lat;
						string11  geo_long;
						string4   msa;
						string7   geo_blk;
						string1   geo_match;
						string4   err_stat;
						
						// Instance tracking fields
						string8		process_date;
						string8		date_first_seen;
						string8		date_last_seen;
						string8		date_vendor_first_reported;
						string8		date_vendor_last_reported;
				END;
					
		EXPORT Layout_behavior	:=
				RECORD
				//Record_id
						unsigned8 persistent_record_id;
						
						string10	IB_Individual_ID;
						string10	IB_Household_ID;
						string8		First_Order_Date;
						string8		Last_Order_Date;
						string8		First_Online_Order_Date;
						string8		Last_Online_Order_Date;
						string8		First_Offline_Order_Date;
						string8		Last_Offline_Order_Date;
						string8		First_Retail_Order_Date;
						string8		Last_Retail_Order_Date;
						string3		number_of_sources;
						string4		Total_Number_of_Orders;
						string9		Total_Dollars;
						string4		Online_Orders;
						string9		Online_Dollars;
						string4		Offline_Orders;
						string9		Offline_Dollars;
						string4		Retail_Orders;
						string9		Retail_Dollars;
						string4		Average_Days_Between_Orders;
						string4		Average_Days_Between_Online_Orders;
						string4		Average_Days_Between_Offline_Orders;
						string4		Average_Days_Between_Retail_Orders;
						string9		Average_Amount_Per_Order;
						string9		Online_Average_Amount_Per_Order;
						string9		Offline_Average_Amount_Per_Order;
						string9		Retail_Average_Amount_Per_Order;
						string4		Online_Orders_Under_50_Range;
						string4		Online_Orders_50_to_99_dot_99_Range;
						string4		Online_Orders_100_to_249_dot_99_Range;
						string4		Online_Orders_250_to_499_dot_99_Range;
						string4		Online_Orders_500_to_999_dot_99_Range;
						string4		Online_Orders_1000_plus_Range;
						string4		Offline_Orders_Under_50_Range;
						string4		Offline_Orders_50_to_99_dot_99_Range;
						string4		Offline_Orders_100_to_249_dot_99_Range;
						string4		Offline_Orders_250_to_499_dot_99_Range;
						string4		Offline_Orders_500_to_999_dot_99_Range;
						string4		Offline_Orders_1000_plus_Range;
						string4		Retail_Orders_Under_50_Range;
						string4		Retail_Orders_50_to_99_dot_99_Range;
						string4		Retail_Orders_100_to_249_dot_99_Range;
						string4		Retail_Orders_250_to_499_dot_99_Range;
						string4		Retail_Orders_500_to_999_dot_99_Range;
						string4		Retail_Orders_1000_plus_Range;
						string3		Weeks_Since_Last_Order_Apparel_General;
						string3		Weeks_Since_Last_Order_Novelty;
						string3		Weeks_Since_Last_Order_Books;
						string3		Weeks_Since_Last_Order_Childrens_Products;
						string3		Weeks_Since_Last_Order_Crafts_or_Hobbies;
						string3		Weeks_Since_Last_Order_Gift;
						string3		Weeks_Since_Last_Order_Holiday_Items;
						string3		Weeks_Since_Last_Order_Specialty_Gifts;
						string3		Weeks_Since_Last_Order_Home_Furnishings;
						string3		Weeks_Since_Last_Order_Housewares;
						string3		Weeks_Since_Last_Order_Homecare;
						string3		Weeks_Since_Last_Order_Garden;
						string3		Weeks_Since_Last_Order_Sports_and_Leiser;
						string3		Weeks_Since_Last_Order_Travel;
						string3		Orders_Apparel_General;
						string3		Orders_Novelty;
						string3		Orders_Books;
						string3		Orders_Childrens_Products;
						string3		Orders_Crafts_or_Hobbies;
						string3		Orders_Gift;
						string3		Orders_Holiday_Items;
						string3		Orders_Specialty_Gifts;
						string3		Orders_Home_Furnishings;
						string3		Orders_Housewares;
						string3		Orders_Homecare;
						string3		Orders_Garden;
						string3		Orders_Sports_and_Leiser;
						string3		Orders_Travel;
						string9		Dollars_Apparel_General;
						string9		Dollars_Novelty;
						string9		Dollars_Books;
						string9		Dollars_Childrens_Products;
						string9		Dollars_Crafts_or_Hobbies;
						string9		Dollars_Gift;
						string9		Dollars_Holiday_Items;
						string9		Dollars_Specialty_Gifts;
						string9		Dollars_Home_Furnishings;
						string9		Dollars_Housewares;
						string9		Dollars_Homecare;
						string9		Dollars_Garden;
						string9		Dollars_Sports_and_Leiser;
						string9		Dollars_Travel;
						string8		process_date;
						string8		date_first_seen;
						string8		date_last_seen;
				END;
	END;