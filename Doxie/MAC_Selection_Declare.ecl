export MAC_Selection_Declare := MACRO

boolean	  Always_Compute := false : stored('AlwaysCompute');
boolean	  Select_Indiv := false : stored('SelectIndividually');
Include_Them_All := (not Select_Indiv) or (Always_Compute);
//

boolean   Include_AKAs := false : stored('IncludeAKAs');
boolean   Include_Timeline := false : stored('IncludeTimeline');
boolean   Include_Imposters := false : stored('IncludeImposters');
boolean   Include_Associates := false : stored('IncludeAssociates');
boolean   Include_OldPhones  := false : stored('IncludeOldPhones');
boolean   Include_Properties := false : stored('IncludeProperties');
boolean   Include_PropertiesV2 := false : stored('IncludePropertiesV2');
boolean   Include_PriorProperties := false : stored('IncludePriorProperties');
boolean   Include_DriversLicenses := false : stored('IncludeDriversLicenses');
boolean   Include_MotorVehicles := false : stored('IncludeMotorVehicles');
boolean   Include_Bankruptcies := false : stored('IncludeBankruptcies');
boolean   Include_LiensJudgments := false : stored('IncludeLiensJudgments');
boolean   Include_CorporateAffiliations := false : stored('IncludeCorporateAffiliations');
boolean   Include_MerchantVessels := false : stored('IncludeMerchantVessels');
boolean   Include_UCCFilings := false : stored('IncludeUCCFilings');
boolean		Include_Dea		    := false : stored('IncludeDEARecords');
boolean   Include_InternetDomains := false : stored('IncludeInternetDomains');
boolean   Include_FAACertificates := false : stored('IncludeFAACertificates');
boolean   Include_CriminalRecords := false : stored('IncludeCriminalRecords');
boolean   Include_CensusData := false : stored('IncludeCensusData');
boolean   Include_Accidents := false : stored('IncludeAccidents');
boolean   Include_ProfessionalLicenses := false : stored('IncludeProfessionalLicenses');
boolean		Include_Sanctions := false : stored('IncludeSanctions');
boolean		Include_Providers := false : stored('IncludeProviders');
boolean		Include_Utility := false : stored('IncludeUtility');
boolean   Include_Email_Addresses := false : stored('IncludeEmailAddresses');
boolean		Include_PeopleAtWork	    := false : stored('IncludePeopleAtWork');
unsigned3 Max_PeopleAtWork := 50 : stored('MaxPeopleAtWork');
boolean   Include_VoterRegistrations := false : stored('IncludeVoterRegistrations');
boolean   Include_HuntingFishingLicenses := false : stored('IncludeHuntingFishingLicenses');
boolean   Include_FirearmsAndExplosives := false : stored('IncludeFirearmsAndExplosives');
boolean   Include_WeaponPermits := false : stored('IncludeWeaponPermits');
boolean   Include_SexualOffenses := false : stored('IncludeSexualOffenses');
boolean   Include_CivilCourts := false : stored('IncludeCivilCourts');
boolean   Include_FAAAircrafts := false : stored('IncludeFAAAircrafts');
boolean   Include_Watercrafts := false : stored('IncludeWatercrafts');
boolean   Include_MatrixCriminalHistory := false : stored('IncludeMatrixCriminalHistory');
boolean 	include_hri := false : stored('IncludeHRI');
boolean   Include_NoticeOfDefaults := false : stored('IncludeNoticeOfDefaults');
boolean   Include_Foreclosures := false : stored('IncludeForeclosures');
unsigned1 maxHriPer_value := 10 : stored('MaxHriPer');
boolean   Include_relatives := false : stored('IncludeRelatives');
unsigned3 Max_Relatives := 20 : stored('MaxRelatives');
unsigned3 Max_Associates := 25 : stored('MaxAssociates');
unsigned1 Relative_Depth := 1 : stored('RelativeDepth');
boolean   Include_RelativeAddresses := false : stored('IncludeRelativeAddresses');
boolean   Include_Neighbors := false : stored('IncludeNeighbors');
unsigned3 Max_Neighborhoods := 0 : stored('MaxNeighborhoods');
boolean IncludeDriversAtAddress := false : stored('IncludeDriversAtAddress');
boolean IncludePatriot := false : stored('IncludePatriot');
boolean IncludeFBN := false : stored('IncludeFBN');
boolean IncludeRTVeh := false : stored('IncludeRTVeh');
boolean AppendRTVeh := false : stored('AppendRTVeh');
boolean IncludeImages := false : stored('IncludeImages');
boolean IncludeStudentInformation := false : stored('IncludeStudentInformation');
boolean IncludeTransactionHistory := false : stored('IncludeTransactionHistory');
boolean IncludeCriminalIndicators := false : stored('IncludeCriminalIndicators');

