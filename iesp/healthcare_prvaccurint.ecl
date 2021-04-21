/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface Handcrafted ***/
/*===================================================*/


export healthcare_prvaccurint := MODULE
			
export t_HealthCareAccurintHCPSearchOption := record (iesp.healthcare_accurintcommon.t_HCSearchOption) 
	string15 DOBMask {xpath('DOBMask')};//hidden[internal]
	boolean IncludeProvidersOnly {xpath('IncludeProvidersOnly')};
	boolean IncludeSanctionsOnly {xpath('IncludeSanctionsOnly')};
	boolean IncludeBoardCertifiedSpecialty {xpath('IncludeBoardCertifiedSpecialty')};
	boolean IncludeABMSCareer {xpath('IncludeABMSCareer')};
	boolean IncludeABMSEducation {xpath('IncludeABMSEducation')};
	boolean IncludeABMSProfessionalAssociations {xpath('IncludeABMSProfessionalAssociations')};
	boolean IncludeABMSTypeOfPractice {xpath('IncludeABMSTypeOfPractice')};
	boolean IncludeFein {xpath('IncludeFein')};
end;
export t_HCPName := record
	integer		nameSeq {xpath('nameSeq')};
	string120 FullName {xpath('FullName')};
	string20 	FirstName {xpath('FirstName')};
	string20 	MiddleName {xpath('MiddleName')};
	string20 	LastName {xpath('LastName')};
	string5 	Suffix {xpath('Suffix')};
	string4 	Title {xpath('Title')};
	string6 	Gender {xpath('Gender')};
end;
export t_HealthCareAccurintHCPSearchBy := record (iesp.healthcare_accurintcommon.t_HCSearchBy)
	string acctno {xpath('acctno')}; 
	string did {xpath('did')};//DID
	string TaxId {xpath('TaxId')};
	string20 name_first {xpath('name_first')};
	string20 name_middle {xpath('name_middle')};
	string20 name_last {xpath('name_last')};
	string5	name_suffix {xpath('name_suffix')};
	string8 DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
	string UPIN {xpath('UPIN')};
	string MedicalSchoolName {xpath('MedicalSchoolName')};
	integer GraduationYear {xpath('GraduationYear')};
	string BoardCertifiedSpecialty2 {xpath('BoardCertifiedSpecialty2')};
	string BoardCertifiedSpecialty3 {xpath('BoardCertifiedSpecialty3')};
	string BoardCertifiedSpecialty4 {xpath('BoardCertifiedSpecialty4')};
	string BoardCertifiedSpecialty5 {xpath('BoardCertifiedSpecialty5')};
	string BoardCertifiedSubSpecialty2 {xpath('BoardCertifiedSubSpecialty2')};
	string BoardCertifiedSubSpecialty3 {xpath('BoardCertifiedSubSpecialty3')};
	string BoardCertifiedSubSpecialty4 {xpath('BoardCertifiedSubSpecialty4')};
	string BoardCertifiedSubSpecialty5 {xpath('BoardCertifiedSubSpecialty5')};
end;
export t_HCMedicalSchool := record
	string120 Name {xpath('Name')};
	integer GraduationYear {xpath('GraduationYear')};
end;
EXPORT t_ssns := record
	string12 ssn {xpath('ssn')};
end;
EXPORT t_dob := record
	string8 dob {xpath('dob')};
end;
EXPORT t_did := record
	integer did {xpath('did')};
end;
EXPORT t_taxid := record
	string11 taxid {xpath('taxid')};
end;
EXPORT t_upin := record
	string upin {xpath('upin')};
end;
export t_HCabmsAddress := record
	iesp.healthcare_accurintcommon.t_HCAddress address  {xpath('address')};
	string   	addressseqid {xpath('addressseqid')};
	string1  	addresstype {xpath('addresstype')};
	string   	addresstypedesc {xpath('addresstypedesc')};
	iesp.share.t_date datefirstseen {xpath('datefirstseen')};
	iesp.share.t_date datelastseen {xpath('datelastseen')};
end;
export t_HCabmsContact := record
	string6  	contacttype {xpath('contacttype')};
	string250	contactdescription {xpath('contactdescription')};
	string   	phonenumber {xpath('phonenumber')};
	string   	website {xpath('website')};
	iesp.share.t_date datefirstseen {xpath('datefirstseen')};
	iesp.share.t_date datelastseen {xpath('datelastseen')};
end;
export t_HCABMSTypeOfPractice := record
	string1  	recordtype {xpath('recordtype')};
	string60 	typeofpractice {xpath('typeofpractice')};
	string   	otherinfo {xpath('otherinfo')};
	iesp.share.t_date datefirstreported {xpath('datefirstreported')};
	iesp.share.t_date datelastreported {xpath('datelastreported')};
