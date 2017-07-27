/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from neighborhood_safety.xml. ***/
/*===================================================*/

export neighborhood_safety := MODULE
			
export t_SafetyScores := record
	share.t_IntRange NeighborhoodScoreRange {xpath('NeighborhoodScoreRange')};
	share.t_IntRange FBIScoreRange {xpath('FBIScoreRange')};
	share.t_IntRange EASIScoreRange {xpath('EASIScoreRange')};
	integer NeighborhoodSafetyScore {xpath('NeighborhoodSafetyScore')};
	integer FBINationalScore {xpath('FBINationalScore')};
	string EASIQualityOfLife {xpath('EASIQualityOfLife')};
end;
		
export t_SexOffender := record
	string12 UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DOB {xpath('DOB')};
	integer3 Age {xpath('Age')};
	string Race {xpath('Race')};
	string Ethnicity {xpath('Ethnicity')};
	string Sex {xpath('Sex')};
	string HairColor {xpath('HairColor')};
	string EyeColor {xpath('EyeColor')};
	string Heigth {xpath('Heigth')};
	string Weight {xpath('Weight')};
	string SkinTone {xpath('SkinTone')};
	share.t_GeoAddress GeoAddress {xpath('GeoAddress')};
end;
		
export t_NeighborhoodSafetySearchBy := record
	share.t_Address Address {xpath('Address')};
end;
		
export t_NeighborhoodSafetySearchOptions := record (share.t_BaseSearchOption)
	integer StartingRecord {xpath('StartingRecord')};//hidden[unused]
end;
		
export t_NeighborhoodSafetyReportBy := record
	share.t_Address Address {xpath('Address')};
end;
		
export t_NeighborhoodSafetyReportOptions := record (share.t_BaseSearchOption)
	integer StartingRecord {xpath('StartingRecord')};//hidden[unused]
end;
		
export t_NeighborhoodSafetySearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_SafetyScores SafetyScores {xpath('SafetyScores')};
end;
		
export t_AddressRisk := record
	unsigned occupants {xpath('occupants')};
	unsigned Turnover1YearIn {xpath('Turnover1YearIn')};
	unsigned Turnover1YearOut {xpath('Turnover1YearOut')};
	unsigned Crimes {xpath('Crimes')};
	unsigned Crimes1Year {xpath('Crimes1Year')};
	unsigned Crimes2Year {xpath('Crimes2Year')};
	unsigned Foreclosures {xpath('Foreclosures')};
	unsigned Foreclosures1Year {xpath('Foreclosures1Year')};
	unsigned Foreclosures2Years {xpath('Foreclosures2Years')};
	unsigned SexOffenders {xpath('SexOffenders')};
	unsigned SexOffenders1Year {xpath('SexOffenders1Year')};
	unsigned SexOffenders2Years {xpath('SexOffenders2Years')};
	string CrimeIndex {xpath('CrimeIndex')};
	string PovertyIndex {xpath('PovertyIndex')};
	string ForeclosureIndex {xpath('ForeclosureIndex')};
	string DisruptionIndex {xpath('DisruptionIndex')};
	string MobilityIndex {xpath('MobilityIndex')};
	integer RiskIndex {xpath('RiskIndex')};
end;
		
