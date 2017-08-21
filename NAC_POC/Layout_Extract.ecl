EXPORT Layout_Extract := RECORD

	string12	LexID;
	string3	 	LexID_Score;
	string9		Clean_Client_SSN;		//	Clean SSN - Use this one instead of Client SSN below
	string8		Clean_Client_DOB;		//	Clean DOB - Use this one instead of Client DOB below
	integer4		Age;							// Precalculated	Age	Age calculated
		// Clean Name
	string5		Title;
	string20	Preferred_First_Name;	//	Preferred First Name, in case wanted/needed for something
	string20	Fname;
	string20	Mname;
	string20	Lname;
	string5		Name_Suffix;
		// Clean Address
	string10	Prim_Range;
	string2		Predir;
	string28	Prim_Name;
	string4		addr_Suffix;
	string2		Postdir;
	string10	Unit_Desig;
	string8		Sec_Range;
	string25	City;
	string2		St;
	string5		Zip5;
	string4		Zip4;
	string2		FIPS_State;
	string3		FIPS_County;
	string10	Latitude;
	string11	Longitude;
	string1		Geo_Match;		// (0=Rooftop, 1=Zip9, 4=Zip7, 5=Zip5 centroid)	Geo Match (0=Rooftop, 1=Zip9, 4=Zip7, 5=Zip5 centroid)
			//	Begin Informational Fields			
			//	SNAP Contribution & Month Data	
	string2		Contributing_State;
	string1	Case_Benefit_Type;			//S=SNAP, D=DSNAP
	string6	Case_Benefit_Month;			//YYYYMM	YYYYMM (for this POC, will be providing only one, 201506)
			// Case Info
	string20	Case_Identifier;			//	Case ID	Case ID (AKA Household ID, possible multiple Clients per)
	string30	Case_Last_Name;		//	Case Last Name
	string25	Case_First_Name;	//	Case First Name
	string25	Case_Middle_Name;	//	Case Middle Name
	string10	Case_Phone_1;			//	Case Phone 1
	string10	Case_Phone_2;			//	Case Phone 2
	string256	Case_Email;			//	Case Email
	string70	Case_Physical_Address_Street_1;		//	Case Physical Address Street 1
	string70	Case_Physical_Address_Street_2;		//	Case Physical Address Street 2
	string30	Case_Physical_Address_City;			//	Case Physical Address City
	string2		Case_Physical_Address_State;			//	Case Physical Address State
	string9		Case_Physical_Address_Zip;				//	Case Physical Address Zip
	string70	Case_Mailing_Address_Street_1;		//	Case Mailing Address Street 1
	string70	Case_Mailing_Address_Street_2;		//	Case Mailing Address Street 2
	string30	Case_Mailing_Address_City;				//	Case Mailing Address City
	string2		Case_Mailing_Address_State;			//	Case Mailing Address State
	string9		Case_Mailing_Address_Zip;				//	Case Mailing Address Zip
	string3		Case_County_Parish_Code;				//	Case County Parish Code
	string25	Case_County_Parish_Name;				//	Case County Parish Name
		// Client Info
	string20	Client_Identifier;					//	Client ID (unique to person, but duplicates if multiple addresses)
	string30	Client_Last_Name;								//	Client Last Name
	string25	Client_First_Name;							//	Client First Name
	string25	Client_Middle_Name;							//	Client Middle Name
	string1		Client_Gender;									//	Client Gender
	string1		Client_Race;										//	Client Race
	string1		Client_Ethnicity;							//	Client Ethnicity
	string9		Client_SSN;										//	Client SSN (use Clean SSN )
	string1		Client_SSN_Type_Indicator;		//	Client SSN Type Indicator
	string8		Client_DOB;										//	Client DOB (use Clean DOB )
	string1		Client_DOB_Type_Indicator;		// 	Client DOB Type Indicator
	string1		Client_Eligible_Status_Indicator;	//	Client Eligible Status Indicator (If not "E," not really eligible)
	string8		Client_Eligible_Status_Date;			//	Client Eligible Status Date
	string10	Client_Phone;									//	Client Phone
	string256	Client_Email;									//	Client Email
  string32	record_id;
END;