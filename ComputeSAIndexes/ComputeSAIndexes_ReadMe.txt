Compute SA Indexes 
ReadMe

This is a CUSTOM plugin.


This plugin builds custom SA Indexes for use in custom SA search query used by Suspect Address project dashboards.
This plugin is meant to be used in a prep SA composition downstream and uses two input files. 
One is the TestSuspectProviderAddressScoring output scoring file and the other is the Facility Prep/Prep2 output clean besunesses file. 


GCID and JobID will be appended to the indexes names to avoid collision with clients/runs of SA prep compositions.
For example if the GCID is 67890 and JobID is 12345 the indexes names will look like  ~sa::key::payload::67890::12345


The dsInputProvider is the TestSuspectProviderAddressScoring output file. 
The following field must be specified:
  ProviderProviderKey="provider_key"
  ProviderProviderNpi="provider_npi"
  ProviderFacilityName="provider_facility_name"
  ProviderSpecialty="providerattrtaxonomydescription"

  ProviderChargedDollars="claimoutlierproviderhighchargeamount"
  ProviderPaidDollars="claimoutlierproviderhighpaidamount"
  ProviderClaims="claimoutlierproviderclaimcount"

  FirstName="cleanproviderfirstname"
  MiddleName="cleanprovidermiddlename"
  LastName="cleanproviderlastname"
  SuffixName="cleanprovidernamesuffix"
  
  PrimaryRange="cleanproviderprimaryrange"
  PreDirectional="cleanproviderpredirectional"
  PrimaryName="cleanproviderprimaryname"
  AddressSuffix="cleanprovideraddresssuffix"
  PostDirectional="cleanproviderpostdirectional"
  SecondaryRange="cleanprovidersecondaryrange"
  City="cleanprovidervanitycity"
  State="cleanproviderstate"
  Zip5="cleanproviderzip5"
  FipsState="cleanproviderfipsstate"
  County="cleanprovidercounty"
  Latitude="cleanproviderlatitude"
  Longitude="cleanproviderlongitude"
  AddressKey="cleanprovideraddresskey"

  LNPID="inplnpid"
  LEXID="providerattrlexid"

The dsInputFacility is the the Facility Prep/Prep2 output clean besunesses file.
The following field must be specified:
  FacilityProviderKey="provider_id"
  FacilityProviderNpi="npi"
  FacilityFacilityName="facility_name"
  FacilitySpecialty="speciality"

  FacilityChargedDollars="chargeddollaramount"
  FacilityPaidDollars="paiddollaramount"
  FacilityClaims="totalclaims"

  DateFirstSeen="facilitiesbestproxdatefirstseen"
  ClaimStartDate="claimsstartdate"
  ClaimEndDate="claimsenddate"

  NetworkKey="proxentitycontextuid"
  LegalBusinessName="legal_business_name"
  DoingBusinessAs="doing_business_as"
  BusinessAddress="facilityaddresssearchsearchstring"
  InInputFile="additionalbusinessesisproxinput"
  IncorporationDate="facilitiesbestproxincorporationdate"
  LegalEntityIsActive="facilitiesbestseleisactive"
  LegalEntityIsDefunct="facilitiesbestseleisdefunct"
