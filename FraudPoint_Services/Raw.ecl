
/*
1.	Virtual Fraud Database (VFD)--This database contains InstantID, FraudPoint (and other 
legacy variations of those products) inquiries with an appended fraud score to identify past 
transactions that were either very likely fraud events or were very likely NOT fraud events.  
Content from this database is exposed Modeling Shell 5.0 as variables that start with the 
prefix "vf_".

2.	Test Fraud Database (TFD)--This database includes records of known fraud events 
contributed by customers through test engagements.  Content from this database shall be 
exposed in Modeling Shell 5.0 as variables that start with the prefix "tf_".

3.	Contributory Fraud Database (CFD)--This database includes records of known fraud events 
contributed by customers as part of ongoing use of LexisNexis services, either as part of a 
"give to get" program or a price discount program.  Content from this database shall be 
exposed in Modeling Shell 5.0 as variables that start with the prefix "cf_".

4.	Identity Fraud Database (IFD)--The union of the VFD, FTD, and CFD.  This will likely be 
referred to in client facing communications as the LexisNexis Fraud Defense Network.

NOTE: For Field Names and Definitions see comment block at the bottom of this file.
*/

IMPORT Doxie, FraudPoint3, Risk_Indicators;

EXPORT Raw := MODULE
	
	// --------------------[ Layouts ]--------------------
	
	// Layouts in: by address
	
	EXPORT layout_in_byAddress := RECORD 
		STRING5  zip;
		STRING28 prim_name;
		STRING10 prim_range;
		STRING8  sec_range;
	END;

	EXPORT layout_in_byAddress_batch := RECORD 
		STRING30 acctno;
		STRING5  zip;
		STRING28 prim_name;
		STRING10 prim_range;
		STRING8  sec_range;
	END;

	// Layouts in: by email
	
	EXPORT layout_in_byEmail := RECORD 
		STRING50 email_address;
	END;

	EXPORT layout_in_byEmail_batch := RECORD 
		STRING30 acctno;
		STRING50 email_address;
	END;
	
	// Layouts in: by ip address
	
	EXPORT layout_in_byIP := RECORD 
		STRING50 ip_address;
	END;

	EXPORT layout_in_byIP_batch := RECORD 
		STRING30 acctno;
		STRING50 ip_address;
	END;
	
	// Layouts in: by name
	
	EXPORT layout_in_byName := RECORD 
		STRING20 lname;
		STRING20 fname;
		STRING20 mname;
	END;

	EXPORT layout_in_byName_batch := RECORD 
		STRING30 acctno;
		STRING20 lname;
		STRING20 fname;
		STRING20 mname;
	END;
	
	// Layouts in: by phone
	
	EXPORT layout_in_byPhone := RECORD 
		STRING10 phone10;
	END;

	EXPORT layout_in_byPhone_batch := RECORD 
		STRING30 acctno;
		STRING10 phone10;
	END;

	// Layouts in: by ssn
	
	EXPORT layout_in_bySSN := RECORD 
		STRING9 ssn;
	END;

	EXPORT layout_in_bySSN_batch := RECORD 
		STRING30 acctno;
		STRING9 ssn;
	END;
	
	// Layouts out:

	EXPORT layout_IFD := FraudPoint3.layout.base;
	
	EXPORT layout_IFD_batch := RECORD
		STRING30 acctno;
		layout_IFD;
	END;
	
	EXPORT layout_IFD_bocashell := RECORD
		UNSIGNED4 seq;
		layout_IFD;
	END;
	
	// --------------------[ Fetch by DID ]--------------------
	
	EXPORT get_IFD_recs_byDID( DATASET(Doxie.layout_references) dids ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					dids(did != 0), FraudPoint3.key_DID,
					KEYED(LEFT.did = RIGHT.s_did),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byDID_batch( DATASET(Doxie.layout_references_acctno) dids ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					dids(did != 0), FraudPoint3.key_DID,
					KEYED(LEFT.did = RIGHT.s_did),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT, 
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byDID_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep(did != 0), FraudPoint3.key_DID,
					KEYED(LEFT.did = RIGHT.s_did) AND
					(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT, 
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;
	
	// --------------------[ Fetch by Address ]--------------------
	
	EXPORT get_IFD_recs_byAddress( DATASET(layout_in_byAddress) addrs ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					addrs, FraudPoint3.Key_Address,
					KEYED( LEFT.zip = RIGHT.zip AND
						LEFT.prim_name = RIGHT.prim_name AND
						LEFT.prim_range = RIGHT.prim_range AND
						LEFT.sec_range = RIGHT.sec_range),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byAddress_batch( DATASET(layout_in_byAddress_batch) addrs ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					addrs, FraudPoint3.Key_Address,
					KEYED( LEFT.zip = RIGHT.zip AND
						LEFT.prim_name = RIGHT.prim_name AND
						LEFT.prim_range = RIGHT.prim_range AND
						LEFT.sec_range = RIGHT.sec_range),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byAddress_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep, FraudPoint3.Key_Address,
					KEYED( LEFT.z5 = RIGHT.zip AND
						LEFT.prim_name = RIGHT.prim_name AND
						LEFT.prim_range = RIGHT.prim_range AND
						LEFT.sec_range = RIGHT.sec_range) AND
						(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	// --------------------[ Fetch by Email ]--------------------
	
	EXPORT get_IFD_recs_byEmail( DATASET(layout_in_byEmail) emails ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					emails, FraudPoint3.Key_Email,
					KEYED( LEFT.email_address = RIGHT.Email_Address),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byEmail_batch( DATASET(layout_in_byEmail_batch) emails ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					emails, FraudPoint3.Key_Email,
					KEYED( LEFT.email_address = RIGHT.Email_Address),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byEmail_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep, FraudPoint3.Key_Email,
					KEYED( LEFT.email_address = RIGHT.Email_Address) AND
					(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;
		
	// --------------------[ Fetch by IP Address ]--------------------
	
	EXPORT get_IFD_recs_byIP( DATASET(layout_in_byIP) IPs ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					IPs, FraudPoint3.Key_IPaddress,
					KEYED( LEFT.ip_address = RIGHT.ip_address),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byIP_batch( DATASET(layout_in_byIP_batch) IPs ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					IPs, FraudPoint3.Key_IPaddress,
					KEYED( LEFT.ip_address = RIGHT.ip_address),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byIP_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep, FraudPoint3.Key_IPaddress,
					KEYED( LEFT.ip_address = RIGHT.ip_address) AND
					(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;
		
	// --------------------[ Fetch by Name ]--------------------
	
	EXPORT get_IFD_recs_byName( DATASET(layout_in_byName) names ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					names, FraudPoint3.Key_Name,
					KEYED( LEFT.lname = RIGHT.lname AND
						LEFT.fname = RIGHT.fname AND 
						(LEFT.mname = '' OR LEFT.mname[1] = RIGHT.mname[1]) ),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byName_batch( DATASET(layout_in_byName_batch) names ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					names, FraudPoint3.Key_Name,
					KEYED( LEFT.lname = RIGHT.lname AND
						LEFT.fname = RIGHT.fname AND 
						(LEFT.mname = '' OR LEFT.mname[1] = RIGHT.mname[1]) ),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byName_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep, FraudPoint3.Key_Name,
					KEYED( LEFT.lname = RIGHT.lname AND
						LEFT.fname = RIGHT.fname AND 
						(LEFT.mname = '' OR LEFT.mname[1] = RIGHT.mname[1]) ) AND
						(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;
		
	// --------------------[ Fetch by Phone ]--------------------
	
	EXPORT get_IFD_recs_byPhone( DATASET(layout_in_byPhone) phones ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					phones, FraudPoint3.Key_Phone,
					KEYED( LEFT.phone10 = RIGHT.phone_number),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byPhone_batch( DATASET(layout_in_byPhone_batch) phones ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					phones, FraudPoint3.Key_Phone,
					KEYED( LEFT.phone10 = RIGHT.phone_number),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_byPhone_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep, FraudPoint3.Key_Phone,
					KEYED( LEFT.phone10 = RIGHT.phone_number) AND
					(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;
				
	// --------------------[ Fetch by SSN ]--------------------
	
	EXPORT get_IFD_recs_bySSN( DATASET(layout_in_bySSN) SSNs ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					SSNs, FraudPoint3.Key_SSN,
					KEYED( LEFT.ssn = RIGHT.ssn),
					TRANSFORM( layout_IFD,
						SELF := RIGHT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_bySSN_batch( DATASET(layout_in_bySSN_batch) SSNs ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					SSNs, FraudPoint3.Key_SSN,
					KEYED( LEFT.ssn = RIGHT.ssn),
					TRANSFORM( layout_IFD_batch,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;

	EXPORT get_IFD_recs_bySSN_bocashell( GROUPED DATASET(Risk_Indicators.Layout_Input) iid_prep ) :=
		FUNCTION
			IFD_recs_raw := 
				JOIN(
					iid_prep, FraudPoint3.Key_SSN,
					KEYED( LEFT.ssn = RIGHT.ssn) AND
					(((UNSIGNED3)RIGHT.date_application) DIV 100 < LEFT.historydate OR LEFT.historydate IN [0,999999]),
					TRANSFORM( layout_IFD_bocashell,
						SELF := RIGHT,
						SELF := LEFT
					),
					ATMOST(1000)
				);
			
			IFD_recs_raw_ddpd := DEDUP(IFD_recs_raw, RECORD, ALL);
			
			RETURN IFD_recs_raw_ddpd;
		END;
				
END;

// Field names and definitions...:

/*                             Required
Data Field                      (Y/N)   Description
================================================================
Customer ID                       Y    Customer ID/Billgroup
Vendor ID                         N    Different Orbit IDs per CFD vendor. Same Orbit ID for all TFD
Appended LexID                    Y    LexisNexis appended LexID
Date Fraud Reported to LexisNexis Y    Date Fraud Reported to LexisNexis
First Name                        Y    First Name of Applicant
Middle Name                       N    Middle Name of Applicant
Last Name                         Y    Last Name of Applicant
Suffix                            N    Suffix of Applicant
Street Address                    N    Street Address of Applicant
City                              Y    City of Applicant
State                             Y    State of Applicant
Zip Code                          Y    5 Digit Zip Code of Applicant
Phone Number                      N    10 Digit Full Phone Number of Applicant
Social Security Number            N    Social Security Number of Applicant
Date of Birth                     N    Date of Birth of Applicant
Driver's License Number           N    Driver's License Number of Applicant
Driver's License State            N    Driver's License State of Applicant
IP Address                        N    IP Address originating from Applicant
Email Address                     N    Email Address of Applicant
Device Identification             N    Device Identification Number originating from the submitted Application (Internet channel applicability)
Device identification Provider    N    Provider of device identification technology (1=iovation, 2=41st Parameter, 3=ThreadMetrix, 4=Kount, 5=Other)
Origination Channel               N    Channel (1=Mail, 2=Point Of Sale, 3=Kiosk, 4=Internet, 5=Branch, 6=Telephonic, 7=Mobile, 8=Other)
Income                            N    Income of Applicant
Own or Rent                       N    Indicator if subject owns or rents home (Own | Rent)
Location Identifier               N    Physical Address of Applicant
Other Application Identifier      N    Other unique identifierÂ  used to identifyÂ  the Applicant
Other Application Identifier2     N    Other unique identifier-2 used to identifyÂ  the Applicant
Other Application Identifier3     N    Other unique identifier-3 used to identifyÂ  the Applicant
Date of Application               Y    Application Submission Date (MM/DD/YYYY)
Time of Application               N    Application Hour and Minute submitted time of day (HH:MM) AM/PM
Application ID                    N    Application identifier used by organization to track application submission
FraudPoint Score                  N    3 Digit FraudPoint Score returned on Applicant from LexisNexis
Date Fraud Detected               N    Date fraud Detected
Financial Loss                    N    Did a financial/monetary loss occur resulting from the fraudulent event (1=Yes, 2=No)
Gross Fraud Dollar Loss           N    Gross Fraud Dollar Loss before any charge-back or restitution
Application Fraud                 N    Specify if this event was classified as Application fraud (1=Yes, 2=No)
Primary Fraud Code                N    Other code used by organization to classify fraud type 
Secondary Fraud Code              N    Other code used by organization to classify fraud type
Source Identifier                 Y    Identify the reported fraud source, Contributory Fraud Data (CFD) or Test Fraud Data (TFD)
Industry                          N    Vertical Market of billgroup
Fraud Index Type                  N    Index Type (1=Synthetic, 2=Stolen, 3=Manipulated, 4=Vulnerable Victim, 5=Friendly Fraud, 6=Suspicious Activity, 7=Other)
*/