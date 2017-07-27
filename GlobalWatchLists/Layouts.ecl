export	Layouts	:=
module

	// In file layouts
	export	In	:=
	module
		shared	rAka_layout	:=
		record,maxlength(8192)
			unicode	AkaID				{xpath('@ID')};
			unicode	AkaType			{xpath('Type')};
			unicode	Category		{xpath('Category')};
			unicode	Title				{xpath('Title')};
			unicode	FirstName		{xpath('First_Name')};
			unicode	MiddleName	{xpath('Middle_Name')};
			unicode	LastName		{xpath('Last_Name')};
			unicode	Generation	{xpath('Generation')};
			unicode	FullName		{xpath('Full_Name')};
			unicode	AkaComments	{xpath('Comments')};
		end;

		shared	rAddress_layout	:=
		record,maxlength(8192)
			unicode	AddressID			{xpath('@ID')};
			unicode	AddressType		{xpath('Type')};
			unicode	StreetAddr1		{xpath('Street_1')};
			unicode	StreetAddr2		{xpath('Street_2')};
			unicode	City					{xpath('City')};
			unicode	State					{xpath('State')};
			unicode	Zip						{xpath('Postal_Code')};
			unicode	Country				{xpath('Country')};
			unicode	AddrComments	{xpath('Comments')};
		end;

		shared	rAdditionalInfo_layout	:=
		record,maxlength(8192)
			unicode	AddlInfoID				{xpath('@ID')};
			unicode	AddlInfoType			{xpath('Type')};
			unicode	AddlInfo					{xpath('Information')};
			unicode	ParsedInfo				{xpath('Parsed')};           
			unicode	AddlInfoComments	{xpath('Comments')};
		end;

		shared	rIdentification_layout	:=
		record,maxlength(8192)
			unicode	IdentificationID				{xpath('@ID')};
			unicode	IdentificationType			{xpath('Type')};
			unicode	Label										{xpath('Label')};
			unicode	IDNumber								{xpath('Number')};
			unicode	IssuedBy								{xpath('Issued_By')};
			unicode	DateIssued							{xpath('Date_Issued')};
			unicode	DateExpires							{xpath('Date_Expires')};
			unicode	IdentificationComments	{xpath('Comments')};
		end;

		shared	rPhoneNumber_layout	:=
		record,maxlength(4096)
			unicode	PhoneID				{xpath('@ID')};
			unicode	PhoneType			{xpath('Type')};
			unicode	PhoneAddress	{xpath('Address_ID')};
			unicode	PhoneNumber		{xpath('Number')};
			unicode	Comments			{xpath('Comments')};
		end;
		
		export	Entity := 	
		record,maxlength(40960)
			unicode													WatchListName				{xpath('@Watch_List_Name')};
			unicode													WatchListDate				{xpath('@Watch_List_Date')};
			unicode													NameType						{xpath('Type')};
			unicode													Title								{xpath('Title')};
			unicode													FirstName						{xpath('First_Name')};
			unicode													MiddleName					{xpath('Middle_Name')};
			unicode													LastName						{xpath('Last_Name')};
			unicode													Generation					{xpath('Generation')};
			unicode													FullName						{xpath('Full_Name')};
			unicode													Gender							{xpath('Gender')};
			unicode													DateListed					{xpath('Listed_Date')};
			unicode													AddedBy							{xpath('Entity_Added_By')};
			unicode													ReasonListed				{xpath('Reason_Listed')};
			unicode													ReferenceID					{xpath('Reference_ID')};
			unicode													Comments						{xpath('Comments')};
			dataset(rAKA_layout)						AkaList							{xpath('AKA_List/AKA')};
			dataset(rAddress_layout)				AddressList					{xpath('Address_List/Address')};
			dataset(rAdditionalInfo_layout)	AdditionalInfoList	{xpath('Additional_Info_List/AdditionalInfo')};
			dataset(rIdentification_layout)	IdentificationList	{xpath('Identification_List/Identification')};
			dataset(rPhoneNumber_layout)		PhoneNumberList			{xpath('Phone_Number_List/Phone_Number')};
		end;
		
	////////////////////////////////////////////////////////////////////////////////////////////////////////////		

		shared	rCountryAKA_layout	:=
		record,maxlength(4096)
			unicode	CountryAKAID		{xpath('@ID')};
			unicode	CountryAKAType	{xpath('Type')};
			unicode	CountryAKAName	{xpath('Name')};
		end;
		
		shared	rLocation_layout	:=
		record,maxlength(4096)
			unicode	LocationID		{xpath('@ID')};
			unicode	LocationType	{xpath('Type')};
			unicode	LocationName	{xpath('Name')};
		end;
		
		export	Country	:= 	
		record,maxlength(32768)
			unicode											WatchListName		{xpath('@Watch_List_Name')};
			unicode											WatchListDate		{xpath('@Watch_List_Date')};
			unicode											NameType				{xpath('Type')};
			unicode											CountryName			{xpath('Country_Name')};
			unicode											DateListed			{xpath('Listed_Date')};
			unicode											ReasonListed		{xpath('Reason_Listed')};
			unicode											Comments				{xpath('Comments')};
			dataset(rCountryAKA_layout)	CountryAkaList	{xpath('AKA_List/AKA')};
			dataset(rLocation_layout)		LocationList		{xpath('Location_List/Location')};
		end;
	end;
	
	// Temporary file layouts
	export	Temp	:=
	module
		
		export	EntityRecordID	:=
		record(In.Entity),maxlength(40960)
			string	ListID;
			string	RecordID;
		end;
		
		export	CountryRecordID	:=
		record(In.Country),maxlength(32768)
			string	ListID;
			string	RecordID;
		end;
		
		export	EntityMain	:=
		record,maxlength(40960)
			string	ListID;
			string	RecordID;
			string	WatchListName;
			string	WatchListDate;
			string	NameType;
			string	Title_1;
			string	First_Name;
			string	Middle_Name;
			string	Last_Name;
			string	Generation;
			string	FullName;
			string	Gender;
			string	DateListed;
			string	AddedBy;
			string	ReasonListed;
			string	ReferenceID;
			string	Comments;

			string	title2;
			string	fname;
			string	mname;
			string	lname;
			string	name_suffix;
			string	name_score;
			string	pname_clean;
			string	cname;
			string1	giv_designator;
			string	AddrComments;
		end;
		
		export	EntityCommon	:=
		record,maxlength(40960)
			string			pty_key;
			string			source;
			string			watchlistdate;
			string			orig_pty_name;
			string350		orig_vessel_name;
			string1			giv_designator;
			string			referenceid;
			
			string			first_name; 
			string			middle_name; 
			string			last_name; 
			string			title_1;
			string			name_type;
			string			cname;
			string			title;
			string			fname;
			string			mname;
			string			lname;
			string			suffix;
			string			a_score;
			
			string			entity_type;
			string			sanctions_program_1;
			string			date_last_updated;
			string			date_added_to_list;
			string			gender;
			string			pname_clean;
			
			string20		language_1;
			string20		language_2;
			string20		language_3;
			string20		language_4;
			string20		language_5;
			string20		language_6;
			string20		language_7;
			string20		language_8;
			string20		language_9;
			string20		language_10;
			
			string50		linked_with_1;
			string50		linked_with_2;
			string50		linked_with_3;
			string50		linked_with_4;
			string50		linked_with_5;
			string50		linked_with_6;
			string50		linked_with_7;
			string50		linked_with_8;
			string50		linked_with_9;
			string50		linked_with_10;
			
			string75		remarks_1;
			string75		remarks_2;
			string75		remarks_3;
			string75		remarks_4;
			string75		remarks_5;
			string75		remarks_6;
			string75		remarks_7;
			string75		remarks_8;
			string75		remarks_9;
			string75		remarks_10;
			string75		remarks_11;
			string75		remarks_12;
			string75		remarks_13;
			string75		remarks_14;
			string75		remarks_15;
			string75		remarks_16;
			string75		remarks_17;
			string75		remarks_18;
			string75		remarks_19;
			string75		remarks_20;
			string75		remarks_21;
			string75		remarks_22;
			string75		remarks_23;
			string75		remarks_24;
			string75		remarks_25;
			string75		remarks_26;
			string75		remarks_27;
			string75		remarks_28;
			string75		remarks_29;
			string75		remarks_30;
			
			string20		effective_date;
			string20		expiration_date;
			
			string12		type_of_denial;
			string1			registrant_terminated_flag;
			string1			foreign_principal_terminated_flag;
			string1			short_form_terminated_flag;
			string200		grounds;
			string200		warrant_by;
			string1000	offenses;
			string1000	caution;
			string100		membership_1;
			
			string35		federal_register_citation_1;
			string35		federal_register_citation_2;
			string35		federal_register_citation_3;
			string35		federal_register_citation_4;
			string35		federal_register_citation_5;
			string35		federal_register_citation_6;
			string35		federal_register_citation_7;
			string35		federal_register_citation_8;
			string35		federal_register_citation_9;
			string35		federal_register_citation_10;
			string20		federal_register_citation_date_1;
			string20		federal_register_citation_date_2;
			string20		federal_register_citation_date_3;
			string20		federal_register_citation_date_4;
			string20		federal_register_citation_date_5;
			string20		federal_register_citation_date_6;
			string20		federal_register_citation_date_7;
			string20		federal_register_citation_date_8;
			string20		federal_register_citation_date_9;
			string20		federal_register_citation_date_10;
			
			string			comments;
			string			remarks;
			integer			numrows;
		end;
		
	end;
	
	// V2 base file layouts
	export	Base	:=
	module
		export	rAkaName_Layout	:=
		record
			unsigned1		RecordID;
			unicode10		AkaType;
			unicode10		Category;
			unicode200	Title;
			unicode100	FirstName;
			unicode100	MiddleName;
			unicode100	LastName;
			unicode20		Generation;
			unicode320	FullName;
			unicode1024 Comments;
		end;
		
		export	rAddress_Layout	:=
		record
			unsigned1		RecordID;
			string10		AddressType;
			unicode256	StreetAddress1;
			unicode256	StreetAddress2;
			unicode50		City;
			unicode50		State;
			unicode20		Zip;
			unicode50		Country;
			unicode1024	Comments;
		end;
		
		export	rPhone_Layout	:=
		record
			unsigned1		RecordID;
			unicode20		PhoneNumber;
			unicode20		PhoneType;
			unicode1024	Comments;
		end;
		
		export	rID_Layout	:=
		record
			unsigned1		RecordID;
			string12		DateIssued;
			string12		DateExpires;
			unsigned1		IDType;
			unicode50		IDNumber;
			unicode50		Label;
			unicode50		IssuedBy;
			unicode1024	Comments;
		end;
		
		export	rAddlInfo_Layout	:=
		record,maxlength(12288)
			unsigned1		RecordID;
			unicode50		AddlInfoType;
			unicode1024	AddlInfo;
			unicode50		ParsedInfo;
			unicode8192	Comments;
		end;
		
		export	rEntity_Layout	:=
		record,maxlength(4096000)
			string20		EntityID;	// key
			string6			ListID;
			string150		WatchListName;
			string10		WatchListDate;
			string10		DateListed;
			string1			EntityType;

			unicode200	Title;
			unicode100	FirstName;
			unicode100	MiddleName;
			unicode100	LastName;
			unicode20		Generation;
			unicode320	FullName;
			unicode1		Gender;
			unicode100	ReasonListed;
			unicode40		ReferenceID;
			unicode8192	Comments; 
			
			unsigned1		NameCount;
			unsigned1		AddressCount;
			unsigned1		IDCount;
			unsigned1		PhoneCount;
			unsigned1		InfoCount;
			
			dataset(rAkaName_Layout)	AkaNames;
			dataset(rAddress_Layout)	Addresses;
			dataset(rPhone_Layout)		Phones;
			dataset(rID_Layout)				IDs;
			dataset(rAddlInfo_Layout)	AddlInfo;
		end;
		
		export	rCountryName_Layout	:=
		record
			unsigned1		RecordID;	// key
			string8			NameInd;	// Location or Country
			unicode10		NameType;
			unicode120	Name;
		end;
		
		export	rCountry_Layout	:=
		record,maxlength(40960)
			string20		CountryID;	// key
			string6			ListID;
			string150		WatchListName;
			string10		WatchListDate;
			unicode120	CountryName;
			string10		DateListed;
			string1			CountryType;
			unicode100	ReasonListed;
			unicode4096	Comments;
			
			unsigned1		NameCount;
			
			dataset(rCountryName_Layout)	CountryNames;
		end;
		
	end;
end;