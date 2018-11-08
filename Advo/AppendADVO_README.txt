Append Clean Address HIPIE Plugin

This plugin appends the ADVO (US Postal Attributes) to the input dataset. 

This plugin is typically preceeded by an AppendCleanAddress plugin in a composition. 
It requires clean address parts. 

Plugin Inputs.

Prefix: It will add this text to the start of all the appended fields. 'Business' will result in columns being named...
        BusinessVacancyIndicator, BusinessThrowBackIndicator,BusinessSeasonalDeliveryIndicator,BusinessSeasonalSuppressionStartDate
PrimaryRange: Primary Range, street number of the address.
PrimaryName: Primary Name, street name of the address.
AddressSuffix: Address Suffix.
PreDirectional: Pre-Directional.
PostDirectional: Post-Directional.
SecondaryRange: Secondary Range, Apt or Suite.
Zip5: Zip5 code
County: County

Expected Outputs.
        STRING1 VacancyIndicator;
        STRING1 ThrowBackIndicator;
        STRING1 SeasonalDeliveryIndicator;
        STRING5 SeasonalSuppressionStartDate;
        STRING5 SeasonalSuppressionEndDate;
        STRING1 DoNotDeliverIndicator;
        STRING1 CollegeIndicator;
        STRING10 CollegeSuppressionStartDate;
        STRING10 CollegeSuppressionEndDate;
        STRING1 AddressStyle;
        STRING5 SimplifyAddressCount;
        STRING1 DropIndicator;
        STRING1 ResidentialOrBusinessIndicator;
        STRING1 OnlyWayToGetMailIndicator;
        STRING1 RecordTypeCode;
        STRING1 AddressType;
        STRING1 AddressUsageType;
        STRING8 FirstSeenDate;
        STRING8 LastSeenDate;
        STRING8 VendorFirstReportedDate;
        STRING8 VendorLastReportedDate;
        STRING8 VacationBeginDate;
        STRING8 VacationEndDate;
        STRING8 NumberOfCurrentVacationMonths;
        STRING8 MaxVacationMonths;
        STRING8 VacationPeriodsCount;

Advo Column Descriptions
------------------------
Address Vacancy Indicator
    Indicator of Y=vacancy and N = active delivery. 
Throw Back Indicator
    Indicator of Y= yes, it is a throwback or N = no, it is not a throwback and it is an active delivery.    Indicates that the particular city style address receives 
    the mail at a PO Box rather than the residential address per the customer's request.  The customer who lives at 5 Main St. also has a PO Box.  
    The customer has asked the USPS to deliver their mail to the PO Box rather than their house.  A mailer cannot mail to throwbacks via standard mail class because 
    the mail will not be forwarded to the PO Box; the postage doesn't cover the forwarding expense.  First class mail will be forwarded to the PO Box for a throwback.
Seasonal Delivery Indicator
    Indicator of Y=seasonal delivery, N=not a seasonal delivery, and E = educational identifier.  See field 15 and 16 for suppression start and end dates.
Seasonal Start Suppression Date
    Identifies when to begin suppressing this address from your mailings.  Use this field in conjunction with field 16 (Seasonal End Suppression Date) to determine 
    when to mail this address. The date format will be mm-dd.  This only applies to addresses that have a “Y” in field 14 (SEASONAL Delivery Indicator).
Seasonal End Suppression Date
    Identifies when to stop suppressing this address from your mailings.  Use this field in conjunction with field 15 (Seasonal Start Suppression Date) to determine 
    when to mail this address. The date format will be mm-dd.  This only applies to addresses that have a “Y” in field 14 (SEASONAL Delivery Indicator).
DND Indicator
    This will be an indicator Y for YES or N for NO that the address has been flagged as a DND - DO NOT DELIVER.
College Indicator
    This will be an indicator Y for YES or N for NO that the address has been flagged as a COLLEGE.
College Start Suppression Date
    Identifies when to begin suppressing this address from your mailings.  Use this field in conjunction with field 20 (COLLEGE End Suppression Date) to determine 
    when to mail this address.  Date format will be yyyy-mm-dd including dashes/hyphens.  This only applies to addresses that have a “Y” in field 18 (COLLEGE Indicator). 
College End Suppression Date
    Identifies when to stop suppressing this address from your mailings.  Use this field in conjunction with field 19 (COLLEGE Start Suppression Date) 
    to determine when to mail this address. Date format will be yyyy-mm-dd including dashes/hyphens.  
    This only applies to addresses that have a “Y” in field 18 (COLLEGE Indicator).
Address Style Flag
    Identifies the address as City Style (C) or Simplified (S). City style (C) addressing requires that there is a specific street address 
    including street numbers or specific post office box number. Simplified addressing (S) is an address method used for rural deliveries.  
    Simplified addresses are those which do not contain a specific street address. Renamed from city rural flag.
Simplify Address Count
    Will supply a count for a simplified rural routes only. Renamed from box count.
Drop Indicator
    This is renamed from  Address Status 2.
    There are Four valid values for this field;
        C - This address is a CMRA (Commercial Mail Receiving Agency)
        Y - This address is part of a drop delivery
        N - This address is neither a CMRA, Drop Stop or Simplified
        Blank - Simplified Carrier Route  (see field, Address Style Flag)
Delivery Point Usage Code    (Business / Residential)
    A = Residential       C = Primary Residential with Business
    B = Business          D = Primary Business with Residential
OWGM_Indicator
    Only Way to G et Mail - These are critical post office boxes where the consumer residing in the town can only receive residential delivery via Post Office Boxes.  
    For example there is no curb side delivery or NDCBU.  The indicator will only be set for post office boxes
Record Type Code
    An alphabetic value that identifies the type of delivery point
    F = Firm
    G = General
    H = High rise
    P = PO Box
    R = Rural Route
    S = Street
Address Type
    0=Undefined or Business
    1=Single Family Dwelling Unit
    2=Multi Family Dwelling Unit
    9=PO Box
Mixed Address Usage
    The DPT codes are 
    C=Primarily Residential with Business, 
    D=Primarily Business with Residential or 
    U=Unassigned
Date First Seen
    Date address was first seen
Date Last seen
    Date address was last seen
Date Vendor First Reported
    Date the vendor first reported seeing the address
Date Vendor Last Reported
    Date the vendor last reported seeing the address
Vacancy Begin Date
    Date the address was first marked as vacant
Vacancy End Date
    Date the address was last marked as vacant
Months Vacant Current
    Total months of last continuous vacancy
Months Vacancy Maximum
    Total months of longest vacant period
Vacancy Count
    How many distinct times the address was marked vacant

Resource Requirements:

Requires the Advo Index to be available on the environment.