export t_EASI := record
	string Population {xpath('Population')};
	string Families {xpath('Families')};
	string HouseHold {xpath('HouseHold')};
	string HouseHoldSize {xpath('HouseHoldSize')};
	string MedianAge {xpath('MedianAge')};
	string MedianRent {xpath('MedianRent')};
	string MedianHouseValue {xpath('MedianHouseValue')};
	string MedianYearBuilt {xpath('MedianYearBuilt')};
	string MedianHouseHoldIncome {xpath('MedianHouseHoldIncome')};
	string UrbanPercent {xpath('UrbanPercent')};
	string RuralPercent {xpath('RuralPercent')};
	string MarriedFamiliesPercent {xpath('MarriedFamiliesPercent')};
	string Families18YearsPercent {xpath('Families18YearsPercent')};
	string Families18YearsNotLivingAtHomePercent {xpath('Families18YearsNotLivingAtHomePercent')};
	string Child {xpath('Child')};
	string Young {xpath('Young')};
	string Retired {xpath('Retired')};
	string DivorcedFamiliesPercent {xpath('DivorcedFamiliesPercent')};
	string VacantPercent {xpath('VacantPercent')};
	string OccupiedUnitPercent {xpath('OccupiedUnitPercent')};
	string OwnerOccupied {xpath('OwnerOccupied')};
	string RentOccupied {xpath('RentOccupied')};
	string SingleFamilyDetachedUnitPercent {xpath('SingleFamilyDetachedUnitPercent')};
	string BigApartmentPercent {xpath('BigApartmentPercent')};
	string TrailerPercent {xpath('TrailerPercent')};
	string HigherRent {xpath('HigherRent')};
	string LowerRent {xpath('LowerRent')};
	string LowerHouseValue {xpath('LowerHouseValue')};
	string HigherHouseValue {xpath('HigherHouseValue')};
	string NewHouses {xpath('NewHouses')};
	string OldHouses {xpath('OldHouses')};
	string LowIncome {xpath('LowIncome')};
	string HighIncome {xpath('HighIncome')};
	string PopulationOver25 {xpath('PopulationOver25')};
	string PopulationOver18 {xpath('PopulationOver18')};
	string LowEducation {xpath('LowEducation')};
	string HighEducation {xpath('HighEducation')};
	string InCollege {xpath('InCollege')};
	string Unemployed {xpath('Unemployed')};
	string CivilEmployed {xpath('CivilEmployed')};
	string MilitaryEmployed {xpath('MilitaryEmployed')};
	string WhiteCollar {xpath('WhiteCollar')};
	string BlueCollar {xpath('BlueCollar')};
	string Murders {xpath('Murders')};
	string Rape {xpath('Rape')};
	string Robbery {xpath('Robbery')};
	string Assault {xpath('Assault')};
	string Burglary {xpath('Burglary')};
	string Larceny {xpath('Larceny')};
	string CarTheft {xpath('CarTheft')};
	string TotalCrime {xpath('TotalCrime')};
	string EasiqScore {xpath('EasiqScore')};
end;
		