// Infutor non regulated source
boolean IncludeNonRegulatedVehicleSources := false : stored('IncludeNonRegulatedVehicleSources');
boolean IncludeNonRegulatedWatercraftSources := false : stored('IncludeNonRegulatedWatercraftSources');

boolean   Include_HistoricalNeighbors := false : stored('IncludeHistoricalNeighbors');

boolean   Email_dedup := false : stored('DedupEmail'); // accurint comp report re-design for email dedup

//HistoricalNeighborhoodCount 
//HistoricalNeighborCount 
boolean   Law_Enforcement := false : stored('LawEnforcement');
boolean   Legacy_Verified_Value := false : stored('LegacyVerified');

//Other Selections
unsigned1 n_phones := 3 : stored('PhonesPerAddress');
unsigned1 Neighbors_PerAddress := 3 : stored('NeighborsPerAddress');
unsigned1 Neighbors_Per_NA := 6 : stored('NeighborsPerNA');
unsigned1 Neighbor_Recency := 3 : stored('NeighborRecency');
// generally, the radius of neighbors' units: houses, or appartments or etc.
unsigned1 neighbors_proximity := 10 : stored('NeighborsProximityRadius');

boolean   Use_CurrentlyOwnedProperty_value := doxie.stored_Use_CurrentlyOwnedProperty_value;
boolean		Use_CurrentlyOwnedVehicles_value := FALSE : stored('UseCurrentlyOwnedVehicles');

//*** BOOLEANS NOT SUBJECT TO SELECTINDIVIDUALLY
boolean Include_PhonesPlus_val 														:= false : stored('IncludePhonesPlus');
boolean Exclude_Sources_val 															:= false : stored('ExcludeSources');
boolean Exclude_ResidentsForAssociatesAddresses_val 			:= false : stored('ExcludeResidentsForAssociatesAddresses');

// Premium Phones
boolean Include_PremiumPhones_val := false : stored('IncludePremiumPhones');
set of string10 dedupPremiumPhones  := []  : stored('DedupPremiumPhones');

//*** Phones Feedback Option
boolean   IncludePhonesFeedback := false : stored('IncludePhonesFeedback');

// Added for the FDN project, 3 new input options & 3 required input fields  Add here or ???
boolean IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
boolean IncludeFDNSubjectOnly      := false : stored('IncludeFDNSubjectOnly');
boolean IncludeFDNAllAssociations  := false : stored('IncludeFDNAllAssociations');
unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

//*** BOOLEANS SUBJECT TO SELECTINDIVIDUALLY
Include_Timeline_val := Include_Them_All or Include_Timeline;
Include_relatives_val := Include_Them_All or Include_relatives;
Include_RelativeAddresses_val := Include_Them_All or Include_RelativeAddresses;//will effectively be false if Include_relatives_val is
Include_Bankruptcies_val := Include_Them_All or Include_Bankruptcies;
Include_Neighbors_val := Include_Them_All or Include_Neighbors;
Include_OldPhones_val := Include_Them_All or Include_OldPhones;
Include_Properties_val := Include_Them_All or Include_Properties;
Include_PropertiesV2_val := Include_Them_All or Include_PropertiesV2;
Include_DriversLicenses_val := Include_Them_All or Include_DriversLicenses;
Include_MotorVehicles_val := Include_Them_All or Include_MotorVehicles;
Include_CorporateAffiliations_val := Include_Them_All or Include_CorporateAffiliations;
Include_MerchantVessels_val := Include_Them_All or Include_MerchantVessels;
Include_UCCFilings_val := Include_Them_All or Include_UCCFilings;
Include_ProfessionalLicenses_val := Include_Them_All or Include_ProfessionalLicenses;
Include_Sanctions_val := Include_Them_All or Include_Sanctions;
Include_Providers_val := Include_Them_All or Include_Providers;
Include_Utility_val := Include_Them_All or Include_Utility;
Include_Email_Addresses_val := Include_Them_All or Include_Email_Addresses;
Include_PeopleAtWork_val := Include_them_All or Include_PeopleAtWork;
Include_VoterRegistrations_val := Include_Them_All or Include_VoterRegistrations;
Include_HuntingFishingLicenses_val := Include_Them_All or Include_HuntingFishingLicenses;
Include_FirearmsAndExplosives_val := Include_Them_All or Include_FirearmsAndExplosives;
Include_WeaponPermits_val := Include_Them_All or Include_WeaponPermits;
Include_SexualOffenses_val := Include_Them_All or Include_SexualOffenses;
Include_CriminalRecords_val := Include_Them_All or Include_CriminalRecords;
Include_Accidents_val := Include_Them_All or Include_Accidents;
Include_LiensJudgments_val := Include_Them_All or Include_LiensJudgments;
Include_Associates_val := Include_Them_All or Include_Associates;
Include_FAAAircrafts_val := Include_Them_All or Include_FAAAircrafts;
Include_Watercrafts_val := Include_Them_All or Include_Watercrafts;
Include_Imposters_val := Include_Them_All or Include_Imposters;
Include_AKAs_val := Include_Them_All or Include_AKAs;
Include_FAACertificates_val := Include_Them_All or Include_FAACertificates;
Include_CensusData_val := Include_Them_All or Include_CensusData;
Include_PriorProperties_val := Include_Them_All or Include_PriorProperties;
include_hri_val := Include_Them_All or include_hri;
include_NoticeOfDefaults_val := Include_Them_All or Include_NoticeOfDefaults;
include_foreclosures_val := Include_Them_All or Include_Foreclosures;
include_StudentInformation_val := Include_Them_All or IncludeStudentInformation;
include_CriminalIndicators_val := IncludeCriminalIndicators;

