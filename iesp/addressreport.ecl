/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from addressreport.xml. ***/
/*===================================================*/

import iesp;

export addressreport := MODULE
			
export t_AddrReportRealTimePhone := record (iesp.share.t_PhoneInfoEx)
	string CarrierName {xpath('CarrierName')};
end;
		
export t_AddrReportPresentResident := record
	iesp.share.t_Identity Identity {xpath('Identity')};
	dataset(iesp.share.t_Identity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.AR.MaxAKAs)};
	string3 Height {xpath('Height')};
	string3 Weight {xpath('Weight')};
	string3 HairColor {xpath('HairColor')};
	string3 EyeColor {xpath('EyeColor')};
	iesp.share.t_AddressEx Address {xpath('Address')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	dataset(t_AddrReportRealTimePhone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.constants.BR.MaxAddress_Phones)};
end;
		
export t_AddrReportPriorResident := record
	iesp.share.t_Identity Identity {xpath('Identity')};
	dataset(iesp.share.t_Identity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.AR.MaxAKAs)};
	iesp.share.t_Address CurrentAddress {xpath('CurrentAddress')};
	iesp.share.t_PhoneInfo CurrentPhone {xpath('CurrentPhone')};
end;
		
export t_AddrReportResidents := record
	dataset(t_AddrReportPresentResident) Present {xpath('Present/Resident'), MAXCOUNT(iesp.constants.AR.MaxResidents)};
	dataset(t_AddrReportPriorResident) Prior {xpath('Prior/Resident'), MAXCOUNT(iesp.constants.AR.MaxResidents)};
	string Remark {xpath('Remark')};
end;
		
