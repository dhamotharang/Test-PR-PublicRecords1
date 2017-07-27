export Layout_InfutorCID := 
record, maxlength(8000)
    string orig_Phone;
    string orig_PhoneType;
    string orig_DirectIndial; 
    string orig_RecordType;
    string orig_FirstDate;
    string orig_LastDate;
    string orig_TelcoName;
    string orig_BusinessName;
    string orig_FirstName;
    string orig_Mi;
    string orig_Lastname;
    string orig_PrimaryHouseNumber;
    string orig_PrimaryPreDirAbbrev;
    string orig_PrimaryStreetName;
    string orig_PrimaryStreetType;
    string orig_PrimaryPostDirAbbrev;
    string orig_SecondaryAptType;
    string orig_SecondaryAptNbr;
    string orig_City;
    string orig_State;
    string orig_Zip;
    string orig_Zip4;
    string orig_DPBC;
    string orig_CRTE;
    string orig_CNTY;
    string orig_Z4Type;
    string orig_DPV;
    string orig_MailDeliverabilityCode;
    string orig_AddressValidationDate;
    string orig_Filler1;
    string orig_DirectoryAssistanceFlag;
    string orig_TelephoneConfidenceScore;

end;

/*
							
INFUTOR - Enhanced TNR (Telephone Number Resource) file Layout							

	Format:  Ascii Tab Delimited						
							
Field #.	Field Name	Length	Field Description				
1	Phone	10	Telephone Number				
2	Phone Type	1	Probable Phone Type				
				L - Land Line			
				V - VOIP			
				W - Wireless			
				O - Other			
3	DID	1	Direct Indail Number = "Y" or Blank				
4	Record Type	1	Record Type				
				R - Residential			
				B - Business			
				P - Payphone			
				U - Unknown			
5	FirstDate	10	Date Records First Received (YYYYMMDD)				
6	LastDate	10	Date Records Last Received as Connect (YYYYMMDD)				
7	TelcoName	50	Name of Original Telco Provider				
8	Business Name	100	Business Name ( for Rectype B,P,U)				
9	First Name	15	Given Name ( For Rectype = "R" only)				
10	Mi	1	Middle Initial				
11	Last name	20	Surname				
12	Primary House Number	10	Physical Street Number or PO Box ###, or RR Box ###, or HC Box ### (number only )				
13	Primary PreDir Abbrev	2	Physical Street Pre Direction: N, S, E, W, NE, SW, etc.				
14	Primary Street Name	28	Physical Street Name or PO Box name, or RR ### Box name, or  HC ### Box name				
15	Primary Street Type	4	Physical Street Suffix:  ST, AVE, PL, BLVD, PKWY, etc.				
16	Primary PostDir Abbrev	2	Physical Street Post Direction: N, S, E, W, NE, etc.				
17	Secondary AptType	4	Unit Designator: :  Apt or  Suite				
18	Secondary AptNbr	8	Unit Number:  Apt. # or  Suite #				
19	City	28	USPS City Name				
20	State	2	USPS State Abbriviation				
21	Zip	4	Zip Code				
22	Zip+4	4	Four-Position numeric ZIP+4, ZIP Code extension				
23	DPC	3	Delivery Point Code with Check Digit				
24	CRTE	4	Carrier Route				
25	CNTY	3	County Code				
26	Z4 Type	1	USPS Zip+4 Type				
				F - Firm or company address			
				G - General delivery address			
				H - High-rise or business complex			
				P - PO Box address			
				R - Rural route address			
				S - Street or residential address			
				Blank - Unknown			
27	DPV	1	Delivery Point Validation				
				Y - Address DPV confirmed for both primary and (if present) secondary numbers			
				D - Address DPV confirmed for the primary number only, and secondary number          information was missing			
				S - Address DPV confirmed for the primary number only, and secondary number information was present but unconfirmed			
				N - Both Primary and (if present) Secondary number information failed to DPV Confirm			
				Blank - Address not presented to hash table.			
28	Mail Deliverability Code	1	"Y" or "N" or blank				
29	Address Validation Date	8	Last Address Validation Date  (YYYYMMDD)				
30	Filler 1	2	Internal Use				
31	Directory Assistance Flag	1	"Y" = record as it appears on Directory Assistance; "D" = Delisted/Disconnected 				
32	Telephone Confidence Score	5	1; 2; 3; 4; 5 scores.  1 been highest confidence score and 5 been lowest. 				
							
							

	Note: The data in this Infutor Product reflects the most accurate information where available 						
	then if falls back on the NPA,NXX and, where applicable, Thousands-Block assignments.						
	Telco Companies specify the use of these NXX and blocks relative to their expected assigned use to new customers.						
	However, due to portability of telephone numbers among service providers in many areas of the NANP,						
	accuracy of a specific ten-digit telephone number correlating to the use designation indicated in this product, 						
	although very high, cannot be 100% ensured.						

							
	The information in this document may not be altered, changed, or recreated without written consent of Infutor Data Solutions Inc.						
							
*/