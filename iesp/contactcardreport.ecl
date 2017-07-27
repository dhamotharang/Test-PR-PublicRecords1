export contactcardreport := MODULE
			
export t_ContactCardPersonsOption := record
	integer MaxPhones {xpath('MaxPhones')};
	integer MaxAddresses {xpath('MaxAddresses')};
	boolean IncludePhonelessAddresses {xpath('IncludePhonelessAddresses')};
end;
		
export t_ContactCardRelativeOption := record
	integer MaxRelatives {xpath('MaxRelatives')};
	integer RelativeDepth {xpath('RelativeDepth')};
end;
		
export t_ContactCardReportOption := record (share.t_BaseReportOption)
	boolean PruneAgedSSNs {xpath('PruneAgedSSNs')};
	integer TargetRadius {xpath('TargetRadius')};
	boolean IncludePhonesPlus {xpath('IncludePhonesPlus')};
	t_ContactCardPersonsOption Persons {xpath('Persons')};
	t_ContactCardRelativeOption Relatives {xpath('Relatives')};
end;
		
export t_ContactCardReportBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	string SSNLast4 {xpath('SSNLast4')};
	string SSNFirst5 {xpath('SSNFirst5')};
	string UniqueId {xpath('UniqueId')};
	share.t_Date DOB {xpath('DOB')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_ContactCardAddress := record
	share.t_Address Address {xpath('Address')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	boolean _Shared {xpath('Shared')};
	boolean Verified {xpath('Verified')};
end;
		
export t_ContactCardAddressWithPhones := record (t_ContactCardAddress)
	string LocationId {xpath('LocationId')};
	dataset(share.t_PhoneInfo) Phones {xpath('Phones/Phone'), MAXCOUNT(1)};
end;
		
export t_ContactCardContact := record
	string Relationship {xpath('Relationship')};
	share.t_Date RelationshipDateLastSeen {xpath('RelationshipDateLastSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_NameAndCompany Name {xpath('Name')};
	string Gender {xpath('Gender')};
	string UniqueId {xpath('UniqueId')};
end;
		
export t_ContactCardGroupEntry := record
	t_ContactCardAddressWithPhones AddressWithPhones {xpath('AddressWithPhones')};
	dataset(t_ContactCardContact) Contacts {xpath('Contacts/Contact'), MAXCOUNT(1)};
end;
		
export t_ContactCardGroup := record
	string Priority {xpath('Priority')};
	string GroupCategory {xpath('GroupCategory')};
	dataset(t_ContactCardGroupEntry) GroupEntries {xpath('GroupEntries/GroupEntry'), MAXCOUNT(1)};
end;
		
export t_ContactCardAddressWithResidents := record (t_ContactCardAddressWithPhones)
	dataset(share.t_Identity) Residents {xpath('Residents/Resident'), MAXCOUNT(1)};
end;
		
export t_ContactCardReportIndividual := record
	string UniqueId {xpath('UniqueId')};
	string Probability {xpath('Probability')};
	string HasBankruptcy {xpath('HasBankruptcy')};
	string HasProperty {xpath('HasProperty')};
	string HasCorporateAffiliation {xpath('HasCorporateAffiliation')};
	share.t_Identity SubjectInformation {xpath('SubjectInformation')};
	dataset(share.t_Identity) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(1)};
	dataset(share.t_Identity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(1)};
	dataset(t_ContactCardAddressWithResidents) ReportAddresses {xpath('ReportAddresses/ReportAddress'), MAXCOUNT(1)};
	dataset(bankruptcy.t_BankruptcyReport2Record) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(1)};
	dataset(t_ContactCardGroup) ContactCard {xpath('ContactCard/CardGroup'), MAXCOUNT(1)};
end;
		
export t_ContactCardReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_ContactCardReportIndividual Individual {xpath('Individual')};
end;
		
export t_ContactCardReportRequest := record (share.t_BaseRequest)
	t_ContactCardReportOption Options {xpath('Options')};
	t_ContactCardReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_ContactCardReportResponseEx := record
	t_ContactCardReportResponse response {xpath('response')};
end;
		

end;

