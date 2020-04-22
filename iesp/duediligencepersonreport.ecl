/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from duediligencepersonreport.xml. ***/
/*===================================================*/

import iesp;

export duediligencepersonreport := MODULE
			
export t_DDRPersonSSNLexID := record
	string SSN {xpath('SSN')};
	string LexID {xpath('LexID')};
end;
		
export t_DDRPersonDOBAge := record
	iesp.share.t_Date DOB {xpath('DOB')};
	integer3 Age {xpath('Age')};
end;
		
export t_DDRPersonLexIDInformation := record
	string IdentityType {xpath('IdentityType')};
	string IdentityTypeDescription {xpath('IdentityTypeDescription')};
	iesp.share.t_Date IdentityDateAppeared {xpath('IdentityDateAppeared')};
	integer3 IdentityDateAppearedMonths {xpath('IdentityDateAppearedMonths')};
	integer3 IdentityDateAppearedYears {xpath('IdentityDateAppearedYears')};
	iesp.share.t_Date IdentityDateLastReported {xpath('IdentityDateLastReported')};
	integer3 IdentityDateLastReportedMonths {xpath('IdentityDateLastReportedMonths')};
	integer3 IdentityDateLastReportedYears {xpath('IdentityDateLastReportedYears')};
	dataset(iesp.share.t_Name) IdentityAKAs {xpath('IdentityAKAs/Identity'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxReportedAKAs)};
	dataset(t_DDRPersonDOBAge) IdentityReportedDOBs {xpath('IdentityReportedDOBs/Identity'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxReportedDOBs)};
	dataset(t_DDRPersonSSNLexID) IdentityReportedSSNs {xpath('IdentityReportedSSNs/Identity'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxSSNAssociations)};
	boolean LexIDReportedDeceased {xpath('LexIDReportedDeceased')};
	boolean LexIDBestSSNInvalid {xpath('LexIDBestSSNInvalid')};
	boolean LexIDMultipleSSNs {xpath('LexIDMultipleSSNs')};
end;
		
export t_DDRPersonLexIDSourcesReporting := record
	string SourceCategory {xpath('SourceCategory')};
	integer3 TimesReported {xpath('TimesReported')};
	iesp.share.t_Date FirstReported {xpath('FirstReported')};
	iesp.share.t_Date LastReported {xpath('LastReported')};
end;
		
export t_DDRPersonSSNDeviations := record
	iesp.share.t_Name name {xpath('name')};
	string LexID {xpath('LexID')};
	iesp.share.t_Date dob {xpath('dob')};
	iesp.share.t_Address address {xpath('address')};
	string Relative {xpath('Relative')};
	integer3 SSNTimesAssociated {xpath('SSNTimesAssociated')};
end;
		
export t_DDRPersonSources := record
	string SourceName {xpath('SourceName')};
	integer3 NumberOfTimesSeen {xpath('NumberOfTimesSeen')};
end;
		
export t_DDRPersonSSNDetails := record
	iesp.share.t_Date SSNFirstAssociated {xpath('SSNFirstAssociated')};
	iesp.share.t_Date SSNLastAssociated {xpath('SSNLastAssociated')};
	iesp.share.t_Date SSNIssuanceRangeLow {xpath('SSNIssuanceRangeLow')};
	iesp.share.t_Date SSNIssuanceRangeHigh {xpath('SSNIssuanceRangeHigh')};
	integer3 NumberOfTimesSSNAssociated {xpath('NumberOfTimesSSNAssociated')};
	string9 SSN {xpath('SSN')};
	string2 SSNIssuanceState {xpath('SSNIssuanceState')};
	boolean SSNRandomized {xpath('SSNRandomized')};
	boolean SSNEnumerationAtEntry {xpath('SSNEnumerationAtEntry')};
	boolean SSNIsITIN {xpath('SSNIsITIN')};
	boolean SSNInvalid {xpath('SSNInvalid')};
	boolean SSNIssuedPriorToDOB {xpath('SSNIssuedPriorToDOB')};
	boolean SSNRandomlyIssuedInvalid {xpath('SSNRandomlyIssuedInvalid')};
	boolean SSNReportedAsDeceased {xpath('SSNReportedAsDeceased')};
	dataset(t_DDRPersonSources) SourcesReporting {xpath('SourcesReporting/Source'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxReportingSources)};
	dataset(t_DDRPersonSSNDeviations) SSNDeviations {xpath('SSNDeviations/Deviation'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxSSNDeviations)};
