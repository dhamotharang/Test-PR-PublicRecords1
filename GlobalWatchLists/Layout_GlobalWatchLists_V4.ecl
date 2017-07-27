export Layout_GlobalWatchLists_V4 := module

// ********************
// ENTITY DATA LAYOUTS
// ********************
export LayoutEntity := record, maxlength(10240)
	string20	EntityID;	// key
	string6		ListID;
	string150	WatchListName;
	string10	WatchListDate;
	string10	DateListed;
	string1		EntityType;

	unicode200	Title;
	unicode100	FirstName;
	unicode100	MiddleName;
	unicode100	LastName;
	unicode20	Generation;
	unicode320	FullName;
	unicode1		Gender;
	unicode100	ReasonListed;
	unicode40	ReferenceID;
	unicode8192	Comments; 
	
	unsigned1	NameCount;
	unsigned1	AddressCount;
	unsigned1	IDCount;
	unsigned1	PhoneCount;
	unsigned1	InfoCount;
end;

export LayoutName := record, maxlength(8192)
	string20	EntityID; // key
	unsigned1	RecordID; // key
	string1		EntityType;

	unicode10	AkaType;
	unicode10	Category;
	unicode200	Title;
	unicode100	FirstName;
	unicode100	MiddleName;
	unicode100	LastName;
	unicode20	Generation;
	unicode320	FullName;
	unicode1024 Comments; 
end;

export LayoutNameIndex := record, maxlength(40)
	unsigned6	Key;		// key
	string6		ListID;	// key
	string20	EntityID;
	unsigned1	RecordID;
end;

export LayoutAddress := record, maxlength(8192)
	string20	EntityID;	// key
	unsigned1	RecordID;	// key
	string10	AddressType;
	unicode256	StreetAddress1;
	unicode256	StreetAddress2;
	unicode50	City;
	unicode50	State;
	unicode20	Zip;
	unicode50	Country;
	unicode1024	Comments;
end;

export LayoutAddressIndex := record, maxlength(40)
	unsigned6	Key;		// key
	string6		ListID;	// key
	string20	EntityID;
	unsigned1	RecordID;
end;

export LayoutID := record, maxlength(8192)
	string20	EntityID; // key
	unsigned1	RecordID;
	string10	DateIssued;
	string10	DateExpires;
	unsigned1 IDType;
	unicode50	IDNumber;
	unicode50	Label;
	unicode50	IssuedBy;
	unicode1024	Comments;
end;

export LayoutIDIndex := record, maxlength(8192)
	unicode50	IDNumber; // key
	unsigned1 IDType; // key
	string6		ListID; // key
	string20	EntityID;
	unsigned1	RecordID;
end;

export LayoutPhone := record, maxlength(8192)
	string20	EntityID; // key
	unsigned1	RecordID;
	unicode20	PhoneNumber;
	unicode20	PhoneType;
	unicode1024	Comments;
end;

export LayoutPhoneIndex := record, maxlength(8192)
	unicode20	PhoneNumber; //key
	string6		ListID;	//key
	string20	EntityID;
	unsigned1	RecordID;
end;

export LayoutAdditionalInfo := record, maxlength(10240)
	string20	EntityID;	// key
	unsigned1	RecordID;
	unicode50	AddlInfoType;
	unicode1024	AddlInfo;
	unicode50	ParsedInfo;
	unicode8192	Comments;
end;

// ********************
// COUNTRY DATA LAYOUTS
// ********************
export LayoutCountry := record, maxlength(4800)
	string20	CountryID; // key
	string6		ListID;
	string150	WatchListName;
	string10	WatchListDate;
	unicode120	CountryName;
	string10	DateListed;
	unicode100	ReasonListed;
	unicode4096	Comments;
end;

export LayoutCountryName := record, maxlength(256)
	string20	CountryID;// key
	unsigned1	RecordID;	// key
	unicode10	NameType;
	unicode120	Name;
end;

export LayoutCountryIndex := record, maxlength(40)
	unsigned6	Key;		// key
	string6		ListID;	// key
	string20	CountryID;
	unsigned1	RecordID;
end;

export	LayoutCountryAka	:=
record,maxlength(256)
	string8	NameInd;	// Country or Location
	LayoutCountryName;
end;

// ********************
// WORD TOKEN LAYOUTS
// ********************
export LayoutAddressTokenPrep := record
	unicode600	FullAddress; // do not include state or country
	unsigned6	Key;
end;

export LayoutCountryTokenPrep := record
	unicode120	CountryName;
	unsigned6	Key;
end;

export LayoutNameTokenPrep := record
	unicode320	FullName;
	string1		EntityType;
	unsigned6	Key;
end;

export LayoutTokenKey := record
	unsigned6 key;
end;

export LayoutTokens := record
	unicode24 tkn;
	DATASET(LayoutTokenKey) keys {MAXCOUNT(20000)};
end;

end;