end;
export t_HCABMSCertificate := record
	string1  	recordtype {xpath('recordtype')};
	string5  	seq {xpath('seq')};
	string100	certificatename {xpath('certificatename')};
	string100	issuingboard {xpath('issuingboard')};
	string10 	certificatetypeid {xpath('certificatetypeid')};
	string1  	certificatetype {xpath('certificatetype')};
	string1  	recertificateind {xpath('recertificateind')};
	string1  	boardcertified {xpath('boardcertified')};
	iesp.share.t_date issuedate {xpath('issuedate')};
	iesp.share.t_date expiredate {xpath('expiredate')};
	iesp.share.t_date reverificationdate {xpath('reverificationdate')};
	string2  	durationtype {xpath('durationtype')};
	string   	durationtypedesc {xpath('durationtypedesc')};
	string8  	mocpathwayid {xpath('mocpathwayid')};
	string200	mocpathwayname {xpath('mocpathwayname')};
	iesp.share.t_date datefirstreported {xpath('datefirstreported')};
	iesp.share.t_date datelastreported {xpath('datelastreported')};
end;
export t_HCABMSCareer := record
	string1  	recordtype {xpath('recordtype')};
	string5  	seq {xpath('seq')};
	string230	organization {xpath('organization')};
	string100	specialty {xpath('specialty')};
	string150	position {xpath('position')};
	string3  	careertype {xpath('careertype')};
	string   	careertypedesc {xpath('careertypedesc')};
	string4  	fromyear {xpath('fromyear')};
	string4  	toyear {xpath('toyear')};
	string25 	city {xpath('city')};
	string2  	state {xpath('state')};
	string40 	country {xpath('country')};
	iesp.share.t_date datefirstreported {xpath('datefirstreported')};
	iesp.share.t_date datelastreported {xpath('datelastreported')};
end;
export t_HCABMSEducation := record
	string1  	recordtype {xpath('recordtype')};
	string5  	seq {xpath('seq')};
	string150	degree {xpath('degree')};
	string5  	schoolcode {xpath('schoolcode')};
	string150	school {xpath('school')};
	string75 	years {xpath('years')};
	string25 	city {xpath('city')};
	string2  	state {xpath('state')};
	string40 	country {xpath('country')};
	iesp.share.t_date datefirstreported {xpath('datefirstreported')};
	iesp.share.t_date datelastreported {xpath('datelastreported')};
end;
export t_HCABMSProfessionalAssociation := record
	string1  	recordtype {xpath('recordtype')};
	string25 	organization {xpath('organization')};
	string55 	positionheldyears {xpath('positionheldyears')};
	iesp.share.t_date datefirstreported {xpath('datefirstreported')};
	iesp.share.t_date datelastreported {xpath('datelastreported')};
end;
export t_HCABMSResults := record
	string1  	dataindicator {xpath('dataindicator')};
	boolean  	isinputnpimatched {xpath('isinputnpimatched')};
	boolean  	isderivednpimatched {xpath('isderivednpimatched')};
	string15 	derivednpi {xpath('derivednpi')};
	boolean  	isaddresssuppressed {xpath('isaddresssuppressed')};
	integer 	_penalty {xpath('_penalty')};
	string   	accountnumber {xpath('accountnumber')};
	iesp.healthcare_accurintcommon.t_HCCommonName name {xpath('name')};
	string15 	npinumber {xpath('npinumber')};
	string10 	abmsbiogid {xpath('abmsbiogid')};
	dataset(t_HCabmsAddress) addresses {xpath('addresses/address'), MAXCOUNT(iesp.constants.HPR.MAX_NAMES)};
	dataset(t_HCabmsContact) contacts  {xpath('contacts/contact'), MAXCOUNT(iesp.constants.HPR.MAX_NAMES)};
	string60 	organization {xpath('')};
	string6  	gender {xpath('gender')};
	string1  	boardcertified {xpath('boardcertified')};
	boolean  	isdeceased {xpath('isdeceased')};
	iesp.share.t_date 	dod {xpath('dod')};
	iesp.share.t_date 	dob {xpath('dob')};
	string67 	dobcity {xpath('dobcity')};
	string2  	dobstate {xpath('dobstate')};
	string67 	dobnation {xpath('dobnation')};
	string1  	mocparticipation {xpath('mocparticipation')};
	iesp.share.t_date datefirstseen {xpath('datefirstseen')};
	iesp.share.t_date datelastseen {xpath('datelastseen')};
	dataset(iesp.share.t_StringArrayItem) uniqueids {xpath('uniqueids/uniqueid'), MAXCOUNT(iesp.constants.HPR.MAX_UNIQUEIDS)};
	dataset(iesp.share.t_StringArrayItem) businessids {xpath('businessids/businessid'), MAXCOUNT(iesp.constants.HPR.MAX_BDIDS)};
	dataset(iesp.share.t_StringArrayItem) recordsources {xpath('recordsources/recordsource'), MAXCOUNT(iesp.constants.HPR.MAX_UNIQUEIDS)};
	dataset(t_HCABMSTypeOfPractice) typeofpractices {xpath('TypeOfPractices/TypeOfPractice'), MAXCOUNT(iesp.constants.HPR.Max_ABMS_TypeOfPractice)};
	dataset(t_HCABMSCertificate) certifications {xpath('Certifications/Certification'), MAXCOUNT(iesp.constants.HPR.Max_ABMS_Certifications)};
	dataset(t_HCABMSCareer) careerhistory {xpath('CareerHistory/Career'), MAXCOUNT(iesp.constants.HPR.Max_ABMS_Career)};
	dataset(t_HCABMSEducation) educationhistory {xpath('EducationHistory/Education'), MAXCOUNT(iesp.constants.HPR.Max_ABMS_Education)};
	dataset(t_HCABMSProfessionalAssociation) professionalassociations  {xpath('ProfessionalAssociations/Association'), MAXCOUNT(iesp.constants.HPR.Max_ABMS_Memberships)};
