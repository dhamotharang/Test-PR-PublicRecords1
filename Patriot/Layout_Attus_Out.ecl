shared Layout_Alias :=
RECORD
	STRING350 FullName;
	STRING10 EntityType;
	decimal6_5 Score;
END;

shared Layout_Address :=
RECORD
	STRING Address;
END;

shared Layout_Country :=
RECORD
	STRING Name;
	decimal6_5 Score;
END;

export Layout_Attus_Out :=
RECORD,MAXLENGTH(100000)
	STRING10 EntityId;
	decimal6_5 ThisEntityMaxScore;
	STRING350 FullName;
	STRING20 LastName;
	STRING20 FirstName;
	STRING200 OtherName;
	UNSIGNED1 IsAliasHit;
	decimal6_5 Score;
	STRING10 EntityType;
	STRING60 Programs;
	STRING Remarks;
	DATASET(Layout_Alias) Aliases;
	DATASET(Layout_Address) Addresses;
	DATASET(Layout_Country) Countries;
END;