//Bug 10913
Include_CivilCourts_val := Include_Them_All or Include_CivilCourts;
//bug 10402 
Include_MatrixCriminalHistory_val := Include_Them_All or Include_MatrixCriminalHistory; 
//-bug-10409- FIXED now works as expected (do not remove)
Include_InternetDomains_val := Include_Them_All or Include_InternetDomains;

//bug 14161
Include_DEA_Val := Include_Them_All or Include_DEA;
// bug 29789
IncludeImages_val := Include_Them_All or IncludeImages;

//not being done now
Include_HistoricalNeighbors_val := Include_Them_All or Include_HistoricalNeighbors;
IncludeDriversAtAddress_val := Include_Them_All or IncludeDriversAtAddress;
IncludePatriot_val := Include_Them_All or IncludePatriot;
IncludeFBN_val := Include_Them_All or IncludeFBN;
IncludeRTVeh_val := Include_Them_All or IncludeRTVeh or AppendRTVeh;

email_dedup_val := email_dedup; // for accurint comp report re-design


// ------------ number of addresses to return ------------
unsigned2 tmp_Addresses := 1000 : stored('MaxAddresses'); // overall number of addresses in the output
unsigned1 Max_RelativeAddresses := 3 : stored('MaxRelativeAddresses'); // per each relative or associate
unsigned1 Addresses_PerNeighbor := 3 : stored('AddressesPerNeighbor');

// "MaxAddresses" input parameter is treated differently in Moxie and Roxie: 
//   Moxie: a limit for each section -- subject's, relatives', etc.
//   Roxie: a limit for a total number of addresses to return;

// To fix this discrepancy we will introduce a new tag in Roxie, which, 
// if provided, will overwrite the behavior controlled by 'MaxAddresses'
integer2 addr_subject := -1 : stored('MaxSubjectAddresses');

// define overall limit for new behavior (careful: addr_subject can be negative here)
// I really suspect that Addresses_PerNeighbor and Neighbors_Per_NA are almost the same, 
// but want to be on the safe side; it is also unclear how "historical" addresses affect the counts,
// so I simply use the same limit as for current neighbors.
res_in_addr := (Addresses_PerNeighbor + Neighbors_Per_NA);
unsigned2 addr_all := addr_subject + 
if (Include_Relatives_val and Include_RelativeAddresses_val, Max_Relatives * Max_RelativeAddresses, 0) +
if (Include_Associates_val, Max_Associates * Max_RelativeAddresses, 0) +
if (Include_Neighbors_val,  Max_Neighborhoods * Neighbors_PerAddress * res_in_addr, 0) +
if (Include_HistoricalNeighbors_val,  Max_Neighborhoods * Neighbors_PerAddress * res_in_addr, 0);


// overwrite legacy behavior, if new input is given:
unsigned2 Max_Addresses := if (addr_subject >= 0, addr_all, tmp_Addresses);

unsigned2 Addresses_PerSubject   := if (addr_subject >= 0, addr_subject, Max_Addresses);
// NB: in legacy case subject's address limit is the same as overall limit, which is not an issue,
// since we must guarantee that we return subject's address first, and only then others' addresses.
// --------------------------------------------------------

ENDMACRO;