export t_NeighborhoodStats := record
	unsigned VacantProperties {xpath('VacantProperties')};
	unsigned Business {xpath('Business')};
	unsigned SingleFamilyDwelling {xpath('SingleFamilyDwelling')};
	unsigned MultiFamilyDwelling {xpath('MultiFamilyDwelling')};
	unsigned CollegeAddress {xpath('CollegeAddress')};
	unsigned SeasonalAddress {xpath('SeasonalAddress')};
	unsigned POBOX {xpath('POBOX')};
	unsigned NoticeOfDefault {xpath('NoticeOfDefault')};
	unsigned NoticeOfDefault1Year {xpath('NoticeOfDefault1Year')};
	unsigned NoticeOfDefault2Year {xpath('NoticeOfDefault2Year')};
	unsigned NoticeOfDefault3Year {xpath('NoticeOfDefault3Year')};
	unsigned NoticeOfDefault4Year {xpath('NoticeOfDefault4Year')};
	unsigned NoticeOfDefault5Year {xpath('NoticeOfDefault5Year')};
	unsigned Foreclosures {xpath('Foreclosures')};
	unsigned Foreclosures1Year {xpath('Foreclosures1Year')};
	unsigned Foreclosures2Year {xpath('Foreclosures2Year')};
	unsigned Foreclosures3Year {xpath('Foreclosures3Year')};
	unsigned Foreclosures4Year {xpath('Foreclosures4Year')};
	unsigned Foreclosures5Year {xpath('Foreclosures5Year')};
	unsigned DeedTransfers {xpath('DeedTransfers')};
	unsigned DeedTransfers1Year {xpath('DeedTransfers1Year')};
	unsigned DeedTransfers2Year {xpath('DeedTransfers2Year')};
	unsigned DeedTransfers3Year {xpath('DeedTransfers3Year')};
	unsigned DeedTransfers4Year {xpath('DeedTransfers4Year')};
	unsigned DeedTransfers5Year {xpath('DeedTransfers5Year')};
	unsigned ReleaseLisPendens {xpath('ReleaseLisPendens')};
	unsigned ReleaseLisPendens1Year {xpath('ReleaseLisPendens1Year')};
	unsigned ReleaseLisPendens2Year {xpath('ReleaseLisPendens2Year')};
	unsigned ReleaseLisPendens3Year {xpath('ReleaseLisPendens3Year')};
	unsigned ReleaseLisPendens4Year {xpath('ReleaseLisPendens4Year')};
	unsigned ReleaseLisPendens5Year {xpath('ReleaseLisPendens5Year')};
	unsigned LiensRecentUnreleased {xpath('LiensRecentUnreleased')};
	unsigned LiensHistoricalUnreleased {xpath('LiensHistoricalUnreleased')};
	unsigned LiensRecentReleased {xpath('LiensRecentReleased')};
	unsigned LiensHistoricalReleased {xpath('LiensHistoricalReleased')};
	unsigned EvictionRecentUnreleased {xpath('EvictionRecentUnreleased')};
	unsigned EvictionHistoricalUnreleased {xpath('EvictionHistoricalUnreleased')};
	unsigned EvictionRecentReleased {xpath('EvictionRecentReleased')};
	unsigned EvictionHistoricalReleased {xpath('EvictionHistoricalReleased')};
	unsigned OccupantOwned {xpath('OccupantOwned')};
	unsigned BuildingAgeRecords {xpath('BuildingAgeRecords')};
	unsigned AverageBuildingAge {xpath('AverageBuildingAge')};
	unsigned PurchaseAmountRecords {xpath('PurchaseAmountRecords')};
	unsigned AveragePurchaseAmount {xpath('AveragePurchaseAmount')};
	unsigned MortgageAmountRecords {xpath('MortgageAmountRecords')};
	unsigned AverageMortgageAmount {xpath('AverageMortgageAmount')};
	unsigned AssessedAmountRecords {xpath('AssessedAmountRecords')};
	unsigned AverageAssessedAmount {xpath('AverageAssessedAmount')};
	unsigned BuildingAreaRecords {xpath('BuildingAreaRecords')};
	unsigned AverageBuildingArea {xpath('AverageBuildingArea')};
	unsigned PricePerSquareFootRecords {xpath('PricePerSquareFootRecords')};
	unsigned AveragePricePerSquareFoot {xpath('AveragePricePerSquareFoot')};
	unsigned NumberOfBuildingsRecords {xpath('NumberOfBuildingsRecords')};
	unsigned AverageNumberOfBuildings {xpath('AverageNumberOfBuildings')};
	unsigned NumberOfStoriesRecords {xpath('NumberOfStoriesRecords')};
	unsigned AverageNumberOfStories {xpath('AverageNumberOfStories')};
	unsigned NumberOfRoomsRecords {xpath('NumberOfRoomsRecords')};
	unsigned AverageNumberOfRooms {xpath('AverageNumberOfRooms')};
	unsigned NumberOfBedroomsRecords {xpath('NumberOfBedroomsRecords')};
	unsigned AverageNumberOfBedrooms {xpath('AverageNumberOfBedrooms')};
	unsigned NumberOfBathsRecords {xpath('NumberOfBathsRecords')};
	unsigned AverageNumberOfBaths {xpath('AverageNumberOfBaths')};
	unsigned NumberOfPartiaBathsRecords {xpath('NumberOfPartiaBathsRecords')};
	unsigned AverageNumberOfPartialBaths {xpath('AverageNumberOfPartialBaths')};
	unsigned TotalProperty {xpath('TotalProperty')};
	unsigned BankruptcyCount {xpath('BankruptcyCount')};
	unsigned Bankruptcy1yr {xpath('Bankruptcy1yr')};
	unsigned Bankruptcy2yr {xpath('Bankruptcy2yr')};
	unsigned Bankruptcy3yr {xpath('Bankruptcy3yr')};
	unsigned Bankruptcy4yr {xpath('Bankruptcy4yr')};
	unsigned Bankruptcy5yr {xpath('Bankruptcy5yr')};
	unsigned BankruptcyCh7 {xpath('BankruptcyCh7')};
	unsigned BankruptcyCh11 {xpath('BankruptcyCh11')};
	unsigned BankruptcyCh12 {xpath('BankruptcyCh12')};
	unsigned BankruptcyCh13 {xpath('BankruptcyCh13')};
	unsigned BankruptcyDischarged {xpath('BankruptcyDischarged')};
	unsigned BankruptcyDismissed {xpath('BankruptcyDismissed')};
	unsigned BankruptcySelfRepresenting {xpath('BankruptcySelfRepresenting')};
	unsigned BankruptcyBusinessFlag {xpath('BankruptcyBusinessFlag')};
	unsigned BankruptcyCorpFlag {xpath('BankruptcyCorpFlag')};