end;
		
export t_DDRPersonSSNInformation := record
	t_DDRPersonSSNDetails InputSSNDetails {xpath('InputSSNDetails')};
	t_DDRPersonSSNDetails BestSSNDetails {xpath('BestSSNDetails')};
end;
		
export t_DDRIdentityAttributeDetails := record
	dataset(t_DDRPersonLexIDSourcesReporting) SourcesReporting {xpath('SourcesReporting/Source'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxReportingSources)};
	integer1 EstimatedAge {xpath('EstimatedAge')};
	integer3 NumberOfSourcesReporting {xpath('NumberOfSourcesReporting')};
	t_DDRPersonSSNInformation SSNInformation {xpath('SSNInformation')};
	t_DDRPersonLexIDInformation LexIDInformation {xpath('LexIDInformation')};
end;
		
export t_DDRExecutives := record (iesp.duediligenceshared.t_DDRPersonNameWithLexID)
	string ExecTitle {xpath('ExecTitle')};
	iesp.share.t_Date FirstReported {xpath('FirstReported')};
	iesp.share.t_Date LastReported {xpath('LastReported')};
end;
		
export t_DDRIndustryRisk := record
	string Code {xpath('Code')};
	string Description {xpath('Description')};
	string IndustryRisk {xpath('IndustryRisk')};
end;
		
export t_DDRBusinessAssocationDetails := record
	string BusinessName {xpath('BusinessName')};
	iesp.share.t_Address BusinessAddress {xpath('BusinessAddress')};
	string BusinessAddressType {xpath('BusinessAddressType')};
	string LexID {xpath('LexID')};
	t_DDRIndustryRisk BestNaics {xpath('BestNaics')};
	t_DDRIndustryRisk BestSic {xpath('BestSic')};
	t_DDRIndustryRisk HighestRisk {xpath('HighestRisk')};
	string StructureType {xpath('StructureType')};
	dataset(t_DDRExecutives) ExecutiveOfficers {xpath('ExecutiveOfficers/ExecutiveOfficer'), MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxBusinessExecs)};
	dataset(iesp.duediligenceshared.t_DDRPersonNameWithLexID) RegisteredAgents {xpath('RegisteredAgents/RegisteredAgent'), MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxRegisteredAgents)};
end;
		
export t_DDRBusinessAssociationDetails := record (t_DDRBusinessAssocationDetails)
end;
		
export t_DDRBusinessAssocations := record
	dataset(t_DDRBusinessAssocationDetails) Associations {xpath('Associations/Association'), MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxBusAssociations)};
end;
		
export t_DDRBusinessAssociations := record
	dataset(t_DDRBusinessAssociationDetails) Associations {xpath('Associations/Association'), MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxBusAssociations)};
end;
		
export t_DDRPersonInformation := record
	string LexID {xpath('LexID')};
	iesp.share.t_Name InputName {xpath('InputName')};
	iesp.share.t_Name BestName {xpath('BestName')};
	iesp.share.t_Address InputAddress {xpath('InputAddress')};
	string InputAddressType {xpath('InputAddressType')};
	iesp.share.t_Address BestAddress {xpath('BestAddress')};
	string BestAddressType {xpath('BestAddressType')};
	string9 InputSSN {xpath('InputSSN')};
	string9 BestSSN {xpath('BestSSN')};
	iesp.share.t_Date InputDOB {xpath('InputDOB')};
	integer2 InputAge {xpath('InputAge')};
	iesp.share.t_Date BestDOB {xpath('BestDOB')};
	integer2 BestAge {xpath('BestAge')};
	string10 InputPhone {xpath('InputPhone')};
	string10 BestPhone {xpath('BestPhone')};
end;
		
export t_DDRInquiredOrSpouseOwnership := record
	boolean SubjectOwned {xpath('SubjectOwned')};
	boolean SpouseOwned {xpath('SpouseOwned')};
	dataset(iesp.duediligenceshared.t_DDRPersonNameWithLexID) Owners {xpath('Owners/Owner'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxPropertyOwners)};
