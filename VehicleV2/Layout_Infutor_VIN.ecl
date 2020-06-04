//Copied from Layout_OH
IMPORT	AID,Address;

EXPORT Layout_Infutor_VIN	:= MODULE

	//---------------------------------------------------------
	//-----------INFUTOR INPUT FORMAT LAYOUT
	//---------------------------------------------------------
	
	EXPORT	Raw_Main	:= RECORD
	
	STRING15 	IID;								// 1	IID       			15	Unique Identifier Number
	STRING25	PID;								// 2	PID							25	Persistent ID
	STRING11	VIN;								// 3	VIN       			11	11 Digit Masked VIN Number available for Delivery
	STRING30	MAKE;								// 4	MAKE      			30	Vehicle Make
	STRING30	MODEL;							// 5	MODEL     			30	Vehicle Model
	STRING4		YEAR;								// 6	YEAR      	 		 4	Vehicle Year (YYYY)
	STRING15	CLASS_CODE;					// 7	CLASS_CODE			15	Vehicle Class Code. e.g. SMALL CAR, MID SIZE CAR
	STRING1		FUEL_TYPE_CODE;			// 8	FUEL_TYPE_CODE	 1	Vehicle Fuel Code
	STRING1		MFG_CODE;						// 9	MFG_CODE				 1	Vehicle Manufacturing Code
	STRING10	STYLE_CODE;					//10	STYLE_CODE			10	Vehicle Style Code e.g. CPE 2DR
	STRING1		MILEAGECD;					//11	MILEAGECD			 	 1	Mileage Code A-Z in increments of 10,000 0-10000=A and 250,000+=Z
	STRING1		NBR_VEHICLES;				//12	NBR_VEHICLES		 1	Number of Vehicle per Household 1-8; 9 - 9 or more
	STRING8		IDATE;							//13	IDATE						 8	First Seen Date
	STRING8		ODATE;							//14	ODATE						 8	Last Seen Date
	STRING20	FNAME;							//15	FNAME           20	Given Name
	STRING20	MI;									//16	MI               1	Middle Initial
	STRING75 	LNAME;							//17	LNAME           75	Surname
	STRING10	SUFFIX;							//18	SUFFIX          10	Honorary Suffix
	STRING1		GENDER;							//19	GENDER           1	M - Male; F - Female
	STRING10	HOUSE;							//20	HOUSE           10	Physical Street Number
	STRING2		PREDIR;							//21	PREDIR           2	Physical Street Pre Direction
	STRING28	STREET;							//22	STREET          28	Physical Street Name
	STRING4		STRTYPE;						//23	STRTYPE          4	Physical Street Suffix
	STRING2		POSTDIR;						//24	POSTDIR          2	Physical Street Post Direction
	STRING4		APTTYPE;						//25	APTTYPE          4	Unit Designator
	STRING8		APTNBR;							//26	APTNBR         	 8	Unit Number
	STRING28	CITY;								//27	CITY            28	USPS City Name
	STRING2		STATE;							//28	STATE          	 2	USPS State Abbriviation
	STRING5		ZIP;								//29	ZIP              5	Zip Code
	STRING4		Z4;									//30	Z4               4	Zip Addon
	STRING3		DPC;								//31	DPC              3	Delivery point code
	STRING4		CRTE;								//32	CRTE             4	Carrier Route
	STRING3		CNTY;								//33	CNTY             3	County Code
	STRING1		Z4TYPE;							//34	Z4TYPE           1	USPS Zip+4 Type:
																//														F - Firm or company address
																//														G - General delivery address
																//														H - High-rise or business complex
																//														P - PO Box address
																//														R - Rural route address
																//														S - Street or residential address
																//														Blank - Unknown
	STRING1		DPV;								//35	DPV              1	Delivery Point Validation:
																//														D - Address DPV confirmed for the primary number only, and secondary number information was missing
																//														N - Both Primary and (if present) Secondary number information failed to DPV Confirm.
																//														S - Address DPV confirmed for the primary number only, and secondary number information was present but unconfirmed
																//														Y - Address DPV confirmed for both primary and (if present) secondary numbers
																//														Z - records for verification purposes only (should not be used for mailing or marketing)
																//														Blank - Address not presented to hash table
	STRING1		VACANT;							//36	VACANT					 1	Y - Physical Address Identified by USPS as Vacant;  
																//												N - Someone living at that address;
																//												Blank - Unknown
	STRING10	PHONE;							//37	PHONE           10	Telephone Number
	STRING1		DNC;								//38	DNC	1	N - Telephone Number Present on FTC DoNotCall list
																//					S -  Telephone Number Present on State DoNotCall list
																//					W - Wireless
																//					D - DMA's Telephone Preference Service
	STRING17	INTERNAL1;					//39	INTERNAL1				17	Full VIN Number Used for Vin Lookup
	STRING10	INTERNAL2;					//40	INTERNAL2				10	Internal Use
	STRING10	INTERNAL3;					//41	INTERNAL3				10	Internal Use
	STRING30	COUNTY;							//42	COUNTY					30	FIPS County Name
	STRING4		MSA;								//43	MSA							 4	MSA
	STRING5		CBSA;								//44	CBSA						 5	CBSA
	STRING1		EHI;								//45	EHI							 1	Estimated HouseHold Income Code
																//														Blank =Unknown
																//														A = Less than $20,000
																//														B = $20,000 - $29,999
																//														C = $30,000 - $39,999
																//														D = $40,000 - $49,999
																//														E = $50,000 - $74,999
																//														F = $75,000 - $99,999
																//														G = $100,000 - $124,999
																//														H = $125,000 or More
	STRING1		CHILD;							//46	CHILD						 1	Y or Blank
	STRING1		HOMEOWNER;					//47	HOMEOWNER	 			 1	Y or Blank
	STRING1		PCTW;								//48	PCTW						 1	Penetration Range White  - See Below
	STRING1		PCTB;								//49	PCTB						 1	Penetration Range Black or African American  - See Below 
	STRING1		PCTA;								//50	PCTA						 1	Penetration Range Asian - See Below
	STRING1		PCTH;								//51	PCTH						 1	Penetration Range Hispanic  or Latino - See Below
	STRING1		PCTSPE;							//52	PCTSPE					 1	Penetration Range English Speaking - See Below
	STRING1		PCTSPS;							//53	PCTSPS		 			 1	Penetration Range Spanish Speaking - See Below
	STRING1		PCTSPA;							//54	PCTSPA					 1	Penetration Range Asian Speaking - See Below
	STRING1		MHV;								//55	MHV							 1	Median House Value Code
																//														A - Less than $50,000
																//														B = $50,000 - $99,999
																//														C = $100,000 - $149,999
																//														D = $150,000 - $249,999
																//														E = $250,000 - $349,999
																//														F = $350,000 - $499,999
																//														G = $500,000 - $749,999
																//														H = $750,000 - $999,999
																//														I = $1,000,000 or More
	STRING1		MOR;								//56	MOR							 1	Penetration Range Mail Order Respondent - See Below
	STRING1		PCTOCCW;						//57	PCTOCCW					 1	Penetration Range White Collar - See Below
	STRING1		PCTOCCB;						//58	PCTOCCB					 1	Penetration Range Blue Collar - See Below
	STRING1		PCTOCCO;						//59	PCTOCCO					 1	Penetration Range Other Occupation - See Below
	STRING3		LOR;								//60	LOR							 3	Length of Residence 00 - 14; 15 - 15 or more Years
	STRING1		SFDU;								//61	SFDU						 1	Penetration Range SFDU Structure - See Below
	STRING1		MFDU;								//62	MFDU						 1	Penetration Range MFDU Structure - See Below
																//												Penetration Percentage Ranges	
																//													Greater than 95	A
																//													95 thru 91			B
																//													90 thru 86			C
																//													85 thru 81			D
																//													80 thru 76			E
																//													75 thru 71			F
																//													70 thru 66			G
																//													65 thru 61			H
																//													60 thru 56			I
																//													55 thru 51			J
																//													50 thru 46			K
																//													45 thru 41			L
																//													40 thru 36			M
																//													35 thru 31			N
																//													30 thru 26			O
																//													25 thru 21			P
																//													20 thru 16			Q
																//													15 thru 11			R
																//													10 thru 6				S
																//													Less than 6			T
		STRING10  crlf; 
