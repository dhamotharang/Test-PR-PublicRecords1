export death := MODULE
			
export t_DeathSearchBy := record (share.t_BaseSearchBy)
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_DeathSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_DeathSearchDecedent := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	string Sex {xpath('Sex')};
	string Race {xpath('Race')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
end;
		
export t_DeathSearchDecedentFamily := record
	string Father {xpath('Father')};
	string Mother {xpath('Mother')};
end;
		
export t_DeathSearchDeathInfo := record
	string IssuingAuthority {xpath('IssuingAuthority')};
	string CertificateNumber {xpath('CertificateNumber')};
	string DeathLocation {xpath('DeathLocation')};
end;
		
export t_DeathSearchRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	string StateDeathId {xpath('StateDeathId')};
	string VerifiedOrProved {xpath('VerifiedOrProved')};
	boolean IsStateSource {xpath('IsStateSource')};
	t_DeathSearchDecedent Decedent {xpath('Decedent')};
	t_DeathSearchDecedentFamily Family {xpath('Family')};
	t_DeathSearchDeathInfo DeathInfo {xpath('DeathInfo')};
end;
		
export t_DeathSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_DeathSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_DeathReportBy := record
	string UniqueId {xpath('UniqueId')};
	string StateDeathId {xpath('StateDeathId')};
end;
		
export t_DeathReportOption := record (share.t_BaseReportOption)
end;
		
export t_DeathReportDecedent := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	string Sex {xpath('Sex')};
	string Race {xpath('Race')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	string BirthPlace {xpath('BirthPlace')};
	integer DeathAge {xpath('DeathAge')};
	string DeathAgeUnit {xpath('DeathAgeUnit')};
	string BirthCertificateNumber {xpath('BirthCertificateNumber')};
	string BirthVolYear {xpath('BirthVolYear')};
	string Education {xpath('Education')};
	boolean ArmedForces {xpath('ArmedForces')};
	string Occupation {xpath('Occupation')};
	string MaritalStatus {xpath('MaritalStatus')};
end;
		
export t_DeathReportDecedentFamily := record
	string Father {xpath('Father')};
	string Mother {xpath('Mother')};
end;
		
export t_DeathReportDeathInfo := record
	string IssuingAuthority {xpath('IssuingAuthority')};
	string CertificateNumber {xpath('CertificateNumber')};
	share.t_Date CertificateFileDate {xpath('CertificateFileDate')};
	string CertificateVolNumber {xpath('CertificateVolNumber')};
	integer CertificateVolYear {xpath('CertificateVolYear')};
	string LocalFileNumber {xpath('LocalFileNumber')};
	string FuneralHomeLicenseNumber {xpath('FuneralHomeLicenseNumber')};
	string EmbalmerLicenseNumber {xpath('EmbalmerLicenseNumber')};
	string ZipLastPayment {xpath('ZipLastPayment')};
	string CauseOfDeath {xpath('CauseOfDeath')};
	string TimeOfDeath {xpath('TimeOfDeath')};
	string DeathLocation {xpath('DeathLocation')};
	string Facilty {xpath('Facilty')};
	string DeathType {xpath('DeathType')};
	string Disposition {xpath('Disposition')};
	share.t_Date DispositionDate {xpath('DispositionDate')};
	string Autopsy {xpath('Autopsy')};
	string AutopsyFindings {xpath('AutopsyFindings')};
	string MedicalExamination {xpath('MedicalExamination')};
	boolean WorkInjury {xpath('WorkInjury')};
	share.t_Date InjuryDate {xpath('InjuryDate')};
	string InjuryLocation {xpath('InjuryLocation')};
	boolean SurgeryPerformed {xpath('SurgeryPerformed')};
	share.t_Date SurgeryDate {xpath('SurgeryDate')};
	string Pregnancy {xpath('Pregnancy')};
	string Certifier {xpath('Certifier')};
	string HospitalStatus {xpath('HospitalStatus')};
end;
		
export t_DeathReportRecord := record
	string StateDeathId {xpath('StateDeathId')};
	string SourceState {xpath('SourceState')};
	string County {xpath('County')};
	string VerifiedOrProved {xpath('VerifiedOrProved')};
	t_DeathReportDecedent Decedent {xpath('Decedent')};
	t_DeathReportDecedentFamily Family {xpath('Family')};
	t_DeathReportDeathInfo DeathInfo {xpath('DeathInfo')};
end;
		
export t_DeathReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_DeathReportRecord) DeathRecords {xpath('DeathRecords/DeathRecord'), MAXCOUNT(1)};
end;
		
export t_DeathSearchRequest := record (share.t_BaseRequest)
	t_DeathSearchOption Options {xpath('Options')};
	t_DeathSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_DeathReportRequest := record (share.t_BaseRequest)
	t_DeathReportOption Options {xpath('Options')};
	t_DeathReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_DeathSearchResponseEx := record
	t_DeathSearchResponse response {xpath('response')};
end;
		
export t_DeathReportResponseEx := record
	t_DeathReportResponse response {xpath('response')};
end;
		

end;