end;
		
export t_DDRPersonProperty := record (iesp.duediligenceshared.t_DDRProperty)
	dataset(iesp.duediligenceshared.t_DDRPersonNameWithLexID) Owners {xpath('Owners/Owner'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxPropertyOwners)};
	boolean Vacant {xpath('Vacant')};
	boolean SubjectOwned {xpath('SubjectOwned')};
	boolean SpouseOwned {xpath('SpouseOwned')};
	t_DDRInquiredOrSpouseOwnership OwnershipType {xpath('OwnershipType')};
end;
		
export t_DDRPersonPropertyOwnership := record
	integer2 PropertyCurrentCount {xpath('PropertyCurrentCount')};
	integer8 TaxAssessedValue {xpath('TaxAssessedValue')};
	dataset(t_DDRPersonProperty) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxProperties)};
end;
		
export t_DDRPersonVehicle := record (iesp.duediligenceshared.t_DDRMotorVehicle)
	t_DDRInquiredOrSpouseOwnership OwnershipType {xpath('OwnershipType')};
end;
		
export t_DDRPersonVehicleOwnership := record
	dataset(t_DDRPersonVehicle) MotorVehicles {xpath('MotorVehicles/MotorVehicle'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxVehicles)};
end;
		
export t_DDRPersonWatercraft := record (iesp.duediligenceshared.t_DDRWatercraft)
	t_DDRInquiredOrSpouseOwnership OwnershipType {xpath('OwnershipType')};
end;
		
export t_DDRPersonWatercraftOwnership := record
	dataset(t_DDRPersonWatercraft) Watercrafts {xpath('Watercrafts/Watercraft'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxWatercraft)};
end;
		
export t_DDRPersonAircraft := record (iesp.duediligenceshared.t_DDRAircraft)
	t_DDRInquiredOrSpouseOwnership OwnershipType {xpath('OwnershipType')};
end;
		
export t_DDRPersonAircraftOwnership := record
	dataset(t_DDRPersonAircraft) Aircrafts {xpath('Aircrafts/Aircraft'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxAircraft)};
end;
		
export t_DDRPersonEconomicAttributeDetails := record
	t_DDRPersonPropertyOwnership Property {xpath('Property')};
	t_DDRPersonVehicleOwnership Vehicle {xpath('Vehicle')};
	t_DDRPersonWatercraftOwnership Watercraft {xpath('Watercraft')};
	t_DDRPersonAircraftOwnership Aircraft {xpath('Aircraft')};
	integer8 EstimatedIncome {xpath('EstimatedIncome')};
end;
		
export t_DDRPersonProfessionalNetworkDetails := record
	dataset(iesp.duediligenceshared.t_DDRProfessionalLicenses) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLicenses)};
end;
		
export t_DDRPersonCriminalEvents := record
	iesp.duediligenceshared.t_DDRLegalEventIndividual PersonInfo {xpath('PersonInfo')};
	dataset(iesp.duediligenceshared.t_DDRLegalStateCriminal) Criminals {xpath('Criminals/Criminal'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLegalEvents)};
end;
		
export t_DDRPersonLegalAttributeDetails := record
	dataset(t_DDRPersonCriminalEvents) PossibleLegalEvents {xpath('PossibleLegalEvents/PossibleLegalEvent'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLegalEvents)};
	dataset(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) PossibleLiensJudgmentsEvictions {xpath('PossibleLiensJudgmentsEvictions/PossibleLiensJudgmentsEviction'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLienJudgementsEvictions)};
end;
		
export t_DDRPersonGeographicResidentTenantRisk := record
	integer NumberCurrentResidentTenant {xpath('NumberCurrentResidentTenant')};
	integer NumberRelatives {xpath('NumberRelatives')};
	integer NumberBusinessAssociates {xpath('NumberBusinessAssociates')};
	integer NumberHighRiskProfServiceProvidersOrFieldOfStudy {xpath('NumberHighRiskProfServiceProvidersOrFieldOfStudy')};
	integer NumberPotentialCriminalRecordsArrests {xpath('NumberPotentialCriminalRecordsArrests')};
	integer NumberPotentialSexOffenders {xpath('NumberPotentialSexOffenders')};