END;
	
	//------------------------------------------------------------
	//ADD NAME TYPE INDICATORS
	//------------------------------------------------------------
	EXPORT	Prepped	:=
	RECORD
		Raw_Main;
		STRING8		ProcessDate;
		string2		Source_Code;
		string2		State_Origin;
		STRING1		Append_OwnerNameTypeInd			:=	'';			//Set by Address.Mac_Is_Business_Parsed. Can be P, B, U, or I
		STRING80	FullName;
	END;
	
	//------------------------------------------------------------
	//OUTPUT CLEAN FILE LAYOUTS
	//------------------------------------------------------------
	EXPORT Clean_Main	:=
	RECORD
		STRING8		ProcessDate;
		STRING2		Source_Code;
		STRING2		State_Origin;		
		STRING15 	IID;								// 1	IID       			15	Unique Identifier Number
		STRING25	PID;								// 2	PID							25	Persistent ID
		STRING11	VIN;								// 3	VIN       			11	11 Digit Masked VIN Number available for Delivery
		STRING30	MAKE;								// 4	MAKE      			30	Vehicle Make
		STRING30	MODEL;							// 5	MODEL     			30	Vehicle Model
		STRING4		YEAR;								// 6	YEAR      	 		 4	Vehicle Year (YYYY)
		STRING15	CLASS_CODE;					// 7	CLASS_CODE			15	Vehicle Class Code
		STRING1		FUEL_TYPE_CODE;			// 8	FUEL_TYPE_CODE	 1	Vehicle Fuel Code
		STRING1		MFG_CODE;						// 9	MFG_CODE				 1	Vehicle Manufacturing Code
		STRING10	STYLE_CODE;					//10	STYLE_CODE			10	Vehicle Style Code
		STRING1		MILEAGECD;					//11	MILEAGECD			 	 1	Mileage Code A-Z in increments of 10,000 0-10000=A and 250,000+=Z
		STRING1		NBR_VEHICLES;				//12	NBR_VEHICLES		 1	Number of Vehicle per Household 1-8; 9 - 9 or more
		STRING8		IDATE;							//13	IDATE						 8	First Seen Date
		STRING8		ODATE;							//14	ODATE						 8	Last Seen Date
		//STRING20	FNAME;							//15	FNAME           20	Given Name
		//STRING20	MI;									//16	MI               1	Middle Initial
		//STRING75 	LNAME;							//17	LNAME           75	Surname
		//STRING10	SUFFIX;							//18	SUFFIX          10	Honorary Suffix
		STRING20	RAW_FNAME;
		STRING20	RAW_MI;
		STRING75 	RAW_LNAME;
		STRING10	RAW_SUFFIX;
		STRING		Append_OwnerName;
		STRING1		Append_OwnerNameTypeInd;
		STRING1		GENDER;							//19	GENDER           1	M - Male; F - Female
		STRING10	HOUSE;							//20	HOUSE           10	Physical Street Number
		STRING2		PREDIR;							//21	PREDIR           2	Physical Street Pre Direction
		STRING28	STREET;							//22	STREET          28	Physical Street Name
		STRING4		STRTYPE;						//23	STRTYPE          4	Physical Street Suffix
		STRING2		POSTDIR;						//24	POSTDIR          2	Physical Street Post Direction
		STRING4		APTTYPE;						//25	APTTYPE          4	Unit Designator
		STRING8		APTNBR;							//26	APTNBR         	 8	Unit Number
		STRING28	CITY;								//27	CITY            28	USPS City Name
		STRING2		STATE;							//28	STATE          	 2	USPS State Abbriviation
		STRING5		ZIP;								//29	ZIP              5	Zip Code
		STRING4		Z4;									//30	Z4               4	Zip Addon
		STRING3		DPC;								//31	DPC              3	Delivery point code
		STRING4		CRTE;								//32	CRTE             4	Carrier Route
		STRING3		CNTY;								//33	CNTY             3	County Code
		STRING1		Z4TYPE;							//34	Z4TYPE           1	USPS Zip+4 Type:
		STRING1		DPV;								//35	DPV              1	Delivery Point Validation:
		STRING1		VACANT;							//36	VACANT					 1	Y - Physical Address Identified by USPS as Vacant;  
		STRING10	PHONE;							//37	PHONE           10	Telephone Number
		STRING1		DNC;								//38	DNC	1	N - Telephone Number Present on FTC DoNotCall list
		STRING17	INTERNAL1;					//39	INTERNAL1				17	Full VIN Number Used for Vin Lookup
		STRING10	INTERNAL2;					//40	INTERNAL2				10	Internal Use
		STRING10	INTERNAL3;					//41	INTERNAL3				10	Internal Use
		STRING30	COUNTY;							//42	COUNTY					30	FIPS County Name
		STRING4		MSA;								//43	MSA							 4	MSA
		STRING5		CBSA;								//44	CBSA						 5	CBSA
		STRING1		EHI;								//45	EHI							 1	Estimated HouseHold Income Code
		STRING1		CHILD;							//46	CHILD						 1	Y or Blank
		STRING1		HOMEOWNER;					//47	HOMEOWNER	 			 1	Y or Blank
		STRING1		PCTW;								//48	PCTW						 1	Penetration Range White  - See Below
		STRING1		PCTB;								//49	PCTB						 1	Penetration Range Black or African American  - See Below 
		STRING1		PCTA;								//50	PCTA						 1	Penetration Range Asian - See Below
		STRING1		PCTH;								//51	PCTH						 1	Penetration Range Hispanic  or Latino - See Below
		STRING1		PCTSPE;							//52	PCTSPE					 1	Penetration Range English Speaking - See Below
		STRING1		PCTSPS;							//53	PCTSPS		 			 1	Penetration Range Spanish Speaking - See Below
		STRING1		PCTSPA;							//54	PCTSPA					 1	Penetration Range Asian Speaking - See Below
		STRING1		MHV;								//55	MHV							 1	Median House Value Code
		STRING1		MOR;								//56	MOR							 1	Penetration Range Mail Order Respondent - See Below
		STRING1		PCTOCCW;						//57	PCTOCCW					 1	Penetration Range White Collar - See Below
		STRING1		PCTOCCB;						//58	PCTOCCB					 1	Penetration Range Blue Collar - See Below
		STRING1		PCTOCCO;						//59	PCTOCCO					 1	Penetration Range Other Occupation - See Below
		STRING3		LOR;								//60	LOR							 3	Length of Residence 00 - 14; 15 - 15 or more Years
		STRING1		SFDU;								//61	SFDU						 1	Penetration Range SFDU Structure - See Below
		STRING1		MFDU;								//62	MFDU						 1	Penetration Range MFDU Structure - See Below
		//Additional fields: clean name1 and address
		address.Layout_Clean_Name;
		STRING35	company_name1								:=	'';
		STRING100	Append_PrepAddr1						:=	'';
		STRING50	Append_PrepAddr2						:=	'';
		AID.Common.xAID	Append_RawAID					:=	0;
	END;

	EXPORT	Infutor_Vin_as_VehicleV2	:=
	RECORD
		STRING30				Vehicle_Key;
		STRING15				Iteration_Key;
		STRING15				Sequence_Key;
		UNSIGNED4    		dt_first_seen;
		UNSIGNED4				dt_last_seen;
		UNSIGNED4    		dt_vendor_first_reported;
		UNSIGNED4    		dt_vendor_last_reported;
		STRING2     		STATE_ORIGIN;									//State Origin is the state vehicle registered at. This info is N/A in Infutor VIN.
		STRING1     		VINA_VINFLAG;
		STRING1					HISTORY;											//No history information in the vendor file. This field will be left blank.
		STRING2     		SOURCE_CODE;
		//STRING2     		CATEGORYCODE;
		STRING25				RAW_VIN;
		STRING25    		ORIG_VIN;
		STRING4					RAW_YEAR_MAKE;
		STRING4    			YEAR_MAKE;
		STRING15				RAW_CLASS_CODE;
		STRING30   			RAW_MAKE_CODE;
		STRING5   			MAKE_CODE;		
		STRING30   			RAW_MODEL;
		STRING30   			MODEL;		
		STRING10   			RAW_BODY_CODE;
		STRING5   			BODY_CODE;
		STRING1   			RAW_FUEL_TYPE_CODE;
		STRING1   			FUEL_TYPE_CODE;
		STRING20				RAW_FNAME;
		STRING20				RAW_MI;
		STRING75 				RAW_LNAME;
		STRING10				RAW_SUFFIX;
		STRING					Append_OwnerName;
		STRING1					Append_OwnerNameTypeInd;
		STRING5					TITLE;
		STRING20				FNAME;
		STRING20				MNAME;
		STRING20				LNAME;
		STRING5					NAME_SUFFIX;
		STRING3					NAME_SCORE;
		STRING1					CUSTOMER_TYPE;
		STRING35				COMPANY_NAME1;
		STRING100				APPEND_PREPADDR1;
		STRING50				APPEND_PREPADDR2;
		AID.Common.xAID	APPEND_RAWAID;
		//Fields that are in vendor file and not used
		STRING15 				RAW_IID;
		STRING25				RAW_PID;
		STRING25				RAW_IDATE;
		STRING25				RAW_ODATE;
		STRING11				RAW_VIN_MASKED;
		STRING1					RAW_MFG_CODE;
		STRING1					RAW_MILEAGECD;
		STRING1					RAW_NBR_VEHICLES;
		STRING1					RAW_GENDER;
		STRING10				RAW_HOUSE;
		STRING2					RAW_PREDIR;
		STRING28				RAW_STREET;
		STRING4					RAW_STRTYPE;
		STRING2					RAW_POSTDIR;	
		STRING4					RAW_APTTYPE;
		STRING8					RAW_APTNBR;
		STRING28				RAW_CITY;
		STRING2					RAW_STATE;		
		STRING5					RAW_ZIP;			
		STRING4					RAW_Z4;
		STRING3					RAW_DPC;
		STRING4					RAW_CRTE;
		STRING3					RAW_CNTY;
		STRING1					RAW_Z4TYPE;
		STRING1					RAW_DPV;
		STRING1					RAW_VACANT;
		STRING10				RAW_PHONE;
		STRING1					RAW_DNC;
		STRING17				RAW_INTERNAL1;
		STRING10				RAW_INTERNAL2;
		STRING10				RAW_INTERNAL3;
		STRING30				RAW_COUNTY;
		STRING4					RAW_MSA;	
		STRING5					RAW_CBSA;	
		STRING1					RAW_EHI;
		STRING1					RAW_CHILD;
		STRING1					RAW_HOMEOWNER;
		STRING1					RAW_PCTW;
		STRING1					RAW_PCTB;
		STRING1					RAW_PCTA;
		STRING1					RAW_PCTH;
		STRING1					RAW_PCTSPE;
		STRING1					RAW_PCTSPS;
		STRING1					RAW_PCTSPA;
		STRING1					RAW_MHV;
		STRING1					RAW_MOR;
		STRING1					RAW_PCTOCCW;	
		STRING1					RAW_PCTOCCB;
		STRING1					RAW_PCTOCCO;	
		STRING3					RAW_LOR;
		STRING1					RAW_SFDU;
		STRING1					RAW_MFDU;
		//****VINA fields start
		STRING1 				VINA_Veh_Type;
		STRING5 				VINA_NCIC_Make;
		STRING2 				VINA_Model_Year_YY;
		STRING17				VINA_VIN;
		STRING1 				VINA_VIN_Pattern_Indicator;
		STRING1 				VINA_Bypass_Code;
		STRING1 				VINA_VP_Restraint;
		STRING4 				VINA_VP_Abbrev_Make_Name;
		STRING2 				VINA_VP_Year;
		STRING3 				VINA_VP_Series;
		STRING3 				VINA_VP_Model;
		STRING1 				VINA_VP_Air_Conditioning;
		STRING1 				VINA_VP_Power_Steering;
		STRING1 				VINA_VP_Power_Brakes;
		STRING1 				VINA_VP_Power_Windows;
		STRING1 				VINA_VP_Tilt_Wheel;
		STRING1 				VINA_VP_Roof;
		STRING1 				VINA_VP_Optional_Roof1;
		STRING1 				VINA_VP_Optional_Roof2;
		STRING1 				VINA_VP_Radio;
		STRING1 				VINA_VP_Optional_Radio1;
		STRING1 				VINA_VP_Optional_Radio2;
		STRING1 				VINA_VP_Transmission;
		STRING1 				VINA_VP_Optional_Transmission1;
		STRING1 				VINA_VP_Optional_Transmission2;
		STRING1 				VINA_VP_Anti_Lock_Brakes;
		STRING1 				VINA_VP_Front_Wheel_Drive;
		STRING1 				VINA_VP_Four_Wheel_Drive;
		STRING1 				VINA_VP_Security_System;
		STRING1 				VINA_VP_Daytime_Running_Lights;
		STRING25				VINA_VP_Series_Name;
		STRING4 				VINA_Model_Year;
		STRING3 				VINA_Series;
		STRING3 				VINA_Model;
		STRING2 				VINA_Body_Style;
		STRING36				VINA_Make_Desc;
		STRING36				VINA_Model_Desc;
		STRING25				VINA_Series_Desc;
		STRING25				VINA_Body_Style_Desc;
		STRING2 				VINA_Number_Of_Cylinders;
		STRING4 				VINA_Engine_Size;
		STRING1 				VINA_Fuel_Code;
		STRING6 				VINA_Price;
		STRING5					Best_Make_Code;
		STRING3					Best_Series_Code;
		STRING3					Best_Model_Code;
		STRING5					Best_Body_Code;
		STRING4					Best_Model_Year;
		STRING3					Best_Major_Color_Code;
		STRING3					Best_Minor_Color_Code;
		//****VINA fields End
		//Needed to work with macro VehicleV2.Mac_validVIN
		STRING8         REGISTRATION_EFFECTIVE_DATE;
		STRING8         REGISTRATION_EXPIRATION_DATE;
		STRING3					MAJOR_COLOR_CODE;
		STRING3					MINOR_COLOR_CODE;
		STRING20		    ORIG_BODY_DESC;
		STRING30				ORIG_MODEL_DESC;
		STRING25				ORIG_SERIES_DESC;
		STRING4         MODEL_YEAR; 
		STRING36        MAKE_DESC;	
 		STRING36        MODEL_DESC;
		STRING4         VEHICLE_TYPE;
		STRING3         VESSEL_TYPE;
		STRING30		    ORIG_VEHICLE_TYPE_DESC;
		STRING15		    ORIG_MAJOR_COLOR_DESC;
		STRING15		    ORIG_MINOR_COLOR_DESC;
		STRING1         VEHICLE_USE;
		STRING30        ORIG_VEHICLE_USE_DESC;
		STRING40        vehicle_type_desc;
		STRING25        series_desc;
		STRING25        body_style_desc;
		STRING15        major_color_desc;
		STRING15        minor_color_desc; 
		STRING36        make_description;
		STRING36        model_description;
		STRING25        series_description;
		STRING25        body_style_description;
		UNSIGNED8				source_rec_id := 0;	 	//Added for BIP project
		//Added for CCPA-103
		UNSIGNED4       global_sid := 0;
		UNSIGNED8       record_sid := 0;

	END;
	
END;