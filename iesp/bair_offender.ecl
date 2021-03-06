/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_offender.xml. ***/
/*===================================================*/

import iesp;

export bair_offender := MODULE
			
export t_BAIROffenderBaseRecord := record
	string OffenderID {xpath('OffenderID')};
	string OffenderPK {xpath('OffenderPK')};
	string PhotoURL {xpath('PhotoURL')};
	string Address {xpath('Address')};
	iesp.share.t_Address AddressClean {xpath('AddressClean')};
	string LexID {xpath('LexID')};
	string FirstName {xpath('FirstName')};
	string MiddleName {xpath('MiddleName')};
	string LastName {xpath('LastName')};
	string Moniker {xpath('Moniker')};
	string NameType {xpath('NameType')};
	string DOB {xpath('DOB')};
	string Race {xpath('Race')};
	string Sex {xpath('Sex')};
	string Hair {xpath('Hair')};
	string HairLength {xpath('HairLength')};
	string Eyes {xpath('Eyes')};
	string HandUse {xpath('HandUse')};
	string Speech {xpath('Speech')};
	string Teeth {xpath('Teeth')};
	string PhysicalCondition {xpath('PhysicalCondition')};
	string Build {xpath('Build')};
	string Complexion {xpath('Complexion')};
	string FacialHair {xpath('FacialHair')};
	string Hat {xpath('Hat')};
	string Mask {xpath('Mask')};
	string Glasses {xpath('Glasses')};
	string Appearance {xpath('Appearance')};
	string Shirt {xpath('Shirt')};
	string Pants {xpath('Pants')};
	string Shoes {xpath('Shoes')};
	string Jacket {xpath('Jacket')};
	string Weight1 {xpath('Weight1')};
	string Weight2 {xpath('Weight2')};
	string Height1 {xpath('Height1')};
	string Height2 {xpath('Height2')};
	string Age1 {xpath('Age1')};
	string Age2 {xpath('Age2')};
	string AgencyName {xpath('AgencyName')};
	string SID {xpath('SID')};
	string DLNumber {xpath('DLNumber')};
	string DLState {xpath('DLState')};
	string FBINumber {xpath('FBINumber')};
	string EditDate {xpath('EditDate')};
	string AdminState {xpath('AdminState')};
	string Category {xpath('Category')};
	string Level {xpath('Level')};
	string Score {xpath('Score')};
	string CaseReferenceNumber {xpath('CaseReferenceNumber')};
	string ChargeOffense {xpath('ChargeOffense')};
	string ProbationType {xpath('ProbationType')};
	string ProbationOfficer {xpath('ProbationOfficer')};
	string WarrantType {xpath('WarrantType')};
	string WarrantNumber {xpath('WarrantNumber')};
	string GangName {xpath('GangName')};
	string GangRole {xpath('GangRole')};
	string ClassificationDate {xpath('ClassificationDate')};
	string ExpirationDate {xpath('ExpirationDate')};
	string Expired {xpath('Expired')};
	string XCoordinate {xpath('XCoordinate')};
	string YCoordinate {xpath('YCoordinate')};
	string Classification {xpath('Classification')};
	boolean ImageAvailable {xpath('ImageAvailable')};
end;
		
export t_BAIROffenderSearchBy := record (iesp.bair_share.t_BAIRBaseModeSearchBy)
end;
		
export t_BAIROffenderSearchOption := record (iesp.bair_share.t_BAIRBaseSearchOption)
	boolean IncludeNotes {xpath('IncludeNotes')};
	boolean Raids {xpath('Raids')};
	boolean ApplyOffenderDates {xpath('ApplyOffenderDates')};
end;
		