END;	
EXPORT t_language := RECORD	
	STRING40  Language {xpath('Language')};
	UNSIGNED2 LanguageTierTypeID {xpath('LanguageTierTypeID')};
END;
EXPORT t_medschool := RECORD		     
	string20	acctno {xpath('acctno')};
	unsigned6 ProviderID {xpath('ProviderID')};
	string 		group_key {xpath('group_key')};
	STRING12  BDID {xpath('BDID')};
	STRING120 MedSchoolName {xpath('MedSchoolName')};
	STRING4   GraduationYear {xpath('GraduationYear')};
	UNSIGNED2 MedSchoolTierTypeID {xpath('MedSchoolTierTypeID')};
END;		
		
export t_HealthCareAccurintHCPSearchProvider := record 
		iesp.healthcare_accurintcommon.t_HCResultsHeader;
		dataset(t_HCPName) Names {xpath('Names/Name'), MAXCOUNT(iesp.constants.HPR.MAX_NAMES)};
		dataset(t_did) dids {xpath('DIDs/DID'), MAXCOUNT(iesp.constants.HPR.Max_Small_Cnt)};
		dataset(t_taxid) taxids {xpath('TaxIDs/TaxID'), MAXCOUNT(iesp.constants.HPR.MAX_TAXIDS)};
		dataset(t_upin) upins {xpath('Upins/Upin'), MAXCOUNT(iesp.constants.HPR.MAX_UPINS)};
		dataset(t_ssns) ssns  {xpath('SSNs/SSN'), MAXCOUNT(iesp.constants.HPR.MAX_SSNS)};
		dataset(t_dob) dobs {xpath('DOBs/DOB'), MAXCOUNT(iesp.constants.HPR.MAX_DOBS)};
		boolean	DeathLookup {xpath('DeathLookup')};
		string8	DateofDeath  {xpath('DateofDeath')};
		iesp.healthcare_accurintcommon.t_HCResultsCommon;
		dataset(iesp.share.t_StringArrayItem) Degrees {xpath('Degrees/Degree'), MAXCOUNT(iesp.constants.HPR.MAX_DEGREES)};
		dataset(t_language) Languages {xpath('Languages/Language'), MAXCOUNT(iesp.constants.HPR.MAX_LANGUAGES)};
		dataset(t_medschool) MedSchools {xpath('MedicalSchools/MedicalSchool'), MAXCOUNT(iesp.constants.HPR.MAX_MEDICALSCHOOLS)};
		iesp.healthcare_accurintcommon.t_HCResultsRaw;
		dataset(t_HCABMSResults) abmsRaw {xpath('abmsRaws/abmsRaw'), MAXCOUNT(iesp.constants.HPR.Max_ABMS_ADDRESSES)};
		boolean	srcIndividualHeader {xpath('srcIndividualHeader')};
end;
		
export t_HealthCareAccurintHCPSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_HealthCareAccurintHCPSearchBy SearchBy {xpath('SearchBy')};
	t_HealthCareAccurintHCPSearchOption Options {xpath('Options')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_HealthCareAccurintHCPSearchProvider) healthcareproviders {xpath('healthcareproviders/Row'), MAXCOUNT(iesp.constants.HPR.Max_Cnt_Search)};
end;
		
export t_HealthCareAccurintHCPSearchRequest := record (iesp.share.t_BaseRequest)
	t_HealthCareAccurintHCPSearchOption Options {xpath('Options')};
	t_HealthCareAccurintHCPSearchBy SearchBy {xpath('SearchBy')};
end;
export t_HealthCareAccurintHCPBatchSearchRequest := record (iesp.share.t_BaseRequest)
	t_HealthCareAccurintHCPSearchOption Options {xpath('Options')};
	dataset(t_HealthCareAccurintHCPSearchBy) SearchBy {xpath('SearchBy/row'), MAXCOUNT(100)};
end;
		
export t_HealthCareAccurintHCPSearchRequestEx := record
	t_HealthCareAccurintHCPSearchRequest criteria {xpath('criteria/row')};
end;
export t_HealthCareAccurintHCPBatchRequestEx := record
	t_HealthCareAccurintHCPBatchSearchRequest criteria {xpath('batch_in/row')};
end;
export t_HealthCareAccurintHCPSearchResponseEx := record
	t_HealthCareAccurintHCPSearchResponse response {xpath('response')};
end;
		

end;

/*===================================================*/

