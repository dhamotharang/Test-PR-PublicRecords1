/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from dmap.xml. ***/
/*===================================================*/

import iesp;

export dmap := MODULE
					
export t_DMAPReportBy := record
	string12 UniqueId {xpath('UniqueId')};
	string30 LoanPurpose {xpath('LoanPurpose')};
	iesp.share.t_Address PropertyAddress {xpath('PropertyAddress')};
end;
		
export t_DMAPOption := record (iesp.share.t_BaseReportOption)
end;
		
export t_DMAPAddressInfo := record (iesp.share.t_Address)
	string2 YearsAtAddress {xpath('YearsAtAddress')};
	string2 InferredOwnershipTypeIndex {xpath('InferredOwnershipTypeIndex')};
	string2 VerificationOfOccupancyScore {xpath('VerificationOfOccupancyScore')};
	iesp.share.t_Date VerificationOfOccupancyAsOfDate {xpath('VerificationOfOccupancyAsOfDate')};
	string1 OwnOrRent {xpath('OwnOrRent')};
end;
		
export t_DMAPBorrowerInfo := record
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	string11 SSN {xpath('SSN')};
	iesp.share.t_MaskableDate DOB {xpath('DOB')};
	string10 Phone1 {xpath('Phone1')};
	string10 Phone2 {xpath('Phone2')};
	t_DMAPAddressInfo CurrentAddress {xpath('CurrentAddress')};
	t_DMAPAddressInfo PriorAddress {xpath('PriorAddress')};
end;
		
export t_DMAPPropertyBase := record
	iesp.share.t_Address Address {xpath('Address')};
	string76 PropertyType {xpath('PropertyType')};
end;
		
export t_DMAPPropertyInfo := record
	iesp.share.t_Address Address {xpath('Address')};
	string24 BorrowerVestingDescription {xpath('BorrowerVestingDescription')};
	string24 BuyerVestingDescription {xpath('BuyerVestingDescription')};
	string5 NoOfUnits {xpath('NoOfUnits')};
	string76 PropertyType {xpath('PropertyType')};
	string250 LegalDescription {xpath('LegalDescription')};
	string4 YearBuilt {xpath('YearBuilt')};
	string4 YearLotAcquired {xpath('YearLotAcquired')};
	string11 OriginalCost {xpath('OriginalCost')};
	string13 RealEstateTaxesCurrentProperty {xpath('RealEstateTaxesCurrentProperty')};
end;
		
export t_DMAPReportResult := record
	t_DMAPBorrowerInfo Borrower {xpath('Borrower')};
	t_DMAPPropertyInfo SubjectProperty {xpath('SubjectProperty')};
	dataset(t_DMAPPropertyBase) OwnedProperties {xpath('OwnedProperties/OwnedProperty'), MAXCOUNT(iesp.Constants.DMAP_MAX_COUNT_OWNED_PROPERTIES)};
end;
		
export t_DMAPReportResponse := record (iesp.share.t_BaseResponse)
	t_DMAPReportBy InputEcho {xpath('InputEcho')};
	t_DMAPReportResult Result {xpath('Result')};
end;
		
export t_DMAPReportRequest := record (iesp.share.t_BaseRequest)
	t_DMAPOption Options {xpath('Options')};
	t_DMAPReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_DMAPReportResponseEx := record
	t_DMAPReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from dmap.xml. ***/
/*===================================================*/

