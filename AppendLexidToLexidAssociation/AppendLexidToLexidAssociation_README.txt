AppendLexidToLexidAssociation Plugin

There are two specific use cases which apply to this plugin.

1. Given a two Lexids on the same row of data within a dataset (Prescriber - Patient, Merchant - Cardholder) 
   this plugin will append whether there is an association in the LexisNexis relatives file.
2. Given a single Lexid on a row of data it will append all associations for that lexid. This allows for 
   subsequent aggregations on the associated Lexid. To find clusters of people relative to the input dataset.


This plugin is primarily used to prep for downstream aggregations and analytics. 
i.e. 
   Count the number of claims for a sender where they are claiming for a parcel that was mailed to a relative.
   Count the number of Vicodin prescriptions that a prescriber prescribed to a relative or associate.
   
Input Parameters

    Prefix: The prefix for all the appended columns. 
        e.g. PrescriptionAssociation will result in the columns like the following being appended
               PrescriptionAssociationIsRelative        
               PrescriptionAssociationIsAssociate
               PrescriptionAssociationIsBusiness
            (along with the additional columns).
            
    DistanceThreshold: Distance threshold in relationship degrees. This allows for setting a tighter
                       circle of relatives and associates that you want to measure against.
    Lexid1: The Lexid for the first person for the association you want to measure.
    Lexid1Label: The label that matches the first person. Fullname or last name. This is primarily so that in the 
                 side effects, the top people have a name in the stats.
    Lexid2: (Optional) The Lexid for the second person for the association you want to measure.
    Lexid2Label: (Optional) The label that matches the second person. Fullname or last name. This is primarily so that in the 
                 side effects, the top people have a name in the stats.

Outputs
    Type: Personal – Cohabit, CoApt, CoPOBox, CoSSN, CoPolicy, CoClaim, CoVehicle, CoExperian, CoTransunion, CoMarriageDivorce, 
          CoProperty, CoForeclosure, CoLIen or BCoBankruptcy
          Business – BCoProperty, BCoForeclosure, BCoLIen, BCoBankruptcy or CoEnclarity
          Other – CoEcrash, CoWatercraft, CoAircraft or CoUCC
    confidence: For the Personal Category we assign one of the following confidence levels:
          High (indicative of a potential relative relationship)
            Multiple indications of relationship 
          Medium (indicative of an associate relationship)
            Two separate indications of a cohabit, but no additional indications of a relationship (other than phone)
            A single instance of a cohabit, but a matching phone number (possible land line)
            A single non cohabit match without any other indications of a relationship
          Low
            A single cohabit date overlap without any other corroborating information
          Noise
            Cohabit overlap period 3 months or less
            Cohabit overlap period cannot be determined since month not specified in dates
            A matching address has a high density did population (25+ dids); could be mail forwarding address
          Only the High and Medium Personal Categories are currently in the Keys (Low and Noise exist on the base file only).
    CohabitScore: Relationship by shared single family home addresses and either an overlapping address dates or one of the following three: 
                     a last name > 8; a phone score > 0; a dl nbr score > 0 
    CohabitCount: Number of addresses shared between the two lexids.
    CoApartmentScore: Relationship by shared multi family home addresses and either an overlapping address dates or one of the following three: a last name > 8; a phone score > 0; a dl nbr score > 0 
    CoApartmentCount: Number of apartment/suite addresses shared between the two lexids.
    CoPoBoxScore: Relationship by shared PO Box addresses and either an overlapping address dates or one of the following three: a last name > 8; a phone score > 0; a dl nbr score > 0 
    CoPoBoxCount: Number of PO Box addresses shared between the two lexids.
    CoSsnScore: Relationship by shared SSN regardless of date overlap
    CoSsnCount: The number of SSNs shared between the two lexids.
    TotalCount: This field is the sum of the individual relationship source counts determined with SALT;
    TotalScore: This field is the sum of the individual relationship source scores determined with SALT, in addition to scores associated with last name, phone and dl nbr;
    Cluster: Type of LexID cluster found on segmentation file for the 2nd LexID (Core,NO_SSN,INACTIVE…).
    Generation: Generation gap between two individuals 
    RelationshipDateFirstSeen: First date of relationship between Lexids using header data only.
    RelationshipDateLastSeen: Last date of relationship between Lexids using header data only.
    OverlapMonths: Overlap of Relationship dates between Lexids.
    DateFirstSeen: First seen date of 2nd Lexid in header.
    DateLastSeen: Last seen date of 2nd Lexid in header.
    AgeFirstSeen: Age in which the 2nd Lexid was first seen in the header. This field is being initialized as the DOB used is source dependent;
    Personal: Does the relationship contain personal matching data?
    Business: Does the relationship contain business matching data?
    Other: Does the relationship contain other matching data?
    IsRelative: Does this match the legacy relative criteria.
    IsAssociate: Does this match the legacy associate criteria.
    IsBusiness: Do this association match the legacy business criteria.
    Degree: The number of steps in associations between the two Lexids. 
              0 = Assocation to themselves. i.e. The prescribed Vicodin where they are both the prescriber and the patient.
              1 = First degree association. Husband - Wife.
              1+  Second degree associations. The closer to 1, the more connected they are through first degree associates. 
                  At 2 they have only a single first degree association connecting them.
    Hit : A numeric that indicates if there was an association found or not. Value is 1=Found 0=Not Found. 
          This can be useful if you later do an AVERAGE Hit per street or county or zip or Lexid. It will essentially give you a percentage.  
    RelationshipCode: the code for the relationship between lexid1 and lexid2 individual
    Relationship: the relationship in english between lexid1 and lexid2. For instance Spouse
