IMPORT IESP;

export Layout := module

EXPORT InputLayout := RECORD
  string30 		acctno;
	UNSIGNED4  	seq;
	unsigned6  	did;
	unsigned6  	bdid;
	unsigned3  	historydate;
	string50 		firstName;
	string50 		middleName;
	string50 		lastName;
	STRING150 	FullName;
	STRING20 		searchType;
	string10 	  DOB;
	integer2 		dob_radius := -1;
	string120 	company_name := '';
	string10  	prim_range := '';
	string2   	predir := '';
	string28  	prim_name := '';
	string4   	addr_suffix := '';
	string2   	postdir := '';
	string10  	unit_desig := '';
	string8   	sec_range := '';
	string25  	city_name := '';
  string2   	state := '';
	string5   	z5 := '';
	string4   	zip4 := '';
	string20   country := '';
END;


EXPORT SearchResultsSlimmed := record
	InputLayout;
	integer EntityRecSeq ;
	integer BlockID ;
	string ErrorMessage;
	string WarningMessage ;
	string SearchTime ;
	string WriteTime;
	unicode ResponseFullName;
	dataset(iesp.WsSearchCore.t_ResultEntityRecord) EntityRecords;
	
end;

EXPORT  EntityMatch := record  //not a dataset - only one record per match
  integer BlockID ;
	integer EntitySeq;
	integer EntityCheckSum;
	string EntityCountry;
	string EntityDate;
	string EntityGender; //values['None','Unknown','Female','Male','']
	unicode EntityNameFull;
	unicode EntityNameTitle;
	unicode EntityNameFirst;
	unicode EntityNameMiddle ;
	unicode EntityNameLast;
	unicode EntityNameGeneration ;
	string EntityNotes ;
	string EntityNumber ;
	string EntityPartyKey ;
	string EntityReason ;
	unsigned8 EntityType;
	string EntityTypeDesc;
	string EntityUniqueID;
	string SearchCriteria ;
	boolean MatchRealert;
	unicode EntityName;
	integer EntityOffset;
	integer8 EntityPrevResultID ;
	real EntitymatchScore;
	string EntitySourceNumber;
	boolean EntityTypeConflict;
END;



EXPORT AddressMatches := RECORD	
	integer BlockID ;
	integer EntitySeq;
	integer addressCount;
  string AddressEFTValue ;
	boolean AddressPartialAddress ;
	integer AddressScore ;
	integer AddressSourceID ;
	integer AddressValueType ;
	integer AddressInputInstance ;
	// addtl info
	integer AddressBestScore ;
	string AddressBest ;
	boolean AddressBestIsPartial ;
	boolean AddressConflict ;
	boolean AddressIndexMatch ;
	unsigned1 AddressBestInputID ;
	unsigned1 AddressBestListID ;
	unsigned8 AddressID ;
	unsigned8 AddressType ;
	string AddressTypeDesc;
	string FullAddress;
	string StreetAddress1;
	string StreetAddress2;
	string City;
	string State;
	string PostalCode;
	string Country;
	string Notes;
END;

EXPORT AKAMatches := record //(t_InputName)

  unicode FullName;
	unicode Title;
	unicode FirstName;
	unicode MiddleName;
	unicode LastName;
	unicode Generation;
	unsigned8 akaID;
	unsigned8 akaType;
	string AKATypeDesc;
	unsigned8 Category;
	string Notes;
END;

EXPORT AKABestMatches := record
  integer BlockID ;
	integer EntitySeq;
  unsigned1 BestID;
  real BestScore;
	unicode BestName;
	AKAMatches;
END;

EXPORT ResultMatchFile := record
  integer blockid;
	integer EntitySeq;
	string BuildDate;
	boolean CustomFile;
	unsigned8 FileID;
	integer FileIndex;
	string FileName;
	string FileKeyPrefix;
	string PublishedDate;
	string FileType; //values['UDF','ADF','BDF','CDF','SDF','']
end;
	
EXPORT ResultMatchCitizenship := record
  integer blockid;
	integer EntitySeq;
	integer CitizenshipBestScore;
	string  CitizenshipEFTValue;
	boolean CitizenshipPartialAddress ;
	integer CitizenshipScore;
	integer CitizenshipSourceID;
	integer CitizenshipValueType;
	integer CitizenshipInputInstance ;
	boolean CitizenshipConflict;
end;

