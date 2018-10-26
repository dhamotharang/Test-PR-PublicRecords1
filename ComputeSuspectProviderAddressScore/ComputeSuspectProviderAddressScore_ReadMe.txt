ComputeSuspectProviderAddressScore HIPIE Plugin

This plugin takes the input from a series of plugins prior to executing this plugin with all the neccessary attributes to compute the scoring for the providers. The scores are pre-defined and will be added to the final professional score 

based on the flag set for each of the attribute for a provider. 


Note : This plugin is specific for Healthcare


Input Parameters

    Prefix  :  The prefix for all the appended columns. 
        e.g. The preix value Scoring will result in the columns like the following being appended
               ScoringInNetworkActiveExclusionFlag        
               ScoringOutNetworkActiveExclusionFlag
               (along with all the other additional output columns).
            
    Lnpid  :  Lexis Nexis Provider Id.
    ProviderId  :  Provider Identification Key from the customer.
    FirstName  :  Cleaned First Name of the Provider.
    MiddleName  :  Cleaned Middle Initials of the Provider.
    LastName  :  Cleaned Last Name of the Provider.
    NameSuffix  :  Cleaned Name suffix of the Provider.
    FacilityName  :  Cleaned Facility name.
    PrimaryRange  :  Primary Range, street number of the address.
    PrimaryName  :  Primary Name, street name of the address.
    AddressSuffix  :  Address Suffix.
    PreDirectional  :  Pre-Directional address.
    PostDirectional  :  Post-Directional address.
    SecondaryRange  :  Secondary Range, Apt or Suite of Provider address.
    Zip5  :  5 digit Zip Code of Provider address.
    County  :  County
    AddressPaidAmount  :  Address Paid Amount
	AddressExclusionFlag  :  Address Exclusion Flag
	SharedAddressIndicator  :  Shared Address Indicator
	DMEIndicator  :  DME-Indicator
	DMEOutlierRank  :  DME-Outlier Rank
	LABIndicator  :  LAB-Indicator
	LABOutlierRank  :  LAB-Outlier Rank
	SingleAddressIndicator  :  Single Address Indicator
	TotalNPICount  :  Total NPI Count
	RecentNPICount  :  Recent NPI Count
	StudentNPICount  :  Student NPI Count
	DNDIndicator  :  DND Indicator
	TotalChargeAmount  :  Total Charge Amount
	TotalPaidAmount  :  Total Paid Amount
	TotalClaimCount  :  Total Claim Count
	VacantAddressActivityIndicator  :  Vacant Address Activity Indicator
	MailDropIndicator  :  Mail Drop Indicator
	AddressType  :  Address Type
	UsageType  :  Usage Type
	PrisonIndicator  :  Prison Indicator
	ResidentialAddressIndicator  :  Residential Address Indicator
	ActiveStateExclusion  :  Active State-Exclusion
	ActiveOIGExclusion  :  Active OIG-Exclusion
	ActiveOPMExclusion  :  Active OPM-Exclusion
	ActiveLicenseRevocation  :  Active License Revocation
	PastStateExclusion  :  Past State-Exclusion
	PastOIGExclusion  :  Past OIG-Exclusion
	PastOPMExclusion  :  Past OPM-Exclusion
	PastLicenseRevocation  :  Past License Revocation
	LicenseExpiredFlag  :  License Expired Flag
	DEAExpiredFlag  :  DEA Expired Flag
	DeceasedFlag  :  Deceased Flag
	DateofDeath  :  Date of Death
	BankruptcyFlag  :  Bankruptcy Flag
	CriminalHistoryFlag  :  Criminal History Flag
	DeceasedPatientsFlag  :  Deceased Patients Flag
	LargePatientGroupFlag  :  Large Patient Group Flag
	LicenseInactiveFlag  :  License Inactive Flag
	NPIDeactivatedFlag  :  NPI Deactivated Flag
	LongPatientDrivingDistanceIndicator  :  Long Patient Driving Distance Indicator
	LongPatientDrivingDistanceOutlierRank  :  LongPatientDrivingDistanceOutlierRank
	HighPaidDollarsPerPatientIndicator  :  High Paid Dollars Per Patient Indicator
	HighPaidDollarsPerPatientOutlierRank  :  High Paid Dollars Per Patient Outlier Rank
	HighPaidDollarsPerClaimIndicator  :  High Paid Dollars Per Claim Indicator
	HighPaidDollarsPerClaimOutlierRank  :  High Paid Dollars Per Claim Outlier Rank
	HighNumberOfPatientsIndicator  :  High Number Of Patients Indicator
	HighNumberOfPatientsOutlierRank  :  High Number Of Patients Outlier Rank
	HighNumberOfClaimsIndicator  :  High Number Of Claims Indicator
	HighNumberOfClaimsOutlierRank  :  High Number Of Claims Outlier Rank
	HighPaidDollarsIndicator  :  High Paid Dollars Indicator
	HighPaidDollarsOutlierRank  :  High Paid Dollars Outlier Rank
	InNetworkCurrentExclusionFlag  :  In-Network Current Exclusion Flag
	InNetworkCurrentRevocationFlag  :  In-Network Current Revocation Flag
	InNetworkPastExclusionFlag  :  In-Network Past Exclusion Flag
	InNetworkPastRevocationFlag  :  In-Network Past Revocation Flag
	InNetworkhasBankruptcy  :  In-Network has Bankruptcy
	InNetworkhasCriminalHistory  :  In-Network has Criminal History
	OutNetworkCurrentExclusionFlag  :  Out-Network Current Exclusion Flag
	OutNetworkCurrentRevocationFlag  :  Out-Network Current Revocation Flag
	OutNetworkPastExclusionFlag  :  Out-Network Past Exclusion Flag
	OutNetworkPastRevocationFlag  :  Out-Network Past Revocation Flag
	OutNetworkhasBankruptcy  :  Out-Network has Bankruptcy
	OutNetworkhasCriminalHistory  :  Out-Network has Criminal History
	RelativeAssocCriminalFlag  :  Relative Associate Criminal Flag
	RelativeAssocBankruptcyFlag  :  Relative Associate Bankruptcy Flag
	NoOfProviderAtAddress  :  No Of Provider At Address
	NoOfPatientAtAddress  :  No Of Patient At Address
	HighPaidAmountPerPatient  :  High Paid Amount Per Patient
	HighPaidAmountPerClaim  :  High Paid Amount Per Claim
	ClaimMedian  :  Claim Median
	PatientMedian  :  Patient Median
	HighPaidAmountMedian  :  High Paid Amount Median
	HighPaidAmountPerClaimMedian  :  High Paid Amount Per Claim Median
	HighPaidAmountPerPatientMedian  :  High Paid Amount Per Patient Median
	DMEPatientMedian  :  DME Patient Median
	DMEClaimMedian  :  DME Claim Median
	LABPatientMedian  :  LAB Patient Median
	LABClaimMedian  :  LAB Claim Median
	ActiveLicenseRevocationState  :  Active License Revocation State
	ActiveLicenseRevocationDate  :  Active License Revocation Date
	ActiveLicenseExclusionState  :  Active License Exclusion State
	ActiveLicenseExclusionDate  :  Active License Exclusion Date
	ActiveOIGExclusionDate  :  Active OIG Exclusion Date
	ActiveOPMExclusionDate  :  Active OPM Exclusion Date
	ActiveStateSanctionExclusionDate  :  Active State Sanction Exclusion Date
	ActiveOIGSanctionExclusionDate  :  Active OIG Sanction Exclusion Date
	ActiveOPMSanctionExclusionDate  :  Active OPM Sanction Exclusion Date
	LicenseRevocationReinstatedState  :  License Revocation Reinstated State
	StateExclusionReinstatedState  :  State Exclusion Reinstated State
	StateExclusionReinstatedDate  :  State Exclusion Reinstated Date
	OIGExclusionReinstatedState  :  OIG Exclusion Reinstated State
	OIGExclusionReinstatedDate  :  OIG Exclusion Reinstated Date
	OPMExclusionReinstatedState  :  OPM Exclusion Reinstated State
	OPMExclusionReinstatedDate  :  OPM Exclusion Reinstated Date
	ExpiredDEANumber  :  Expired DEA Number
	ExpiredDEADate  :  Expired DEA Date
	ExpiredLicenseNumber  :  Expired License Number
	ExpiredLicenseState  :  Expired License State
	ExpiredLicenseNumberDate  :  Expired License Number Date
	BankruptcyFiledDate  :  Bankruptcy Filed Date
	ConvictionDate  :  Conviction Date
	DeceasedPatientCount  :  Deceased Patient Count
	PatientCount  :  Patient Count
	PatientDOD  :  Patient DOD
	NPIDeactivatedDate  :  NPI Deactivated Date
	LargePatientAddress  :  Large Patient Address
	InactiveLicenseState  :  Inactive License State
	PatientMedian  :  Patient Median
	NoOfPatientsDrivingLongDistance  :  No Of Patients Driving Long Distance
	AveDistance  :  AveDistance
	PractisePrimaryrange  :  Practise Primary range
	PractisePredirectional  :  Practise Predirectional
	PractisePrimaryname  :  Practise Primary Name
	PractiseAddresssuffix  :  Practise Address Suffix
	PractisePostdirectional  :  Practise Post Directional
	PractiseSecondaryrange  :  Practise Secondary Range
	PractiseCityname  :  Practise City Name
	PractiseState  :  Practise State
	PractiseZip5  :  Practise Zip5
	SharedAddressSwitch  :  Shared Address Switch
	DMESwitch  :  DME Switch
	LABSwitch  :  LAB Switch
	SingleAddressSwitch  :  Single Address Switch
	RecentNPISwitch  :  Recent NPI Switch
	StudentNPISwitch  :  Student NPI Switch
	DNDSwitch  :  DND Switch
	VacantSwitch  :  Vacant Switch
	MailDropSwitch  :  Mail Drop Switch
	POBoxSwitch  :  PO Box Switch
	PrisonSwitch  :  Prison Switch
	ResidentialSwitch  :  Residential Switch
	ActiveStateExclusionSwitch  :  Active State Exclusion Switch
	ActiveOIGExclusionSwitch  :  Active OIG Exclusion Switch
	ActiveOPMExclusionSwitch  :  Active OPM Exclusion Switch
	ActiveLicenseRevocationSwitch  :  Active License Revocation Switch
	PastStateExclusionSwitch  :  Past State Exclusion Switch
	PastOIGExclusionSwitch  :  Past OIG Exclusion Switch
	PastOPMExclusionSwitch  :  Past OPM Exclusion Switch
	PastLicenseRevocationSwitch  :  Past License Revocation Switch
	LicenseExpiredSwitch  :  License Expired Switch
	DEAExpiredSwitch  :  DEA Expired Switch
	DeceasedSwitch  :  Deceased Switch
	BankruptcySwitch  :  Bankruptcy Switch
	CriminalHistorySwitch  :  Criminal History Switch
	DeceasedPatientsSwitch  :  Deceased Patients Switch
	LargePatientGroupSwitch  :  Large Patient Group Switch
	LicenseInactiveSwitch  :  License Inactive Switch
	NPIDeactivatedSwitch  :  NPI Deactivated Switch
	LongPatientDrivingDistanceSwitch  :  Long Patient Driving Distance Switch
	HighPaidDollarsPerPatientSwitch  :  High Paid Dollars Per Patient Switch
	HighPaidDollarsPerClaimSwitch  :  High Paid Dollars Per Claim Switch
	HighNumberOfPatientsSwitch  :  High Number Of Patients Switch
	HighNumberOfClaimsSwitch  :  High Number Of Claims Switch
	HighPaidDollarsSwitch  :  High Paid Dollars Switch
	InNetworkCurrentExclusionSwitch  :  InNetwork Current Exclusion Switch
	InNetworkCurrentRevocationSwitch  :  InNetwork Current Revocation Switch
	InNetworkPastExclusionSwitch  :  InNetwork Past Exclusion Switch
	InNetworkPastRevocationSwitch  :  InNetwork Past Revocation Switch
	InNetworkhasBankruptcySwitch  :  InNetwork has Bankruptcy Switch
	InNetworkhasCriminalHistorySwitch  :  InNetwork has Criminal History Switch
	OutNetworkCurrentExclusionSwitch  :  OutNetwork Current Exclusion Switch
	OutNetworkCurrentRevocationSwitch  :  OutNetwork Current Revocation Switch
	OutNetworkPastExclusionSwitch  :  OutNetwork Past Exclusion Switch
	OutNetworkPastRevocationSwitch  :  OutNetwork Past Revocation Switch
	OutNetworkhasBankruptcySwitch  :  OutNetwork has Bankruptcy Switch
	OutNetworkhasCriminalHistorySwitch  :  OutNetwork has Criminal History Switch
	RelativeAssocCriminalSwitch  :  Relative Associate Criminal Switch
	RelativeAssocBankruptcySwitch  :  Relative Associate Bankruptcy Switch
	SharedAddressScore   :  Shared AddressScore
	DMEScore  :  DME Score
	LABScore  :  LAB Score
	SingleAddressScore  :  Single Address Score
	RecentNPIScore  :  Recent NPI Score
	StudentNPIScore  :  Student NPI Score
	DNDScore  :  DND Score
	VacantScore  :  Vacant Score
	MailDropScore  :  Mail Drop Score
	POBoxScore  :  PO Box Score
	PrisonScore  :  Prison Score
	ResidentialScore  :  Residential Score
	ActiveStateExclusionScore  :  Active State Exclusion Score
	ActiveOIGExclusionScore  :  Active OIG Exclusion Score
	ActiveOPMExclusionScore  :  Active OPM Exclusion Score
	ActiveLicenseRevocationScore  :  Active License Revocation Score
	PastStateExclusionScore  :  Past State Exclusion Score
	PastOIGExclusionScore  :  Past OIG Exclusion Score
	PastOPMExclusionScore  :  Past OPM Exclusion Score
	PastLicenseRevocationScore  :  Past License Revocation Score
	ExpiredLicenseScore  :  Expired License Score
	DEAExpiredScore  :  DEA Expired Score
	DeceasedScore  :  Deceased Score
	BankruptcyScore  :  Bankruptcy Score
	CriminalHistoryScore  :  Criminal History Score
	DeceasedPatientsScore  :  Deceased Patients Score
	LargePatientGroupScore  :  Large Patient Group Score
	LicenseInactiveScore  :  License Inactive Score
	NPIDeactivatedScore  :  NPI Deactivated Score
	LongPatientDrivingDistanceScore  :  Long Patient Driving Distance Score
	HighPaidDollarsPerPatientScore  :  High Paid Dollars Per Patient Score
	HighPaidDollarsPerClaimScore  :  High Paid Dollars Per Claim Score
	HighNumberOfPatientsScore  :  High Number Of Patients Score
	HighNumberOfClaimsScore  :  High Number Of Claims Score
	HighPaidDollarsScore  :  High Paid Dollars Score
	InNetworkCurrentExclusionScore  :  In Network Current Exclusion Score
	InNetworkCurrentRevocationScore  :  In Network Current Revocation Score
	InNetworkPastExclusionScore  :  In Network Past Exclusion Score
	InNetworkPastRevocationScore   :  In Network Past Revocation Score
	InNetworkhasBankruptcyScore   :  In Network has Bankruptcy Score
	InNetworkhasCriminalHistoryScore   :  In Network has Criminal History Score
	OutNetworkCurrentExclusionScore  :  Out Network Current Exclusion Score
	OutNetworkCurrentRevocationScore  :  Out Network Current Revocation Score
	OutNetworkPastExclusionScore  :  Out Network Past Exclusion Score
	OutNetworkPastRevocationScore   :  Out Network Past Revocation Score
	OutNetworkhasBankruptcyScore   :  Out Network has Bankruptcy Score
	OutNetworkhasCriminalHistoryScore   :  Out Network has Criminal History Score
	RelativeAssocCriminalScore  :  Relative Associate Criminal Score
	RelativeAssocBankruptcyScore  :  Relative Associate Bankruptcy Score

Outputs
    
	
	The plugin outputs the score fields for all the attributes along with the final professional cumulative score for the provider. The output is appened along with the input file columns with a prefix from the input parameter. 