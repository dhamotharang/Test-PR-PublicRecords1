import GlobalWatchLists;

export Layout_CandidateRecords := record
	string20	EntityID;
	string1		EntityType := GlobalWatchLists.constants.EntityTypeUnknown;
	unsigned1 EntityScore := 0;
	boolean 	EntityTypeConflict := false;
	boolean		FalsePositive := false;
	boolean 	GenderConflict := false;

	unsigned1	AddressRecordID := 0;
	unsigned1	AddressScore := 0;
	boolean 	AddressConflict := false;
	boolean 	CountryConflict := false;
	boolean 	IsAddressPartial := false;

	unsigned1	CountryRecordID := 0;
	unsigned1	CountryScore := 0;
	unicode		MatchingCountry := u'';
	
	unsigned1	DOBRecordID := 0;
	unsigned1	DOBScore := 0;
	boolean 	DOBConflict := false;
	boolean 	IsDOBPartial := false;

	unsigned1	IDRecordID := 0;
	unsigned1	IDScore := 0;
	boolean 	IDConflict := false;

	unsigned1	NameRecordID := 0;
	unsigned1	NameScore := 0;
	unicode		MatchingFirstName := u'';
	unicode		MatchingMiddleName := u'';
	unicode		MatchingLastName := u'';
	unicode		MatchingFullName := u'';
	boolean 	IsNameSingleWordMatch := false;

	unsigned1	PhoneRecordID := 0;
	unsigned1	PhoneScore := 0;
	boolean 	PhoneConflict := false;
end;
