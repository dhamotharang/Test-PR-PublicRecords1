export alsofoundindicators := MODULE
			
export t_AlsoFoundIndicatorsBy := record (share.t_BaseSearchBy)
	string SSN {xpath('SSN')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_AlsoFoundIndicatorsOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean UsePhonetics {xpath('UsePhonetics')};
end;
		
export t_AlsoFoundIndicators := record
	string UniqueId {xpath('UniqueId')};
	string Properties {xpath('Properties')};
	string Vehicles {xpath('Vehicles')};
	string DriversLicenses {xpath('DriversLicenses')};
	string Relatives {xpath('Relatives')};
	string Associates {xpath('Associates')};
	string ProfessionalLicenses {xpath('ProfessionalLicenses')};
	string Vessels {xpath('Vessels')};
	string PeopleAtWork {xpath('PeopleAtWork')};
	string PhonesPlus {xpath('PhonesPlus')};
end;
		
export t_AlsoFoundIndicatorsResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	t_AlsoFoundIndicators AlsoFoundIndicators {xpath('AlsoFoundIndicators')};
end;
		
export t_AlsoFoundIndicatorsRequest := record (share.t_BaseRequest)
	t_AlsoFoundIndicatorsBy SearchBy {xpath('SearchBy')};
	t_AlsoFoundIndicatorsOption Options {xpath('Options')};
end;
		
export t_AlsoFoundIndicatorsResponseEx := record
	t_AlsoFoundIndicatorsResponse response {xpath('response')};
end;
		

end;