export t_AddrReportDriverLicense := record
	string14 LicenseNumber {xpath('LicenseNumber')};
	iesp.share.t_Date IssueDate {xpath('IssueDate')};
	string2 IssueState {xpath('IssueState')};
	string4 LicenseType {xpath('LicenseType')};
	string14 Attention {xpath('Attention')};
	string4 LicenseTypeCode {xpath('LicenseTypeCode')};
	string42 RestrictionCodes {xpath('RestrictionCodes')};
	dataset(iesp.share.t_StringArrayItem) Restrictions {xpath('Restrictions/Restriction'), MAXCOUNT(iesp.constants.AR.MaxRestrictions)};
	string10 EndorsementCodes {xpath('EndorsementCodes')};
	dataset(iesp.share.t_StringArrayItem) Endorsements {xpath('Endorsements/Endorsement'), MAXCOUNT(iesp.constants.AR.MaxEndorsements)};
	iesp.share.t_Date ExpirationDate {xpath('ExpirationDate')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string1 Sex {xpath('Sex')};
	string3 Race {xpath('Race')};
	string3 Height {xpath('Height')};
	string3 Weight {xpath('Weight')};
	string3 HairColor {xpath('HairColor')};
	string3 EyeColor {xpath('EyeColor')};
	string1 History {xpath('History')};
	string25 StateName {xpath('StateName')};
	string Src {xpath('Src')};//hidden[internal]
	string NonDMVSource {xpath('NonDMVSource')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_AddrReportDLs := record
	dataset(iesp.bps_share.t_BpsReportDriverLicense) Present2 {xpath('Present/DriverLicense'), MAXCOUNT(iesp.constants.AR.MaxDLs)};
	dataset(iesp.bps_share.t_BpsReportDriverLicense) Prior2 {xpath('Prior/DriverLicense'), MAXCOUNT(iesp.constants.AR.MaxDLs)};
end;
		
export t_AddrReportProperties := record
	dataset(iesp.bpsreport.t_BpsReportProperty) Present {xpath('Present/Property'), MAXCOUNT(iesp.constants.AR.MaxProperties)};
	dataset(iesp.bpsreport.t_BpsReportProperty) Prior {xpath('Prior/Property'), MAXCOUNT(iesp.constants.AR.MaxProperties)};
	string Remark {xpath('Remark')};
end;
		
export t_AddrReportBusIdentity := record
	string120 Name {xpath('Name')};
	string10 Phone10 {xpath('Phone10')};
	string9 FEIN {xpath('FEIN')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
end;
		
export t_AddrReportBusiness := record
	dataset(t_AddrReportBusIdentity) Identities {xpath('Identities/Identity'), MAXCOUNT(iesp.constants.AR.MaxBusiness)};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_AddrReportBusinesses := record
	dataset(t_AddrReportBusiness) Present {xpath('Present/Business'), MAXCOUNT(iesp.constants.AR.MaxBusiness)};
	dataset(t_AddrReportBusiness) Prior {xpath('Prior/Business'), MAXCOUNT(iesp.constants.AR.MaxBusiness)};
	string Remark {xpath('Remark')};
end;
		
export t_AddrReportVehicle := record
	dataset(iesp.motorvehicle.t_MVReportRecord) Prior {xpath('Prior/Vehicle'), MAXCOUNT(iesp.constants.AR.MaxVehicles)};
	dataset(iesp.motorvehicle.t_MVReportRecord) Present {xpath('Present/Vehicle'), MAXCOUNT(iesp.constants.AR.MaxVehicles)};
end;
		
export t_AddressReportNeighbors := record
	string Remark {xpath('Remark')};
	dataset(iesp.bpsreport.t_NeighborSlim) Neighbors2 {xpath('Neighbors2/Neighbor'), MAXCOUNT(iesp.constants.AR.MaxNeighbors)};
end;
		
export t_AddrReportPhone := record
	dataset(iesp.share.t_PhoneInfo) Business {xpath('Business/Phone'), MAXCOUNT(iesp.constants.AR.MaxPhonesBus)};
	dataset(iesp.share.t_PhoneInfo) Residential {xpath('Residential/Phone'), MAXCOUNT(iesp.constants.AR.MaxPhonesRes)};
end;
		
export t_AddrReportLiensJudgments := record
	string Remark {xpath('Remark')};
	dataset(iesp.bizreport.t_BizLienJudgment) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.constants.AR.MaxLiens)};
end;
		
export t_AddrReportCriminalRecords := record
	string64 Remark {xpath('Remark')};
	dataset(iesp.criminal.t_CrimReportRecord) CriminalRecords {xpath('CriminalRecords/CriminalRecord'), MAXCOUNT(iesp.constants.AR.MaxCriminals)};
end;
		
export t_AddrReportSexOffenses := record
	string64 Remark {xpath('Remark')};
	dataset(iesp.sexualoffender.t_OffenderRecord) SexualOffenses {xpath('SexualOffenses/SexualOffense'), MAXCOUNT(iesp.constants.AR.MaxSexOffenders)};
end;
		
export t_AddrReportJailBookings := record
	string64 Remark {xpath('Remark')};
	dataset(iesp.jailbooking.t_JailBookingReportRecord) JailBookings {xpath('JailBookings/JailBooking'), MAXCOUNT(iesp.constants.AR.MaxJailBooking)};
end;
		
export t_AddrReportHuntingFishings := record
	string64 Remark {xpath('Remark')};
	dataset(iesp.huntingfishing.t_HuntFishRecord) HuntingFishings {xpath('HuntingFishings/HuntingFishing'), MAXCOUNT(iesp.constants.AR.MaxHuntingAndFishing)};
end;
		
export t_AddrReportConcealedWeapons := record
	string64 Remark {xpath('Remark')};
	dataset(iesp.concealedweapon.t_WeaponRecord) ConcealedWeapons {xpath('ConcealedWeapons/ConcealedWeapon'), MAXCOUNT(iesp.constants.AR.MaxConcealedWeapons)};
end;
		
export t_AddrReportRelativeAssociate := record
	string12 ResidentUniqueId {xpath('ResidentUniqueId')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
	string15 RelationshipType {xpath('RelationshipType')};//hidden[internal]
	string10 RelationshipConfidence {xpath('RelationshipConfidence')};//hidden[internal]
end;
		
export t_AddrReportPossibleVehicles := record
	integer YearMake {xpath('YearMake')};
	string36 Make {xpath('Make')};
	string36 Model {xpath('Model')};
	string30 MajorColor {xpath('MajorColor')};
	string30 MinorColor {xpath('MinorColor')};
	string25 BodyStyle {xpath('BodyStyle')};
	iesp.share.t_Name RegistrantName {xpath('RegistrantName')};
	iesp.share.t_Address RegistrantAddress {xpath('RegistrantAddress')};
	string25 VIN {xpath('VIN')};
	string PlateNumber {xpath('PlateNumber')};
	string12 ResidentUniqueId {xpath('ResidentUniqueId')};
	boolean AssociatedToReportAddress {xpath('AssociatedToReportAddress')};
end;
		
export t_AddrReportIdentitySlim := record
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
end;
		
export t_AddrReportPossibleOccupants := record
	iesp.share.t_Address Address {xpath('Address')};
	dataset(t_AddrReportIdentitySlim) Occupants {xpath('Occupants/Identity'), MAXCOUNT(iesp.Constants.BR.MaxAddress_Residents)};
	dataset(iesp.share.t_PhoneInfoEx) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BR.MaxAddress_Phones)};
end;
		
export t_AddrReportPossibleOwner := record
	iesp.share.t_NameAndCompany Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
end;
		
