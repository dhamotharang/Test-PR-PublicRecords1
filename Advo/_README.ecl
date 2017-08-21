/*
//home/shared/data factory/vendor documentation by source/Valassis/Computerized Delivery Sequence (ADVO) -Valassis ADVO ELF Layout V8 14 0908.xls

REVISION	V8.14	This is Valassis Confidential Information supplied to you for use only within your own company.  This data is not for distribution without express written approval from Valassis.   Â©2009 Valassis, Inc.					
Field# / Seq#	Modification	Field Description	Field Type	Field Start	Field End	Data Length	Comments
1	Same	ZIP	Varchar2	1	5	5	ZIP Code for this address
2	Same	Route Num	Varchar2	6	9	4	Carrier Route for this address
3	Same	ZIP4	Varchar2	10	13	4	ZIP+4 for this address, For Simplified addresses the Zip+4 values are Empty/Blank
4	Same	WALK.Sequence	Number	14	22	9	Walk Sequence number The walk sequence will have a maximum number of 9 digits but will not consistently be 9 digits.  Typically the first address starts with 10000 next 20000, etc.  This enables Valassis to insert an address between two addresses.  You will see some addresses with a walk sequence number of 1,2,3, 10000, 20000, 30000
5	Same	STREET.NUM	Varchar2	23	32	10	Street address number. 
6	Same	STREET.PRE.DIRectional	Varchar2	33	34	2	Directional if it falls before the street name e.g. S 73rd Street
7	Same	STREET.NAME	Varchar2	35	62	28	Street name for address (will include suffixes/prefixes only if non-standard)
8	Same	STREET.POST.DIRectional	Varchar2	63	64	2	Directional if it falls after the street name e .g. 73rd Street S
9	Same	STREET.SUFFIX	Varchar2	65	68	4	E.g. St - Street, Dr - Drive, Rd - Road, Ln - Lane
10	Same	Secondary Unit Designator	Varchar2	69	72	4	Secondary Unit Designator (SUD). 
11	Same	Secondary Unit Number	Varchar2	73	80	8	Secondary Unit number (SUN). 
12	Same	Address Vacancy Indicator	Varchar2	81	81	1	Indicator of Y=vacancy and N = active delivery.  
13	Same	Throw Back Indicator	Varchar2	82	82	1	"Indicator of Y= yes, it is a throwback or N = no, it is not a throwback and it is an active delivery.    Indicates that the particular city style address receives the mail at a PO Box rather than the residential address per the customer's request.  The customer who lives at 5 Main St. also has a PO Box.  The customer has asked the USPS to deliver their mail to the PO Box rather than their house.  A mailer cannot mail to throwbacks via standard mail class because the mail will not be forwarded to the PO Box; the postage doesn't cover the forwarding expense.  First class mail will be forwarded to the PO Box for a throwback.
"
14	Same	Seasonal Delivery Indicator	Varchar2	83	83	1	Indicator of Y=seasonal delivery, N=not a seasonal delivery, and E = educational identifier.  See field 15 and 16 for suppression start and end dates.
15	Same	Seasonal Start Suppression Date	Date	84	88	5	Identifies when to begin suppressing this address from your mailings.  Use this field in conjunction with field 16 (Seasonal End Suppression Date) to determine when to mail this address. The date format will be mm-dd.  This only applies to addresses that have a Â“YÂ” in field 14 (SEASONAL Delivery Indicator).
16	Same	Seasonal End Suppression Date	Date	89	93	5	Identifies when to stop suppressing this address from your mailings.  Use this field in conjunction with field 15 (Seasonal Start Suppression Date) to determine when to mail this address. The date format will be mm-dd.  This only applies to addresses that have a Â“YÂ” in field 14 (SEASONAL Delivery Indicator).
17	Same	DND Indicator	Varchar2	94	94	1	This will be an indicator Y for YES or N for NO that the address has been flagged as a DND - DO NOT DELIVER.
18	Same	College Indicator	Varchar2	95	95	1	This will be an indicator Y for YES or N for NO that the address has been flagged as a COLLEGE.
19	Same	College Start Suppression Date	Date	96	105	10	Identifies when to begin suppressing this address from your mailings.  Use this field in conjunction with field 20 (COLLEGE End Suppression Date) to determine when to mail this address.  Date format will be yyyy-mm-dd including dashes/hyphens.  This only applies to addresses that have a Â“YÂ” in field 18 (COLLEGE Indicator).  
20	Same	College End Suppression Date	Date	106	115	10	Identifies when to stop suppressing this address from your mailings.  Use this field in conjunction with field 19 (COLLEGE Start Suppression Date) to determine when to mail this address. Date format will be yyyy-mm-dd including dashes/hyphens.  This only applies to addresses that have a Â“YÂ” in field 18 (COLLEGE Indicator).
21	Same	Address Style Flag	Varchar2	116	116	1	Identifies the address as City Style (C) or Simplified (S). City style (C) addressing requires that there is a specific street address including street numbers or specific post office box number.  Simplified addressing (S) is an address method used for rural deliveries.  Simplified addresses are those which do not contain a specific street address. Renamed from city rural flag.
22	Same	Simplify Address Count	Number	117	121	5	Will supply a count for a simplified rural routes only. Renamed from box count.
23	Same	Drop Indicator	Varchar2	122	122	1	"This is renamed from  Address Status 2.
There are Four valid values for this field; 
  C - This address is a CMRA (Commercial Mail Receiving Agency)
  Y - This address is part of a drop delivery
  N - This address is neither a CMRA, Drop Stop or Simplified
  Blank - Simplified Carrier Route  (see field, Address Style Flag)"
24	Same	Delivery Point Usage Code    (Business / Residential)	Varchar2	123	123	1	"A = Residential       C = Primary Residential with Business 
B = Business           D = Primary Business with Residential "
25	Same	DPBC Digit	Number	124	125	2	Delivery point barcode.  You will have to left zero fill this field.
26	Same	DPBC Check Digit	Number	126	126	1	Delivery point barcode check digit
27	Same	Update Date	Date	127	136	10	Date that addresses were last updated on file via CDS.  Date format will be yyyy-mm-dd including dashes/hyphens.
28	Same	File Release Date	Date	137	146	10	This date is critical for postal qualification per CASS A950.  This date is used unless Override File Release Date is indicated.  Renamed from issue date.  Date format will be yyyy-mm-dd includes dashes/hyphens.
29	Same	Override file release date	Date	147	156	10	This date will be filled in due to data problems with post office supplied information.  This date MUST be used for postal qualification per CASS A950.  Renamed from Route.Pend.upd.  Date format will be yyyy-mm-dd including dashes/hyphens.
30	Same	County Num	Number	157	159	3	County code number is the last three digits in the Federal Information Processing Standard (FIPS) code.  You will have to left zero fill this field.
31	Same	County Name 	Varchar2	160	187	28	Name of the county.
32	Same	City Name	Varchar2	188	215	28	City name as it should appear as part of the address. Renamed from Post Office Name.
33	Same	State Code	Varchar2	216	217	2	The abbreviation used for a state
34	Same	State Num	Number	218	219	2	State code number is the first two digits in the Federal Information Processing Standard (FIPS) code.  You will have to left zero fill this field.
35	Same	Congressional District Number	Number	220	221	2	Identifies congressional district boundaries as identified by the postal zip + 4 product
36	Same	OWGM_Indicator	Varchar2	222	222	1	Only Way to Get Mail - These are critical post office boxes where the consumer residing in the town can only receive residential delivery via Post Office Boxes.  For example there is no curb side delivery or NDCBU.  The indicator will only be set for post office boxes
37	Same	Record Type Code	Varchar2	223	223	1	"An alphabetic value that identifies the type of delivery point
F = Firm
G = General
H = Highrise
P = PO Box
R = Rural Route
S = Street"
38	Same	Valassis KeyÂ™	Number	224	233	10	"Data left zero filled
Used as a primary key to link or append other data options to the addresses, example Name Append and GeoCensus data sets"
39	Same	Address Type	Number	234	234	1	"0=Undefined or Business
1=SFDU
2=MFDU
9=PO Box"
40	Same	Delivery Point Type Code    	Varchar2	235	235	1	"A - Curbline
B - NDCBU (Cluster Box Unit (CBU))
C - Central 
D - Other
E - Facility Box
F - Contract Box  
G - Detached Box 
H - Residential Non-Personnel Unit (NPU)
S - Caller Service Box
T - Remittance Box
U - Contest Box
V - Other Box
Q - General Delivery
Value Blank (None Delvpt Type)
                                                                                                              "
41	Same	Filler	Varchar2	236	300	65	Not Used at this time, reserved for future development
						300	TOTAL DATA LENGTH
*/