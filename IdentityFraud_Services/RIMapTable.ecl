// must include every possible Risk Indicator (RI) for Identity Fraud Report;
// provides RI's rank, "color", description.

// NB: entry may correspond to more than one codes defined in Codes/VARIOUS_HRI_FILES or Risk_Indicators/getHRIDesc

RED    := Constants.Color.RED;
YELLOW := Constants.Color.YELLOW;
BLUE   := Constants.Color.BLUE;

p          := Constants.Providers;
c_ssn      := Constants.RiskCodes.SSN;
c_nlr      := Constants.RiskCodes.NLR;
c_addr     := Constants.RiskCodes.Address;
c_name     := Constants.RiskCodes.Name;
c_phone    := Constants.RiskCodes.Phone;
c_identity := Constants.RiskCodes.Identity;

string STR_NLR := 'is no longer reported to LexisNexis by a consumer reporting agency';

// code must be unique and persistent;
// Rank (3rd column) is generally unique as well, except "no longer reported" and BLUE indicators,
// which may have same or different ranks;
// Rank defines the importance (sorting order for an end customer) and location of blue indicators:
// -- those with ranks >199 are placed into informational pop-up, instead of regular indicator column
EXPORT RIMapTable  := dataset ([

	// identity table
	{c_identity.NO_UPDATES,               RED,    1,  'Identity has no updates reported to LexisNexis for at least 12 months'},
	{c_identity.EXCESSIVE_SSNS,           RED,    4,  'Identity has excessive SSNs associated with it in recent LexisNexis product searches'},
	{c_identity.EXCESSIVE_ADDRESSES,      RED,    5,  'Identity has excessive addresses associated with it in recent LexisNexis product searches'},
	{c_identity.EXCESSIVE_PHONES,         RED,    6,  'Identity has excessive phones associated with it in recent LexisNexis product searches'},
  {c_identity.MULTIPLE_SSNs,            RED,    10, 'Multiple SSNs reported with Identity'},
  {c_identity.EXCESSIVE_SEARCHES_DAY,   RED,    11, 'Identity had excessive searches over the last day in LexisNexis product searches'},
	{c_identity.EXCESSIVE_SEARCHES_WEEK,  RED,    12, 'Identity had excessive searches over the last week in LexisNexis product searches'},
	{c_identity.EXCESSIVE_SEARCHES_MONTH, RED,    13, 'Identity had excessive searches over the last month in LexisNexis product searches'},
	{c_identity.EXCESSIVE_SEARCHES_YEAR,  RED,    14, 'Identity had excessive searches over the last year in LexisNexis product searches'},
	{c_identity.ADDRESS_CHANGES,          RED,    15, 'Identity has numerous address changes in the last 5 years'},
	{c_identity.MULTIPLE_PHONES,          YELLOW, 32, 'Identity has multiple phones'},
	
  // ssn table
  {c_ssn.INVALID,                  RED,    8,   'The SSN is invalid or not yet issued'},
  {c_ssn.IMPOSTERS,                RED,    9,   'Multiple identities associated with SSN'},
  {c_ssn.LASTYEARS_3,              RED,    16,  'The SSN was issued within the last three years'},
  {c_ssn.AFTERAGE_5,               RED,    17,  'The SSN was issued after age five (post-1990)'},
  {c_ssn.DECEASED,                 RED,    18,  'The SSN is reported for a deceased person'},
  {c_ssn.PRIOR_DOB,                RED,    19,  'The SSN was issued prior to the date of birth'},
  {c_ssn.EXCESSIVE_SEARCHES_DAY,   YELLOW, 25,  'The SSN had excessive searches over the last day in LexisNexis product searches'},
  {c_ssn.EXCESSIVE_SEARCHES_WEEK,  YELLOW, 26,  'The SSN had excessive searches over the last week in LexisNexis product searches'},
  {c_ssn.EXCESSIVE_SEARCHES_MONTH, YELLOW, 27,  'The SSN had excessive searches over the last month in LexisNexis product searches'},
  {c_ssn.EXCESSIVE_SEARCHES_YEAR,  YELLOW, 28,  'The SSN had excessive searches over the last year in LexisNexis product searches'},
  {c_ssn.ENUMERATION,              YELLOW, 45,  'The SSN is an Enumeration at Entry'},
  {c_ssn.ITIN,                     YELLOW, 46,  'The SSN is an ITIN (Individual Tax Identification Number)'},
  {c_ssn.RELATIVE,                 YELLOW, 57,  'The SSN belongs to a possible relative'},
  {c_ssn.SPOUSE,                   YELLOW, 58,  'The SSN belongs to a possible spouse'},
  {c_ssn.RANDOMIZED_INVALID,       YELLOW, 60,  'The SSN was possibly randomly issued by SSA, but was invalid when first associated with the input identity'},
  {c_ssn.RANDOMIZED,               BLUE,   100, 'The SSN was possibly randomly issued by the SSA'},
	
  // phones
  {c_phone.TRANSIENT,    RED,    24,  'The phone number matches a transient commercial or institutional address'},
  {c_phone.DISCONNECTED, YELLOW, 43,  'The phone number may be disconnected'},
  {c_phone.INVALID,      YELLOW, 44,  'The phone number is potentially invalid'},
  {c_phone.NUMBER_ZIP,   YELLOW, 59,  'The phone number and zip code combination is invalid'},
  {c_phone.MOBILE,       BLUE,   100, 'The phone number is a mobile number'},
  {c_phone.PAGER,        BLUE,   200, 'The phone number is a pager number'},
  {c_phone.DISTANT,      BLUE,   100, 'The phone number and address are geographically distant (greater than 10 miles)'},

  // no longer reported: per bureau plus general
	{c_nlr.DID_EQ,     RED,     2, 'Identity ' + STR_NLR, p.EQUIFAX},
  {c_nlr.DID_EN,     RED,     2, 'Identity ' + STR_NLR, p.EXPERIAN},
  {c_nlr.DID_TU,     RED,     2, 'Identity ' + STR_NLR, p.TRANSUNION},
  {c_nlr.DID,        RED,     2, 'Identity ' + STR_NLR},
  {c_nlr.SSN,        RED,     3, 'Identity has a SSN no longer reported to LexisNexis by a consumer reporting agency'},
  {c_nlr.SSN_EQ,     RED,     7, 'SSN ' + STR_NLR, p.EQUIFAX},
  {c_nlr.SSN_EN,     RED,     7, 'SSN ' + STR_NLR, p.EXPERIAN},
  {c_nlr.SSN_TU,     RED,     7, 'SSN ' + STR_NLR, p.TRANSUNION},
  {c_nlr.NAME,       YELLOW, 30, 'Identity has a name no longer reported to LexisNexis by a consumer reporting agency'},
  {c_nlr.ADDRESS,    YELLOW, 31, 'Identity has an address no longer reported to LexisNexis by a consumer reporting agency'},
  {c_nlr.LNAME,      YELLOW, 33, 'Identity has a last name no longer reported to LexisNexis by a consumer reporting agency'},
  {c_nlr.DOB,        YELLOW, 34, 'Identity has a DOB no longer reported to LexisNexis by a consumer reporting agency'},
  {c_nlr.NAME_EQ,    YELLOW, 35, 'Name ' + STR_NLR, p.EQUIFAX},
  {c_nlr.NAME_EN,    YELLOW, 35, 'Name ' + STR_NLR, p.EXPERIAN},
  {c_nlr.NAME_TU,    YELLOW, 35, 'Name ' + STR_NLR, p.TRANSUNION},
  {c_nlr.ADDRESS_EQ, YELLOW, 36, 'Address ' + STR_NLR, p.EQUIFAX},
  {c_nlr.ADDRESS_EN, YELLOW, 36, 'Address ' + STR_NLR, p.EXPERIAN},
  {c_nlr.ADDRESS_TU, YELLOW, 36, 'Address ' + STR_NLR, p.TRANSUNION},
  {c_nlr.LNAME_EQ,   YELLOW, 48, 'Last name ' + STR_NLR, p.EQUIFAX},
  {c_nlr.LNAME_EN,   YELLOW, 48, 'Last name ' + STR_NLR, p.EXPERIAN},
  {c_nlr.LNAME_TU,   YELLOW, 48, 'Last name ' + STR_NLR, p.TRANSUNION},
  {c_nlr.DOB_EQ,     YELLOW, 47, 'DOB ' + STR_NLR, p.EQUIFAX},
  {c_nlr.DOB_EN,     YELLOW, 47, 'DOB ' + STR_NLR, p.EXPERIAN},
  {c_nlr.DOB_TU,     YELLOW, 47, 'DOB ' + STR_NLR, p.TRANSUNION},

	// name indicators
  //{c_name.OFAC, YELLOW, XX, 'Name matches a record on the OFAC Watch List'},
  {c_name.DERIVED, BLUE, 205, 'LexisNexis derived'},
	
  // address indicators
  {c_addr.USPIS,           RED,    20, Constants.USPIS_INDICATOR_TEXT, p.USPIS}, // all USPIS will have same rank/description now
  {c_addr.INVALID,         RED,    21, 'Address may be invalid according to postal specifications'},
  {c_addr.CORRECTIONAL,    RED,    22, 'Address is a Correctional Institution'},
	{c_addr.MULTIPLE,        RED,	   23, 'Address is associated with multiple suspicious identities'},	//fraud attribute
  {c_addr.ADVO_VACANT,     YELLOW, 29, 'Address is reported as vacant'},
  {c_addr.ADVO_VACANT_PO,  YELLOW, 29, 'Post Office Box is reported as vacant'},
  {c_addr.ADVO_CMRA,       YELLOW, 37, 'Address is a Commercial Mail Receiving Agency (CMRA)'},
  {c_addr.HOTEL,           YELLOW, 38, 'Address is a Hotel or Motel'},
  {c_addr.LETTER,          YELLOW, 39, 'Address is an Addressing & Letter Service'},
	{c_addr.MORE_RECENT,     YELLOW, 40, 'More recent unconfirmed address'},
  {c_addr.PHOTOCOPYING,    YELLOW, 41, 'Address is a Photocopying & Duplication Service'},
  {c_addr.PACKAGING,       YELLOW, 42, 'Address is a Packaging Service'},
  {c_addr.ADVO_SEASONAL,   YELLOW, 49, 'Address is a seasonal address'},
  {c_addr.COMMERCIAL,      YELLOW, 50, 'Address is a transient commercial or institutional address'},
  {c_addr.COLLEGE,         YELLOW, 51, 'Address is at a College'},
  {c_addr.JUNIORCOLLEGE,   YELLOW, 52, 'Address is a Junior College or Technical Institute'},
  // Note: there's also ADVO-college 
  {c_addr.SCHOOL,          YELLOW, 53, 'Address is an Elementary or Secondary School'},
  {c_addr.LIBRARY,         YELLOW, 54, 'Address is a Library'},
  {c_addr.ZIP2POBOX,       YELLOW, 55, 'The zip code belongs to a post office box'},
  {c_addr.MILITARY,        YELLOW, 56, 'The zip code is a corporate-only, military zip code'},
 
  {c_addr.MULTIUNIT,       BLUE,   100, 'Address is a Multi Unit Dwelling'},
  {c_addr.NEWSPAPER,       BLUE,   100, 'Address is a Newspaper Facility'},
  {c_addr.TRAILER_COURT,   BLUE,   100, 'Address is a Trailer Court'},
  {c_addr.TRAILER_PARK,    BLUE,   100, 'Address is a Trailer Park or Campsite'},
  {c_addr.NURSING,         BLUE,   100, 'Address is a Nursing Home'},
  {c_addr.SKILLED_NURSING, BLUE,   100, 'Address is a Skilled Nursing Care Facility'},
  {c_addr.RETIREMENT,      BLUE,   100, 'Address is a Retirement Home'},
  {c_addr.HOSPITAL,        BLUE,   100, 'Address is a Hospital'},
  {c_addr.PSYCHIATRIC,     BLUE,   100, 'Address is a Psychiatric Hospital'},
  {c_addr.TELEGRAPH,       BLUE,   100, 'Address is a Telegraph & Other Communications'},
  {c_addr.RRZIP,           BLUE,   100, 'Rural Route zip code'},
  {c_addr.USPS,            BLUE,   100, 'Address is a U.S. Postal Service'},
  {c_addr.MOBILE_HOME,     BLUE,   100, 'Address is a Mobile Home Site Operator'},
  {c_addr.BOARDING,        BLUE,   100, 'Address is a Rooming or Boarding House'},

  {c_addr.HUNTING,         BLUE,   100, 'Address is a Hunting, Trapping & Game Service'},
  {c_addr.SPORTING,        BLUE,   100, 'Address is a Sporting or Recreational Camp'},
  {c_addr.TAXPREP,         BLUE,   100, 'Address is a Tax Return Preparation Service'},
  {c_addr.CREDIT,          BLUE,   100, 'Address is a Credit Reporting Service'},
  {c_addr.NTLSECURITY,     BLUE,   100, 'Address is a National Security Facility'},

  {c_addr.SOCIAL_SERVICE,    YELLOW, 61, 'Social Services Facility'},
  {c_addr.SHIPPING_AGENT,    YELLOW, 62, 'Shipping agent'},
  {c_addr.PACKING_CRATING,   YELLOW, 63, 'Packing or crating service'},
  {c_addr.RESIDENTIAL_CARE,  YELLOW, 64, 'Residential Care Facility'},
  {c_addr.HOMEHEALTH_CARE,   YELLOW, 65, 'Home Health Care Facility'},
  {c_addr.INTERMEDIATE_CARE, YELLOW, 66, 'Intermediate Care Facility'},
  {c_addr.GENERAL_DELIVERY,  YELLOW, 67, 'General Delivery mail service'},
  
  // (see history for defnition of the following indicators separately for residence and business)
  {c_addr.ADVO_CURB,             BLUE,   220, 'A delivery point with a mail receptacle located at the curb'},
  {c_addr.ADVO_NDCBU,            BLUE,   220, 'A delivery point consisting of cluster boxes'},
  {c_addr.ADVO_CENTRAL,          BLUE,   220, 'A delivery point in a building with two or more zip codes that is serviced by a bank of boxes or receptacles within a delivery center or mailroom'},
  {c_addr.ADVO_OTHER,            BLUE,   220, 'A delivery point serviced other than by curb, central, or NDCBU. Examples include door-to-door (walking route) or door-slot delivery'},
  {c_addr.ADVO_FACILITY,         BLUE,   220, 'A PO Box whose PO Box section is located at a USPS Facility'},
  {c_addr.ADVO_CONTRACT,         BLUE,   220, 'A PO Box whose PO Box section is located at a USPS contract unit'},
  {c_addr.ADVO_DETACHED,         BLUE,   220, 'A PO Box whose detached box section is not located in a post office building, but which is rented from the USPS.'},
  {c_addr.ADVO_NPU,              BLUE,   220, 'Non-Personnel Unit (NPU) - A self-service postal center that furnishes mail services. Mail NPU deliveries are non-staffed, self-service'},
  {c_addr.ADVO_GENERAL,          BLUE,   220, 'A service for customers to pick up mail at post offices. Used for firms without delivery, those without an address or prefer not to use PO boxes.'},
  {c_addr.ADVO_IDA,              BLUE,   220, 'Internal Drop Address (IDA) - An IDA is a unique address that is delivered as part of a drop, but which represents a separate entity within the drop.'},
  {c_addr.ADVO_CALLER,           BLUE,   220, 'Caller Service Box - provided for customers whose volume of mail exceeds the physical size of the PO Box.'},
  {c_addr.ADVO_REMITTANCE,       BLUE,   220, 'Remittance Box - set up for the handling of payments by a bank or other retail or wholesale institution.'},
  {c_addr.ADVO_CONTEST,          BLUE,   220, 'Contest Box - Contest boxes are those used for rebate, coupon, or contest.'},
  {c_addr.ADVO_POBOX,            BLUE,   220, 'Address receives mail only at a PO Box.'},
  {c_addr.ADVO_RESIDENTIAL,      BLUE,   210, 'Delivery point is strictly residential'},
  {c_addr.ADVO_BUSINESS,         BLUE,   210, 'Delivery point is strictly business'},
  {c_addr.ADVO_RESIDENTIAL_PRIM, BLUE,   210, 'Delivery point is primarily residential with a possible business'},
  {c_addr.ADVO_BUSINESS_PRIM,    BLUE,   210, 'Delivery point is primarily business with a possible residence'},
	
// THOSE I HAVEN'T BEING ABLE TO MAP YET
// 37 New Construction yellow
// 38 New Mover yellow
// 39 Possible Maiden Name yellow

// TODO: remove!!!
  {Constants.RiskCodes.UNKNOWN,  Constants.Color.RED, 1000, 'UNKNOWN INDICATOR'}
], {layouts.ri_map});
