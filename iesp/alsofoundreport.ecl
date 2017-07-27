export alsofoundreport := MODULE
			
export t_AlsoFoundReportOption := record (share.t_BaseReportOption)
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean UseCurrentPropertiesOnly {xpath('UseCurrentPropertiesOnly')};
	boolean IncludePriorProperties {xpath('IncludePriorProperties')};
	boolean IncludeDriversLicenses {xpath('IncludeDriversLicenses')};
	boolean IncludeMotorVehicles {xpath('IncludeMotorVehicles')};
	boolean UseCurrentVehiclesOnly {xpath('UseCurrentVehiclesOnly')};
	boolean IncludePeopleAtWork {xpath('IncludePeopleAtWork')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludeCorporateAffiliations {xpath('IncludeCorporateAffiliations')};
	boolean IncludePhonesPlus {xpath('IncludePhonesPlus')};
	boolean IncludeEmailAddresses {xpath('IncludeEmailAddresses')};
end;
		
export t_AlsoFoundReportBy := record
	string UniqueId {xpath('UniqueId')};
end;
		
export t_AlsoFoundReport := record
	dataset(motorvehicle.t_MotorVehicleReport2Record) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(1)};
	dataset(property.t_PropertyReport2Record) Properties {xpath('Properties/Property'), MAXCOUNT(1)};
	dataset(driverlicense2.t_DLEmbeddedReport2Record) DriverLicenses {xpath('DriverLicenses/DriverLicense'), MAXCOUNT(1)};
	dataset(proflicense.t_ProfessionalLicenseRecord) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(1)};
	dataset(peopleatwork.t_PeopleAtWorkRecord) PeopleAtWorks {xpath('PeopleAtWorks/PeopleAtWork'), MAXCOUNT(1)};
	dataset(bpsreport.t_BpsCorpAffiliation) CorporateAffiliations {xpath('CorporateAffiliations/Affiliation'), MAXCOUNT(1)};
	dataset(dirassistwireless.t_PhonesPlusRecord) PhonesPluses {xpath('PhonesPluses/PhonesPlus'), MAXCOUNT(1)};
	dataset(emailsearch.t_EmailSearchRecord) EmailAddresses {xpath('EmailAddresses/EmailAddress'), MAXCOUNT(1)};
end;
		
export t_AlsoFoundReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	t_AlsoFoundReport Individual {xpath('Individual')};
end;
		
export t_AlsoFoundReportRequest := record (share.t_BaseRequest)
	t_AlsoFoundReportOption Options {xpath('Options')};
	t_AlsoFoundReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_AlsoFoundReportResponseEx := record
	t_AlsoFoundReportResponse response {xpath('response')};
end;
		

end;

