EXPORT Layout_raw_okc_mortgage := RECORD

string1	Record_Type;  // S=SAM, L = Mortgage, D= re-recorded SAM,  N= re-recorded modification M=Copied out of concurrent deed record
string18	County_Name;  //Actual County Name.  No Abbreviations.  May also be Independent City Name.
string2	State;  //Two letter standard postal abbreviation.
string5	FIPS_Code;  //(1st 2 positions = State, last 3 = County)
string8	Recording_Date_MMDDYYYY;  //The official date of the document recordation.
string10	Book_Number_TD;  //In addition to assigning a Document number, many counties also assign a Book and
string10	Page_Number_TD;  //See explanation for Recorderâ€™s Book Number above.
string20	Document_Number_TD;  //A sequential number assigned to documents at the time of recording for identific
string45	APN_Number;  // Whenever possible, attempt to enter the APN in the format used by the County Assessor as provided
string40	no_1_Borrower_FName_MName;  //Key the first name and middle name (when present) without abbreviations, or firs
string40	no_1_Borrower_LName_or_Corp_Name;  //If the last name is composed of two names enter both in the sequence they appear
string2	no_1_Borrower_ID_Code;  //Identifies the nature of each borrower (grantor) keyed from the mortgage.  The v
string40	no_2_Borrower_FName_MName;  //See definition for #1 Borrower Name â€“ Field #10.
string40	no_2_Borrower_LName_or_Corp_Name;  //See definition for #1 Borrower Name â€“ Field #11.
string2	no_2_Borrower_ID_Code;  //See definition for #1 Borrower ID Code â€“ Field #12.
string2	Borrower_Vesting_Code;  //The vesting code, when present, indicates how the Borrower(s) took title to the 
string10	Legal_Lot_Number_s;  //The individual lot(s) which comprise the property.  The actual lot number(s) suc
string7	Legal_Block;  //The block of the subdivision or city in which the property is located.
string7	Legal_Section;  //The section of the city in which the property is located.  Not the same as the â€œ
string7	Legal_District;  //The district in which the property is located.  Usually a numeric code correspon
string7	Legal_Land_Lot;  //A large portion or tract of land (which may also encompass many individual block
string6	Legal_Unit;  //The subdivision unit number.  Common for condominiums, townhomes, etc.   Not alw
string30	Legal_City_Muni_Township;  //Enter â€œUnincorporatedâ€, if applicable.  Often a description of the code provided
string50	Legal_Subdivision_Name;  //The name of the subdivision, plat, or tract in which the property is located.  F
string7	Legal_Phase_Number;  //Generally, the phase of a subdivision or tract development.
string10	Legal_Tract_Number;  //The number of the tract in which the property is located.  Follow by â€œPORâ€ (port
string100	Legal_Brief_Description;  //List exceptions, when only a portion of Block, Lot, Tract or Subdivision is ente
string30	Legal_Sec_Twn_Rng_Mer;  //
string60	Propert_Street_Address;  //Keyers have the option to key the Property Address as reported on the document â€“
string6	Property_Unit_Number;  //Unit, Room or Suite number.  Often used to identify condo or apartment units. Ma
string30	Property_City_Name;  //City name where the property is located.  As it appears on the document.  DO NOT
string2	Property_State;  //Two-letter standard postal abbreviation â€“ See Field #4.
string5	Property_Zip;  //May be obtained from mailing address for owner-occupied properties.
string4	Property_Zip_4;  //Four-digit extension to postal zip code for the property address.  Not always av
string3	Property_Use_Code;  //As indicated on the mortgage or attached rider.
string40	Lender_Name_Beneficiary;  //Name of the beneficiary on the mortgage.
string6	Lender_Name_ID;  //A unique numeric code assigned to each identified lender based on the Standardiz
string1	Lender_Type_Code;  //Describes Lender as follows:
string9	Loan_Amount;  //Reported in whole dollars only, no commas (,).  Do not calculate when loan made 
string1	SAM_or_LAN1_Loan_Type;  //Indicates the type of loan, if able to determine from the recorded document.  Se
string4	Type_Financing;  //Indicates the type of interest rate terms for the mortgage, when available. 
string4	Interest_Rate_99v99;  //
string8	TD_Due_Date_MMDDYYYY;  //When available, the date the mortgage will be paid in full.  
string8	Data_Entry_Date_MMDDYYYY;  //
string4	Data_Entry_Operator_Code;  //
string15	Adj_Rate_Index;  //Identifies the type of index the adjustable loan is tied to.  The valid codes ar
string2	Rate_Change_Freq;  //Identifies the frequency the interest rates may change.  The valid codes are:
string1	Adjustable_Rate_Rider;  //Indicates whether an Adjustable Rate Rider is recorded concurrent to the mortgag
string1	Graduated_Payment_Rider;  //
string1	Balloon_Rider;  //Indicates whether a Balloon Rider is recorded concurrent to the mortgage.
string1	Fixed_Step_Rate_Rider;  //Indicates whether a Fixed/Step (Conversion) Rate Rider is recorded concurrent to
string1	Condominium_Rider;  //Indicates whether a Condominium Rider is recorded concurrent to the mortgage.
string1	Planned_Unit_Development_Rider;  //Indicates whether Planned Unit Development Rider is recorded concurrent to the m
string1	Rate_Improvement_Rider;  //Indicates whether a Rate Improvement Rider is recorded concurrent to the mortgag
string1	Assumability_Rider;  //Indicates whether an Assumability Rider is recorded concurrent to the mortgage.
string1	Prepayment_Rider;  //Indicates whether a Prepayment Rider is recorded concurrent to the mortgage.
string1	one2four_Family_Rider;  //Indicates whether a 1-4 Family Rider is recorded concurrent to the mortgage.
string1	Bi_Weekly_Payment_Rider;  //Indicates whether a Biweekly Payment Rider is recorded concurrent to the mortgag
string1	Second_Home_Rider;  //Indicates whether a Second Home Rider is recorded concurrent to the mortgage.
string4	Change_Index_99v99;  //identifies the margin (expressed as a percentage) that is added by the Lender to
string8	Arm_Reset_Date;  //
string107	Filler1;  //
string8	Contract_Date;  //The date that the document was executed by the parties.  Pre-dates the recording
string28	Title_Company_Name;  //Name of the Title Company which issued the certificate of title insurance.  Not 
string138	Filler2;  //
string5	Lender_Mail_Zip_Code;  //For explanation _ format of Unit, City, State, Zip _ Zip +4 address components, 
string4	Filler;  //
string3	Loan_Term_Months;  //Term of the Loan expressed in Months (i.e. 360 months).  Do NOT calculate to pop
string2	Loan_Term_Years;  //Term of the Loan expressed in Years (i.e. 30 years).  Do NOT calculate to popula
string20	Loan_Number;  //Unique Number assigned to Loan.  Format varies.  If loan number does not appear 
string32	Filler_except_Hawaii_TN;  //
string2	Document_Type_Code;  //SAM or modified or re-recorded SAM or re-recorded modified SAM
string1	Borrower_Name_Addendum;  //Indicates that an addendum record was created to key multiple borrower names exc
string2	Legal_Lot_Code_Complete_Legal_Desc;  //If a portion of a lot is transferred: P/MP or â€¦
string20	Recorders_Map_Reference;  //Standardize and identify each portion with the corresponding heading as shown be
string14	Filler3;  //
string1	Record_ID;  // Identifies the mortgage records as follows:
string41	Tax_Account_Number;  // The Account# assigned by the Tax Collector in a given jurisdiction when differe
string6	First_Change_Date_Conversion_Rider;  //The date (â€œfirst change dateâ€) the mortgage will switch from a fixed to an adjus
string2	Prepayment_Term_Penalty_Rider;  //The number of months that the mortgage must remain active if the borrower is to 
string4	first_Change_Date_Interest_Rate_Not_Greater_Than_99;  //The maximum interest rate allowed on the first Change Date (date when loan switc
string4	first_Change_Date_Interest_Rate_Not_Less_Than_99;  //The minimum interest rate allowed on the first Change Date (date when loan switc
string4	Maximum_Interest_Rate_99;  //The maximum interest rate allowed for the loan.  Format: 99v99 (2-position impli
string2	Reserved1;  //
string2	Interest_Only_Flag;  //If available, the actual Interest-Only period (expressed in years).   Otherwise,
string3	Reserved2;  //
string3	Vendor_Source_Code;  //For internal reference only.


END;