export t_AddrReportPossibleCriminal := record
	string OffenderId {xpath('OffenderId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string25 OffenseState {xpath('OffenseState')};
	string45 DataSource {xpath('DataSource')};
	string35 CaseNumber {xpath('CaseNumber')};
end;
		
export t_AddrReportPossibleSexOffense := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string3 Height {xpath('Height')};
	string3 Weight {xpath('Weight')};
	string30 Race {xpath('Race')};
	dataset(iesp.sexualoffender.t_SexOffReportConviction) Convictions {xpath('Convictions/Conviction'), MAXCOUNT(iesp.Constants.SEXOFF_MAX_COUNT_CONVICTIONS)};
	string50 OffenderStatus {xpath('OffenderStatus')};
	string200 ScarsMarksTattoos {xpath('ScarsMarksTattoos')};
	string150 ImageLink {xpath('ImageLink')};
end;
		
export t_AddrReportPossibleHuntingFishing := record
	iesp.share.t_Name Name {xpath('Name')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Address Address {xpath('Address')};
	string20 LicenseType {xpath('LicenseType')};
	string20 HomeState {xpath('HomeState')};
	string20 LicenseState {xpath('LicenseState')};
	iesp.share.t_Date IssueDate {xpath('IssueDate')};
	string12 ResidentUniqueId {xpath('ResidentUniqueId')};
	boolean AssociatedToReportAddress {xpath('AssociatedToReportAddress')};
end;
		
export t_AddrReportPossibleNeighbors := record
	dataset(t_AddrReportPossibleOwner) PossibleOwners {xpath('PossibleOwners/PossibleOwner'), MAXCOUNT(iesp.Constants.AR.MaxOwners)};
	dataset(t_AddrReportPossibleVehicles) PossibleVehicles {xpath('PossibleVehicles/PossibleVehicle'), MAXCOUNT(iesp.constants.AR.MaxVehicles)};
	dataset(t_AddrReportPossibleOccupants) PossibleOccupants {xpath('PossibleOccupants/PossibleOccupant'), MAXCOUNT(iesp.constants.AR.MaxPossibleOccupants)};
	dataset(t_AddrReportBusiness) PossibleBusinesses {xpath('PossibleBusinesses/PossibleBusiness'), MAXCOUNT(iesp.constants.AR.MaxBusiness)};
	dataset(t_AddrReportPossibleCriminal) PossibleCriminalRecords {xpath('PossibleCriminalRecords/PossibleCriminalRecord'), MAXCOUNT(iesp.constants.AR.MaxCriminals)};
	dataset(t_AddrReportPossibleSexOffense) PossibleSexualOffenses {xpath('PossibleSexualOffenses/PossibleSexualOffense'), MAXCOUNT(iesp.constants.AR.MaxSexOffenders)};
	dataset(iesp.concealedweapon.t_WeaponRecord) PossibleConcealedWeapons {xpath('PossibleConcealedWeapons/PossibleConcealedWeapon'), MAXCOUNT(iesp.constants.AR.MaxConcealedWeapons)};
	dataset(t_AddrReportPossibleHuntingFishing) PossibleHuntingsFishings {xpath('PossibleHuntingsFishings/PossibleHuntingFishing'), MAXCOUNT(iesp.constants.AR.MaxHuntingandFishing)};
end;
		
export t_AddressReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_AddrReportResidents Residents {xpath('Residents')};
	iesp.bpsreport.t_BpsReportCensusData CensusData {xpath('CensusData')};
	dataset(iesp.motorvehicle.t_MVReportRecord) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(iesp.constants.AR.MaxVehicles)};
	dataset(iesp.share.t_PhoneInfo) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.constants.AR.MaxPhones)};
	t_AddrReportVehicle VehiclesX {xpath('VehiclesX')};
	t_AddrReportPhone PhonesX {xpath('PhonesX')};
	iesp.share.t_Address Address {xpath('Address')};
	t_AddrReportDLs DriverLicenses {xpath('DriverLicenses')};
	t_AddrReportProperties Properties {xpath('Properties')};
	t_AddressReportNeighbors Neighbors {xpath('Neighbors')};
	t_AddrReportBusinesses Businesses {xpath('Businesses')};
	dataset(iesp.bankruptcy.t_BankruptcyReportRecord) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.constants.AR.MaxBankruptcies)};
	t_AddrReportLiensJudgments LiensJudgments {xpath('LiensJudgments')};
	t_AddrReportCriminalRecords CriminalRecords {xpath('CriminalRecords')};
	t_AddrReportSexOffenses SexualOffenses {xpath('SexualOffenses')};
	t_AddrReportJailBookings JailBookings {xpath('JailBookings')};
	t_AddrReportHuntingFishings HuntingFishings {xpath('HuntingFishings')};
	t_AddrReportConcealedWeapons ConcealedWeapons {xpath('ConcealedWeapons')};
	dataset(t_AddrReportRelativeAssociate) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.constants.AR.MaxRelatives)};
	dataset(t_AddrReportRelativeAssociate) Associates {xpath('Associates/Associate'), MAXCOUNT(iesp.constants.AR.MaxAssociates)};
	t_AddrReportPossibleNeighbors PossibleNeighbors {xpath('PossibleNeighbors')};
end;
		
export t_AddressReportResponseEx := record
	t_AddressReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from addressreport.xml. ***/
/*===================================================*/

