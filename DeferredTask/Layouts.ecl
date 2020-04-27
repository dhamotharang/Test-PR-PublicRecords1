EXPORT Layouts := MODULE

EXPORT CaseLayout := RECORD
	STRING CollectionDate{xpath('Collection_date')};
	STRING FilingJurisdiction{xpath('Filing_jurisdiction')};
	STRING FilingState{xpath('Filing_state')};
	STRING FilingNumber{xpath('Filing_number')};
	STRING FilingBook{xpath('Filing_book')};
	STRING FilingPage{xpath('Filing_page')};
	STRING FilingDate{xpath('Filing_date')};
	STRING FilingTime{xpath('Filing_time')};
	STRING FilingStatus{xpath('Filing_status')};
	STRING FilingStatusDesc{xpath('Filing_status_desc')};
	STRING Agency{xpath('Agency')};
	STRING AgencyCity{xpath('Agency_city')};
	STRING AgencyState{xpath('Agency_state')};
	STRING AgencyCounty{xpath('Agency_county')};
END;

EXPORT PartiesLayout := RECORD
	STRING PartyType{xpath('Party_type')};
	STRING TaxID{xpath('Tax_id')};
	STRING SSN{xpath('Ssn')};
	STRING FullName{xpath('Full_name')};
	STRING Title{xpath('Title')};
	STRING Fname{xpath('Fname')};
	STRING Mname{xpath('Mname')};
	STRING Lname{xpath('Lname')};
	STRING NameSuffix{xpath('Name_suffix')};
	STRING CompanyName{xpath('Company_name')};
	STRING Address1{xpath('Address1')};
	STRING Address2{xpath('Address2')};
	STRING City{xpath('City')};
	STRING State{xpath('State')};
	STRING Zip{xpath('Zip')};
	STRING Zip4{xpath('Zip4')};
	STRING County{xpath('County')};
	STRING Country{xpath('Country')};
	STRING PreDir{xpath('PreDir')};
	STRING PostDir{xpath('PostDir')};
	STRING AddrSuffix{xpath('Addr_suffix')};
	STRING UnitDesig{xpath('Unit_desig')};
	STRING ReleaseDate{xpath('Release_date')};
	STRING FilingType{xpath('Filing_type')};
	STRING FilingTypeId{xpath('Filing_type_id')};
	STRING FilingTypeDesc{xpath('Filing_type_desc')};
	STRING Amount{xpath('Amount')};
END;

EXPORT ResponseOpaqueContentLayout := RECORD
	DATASET(CaseLayout) Case{xpath('Case')};
	DATASET(PartiesLayout) Parties{xpath('Parties')};
	STRING ErrorCode;
END;

END; // Layouts Module END