EXPORT layout_VerificationOfOccupancy := RECORD
  string20 	dataset_name;
  string30 	acctno;
  string20 	fname;
  string20 	lname;
  string5 	zipcode;
  string9 	ssn;
  string10 	phone10;
  string20 	accountnumber;
	string2		AddressReportingSourceIndex;
	string2		AddressReportingHistoryIndex;
	string2		AddressSearchHistoryIndex;
	string2 	AddressUtilityHistoryIndex;
	string2 	AddressOwnershipHistoryIndex;
	string2 	AddressPropertyTypeIndex;
	string2 	AddressValidityIndex;
	string2 	RelativesConfirmingAddressIndex;
	string2 	AddressOwnerMailingAddressIndex;
	string2 	PriorAddressMoveIndex;
	string2 	PriorResidentMoveIndex;
	string6 	AddressDateFirstSeen;
	string6 	AddressDateLastSeen;
	string2 	OccupancyOverride;
	string2 	InferredOwnershipTypeIndex;
	string5 	OtherOwnedPropertyProximity;
	string2 	VerificationOfOccupancyScore;
 END;