EXPORT ResultMatchCountry := record
  integer blockid;
	integer EntitySeq;
	string CountryBest;
	unsigned2 CountryBestID;
	integer CountryBestScore;
	string CountryBestType; //values['None','Country','Code','AlternateName','City','Port','Term','']
	boolean CountryConflict;
	integer CountryInputInstance ;
	string CountryInputType; //values['None','AdditionalInfo','Address','ID','Name','Phone','EFT','']
end;

EXPORT ResultMatchDOB := record
  integer blockid;
	integer EntitySeq;
	boolean DOBBestIsPartial ;
	integer DOBBestScore ;
	boolean DOBConflict;
	string  DOBEFTValue;
	boolean DOBPartialAddress ;
	integer DOBScore;
	integer DOBSourceID ;
	integer DOBValueType ;
	integer DOBInputInstance ;
end;


EXPORT  ResultMatchEntityValue := record
  integer blockid;
	integer EntitySeq;
	unsigned8 ID ;
	string ResultValue;
	integer recordcount;
end;


EXPORT ResultMatchEntityDescription := record
  integer blockid;
	integer EntitySeq;
	unsigned8 DescriptionsID;
	unsigned8 DescriptionsType;
	string DescriptionsTypeDesc;
	string DescriptionsTypeValue ;
	string DescriptionsNotes;
	integer recordcount;
	string75 remarks;
	integer remarksCount;
end;

EXPORT ResultMatchPhone := record
  integer blockid;
	integer EntitySeq;
	integer PhoneBestScore ;
	boolean PhoneConflict ;
	boolean PhoneIndexMatch ;
  string  PhoneEFTValue;
	boolean PhonePartialAddress;
	integer PhoneScore;
	integer PhoneSourceID ;
	integer PhoneValueType ;
	integer PhoneInputInstance;	
	unsigned8 PhoneID ;
	unsigned8 PhoneType ;
	string PhoneTypeDesc ;
	string PhoneNumber;
	string PhoneNotes ;	
end;
	
EXPORT ResultMatchID := record
  integer blockid;
	integer EntitySeq;
	integer MatchIDBestScore;
	boolean MatchIDConflict;
  string MatchIDEFTValue;
	boolean MatchIDPartialAddress ;
	integer MatchIDScore ;
	integer MatchIDSourceID ;
	integer MatchIDValueType ;
	integer MatchIDInputInstance ;	
	//end of addt'l info DS
	boolean MatchIDIndexMatch;
  unsigned8 MatchIDID ;
	unsigned8 MatchIDType ;
	string MatchIDTypeDesc ;
	string MatchIDLabel ;
	string MatchIDNumber ;
	string MatchIDIssuer;
	string MatchIDIssueDate ;
	string MatchIDExpDate;
	string MatchIDNotes;
	string75 MatchIDremarks;
	integer MatchIDRemarkscount;
end;

EXPORT ResultEntityRecord := record 
	string ErrorMessage;
	string WarningMessage;
	iesp.WsSearchCore.t_InputEntityRecord InputRecord;
	dataset(iesp.WsSearchCore.t_ResultMatch) Matches;
end;

EXPORT NormEntityRecord := Record 
   integer BlockID ;
	 integer EntitySeq;
	 string searchType;
	 unicode OrigFullName;
	 integer CountMatches;
	 integer Countcodes;
	 integer CountCities;
	 integer Countaddress;
	 integer Countakas;
	 integer CountMatchIDDetails;
	 integer CountDesc;
	 integer CountDOB;
	 integer CountTerms;
	 integer CountPorts;
	 integer CountPhone;
	 integer CountCitizen;
	 boolean DOBConflict := FALSE;
   iesp.WsSearchCore.t_ResultMatch Matches;
end;

EXPORT ResponseRec := record  // did not break out Gender tags as they are not used
	InputLayout;  
	integer blockid;
	integer EntitySeq;
	string errormessage;
	unicode ResponseFullName;
	dataset(AddressMatches) AddrRec;
	dataset(AKABestMatches) AKARec;
	dataset(ResultMatchFile) FileRec;
	dataset(EntityMatch) EntityRec;
	dataset(ResultMatchCitizenship) CitizenshipRec;  //max of 30
	dataset(ResultMatchDOB) DOBRec;
	dataset(ResultMatchCountry) CountryRec;
	dataset(ResultMatchEntityValue) CodesRec;
	dataset(ResultMatchEntityValue) TermsRec;
	dataset(ResultMatchEntityValue) CitiesRec;
	dataset(ResultMatchEntityValue) PortsRec;
	dataset(ResultMatchEntityDescription) DescRec;
	dataset(ResultMatchPhone) PhoneRec;
	dataset(ResultMatchID) MatchIDRec;
END;

END;