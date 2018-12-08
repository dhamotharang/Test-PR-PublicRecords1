
EXPORT Layout_Infile := record
//Name/Address	
	string20	orig_HHID;		// Internal Uss
  string20 	orig_PID;			// Internal Uss
  string15	orig_FNAME;
  string1 	orig_MNAME;
  string20 	orig_LNAME;
  string10 	orig_SUFFIX;
  string1 	orig_GENDER;	// M = Male, F = Female
  string2	 	orig_AGE;
  string6 	orig_DOB;			// format YYYYMM
  string1 	orig_HHNBR;   // Internal Uss	
  string20  orig_ADDRID;  // Internal Uss
  string64  orig_ADDRESS;
  string10  orig_HOUSE;
  string2   orig_PREDIR;
  string28  orig_STREET;
  string4   orig_STRTYPE;
  string2 	orig_POSTDIR;
  string15 	orig_APTTYPE;
  string15 	orig_APTNBR;
  string28 	orig_CITY;
  string2 	orig_STATE;
  string5 	orig_ZIP;
  string4 	orig_Z4;
  string3 	orig_DPC;
  string1 	orig_Z4TYPE;
  string4 	orig_CRTE;
  string4 	orig_DPV;
  string4 	orig_VACANT;

//Geographic_Delineation	
  string4 	orig_MSA;
  string5 	orig_CBSA;
	string5 	orig_DMA;
  string3 	orig_County_Code;
  string1 	orig_Time_Zone;
  string1 	orig_Daylight_Savings;
  string11 	orig_Latitude;
  string11 	orig_Longitude;

//Up to 3 Phones	
  string10 	orig_TelephoneNumber_1;
  string1 	orig_DMA_TPS_DNC_Flag_1;
  string10 	orig_TelephoneNumber_2;
  string1 	orig_DMA_TPS_DNC_Flag_2;
  string10 	orig_TelephoneNumber_3;
  string1 	orig_DMA_TPS_DNC_Flag_3;

//Household_Demographic	
  string3 	orig_Length_of_Residence;
  string1 	orig_Homeowner;
	string4		year_built;				//date formate YYYY
	string1		mobile_home_ind;
	string1		pool_owner_ind;
	string1		fireplace_ind;
  string1 	orig_EstimatedIncome;
	string1		orig_Married;
	string1		single_parent_ind;
	string1		senior_hh_ind;
	string1		credit_card_user_ind;
	string1		wealth_score;
	string1		charity_donor_ind;
	string1 	orig_Dwelling_Type;
	string1		home_marker_value;
	string1		education_level;
	string1		ethnicity;
	string1 	orig_CHILD;
	string1		child_age_range;
	string1 	orig_NBRCHILD;
	string1		luxury_veh_owner_ind;
	string1		suv_veh_owner_ind;
	string1		truck_veh_ownere_ind;

//Lifestyle
	string1		price_club_purchasing_ind;
	string1		women_apparal_purchasing_ind;
	string1		men_apparel_purchasing_ind;	
	string1		parent_child_interest_ind;
	string1		pet_owner;
	string1		book_buyer_ind;
	string1		book_reader_ind;
	string1		hi_tech_enthusiasts;
	string1		arts;
	string1		collectibles;
	string1		hobbies_garden;
	string1		home_improvement;
	string1		cook_wine;
	string1		gaming_gabling;
	string1		travel_enthusiast;
	string1		physical_fitness;
	string1		self_improvement;
	string1		automotive_diy;
	string1		spectator_sport_interest;
	string1		outdoors;
	string1		avid_investors_ind;
	string1		avid_boating_ind;
	string1		avid_motorcycling_ind;
	
//Geographic_Demographics
	string1 	orig_Percent_Range_Black;
	string1 	orig_Percent_Range_White;
	string1 	orig_Percent_Range_Hispanic;
	string1 	orig_Percent_Range_Asian;
	string1 	orig_Percent_Range_English_Speaking;
	string1 	orig_Percnt_Range_Spanish_Speaking;
	string1 	orig_Percent_Range_Asian_Speaking;
	string1 	orig_Percent_Range_SFDU;
	string1 	orig_Percent_Range_MFDU;
	string1 	orig_MHV;
	string1 	orig_MOR;
  string1 	orig_CAR;
  string3 	orig_MEDSCHL;
  string1 	orig_Penetration_Range_WhiteCollar;
  string1 	orig_Penetration_Range_BlueCollar;
  string1 	orig_Penetration_Range_OtherOccupation;
  string1 	orig_DEMOLEVEL;
end;	
