EXPORT _documentation := 'product documentation';
/*
		                    Identity Based Government Collections Batch
		                               Product Requirements

		Prepared by: Cindy Loizzo 
		Version: 1.5
		Date: May 9, 2013

		Requirement Descriptions:

		Req. 4.1.1

		The requirements for this project are to create an ECL/Plug-in Batch Service for 
		offline batch processing requests which will be named the Identity Based Government 
		Collections batch.

		Req. 4.1.2 (see: Govt_Collections_Services.Records)

		The minimum input requirements for the Identity Based Government Collections batch 
		include the following combination: 

			o   Last Name, First Name or Initial, Street Address 1, City and State or Zip

		The Identity Based Government Collections batch will allow users to input the 
		following optional fields: 
			o   Client id
			o   Social Security Number (9-digits or last 4 digits)
			o   Middle Name or Middle Initial
			o   Street Address 2
			o   Date of Birth
			o   Additional Filler Fields

		Cleaning of the SSN and DOB (to remove hyphens) is handled in the KTR before sending 
		to ECL/Plug-in.  Additional filler fields are not used in processing but are returned 
		in output.

		Additionally:

		If the minimum requirements (Last Name, First Name or Initial, Street Address 1, City and 
		State or Zip) are not present in a particular input record then the query should fail that 
		record.  In such case, yes, the query should output an "Unprocessable" field with value of 
		"Insufficient data to process."  Also, such record should output to the Rejected Records file.  
		Additionally, when a record with invalid or uncleanable data outputs to the Rejected Records 
		file, the "Unprocessable" field should populate with value of "Unmatchable data."

		Req. 4.1.3 (see: Govt_Collections_Services.Layouts)

		Input layout for Identity Based Government Collections batch requests will include 
		the following allowable input fields with the expectation that the customer will 
		provide the minimum data necessary for processing: 
			o   Client id number
			o   Provided by client as a key for appending matches; will not be used for searching 
		and will be provided on output.  If client does not provide a client id, input records 
		will be numbered beginning with one and counting up through last record provided.  
		(Example 1, 2, 3, ... 4500)
			o   First Name or Initial
			o   Middle Name or Initial
			o   Last Name 
			o   Street Address 1 (Including house number, directional(s), and possibly suite/apt 
		numbers. Example:  123 Main Street)
			o   Street Address 2 (Will allow users to map secondary field when items such suite/apt 
		numbers are in a different field. Example:  Apt B)
			o   City:  example: Boca Raton 
			o   State:  example:  FL
			o   Zip:  example:  33458 
			o   Postal code:  0301 
			o   SSN (9 digits)
			o   9-digit social security number; may be provided with or without punctuation such 
		as hyphens, spaces, etc.  All punctuation will be removed prior to searching, leaving 
		only numeric characters remaining.  Social security numbers containing only the last 4 
		digits will also be accepted.  (Examples:  999-99-9999 OR 999 99 9999 OR 999999999 OR 
		9999)
			o   Date of Birth
			o   May be provided with or without punctuation such as hyphens, spaces, etc.  All 
		punctuation will be removed prior to searching, leaving only numeric characters 
		remaining. (Examples:  01/01/1976, 01-01-1976, 01011976)
			o   Filler/Non-Applicable 
			o   Multiple fillers are acceptable

		Req. 4.1.4 (not applicable for ECL)

		The product will supported the following input formats:
			o   Comma-delimited
			o   Tab-delimited
			o   ASCII Fixed Format

		Req. 4.1.5 (not applicable for ECL)

		The product will support the following output formats:
			o   Comma-delimited
			o   Tab-delimited
			o   ASCII Fixed Format

		Req. 4.1.6 (see: Govt_Collections_Services.Records)

		The Identity Based Government Collections batch will require several processes to be 
		run to produce the output.  This includes use of the following services:  Address 
		Cleaner, Name Cleaner, Best Address, SSNExpansion, ADL_Best, Drivers, OUSSN, AKA, 
		AC Deceased, and Phones Plus.  There will be no use of gateways or use of royalty-
		based sources.

		Req. 4.1.7 (not applicable for ECL ???)

		Step 1:  All components of the input address will be processed through the Address 
		Cleaner for standardization.  This is handled in the KTR.  When address is provided 
		on input as one string, the address will be parsed out.  The cleaned address will 
		be used in the processes detailed in the below requirements.  Records with un-cleanable 
		or invalid address data will continue processing with the below steps, as long as there 
		is enough unique identity components to continue processing.

		Req. 4.1.8 (not applicable for ECL ???)

		Step 2:  All components of input name will be processed through the Name Cleaner for 
		standardization.  When name is provided on input with digits or symbols, those will be 
		stripped out.  The cleaned name will be used in the processes detailed in the below 
		requirements.  The short name/nickname table will be utilized in processing each 
		component piece of this batch.  Records with un-cleanable/invalid name data will 
		continue processing with the below steps, as long as there is enough unique identity 
		components to continue processing.  Records with un-cleanable/invalid address and name 
		data will go in the Rejected Records file.

		Req. 4.1.9 (see: Govt_Collections_Services.fn_getBestAddressRecs)

		Step 3:  All components of the cleaned input address and cleaned input name will be 
		processed through the Best_Address batch service.  If a full SSN is provided on input, 
		then that will also be processed through Best_Address along with the cleaned input 
		address and cleaned input name. 

		The subjects full address history will be checked looking for a match to the input 
		address by setting the "HistoricMatchCode" option in Best Address service to "True."  
		Also, the "IncludeBlankDateLastSeen" option will be enabled.  The Best Address will be 
		returned in the output.  If more than one Best Address is found, then the one with the 
		most recent last seen date will be returned in the output.

		If output state doesn't equal input state ("CO" for example), return "OS" in output 
		field to represent "address outside home state" and return Best Address. Also return 
		Best Address even if it is within the state, so long as it does not match Input Address. 
		If no state is provided by the customer then this field should be left blank.  Return 
		the "OS" indicator only if the Best Address does not equal the Input State.  Note for 
		Engineering:  The comparison to determine "OS" will not look at the input address state; 
		it will look at the Input State variable and compare to the Best Address <State> 
		field.  The Input State variable will consist of the two letter state abbreviation of 
		the state agency submitting the file and not the state on the input address.  This 
		could be handled in the Plug-in/KTR via a Client State field that when populated would 
		be sent in the XML string to the query along with top level values like GLBA/DPPA 
		permissible uses.  The field would accept null/blank value in case of federal customer 
		(not state-specific).

		If output state does equal input state, return "IS" in output field to represent 
		"address inside of home state" and return Best Address.  If no state is provided by the 
		customer then this field should be left blank.  Return the "IS" indicator only if the 
		Best Address does equal the Input State.  The above note for Engineering about 
		comparison to determine "IS" also applies here.

		Req. 4.1.10 (see: Govt_Collections_Services.fn_getExpandedSSNRecs)

		Step 4:  Any Input SSNs with only the last 4 digits provided will be processed 
		through SSNExpansion (PhilipMorris.SSNExpansionService) and the expanded SSN will be 
		returned in the output.  The expanded SSN will also be used in processing for steps 5, 
		6, 7, and 9.

		Req. 4.1.11 (see: Govt_Collections_Services.fn_getBestADLRecs)

		Step 5:  All components of the cleaned input address, cleaned input name, and input 
		SSN or expanded SSN from step 4 (if only last 4 digits of SSN provided on input) will 
		be processed through ADL_Best (DidVille.DID_Batch_Service_Raw).  The LexID, Best SSN, 
		and Best Name fields will be returned in the output.  The LexID will be used in 
		processing for step 8.  The Best SSN will be used in processing for steps 6, 7, and 9.

		Req. 4.1.12 (see: Govt_Collections_Services.fn_getDriversLicenseRecs)

		Step 6:  All components of the cleaned input address, cleaned input name, and input 
		SSN or expanded SSN from step 4 (if only last 4 digits of SSN provided on input) or 
		Best SSN from step 5 (if there was no input SSN) will be processed through Drivers 
		(DriversV2_Services_Batch_ServiceRequest).  This serves as a second verification 
		method after Best_Address to account for instances where someone has an address in 
		more than one state.  

		Both Gov and non-Gov sources will be accessed.  Therefore, the IncludeNonDMVSources 
		option must be enabled.  Also, the "Return_Current_Only?" option will be set to True.

		The DL record (if available) for the subject will be checked and if the DL Expiration 
		Date is > todays date, then the DL Address will be checked.  If the DL Address is 
		different than the Best Address, then the DL Address fields will be returned in the 
		output.

		Req. 4.1.13 (see: Govt_Collections_Services.fn_getOthersUsingSSNRecs)

		Step 7:  All components of the cleaned input address, cleaned input name, and input 
		SSN or expanded SSN from step 4 (if only last 4 digits of SSN provided on input) or 
		Best SSN from step 5 (if there was no input SSN) will be processed through OUSSN 
		(BatchServices_OthersUsingSSN_BatchService).  If the OUSSN count is >/= 4 for the 
		Best SSN, then the Best SSN will not be returned in the output.  If the OUSSN count 
		is >/= 4 for the input SSN or expanded SSN, then the Best SSN will still be returned 
		in the output.  A "Possible Shared SSN" field will be returned in the output with 
		value of Y if OUSSN count is >/= 4 and value of N if OUSSN count is = 0.

		Req. 4.1.14 (see: Govt_Collections_Services.fn_getAKARecs)

		Step 8:  For records where there is no name match found in step 5 (ADL_Best), the 
		LexID will be processed through AKA (BatchServices.AKA_BatchService) to search for 
		aliases.  Up to five AKAs will be returned in the output.  The name mismatch pertains 
		to First Name and Last Name of the Input Name and Best Name.  If the Input/Best Names 
		do not match 100%, then the AKA service will be accessed.

		Req. 4.1.15 (see: Govt_Collections_Services.fn_getDeceasedRecs)

		Step 9:  All components of the cleaned input address and cleaned input name along with 
		input SSN or expanded SSN from step 4 (if only last 4 digits of SSN provided on input) 
		or Best SSN from step 5 (if there was no input SSN) will be processed through AC 
		Deceased (BatchServices.Death_BatchService) to look for a match for the subject.  If 
		a DOD exists for a subject, then a Deceased Indicator with value of Y along with the 
		Date of Death, County of Death, and matchcode fields will return in output.  Also, a 
		Confidence Score of 11 will be assigned for that subjects record and that record will 
		output in the Deceased Identities file.

		[ *** This below is a completely separate requirement. *** ] 

		( TODO )

		Customers will have the option to select any of the below matchcode(s) based on their 
		business needs.
			a. ANSZC
			b. ANSZ
			c. ANSC
			d. ANS
			e. SNCZ
			f. SNC
			g. SNZ
			h. SN
			i. FNS (new)
			j. LNS (new)
			k. FILNS (new)
			l. FNLIS (new)

		Notes:
			o   The codes represent each of the following: A = Address; N = Name; S = SSN; 
		Z = Zip; C = City; FI = First Initial; LI = Last Initial.
			o   The four new matchcodes are requested as additional options for this service 
		under CJR 9093.

		Req. 4.1.16 (see: Govt_Collections_Services.fn_getPhoneRecs)

		Step 10:  All components of the cleaned input address and cleaned input name will 
		be processed through Phones Plus (progressive_phone.progressive_phone_batch_service).  
		Up to five phone numbers will be returned in the output.  The below options will need 
		to be set as follows:
			o   MaxPhoneCount:  5
			o   CountType6_Pp_PHONESPLUSSEARCH:  5
			o   OrderType6_Pp_PHONESPLUSSEARCH:  1

		Req. 4.1.17 ( TODO )

		Step 11: Depending on the outcome of steps 3, 4, 5, and 9, a Confidence Score will be assigned 
		to indicate how the input data matched or did not match.  As applicable, one of the below 
		Confidence Score and Confidence Description values will be returned in the output.  If a record 
		scores 14 (Deceased) and any other confidence score, the score of 14 will override all other scores.

			o   1 = All input data match
			o   2 = SSN/FN + LN match + exact city/state + partial house/street match
			o   3 = SSN/FN + LN match + exact house/street match + different city/state
			o   4 = SSN/FN + LN match + no street/city/state + zip match
			o   5 = SSN/FN + LN match + no street/city/state/zip match
			o   6 = SSN match + street/city/state + zip match + partial name match (FN or LN match)
			o   7 = SSN/LN match + no FN match + no street/city/zip match + state match
			o   8 = SSN/FN match + no LN match + no street/city/state/zip match
			o   9 = FN + LN match + street/city/state + zip match + last 4 digits of input SSN match
			o   10 = FN + LN match + street/city/state + zip match + no SSN match
			o   11 = FN + LN match + street/city/state + zip match + no input SSN
			o   12 = SSN match + street/city/state + zip match + no FN + LN match
			o   13 = SSN match + no street/city/state + zip match + no FN + LN match
			o   14 = Deceased
			o   15 = Unresolved (no input data matched)

		Notes:
			o   For score 9, SSNExpansionService will be used to append full SSN.
			o   For scores 10 & 11, ADL_Best will be used to append Best_ SSN found in step 5 in 
			    requirement 4.1.11.
			o   Records with scores 1-13 will output to the Resolved Identities file.
			o   Records with score 14 will output to the Deceased Identities file.
			o   Records with score 15 will output to the Unresolved Identities file.

		Req. 4.1.18 (not applicable for ECL)

		A statistics file will be created to reflect the information found during processing 
		and will be returned as a text file along with output files to the customer.  Also, 
		the statistics text file will be available in the Batch Monitoring tool so that it 
		can be downloaded as needed for analysis by Product Management.  The statistics will 
		include:
			o   Account Name: (Accurint account name)
			o   Account Number: (Accurint account number)
			o   Name of Job Provided by Client: (name of file provided by the client)
			o   Process Date of File: (date and time file was processed)
			o   Total Number of Input Records: (total count of records within input file)
			o   Total Number of  Output Records: (total count of records within output files)
			o   Total Number of Records where Address outside of home state: (total count of 
		records where Best Addr state differs from input state)
			o   Total Number of Records where Address inside of home state: (total count of 
		records where Best Addr state is same as input state)
			o   Total Number of Records Deceased: (total count of records where Deceased 
		Indicator = Y)
			o   Total Number of Rejected Records: (where all input data was invalid and could 
		not be processed)

		Req. 4.1.19 (see: Govt_Collections_Services.Batch_Service)

		The user and system must comply with Permitted Use Certification, GLBA, and DPPA 
		compliance requirements for this batch including necessary masking of SPII data.

		Req. 4.2.1 (see: Govt_Collections_Services.Layouts)

		Output data will be appended to the input data and include the below fields.  The 
		fields will be configurable per customer so that any output fields the customer does 
		not want returned can be suppressed in the output.
			o   Confidence Score (potential values of 1-12)
			o   Confidence Score Description
			o   Best_fname
			o   Best_lname
			o   Possibly Shared SSN (potential values of Y,  or null string)
			o   HRI_code (MI)
			o   HRI_desc (Multiple identities associated with input social)
			o   AKA 1
			o   AKA 2
			o   AKA 3
			o   Best_addr1
			o   Best_city
			o   Best_state
			o   Best_zip
			o   Address in/out of home state (potential values of IS or OS)
			o   Date_last_seen (Best Address date last seen in YYYYMMDD format)
			o   InputAddrDate (Input Address date last seen in YYYYMMDD format)
			o   Best_SSN
			o   Expanded_SSN
			o   Phone Number 1
			o   Phone Number 2
			o   Phone Number 3
			o   LexID
			o   Deceased Indicator (value of Y if DOD exists for subject)
			o   Date of Death (YYYYMMDD format)
			o   County of Death
			o   Deceased_matchcode
			o   DL addr1
			o   DL city
			o   DL st
			o   DL zip
			o   DL expiration date (YYYYMMDD format)

Requirements for new version are available here:
https://teamsites.rs.lexisnexis.net/sites/engprjmgmt/1010054731/Shared%20Document/A.Requirements%20and%20UI%20Specifications/Identity%20Contact%20Resolution%20Batch%20Enhancements_Rqmts_v1.7.docx


		ADDENDUM Prepared by: Karl Engvold
		Date: October 11, 2017
    Reference: JIRA RR-11653 ( https://jira.rsi.lexisnexis.com/browse/RR-11653 )
               Identity Contact Resolution in XML - Add interface to Govt_Collections_Services

    Per business requirements, a Report Service interface has been implemented whereby this service will
    perform the same query as in a batch, obtaining the query parameters through the common ESP interface
    and returning the data, using standard template record formats, out through a standard ESP results
    record. The following options, features and premeises:

      o ICR (Identity Contact Resollution) is the name determined by business requirements to name
        these services, wherein the Governement Collection Services is a subset of said service name.

      o Only one row shall be processed in this service query, unlike the batch service.

      o UniqueID (LexID, DID) is an allowed query field in this interface; which is translated into 
        an SSN and passed into the batch

      o All results will be similar to that of the batch services whereby the implementation of
        the Report Services will call into the same subset of attributes and functions developed for
        batch service. Therein, when any changes are made to core components and functions, then
        they will be reflected in both the batch and reports services accordingly.

*/