export t_BAIROffenderSearchRecord := record
	string EntityID {xpath('EntityID')};
	string UCRGroup {xpath('UCRGroup')};
	string Class {xpath('Class')};
	string OffenderID {xpath('OffenderID')};
	string OffenderPK {xpath('OffenderPK')};
	string PhotoURL {xpath('PhotoURL')};
	string Address {xpath('Address')};
	iesp.share.t_Address AddressClean {xpath('AddressClean')};
	string Distance {xpath('Distance')};
	string LexID {xpath('LexID')};
	string FirstName {xpath('FirstName')};
	string MiddleName {xpath('MiddleName')};
	string LastName {xpath('LastName')};
	string Moniker {xpath('Moniker')};
	string NameType {xpath('NameType')};
	string DOB {xpath('DOB')};
	string Race {xpath('Race')};
	string Sex {xpath('Sex')};
	string Hair {xpath('Hair')};
	string HairLength {xpath('HairLength')};
	string Eyes {xpath('Eyes')};
	string HandUse {xpath('HandUse')};
	string Speech {xpath('Speech')};
	string Teeth {xpath('Teeth')};
	string PhysicalCondition {xpath('PhysicalCondition')};
	string Build {xpath('Build')};
	string Complexion {xpath('Complexion')};
	string FacialHair {xpath('FacialHair')};
	string Hat {xpath('Hat')};
	string Mask {xpath('Mask')};
	string Glasses {xpath('Glasses')};
	string Appearance {xpath('Appearance')};
	string Shirt {xpath('Shirt')};
	string Pants {xpath('Pants')};
	string Shoes {xpath('Shoes')};
	string Jacket {xpath('Jacket')};
	string Weight1 {xpath('Weight1')};
	string Weight2 {xpath('Weight2')};
	string Height1 {xpath('Height1')};
	string Height2 {xpath('Height2')};
	string Age1 {xpath('Age1')};
	string Age2 {xpath('Age2')};
	string Accuracy {xpath('Accuracy')};
	string Agency {xpath('Agency')};
	string AgencyName {xpath('AgencyName')};
	string SID {xpath('SID')};
	string DLNumber {xpath('DLNumber')};
	string DLState {xpath('DLState')};
	string FBINumber {xpath('FBINumber')};
	string OffenderNotes {xpath('OffenderNotes')};
	string EditDate {xpath('EditDate')};
	string Quarantined {xpath('Quarantined')};
	string AdminState {xpath('AdminState')};
	string Category {xpath('Category')};
	string Level {xpath('Level')};
	string Score {xpath('Score')};
	string BAIRScore {xpath('BAIRScore')};
	string CaseReferenceNumber {xpath('CaseReferenceNumber')};
	string ChargeOffense {xpath('ChargeOffense')};
	string ProbationType {xpath('ProbationType')};
	string ProbationOfficer {xpath('ProbationOfficer')};
	string WarrantType {xpath('WarrantType')};
	string WarrantNumber {xpath('WarrantNumber')};
	string GangName {xpath('GangName')};
	string GangRole {xpath('GangRole')};
	string ClassificationDate {xpath('ClassificationDate')};
	string ExpirationDate {xpath('ExpirationDate')};
	string Expired {xpath('Expired')};
	string XCoordinate {xpath('XCoordinate')};
	string YCoordinate {xpath('YCoordinate')};
	string ProviderId {xpath('ProviderId')};
	string Classification {xpath('Classification')};
	string UserText1 {xpath('UserText1')};
	string UserText2 {xpath('UserText2')};
	string UserInteger {xpath('UserInteger')};
	string UserFloat {xpath('UserFloat')};
	string UserDateTime {xpath('UserDateTime')};
	string ORI {xpath('ORI')};
	boolean ImageAvailable {xpath('ImageAvailable')};
end;
		
export t_BAIROffenderSearchResponse := record (iesp.bair_share.t_BAIRBaseSearchResponse)
	dataset(t_BAIROffenderSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.bair_constants.MAX_SEARCH_RESULTS)};
end;
		
export t_BAIROffenderSearchRequest := record
	iesp.bair_share.t_BAIRUser User {xpath('User')};
	t_BAIROffenderSearchOption Options {xpath('Options')};
	t_BAIROffenderSearchBy SearchBy {xpath('SearchBy')};
	iesp.bair_share.t_BAIRContext BAIRContext {xpath('BAIRContext')};//hidden[ecl_only]
end;
		
export t_BAIROffenderSearchResponseEx := record
	t_BAIROffenderSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_offender.xml. ***/
/*===================================================*/