end;
		
export t_DDRPersonGeographicAreaInformation := record
	string AreaRisk {xpath('AreaRisk')};
	string ResidencyStatus {xpath('ResidencyStatus')};
	string ResidencyType {xpath('ResidencyType')};
end;
		
export t_DDRPersonAddressDetails := record
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date AddressFirstSeenDate {xpath('AddressFirstSeenDate')};
	iesp.share.t_Date AddressLastSeenDate {xpath('AddressLastSeenDate')};
	string AddressType {xpath('AddressType')};
	integer MilesFromPreviousResidence {xpath('MilesFromPreviousResidence')};
	t_DDRPersonGeographicAreaInformation AreaInformation {xpath('AreaInformation')};
	t_DDRPersonGeographicResidentTenantRisk ResidentTenantRisk {xpath('ResidentTenantRisk')};
end;
		
export t_DDRPersonGeographicAttributeDetails := record
	integer NumberCurrentResidence {xpath('NumberCurrentResidence')};
	integer NumberPriorResidence {xpath('NumberPriorResidence')};
	dataset(t_DDRPersonAddressDetails) ResidenceDetails {xpath('ResidenceDetails/ResidenceDetail'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxResidence)};
end;
		
export t_DDRPersonAssociationRelationshipDetails := record
	iesp.share.t_Name Name {xpath('Name')};
	string PossibleRelationship {xpath('PossibleRelationship')};
	t_DDRPersonSSNLexID SSNLexID {xpath('SSNLexID')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Address Address {xpath('Address')};
	boolean TrafficRelated {xpath('TrafficRelated')};
	boolean AllOtherCriminalRecords {xpath('AllOtherCriminalRecords')};
end;
		
export t_DDRPersonAssociations := record
	integer NumberRelatives {xpath('NumberRelatives')};
	integer NumberOtherAssociates {xpath('NumberOtherAssociates')};
	dataset(t_DDRPersonAssociationRelationshipDetails) RelationDetails {xpath('RelationDetails/RelationDetail'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxPersonAssociations)};
end;
		
export t_DDRPersonAttributeDetails := record
	t_DDRPersonLegalAttributeDetails Legal {xpath('Legal')};
	t_DDRPersonEconomicAttributeDetails Economic {xpath('Economic')};
	t_DDRPersonProfessionalNetworkDetails ProfessionalNetwork {xpath('ProfessionalNetwork')};
	t_DDRIdentityAttributeDetails Identitiy {xpath('Identitiy')};
	t_DDRBusinessAssocations BusinessAssocation {xpath('BusinessAssocation')};
	t_DDRPersonGeographicAttributeDetails Geographic {xpath('Geographic')};
	t_DDRPersonAssociations PersonAssociation {xpath('PersonAssociation')};
end;
		
export t_DDRPersonReport := record
	t_DDRPersonInformation PersonInformation {xpath('PersonInformation')};
	t_DDRPersonAttributeDetails PersonAttributeDetails {xpath('PersonAttributeDetails')};
end;
		
export t_DDRPersonReportBy := record
	iesp.duediligenceshared.t_DDRAttributesPerson Person {xpath('Person')};
end;
		
export t_DDRPersonResult := record
	string12 UniqueId {xpath('UniqueId')};
	t_DDRPersonReportBy InputEcho {xpath('InputEcho')};
	iesp.duediligenceshared.t_DDRAttributeGroup AttributeGroup {xpath('AttributeGroup')};
	t_DDRPersonReport PersonReport {xpath('PersonReport')};
	iesp.duediligenceshared.t_DDRAttributesAdditionalInfo AdditionalInput {xpath('AdditionalInput')};
	integer PersonLexIDMatch {xpath('PersonLexIDMatch')};
end;
		
export t_DueDiligencePersonReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_DDRPersonResult Result {xpath('Result')};
end;
		
export t_DueDiligencePersonReportRequest := record (iesp.share.t_BaseRequest)
	iesp.duediligenceshared.t_DDRAttributesOptions Options {xpath('Options')};
	t_DDRPersonReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_DueDiligencePersonReportResponseEx := record
	t_DueDiligencePersonReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from duediligencepersonreport.xml. ***/
/*===================================================*/

