/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from propassess.xml. ***/
/*===================================================*/

import iesp;

export propassess := MODULE
			
export t_AssessSearchBy := record
	string60 CompanyName {xpath('CompanyName')};
	string45 ParcelId {xpath('ParcelId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_AssessOption := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_BaseAssessEntities := record
	dataset(iesp.property.t_OriginalName) OriginalNames {xpath('OriginalNames/OriginalName'), MAXCOUNT(iesp.Constants.Prop.MaxOriginalNames)};
end;
		
export t_AssessEntities := record (t_BaseAssessEntities)
	dataset(iesp.property.t_Property2Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.Prop.MaxNames)};
end;
		
export t_BaseAssessRecord := record
	string1 DataSource {xpath('DataSource')};
	string12 SourcePropertyRecordId {xpath('SourcePropertyRecordId')};
	string12 RecordType {xpath('RecordType')};
	string45 ParcelNumber {xpath('ParcelNumber')};
	string45 ParcelId {xpath('ParcelId')};
	string5 FipsCode {xpath('FipsCode')};
	string47 AssesseeOwnershipRights {xpath('AssesseeOwnershipRights')};
	string47 AssesseeRelationship {xpath('AssesseeRelationship')};
	string15 SalePrice {xpath('SalePrice')};
	integer TaxYear {xpath('TaxYear')};
	string15 TaxAmount {xpath('TaxAmount')};
	string15 AssessedValue {xpath('AssessedValue')};
	string60 SellerName {xpath('SellerName')};
	string60 Owner1Name {xpath('Owner1Name')};
	string60 Owner2Name {xpath('Owner2Name')};
	string60 MortgageLenderName {xpath('MortgageLenderName')};
	string10 LandUseCode {xpath('LandUseCode')};
	string40 LandUsage {xpath('LandUsage')};
	iesp.share.t_Date SaleDate {xpath('SaleDate')};
	iesp.share.t_Date RecordingDate {xpath('RecordingDate')};
	iesp.share.t_Address PropertyAddress {xpath('PropertyAddress')};
	iesp.share.t_Address OwnerAddress {xpath('OwnerAddress')};
	string3 HomesteadExemption {xpath('HomesteadExemption')};
	iesp.share.t_Date PriorSaleDate {xpath('PriorSaleDate')};
	string31 MortgageLoanType {xpath('MortgageLoanType')};
	dataset(iesp.share.t_StringArrayItem) Sellers {xpath('Sellers/Name'), MAXCOUNT(iesp.Constants.PROP.MaxSellers)};
	dataset(iesp.share.t_StringArrayItem) Buyers {xpath('Buyers/Name'), MAXCOUNT(iesp.Constants.PROP.MaxBuyers)};
	dataset(iesp.share.t_StringArrayItem) Owners {xpath('Owners/Name'), MAXCOUNT(iesp.Constants.PROP.MaxOwners)};
end;
		
export t_AssessRecord := record (t_BaseAssessRecord)
	t_AssessEntities Sellers2 {xpath('Sellers2')};
	t_AssessEntities Buyers2 {xpath('Buyers2')};
	t_AssessEntities Owners2 {xpath('Owners2')};
end;
		
export t_AssessSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_AssessRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.PROP.MaxCountSearchAssessments)};
end;
		
export t_AssessReportBy := record
	string12 SourcePropertyRecordId {xpath('SourcePropertyRecordId')};
end;
		
export t_AssessReportOption := record (iesp.share.t_BaseReportOption)
	boolean IncludeAllRecords {xpath('IncludeAllRecords')};
end;
		
export t_BaseAssessReportRecord := record (t_BaseAssessRecord)
	string40 SubdivisionName {xpath('SubdivisionName')};
	integer YearBuilt {xpath('YearBuilt')};
	string10 LotNumber {xpath('LotNumber')};
	string15 LandValue {xpath('LandValue')};
	string15 ImprovementValue {xpath('ImprovementValue')};
	string15 TotalValue {xpath('TotalValue')};
	string15 MarketLandValue {xpath('MarketLandValue')};
	string15 MarketImprovementValue {xpath('MarketImprovementValue')};
	string15 TotalMarketValue {xpath('TotalMarketValue')};
	string9 LivingSize {xpath('LivingSize')};
	string9 LandSize {xpath('LandSize')};
	integer NumberStories {xpath('NumberStories')};
	integer NumberBedrooms {xpath('NumberBedrooms')};
	integer NumberFullBaths {xpath('NumberFullBaths')};
	integer NumberHalfBaths {xpath('NumberHalfBaths')};
	string54 LegalDescription {xpath('LegalDescription')};
	string10 Book {xpath('Book')};
	string10 Page {xpath('Page')};
	string15 LoanAmount {xpath('LoanAmount')};
	string30 ExteriorWalls {xpath('ExteriorWalls')};
	string28 Heating {xpath('Heating')};
	string31 Foundation {xpath('Foundation')};
	string30 GarageDescription {xpath('GarageDescription')};
	string20 RoofDescription {xpath('RoofDescription')};
	string28 ACDescription {xpath('ACDescription')};
end;
		
export t_AssessReportRecord := record (t_BaseAssessReportRecord)
	t_AssessEntities Sellers2 {xpath('Sellers2')};
	t_AssessEntities Buyers2 {xpath('Buyers2')};
	t_AssessEntities Owners2 {xpath('Owners2')};
end;
		
export t_AssessReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_AssessReportRecord) AssessRecords {xpath('AssessRecords/AssessRecord'), MAXCOUNT(iesp.Constants.PROP.MaxCountReportAssessments)};
end;
		
export t_AssessSearchRequest := record (iesp.share.t_BaseRequest)
	t_AssessSearchBy SearchBy {xpath('SearchBy')};
	t_AssessOption Options {xpath('Options')};
end;
		
export t_AssessReportRequest := record (iesp.share.t_BaseRequest)
	t_AssessReportBy ReportBy {xpath('ReportBy')};
	t_AssessReportOption Options {xpath('Options')};
end;
		
export t_AssessSearchResponseEx := record
	t_AssessSearchResponse response {xpath('response')};
end;
		
export t_AssessReportResponseEx := record
	t_AssessReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from propassess.xml. ***/
/*===================================================*/