end;
		
export t_Facility := record
	string Name {xpath('Name')};
	string Institution {xpath('Institution')};
	string Distance {xpath('Distance')};
	share.t_GeoAddress GeoAddress {xpath('GeoAddress')};
end;
		
export t_PublicSafetyFacility := record (t_Facility)
	string BID {xpath('BID')};
	string Officers {xpath('Officers')};
	string PopulationPerOfficer {xpath('PopulationPerOfficer')};
	string Website {xpath('Website')};
	string Phone {xpath('Phone')};
end;
		
export t_NeighborhoodSafetyReport := record
	t_SafetyScores SafetyScores {xpath('SafetyScores')};
	t_AddressRisk AddressRisk {xpath('AddressRisk')};
	t_EASI Demographics {xpath('Demographics')};
	t_NeighborhoodStats NeighborhoodStats {xpath('NeighborhoodStats')};
	dataset(t_PublicSafetyFacility) PublicSafetyFacilities {xpath('PublicSafetyFacilities/PublicSafetyFacility'), MAXCOUNT(iesp.Constants.NeighborSafety.MaxPublicSafety)};
	dataset(t_Facility) CorrectionalFacilities {xpath('CorrectionalFacilities/CorrectionalFacility'), MAXCOUNT(iesp.Constants.NeighborSafety.MaxCorrecFacility)};
	dataset(t_SexOffender) SexOffenders {xpath('SexOffenders/SexOffender'), MAXCOUNT(iesp.Constants.NeighborSafety.MaxSexOffender)};
end;
		
export t_NeighborhoodSafetyReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_NeighborhoodSafetyReport Report {xpath('Report')};
end;
		
export t_NeighborhoodSafetySearchRequest := record (share.t_BaseRequest)
	t_NeighborhoodSafetySearchOptions Options {xpath('Options')};
	t_NeighborhoodSafetySearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_NeighborhoodSafetyReportRequest := record (share.t_BaseRequest)
	t_NeighborhoodSafetyReportOptions Options {xpath('Options')};
	t_NeighborhoodSafetyReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_NeighborhoodSafetySearchResponseEx := record
	t_NeighborhoodSafetySearchResponse response {xpath('response')};
end;
		
export t_NeighborhoodSafetyReportResponseEx := record
	t_NeighborhoodSafetyReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from neighborhood_safety.xml. ***/
/*===================================================*/

