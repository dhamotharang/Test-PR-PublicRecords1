/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from addressreportreq.xml. ***/
/*===================================================*/

export addressreportreq := MODULE
			
export t_AddressReportOption := record (iesp.share.t_BaseReportOption)
	boolean IncludeProperties {xpath('IncludeProperties')};
	integer MaxProperties {xpath('MaxProperties')};
	boolean IncludeDriversLicenses {xpath('IncludeDriversLicenses')};
	integer MaxDriversLicenses {xpath('MaxDriversLicenses')};
	boolean IncludeMotorVehicles {xpath('IncludeMotorVehicles')};
	integer MaxMotorVehicles {xpath('MaxMotorVehicles')};
	boolean IncludeBusinesses {xpath('IncludeBusinesses')};
	integer MaxBusinesses {xpath('MaxBusinesses')};
	boolean IncludeNeighbors {xpath('IncludeNeighbors')};
	integer NeighborCount {xpath('NeighborCount')};
	integer MaxNeighbors {xpath('MaxNeighbors')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
	integer MaxBankruptcies {xpath('MaxBankruptcies')};
	boolean IncludeResidentialPhones {xpath('IncludeResidentialPhones')};
	integer MaxResidentialPhones {xpath('MaxResidentialPhones')};
	boolean IncludeBusinessPhones {xpath('IncludeBusinessPhones')};
	integer MaxBusinessPhones {xpath('MaxBusinessPhones')};
	boolean IncludeCensusData {xpath('IncludeCensusData')};
	integer MaxResidents {xpath('MaxResidents')};//hidden[internal]
	boolean IncludeLiensJudgments {xpath('IncludeLiensJudgments')};
	integer MaxLiens {xpath('MaxLiens')};
	boolean IncludeCriminalRecords {xpath('IncludeCriminalRecords')};
	integer MaxCriminalRecords {xpath('MaxCriminalRecords')};
	boolean IncludeSexualOffenses {xpath('IncludeSexualOffenses')};
	integer MaxSexualOffenses {xpath('MaxSexualOffenses')};
	boolean IncludeJailBookings {xpath('IncludeJailBookings')};
	integer MaxJailBookings {xpath('MaxJailBookings')};
	boolean IncludeHuntingFishings {xpath('IncludeHuntingFishings')};
	integer MaxHuntingFishings {xpath('MaxHuntingFishings')};
	boolean IncludeConcealedWeapons {xpath('IncludeConcealedWeapons')};
	integer MaxConcealedWeapons {xpath('MaxConcealedWeapons')};
	boolean LocationReportOnly {xpath('LocationReportOnly')};
	boolean UseNewBusinessHeader {xpath('UseNewBusinessHeader')};//hidden[internal]
	string1 BusinessReportFetchLevel {xpath('BusinessReportFetchLevel')}; //values['S','D','E','W','P','O','U','','']
	iesp.share.t_RelationshipOption RelationshipOption {xpath('RelationshipOption')};//hidden[internal]
end;
		
export t_AddressReportBy := record
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_AddressReportRequest := record (iesp.share.t_BaseRequest)
	t_AddressReportOption Options {xpath('Options')};
	t_AddressReportBy ReportBy {xpath('ReportBy')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from addressreportreq.xml. ***/
/*===================================================*/

