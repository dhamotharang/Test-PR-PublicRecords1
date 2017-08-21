export layout_equifax_outfile := record
	string12      DID;
	string2	State_Code;
	String5	ZIP_Code;   
	String4	ZIPPlus_4;	   
	String2 delivery_point;
	String1 delivery_point_correction;
	String4	Carrier_Route; 
	//String5	Blank_Space1; 
	//String1	Dsf_Season_Code;
	String1	Dsf_Delivery_Type_Code;
	//String3	Blank_Space2;
	String20 Surname;
	String14 Primary_Given_Name;
	String1	Primary_Middle_Initial;  
	String2	Primary_Name_Suffix;
	String1	Primary_Title_Code;
	String1	Primary_Gender;
	String14 Secondary_Given_Name;  
	String1	Secondary_Title_Code;   
	String11 House_Number;
	String3	Fraction;
	String2	Street_Prefix_Direction;
	String40 Contracted_Street_Address;
	String6	Route_Designator_and_Number;
	String15 Box_Designator_and_Number;
	String15 Secondary_Unit_Designation;
	String15 Post_Office_Name;
	String2	State_Abbreviation;
	String3	County_Code;
	String1	Phone_Suppression_Source;
	String4	MSAs;
	//String4	Blank_Space3;
	String4	DMA;
	//String1	Nielson_County_Size_Code;
	String3	Area_CodeAll_Available;
	String7	TelephoneAll_Available;
	//String1	Status_Code_of_Records;
	//String1	AddressName_Censor_Code;
	String1	Address_Quality_Code;
	String1	Address_Type;
	String1	File_Code;
	//String1	Blank_Space4;
	String1	Home_OwnerRenter_Code;
	String2	Household_Type_Code;
	String1	Marital_Status;
	//String3	Blank_Space5;
	String1	Dwelling_Type;
	String1	Length_of_Residence;
	//String1	Blank_Space6;
	//String4	Structure_Age_Year;
	String6	Verification_Date_of_Household;
	//String2	Number_of_Sources_Verifying_Household;
	//String2	Blank_Space7;  
	String1	Narrow_Band_Income_Predictor;
	//String1	Estimated_Home_Income_Predictor;
	String1	Income_Model_Indicator;
	String3	Niches;
	//String1	Blank_Space8;
	String1	Mail_Public_Responder_Indicator;
	String1	Mail_Responsive_Buyer_Indicator;
	String1	Mail_Responsive_Donor_Indicator;
	//String6	Blank_Space9;
	String1	Outdoors_Dimension_Household;
	String1	Athletic_Dimension_Household;
	String1	Fitness_Dimension_Household;
	String1	Domestic_Dimension_Household;
	String1	Good_Life_Dimension_Household;
	String1	Cultural_Dimension_Household;
	String1	Blue_Chip_Dimension_Household;
	String1	Do_It_Yourself_Dimension_Household;
	String1	Technology_Dimension_Household;
	String2	Household_Occupation;
	//String1	Blank_Space10;
	//String4	Combined_Market_Value_of_All_Vehicles;
	String1	Number_of_Cars_Currently_Registered_Owned;
	//String2	Body_Size_Class_of_Newest_Car_Owned;
	String1	Truck_Owner_Code;
	//String1	New_Vehicle_Purchase_Code;
	String1	Motorcycle_Ownership_Code;
	String1	Recreational_Vehicle_Ownership_Code;
	String1	Age_Indicator;
	String1	Household_Age_Code;
	String1	Number_of_Persons_in_Household;
	String1	Number_of_Adults_in_Household;
	String1	Number_of_Children_in_Household;
	String1	Age_Unknown_of_Adults;
	String1	Age_75_Years_Old_Specific;
	String1	Age_65to74_Year_Old_Specific;
	String1	Age_55to64_Year_Old_Specific;
	String1	Age_45to54_Year_Old_Specific;
	String1	Age_35to44_Year_Old_Specific;
	String1	Age_25to34_Year_Old_Specific;
	String1	Age_18to24_Year_Old_Specific;
	String1	Presence_of_Adults_Age_65_Inferred;
	String1	Age_45to64_Year_Old_Inferred;
	String1	Age_35to44_Year_Old_Inferred;
	String1	Presence_of_Adults_Age_Under_35_Inferred;
	String1	Children_Age_0_to_2;
	String1	Children_Age_3_to_5;
	String1	Children_Age_6_to_10;
	String1	Children_Age_11_to_15;
	String1	Children_Age_16_to_17;
	String1	Children_Age_0_to_17_Unknown_Gender;
	//String1	Blank_Space11;
	String1	Gender_1;
	String2	Age_1;
	String4	Birth_Year_1;
	String2	Birth_Month_1;
	String14 Given_Name_1;
	String1	Middle_Initial_1;
	String1	Member_Code_of_Person_1;
	String1	Gender_2;
	String2	Age_2;
	String4	Birth_Year_2;
	String2	Birth_Month_2;
	String14 Given_Name_2;
	String1	Middle_Initial_2;
	String1	Member_Code_of_Person_2;
	String1	Gender_3;
	String2	Age_3;
	String4	Birth_Year_3;
	String2	Birth_Month_3;
	String14 Given_Name_3;
	String1	Middle_Initial_3;
	String1	Member_Code_of_Person_3;
	/*String1	Gender_4;
	String2	Age_4;
	String4	Birth_Year_4;
	String2	Birth_Month_4;
	String14 Given_Name_4;
	String1	Middle_Initial_4;
	String1	Member_Code_of_Person_4;
	String1	Gender_5;
	String2	Age_5;
	String4	Birth_Year_5;
	String2	Birth_Month_5;
	String14 Given_Name_5;
	String1	Middle_Initial_5;
	String1	Member_Code_of_Person_5;
	String4	US_Census_Tract_Identifier_2000;
	String2	Census_Tract_Suffix;
	String1	Block_Group_Number;
	String10 Blank_Space12;
	String2	US_Census_State_Code_2000;
	String3	US_Census_County_Code_2000;
	String1	Smacs_2000_Level;
	String3	Median_Household_Income_3_bytes;
	String2	HOUSEHOLDS_WITH_RELATED_CHILDREN;
	String3	MEDIAN_AGE_OF_ADULTS_18_OR_OLDER_3_BYTES;
	String3	MEDIAN_SCHOOL_YEARS_COMPLETED_by_ADULTS_25_3_BYTES;
	String2	Percent_Employed_Managerial_and_Professional;
	String2	OWNER_OCCUPIED_HOUSING_UNITS;
	String2	Percent_in_Single_Unit_Structures;
	String4	Median_Home_Value_4_bytes;
	String2	Percent_Owner_Occupied_Structures_Built_Since_1990;
	String2	Percent_Persons_Move_In_Since_1995;*/
	String2	Percent_of_Motor_Vehicle_Ownership;
	String2	Percent_White;
	//String1	Blank_Space13;
	//String5	CBSA_Code;
	//String6	Blank_Space14;
	String1	Credit_Card_Usage_Miscellaneous;
	String1	Credit_Card_Usage_Standard_Retail;
	String1	Credit_Card_Usage_Standard_Specialty_Card;
	String1	Credit_Card_Usage_Upscale_Retail;
	String1	Credit_Card_Usage_Upscale_Spec_Retail;
	String1	Credit_Card_Usage_Bank_Card;
	String1	Credit_Card_Usage_Oil__Gas_Card;
	String1	Credit_Card_Usage_Finance_Co_Card;
	String1	Credit_Card_Usage_Travel__Entertainment;
	String1	Responder_Education_Code_1;
	String1	Responder_Education_Code_2;
	String1	Responder_Education_Code_3;
	String1	Responder_Education_Code_4;
	String1	Spouse_Education_Code_1;
	String1	Spouse_Education_Code_2;
	String1	Spouse_Education_Code_3;
	String1	Spouse_Education_Code_4;
	String1	Household_Income_Identifier;
	String1	Narrow_Band_Household_Income_Identifier;
	//String1	Income_Model_Indicator2;
	String3	fips_county;
	String4 msa;
	String10 telephone;
	String36 click_id;
	String38 click_hhid;
	String2 eor := '\r\n';
end;

