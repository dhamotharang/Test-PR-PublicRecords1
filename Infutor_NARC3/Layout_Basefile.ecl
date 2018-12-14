
import address,AID;

EXPORT Layout_Basefile := record
	integer8  key;
	string2 	src;
	string8	  process_date;
	string8 	date_first_seen  	:='0';
	string8 	date_last_seen 		:='0';
	UNSIGNED6 Date_vendor_first_reported;
	UNSIGNED6 Date_vendor_last_reported;
	string20	orig_HHID;
	string20	orig_PID;
	string15	orig_FNAME;
	string1	  orig_MNAME;
	string20	orig_LNAME;
	string10	orig_SUFFIX;
	string1	  orig_Gender;
	string2	  orig_AGE;
	string6	  orig_DOB;
	string1	  orig_HHNBR;
	string20	orig_ADDRID;
	string64	orig_ADDRESS;
	string10	orig_HOUSE;
	string2	  orig_PREDIR;
	string28	orig_STREET;
	string4	  orig_STRTYPE;
	string2	  orig_POSTDIR;
	string15	orig_APTTYPE;
	string15	orig_APTNBR;
	string28	orig_CITY;
	string2	  orig_STATE;
	string5	  orig_orig_ZIP;
	string4	  orig_Z4;
	string3	  orig_DPC;
	string1	  orig_Z4TYPE;
	string4	  orig_CRTE;
	string4	  orig_DPV;
	string	  orig_VACANT;
	string4	  orig_MSA;
	string5	  orig_CBSA;
	string5	  orig_DMA;
	string3	  orig_County_Code;
	string1	  orig_Time_Zone;	//code
	string	  orig_Time_Zone_descr;	//code
	string1	  orig_Daylight_Savings;
	string11	orig_Latitude;
	string11	orig_Longitude;
	string10	orig_Telephone_Number_1;
	string1	  orig_DMA_TPS_DNC_Flag_1;
	string10	orig_Telephone_Number_2;
	string1	  orig_DMA_TPS_DNC_Flag_2;
	string10	orig_Telephone_Number_3;
	string1	  orig_DMA_TPS_DNC_Flag_3;
	string3	  orig_Length_of_Residence;
	string1	  orig_Homeowner_Renter;	//code
	string2	  orig_Homeowner_Renter_descr;	//code descr
	string4	  orig_Year_Built;
	string1	  orig_Mobile_Home_Indicator;
	string1	  orig_Pool_Owner;
	string1	  orig_Fireplace_in_home;
	string1	  orig_Estimated_Income;	//code
	string	  orig_Estimated_Income_descr;	//code descr
	string1	  orig_Marital_Status;	//code
	string	  orig_Marital_Status_descr;	//code descr
	string1	  orig_Single_Parent;
	string1	  orig_Senior_In_HH;
	string1	  orig_Credit_Card_User;	
	string1	  orig_Wealth_Score_Estimated_Net_worth;	//code
	string	  orig_Wealth_Score_Estimated_Net_worth_descr;	//code descr
	string1	  orig_Donator_to_Charity_or_Causes;	
	string1	  orig_Dwelling_Type;	//code
	string	  orig_Dwelling_Type_descr;	//code descr
	string1	  orig_Home_Market_Value;	//code
	string	  orig_Home_Market_Value_descr;	//code descr
	string1	  orig_Education;	//code 	
	string	  orig_Education_descr;	//code descr 	
	string1	  orig_ETHNICITY;	//code
	string	  orig_ETHNICITY_descr;	//code descr		
	string1	  orig_Child;
	string1	  orig_Child_Age_Ranges;	//code	
	string	  orig_Child_Age_Ranges_descr;	//code descr	
	string1	  orig_Number_of_Children_in_HH;	//code	
	string	  orig_Number_of_Children_in_HH_descr;	//code descr	
	string1	  orig_Luxury_Vehicle_Owner;
	string1	  orig_SUV_Owner;
	string1	  orig_Pickup_Truck_Owner;
	string1	  orig_Price_Club_and_value_Purchasing_Indicator;	
	string1	  orig_Womens_Apparel_Purchasing_Indicator;	//code
	string	  orig_Womens_Apparel_Purchasing_Indicator_descr;	//code descr		
	string1	  orig_Mens_Apparel_Purchasing_Indcator;	//code	
	string	  orig_Mens_Apparel_Purchasing_Indcator_descr;	//code descr
	string1	  orig_Parenting_and_Childrens_interest_Bundle;
	string1	  orig_Pet_Lovers_or_owners;	//code	
	string	  orig_Pet_Lovers_or_owners_descr;	//code descr	
	string1	  orig_Book_Buyers;
	string1	  orig_Book_Readers;
	string1	  orig_Hi_Tech_Enthusiasts;
	string1	  orig_Arts_Bundle;	//code
	string	  orig_Arts_Bundle_descr;	//code descr	
	string1	  orig_Collectibles_Bundle;	//code	
	string	  orig_Collectibles_Bundle_descr;	//code descr	
	string1	  orig_Hobbies_Home_and_Garden_Bundle;	//code	
	string	  orig_Hobbies_Home_and_Garden_Bundle_descr;	//code descr	
	string1	  orig_Home_Improvement;	//code
	string	  orig_Home_Improvement_descr;	//code descr
	string1	  orig_Cooking_and_Wine;	//code	
	string	  orig_Cooking_and_Wine_descr;	//code descr	
	string1	  orig_Gaming_and_Gambling_Enthusiast;
	string1	  orig_Travel_Enthusiasts;	//code
	string	  orig_Travel_Enthusiasts_descr;	//code descr	
	string1	  orig_Physical_Fitness;	//code
	string	  orig_Physical_Fitness_descr;	//code descr
	string1	  orig_Self_Improvement;	//code	
	string	  orig_Self_Improvement_descr;	//code descr	
	string1	  orig_Automotive_DIY;
	string1	  orig_Spectator_Sports_Interest;	//code 	
	string	  orig_Spectator_Sports_Interest_descr;	//code descr 
	string1   orig_Outdoors;	//code	
	string    orig_Outdoors_descr;	//code descr	
	string1	  orig_Avid_Investors;
	string1	  orig_Avid_Interest_in_Boating;
	string1	  orig_Avid_Interest_in_Motorcycling;
	string1	  orig_Percent_Range_Black;	//code
	string	  orig_Percent_Range_Black_descr;	//code descr
	string1	  orig_Percent_Range_White;	//code
	string	  orig_Percent_Range_White_descr;	//code descr
	string1	  orig_Percent_Range_Hispanic;	//code
	string	  orig_Percent_Range_Hispanic_descr;	//code descr
	string1	  orig_Percent_Range_Asian;	//code
	string	  orig_Percent_Range_Asian_descr;	//code descr
	string1	  orig_Percent_Range_English_Speaking;	//code
	string	  orig_Percent_Range_English_Speaking_descr;	//code descr
	string1	  orig_Percnt_Range_Spanish_Speaking;	//code
	string	  orig_Percnt_Range_Spanish_Speaking_descr;	//code descr
	string1	  orig_Percent_Range_Asian_Speaking;	//code
	string	  orig_Percent_Range_Asian_Speaking_descr;	//code descr
	string1	  orig_Percent_Range_SFDU;	//code
	string	  orig_Percent_Range_SFDU_descr;	//code descr
	string1	  orig_Percent_Range_MFDU;	//code
	string	  orig_Percent_Range_MFDU_descr;	//code descr
	string1	  orig_MHV;	//code	
	string	  orig_MHV_descr;	//code descr	
	string1	  orig_MOR;	//code
	string	  orig_MOR_descr;	//code descr
	string1	  orig_CAR;	//code
	string	  orig_CAR_descr;	//code descr
	string3	  orig_MEDSCHL;
	string1	  orig_Penetration_Range_White_Collar;	//code
	string	  orig_Penetration_Range_White_Collar_descr;	//code descr
	string1	  orig_Penetration_Range_Blue_Collar;	//code
	string	  orig_Penetration_Range_Blue_Collar_descr;	//code descr
	string1	  orig_Penetration_Range_Other_Occupation;	//code
	string	  orig_Penetration_Range_Other_Occupation_descr;	//code descr
	string1	  orig_DEMOLEVEL;	//code
	string	  orig_DEMOLEVEL_descr;	//code descr
	address.Layout_Clean_Name.title;
	address.Layout_Clean_Name.fname;
	address.Layout_Clean_Name.mname;
	address.Layout_Clean_Name.lname;
	address.Layout_Clean_Name.name_suffix;
	address.Layout_Clean182.prim_range;
	address.Layout_Clean182.predir;
	address.Layout_Clean182.prim_name;
	address.Layout_Clean182.addr_suffix;
	address.Layout_Clean182.postdir;
	address.Layout_Clean182.unit_desig;
	address.Layout_Clean182.sec_range;
	address.Layout_Clean182.p_city_name;
	address.Layout_Clean182.v_city_name;
	address.Layout_Clean182.st;
	address.Layout_Clean182.zip;
	address.Layout_Clean182.zip4;
	address.Layout_Clean182.cart;
	address.Layout_Clean182.cr_sort_sz;
	address.Layout_Clean182.lot;
	address.Layout_Clean182.lot_order;
	address.Layout_Clean182.dbpc;
	address.Layout_Clean182.chk_digit;
	address.Layout_Clean182.rec_type;
	string2		fips_st:='';
	string3		fips_county:='';
	address.Layout_Clean182.geo_lat;
	address.Layout_Clean182.geo_long;
	address.Layout_Clean182.msa;
	address.Layout_Clean182.geo_blk;
	address.Layout_Clean182.geo_match;
	address.Layout_Clean182.err_stat;
	UNSIGNED6  did 							:= 0;	
	UNSIGNED1  did_score 				:= 0;
	string10   clean_Phone;
	string8	   clean_DOB;	
	unsigned1  record_type;	
	AID.Common.xAID		RawAID;
end;
