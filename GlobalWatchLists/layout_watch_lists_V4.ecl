export layout_watch_lists_V4 := module

	export rAka_layout	:=
	record,maxlength(8192)
		unicode	AkaID			{xpath('@ID')};
		unicode	AkaType			{xpath('Type')};
		unicode	Category		{xpath('Category')};
		unicode	Title			{xpath('Title')};
		unicode	FirstName		{xpath('First_Name')};
		unicode	MiddleName		{xpath('Middle_Name')};
		unicode	LastName		{xpath('Last_Name')};
		unicode	Generation		{xpath('Generation')};
		unicode	FullName		{xpath('Full_Name')};
		unicode	AkaComments		{xpath('Comments')};
	end;

	export rAddress_layout	:=
	record,maxlength(8192)
		unicode	AddressID		{xpath('@ID')};
		unicode	AddressType		{xpath('Type')};
		unicode	StreetAddr1		{xpath('Street_1')};
		unicode	StreetAddr2		{xpath('Street_2')};
		unicode	City			{xpath('City')};
		unicode	State			{xpath('State')};
		unicode	Zip				{xpath('Postal_Code')};
		unicode	Country			{xpath('Country')};
		unicode	AddrComments	{xpath('Comments')};
	end;

	export rAdditionalInfo_layout	:=
	record,maxlength(8192)
		unicode	AddlInfoID			{xpath('@ID')};
		unicode	AddlInfoType		{xpath('Type')};
		unicode	AddlInfo			{xpath('Information')};
		unicode	ParsedInfo		{xpath('Parsed')};           
		unicode	AddlInfoComments	{xpath('Comments')};
	end;

	export rIdentification_layout	:=
	record,maxlength(8192)
		unicode	IdentificationID		{xpath('@ID')};
		unicode	IdentificationType		{xpath('Type')};
		unicode	Label					{xpath('Label')};
		unicode	IDNumber				{xpath('Number')};
		unicode	IssuedBy				{xpath('Issued_By')};
		unicode	DateIssued				{xpath('Date_Issued')};
		unicode	DateExpires				{xpath('Date_Expires')};
		unicode	IdentificationComments	{xpath('Comments')};
	end;

	export rPhoneNumber_layout	:=
	record,maxlength(4096)
		unicode	PhoneID			{xpath('@ID')};
		unicode	PhoneType		{xpath('Type')};
		unicode	PhoneAddress	{xpath('Address_ID')};
		unicode	PhoneNumber		{xpath('Number')};
		unicode	Comments		{xpath('Comments')};
	end;
	
	export entity := 	
	record,maxlength(65536)
		unicode							WatchListName		{xpath('@Watch_List_Name')};
		unicode							WatchListDate		{xpath('@Watch_List_Date')};
		unicode							NameType			{xpath('Type')};
		unicode							Title				{xpath('Title')};
		unicode							FirstName			{xpath('First_Name')};
		unicode							MiddleName			{xpath('Middle_Name')};
		unicode							LastName			{xpath('Last_Name')};
		unicode							Generation			{xpath('Generation')};
		unicode							FullName			{xpath('Full_Name')};
		unicode							Gender				{xpath('Gender')};
		unicode							DateListed			{xpath('Listed_Date')};
		unicode							AddedBy				{xpath('Entity_Added_By')};
		unicode							ReasonListed		{xpath('Reason_Listed')};
		unicode							ReferenceID			{xpath('Reference_ID')};
		unicode							Comments			{xpath('Comments')};
		dataset(rAKA_layout)			AkaList				{xpath('AKA_List/AKA')};
		dataset(rAddress_layout)		AddressList			{xpath('Address_List/Address')};
		dataset(rAdditionalInfo_layout)	AdditionalInfoList	{xpath('Additional_Info_List/AdditionalInfo')};
		dataset(rIdentification_layout)	IdentificationList	{xpath('Identification_List/Identification')};
		dataset(rPhoneNumber_layout)	PhoneNumberList		{xpath('Phone_Number_List/Phone_Number')};
	end;
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////		

	export rCountryAKA_layout	:=
	record,maxlength(4096)
		unicode	CountryAKAID			{xpath('@ID')};
		unicode	CountryAKAType			{xpath('Type')};
		unicode	CountryAKAName			{xpath('Name')};
	end;
	
	export rLocation_layout	:=
	record,maxlength(4096)
		unicode	LocationID				{xpath('@ID')};
		unicode	LocationType			{xpath('Type')};
		unicode	LocationName			{xpath('Name')};
	end;
	
	export country := 	
	record,maxlength(32768)
		unicode							WatchListName		{xpath('@Watch_List_Name')};
		unicode							WatchListDate		{xpath('@Watch_List_Date')};
		unicode							NameType			{xpath('Type')};
		unicode							CountryName			{xpath('Country_Name')};
		unicode							DateListed			{xpath('Listed_Date')};
		unicode							ReasonListed		{xpath('Reason_Listed')};
		unicode							Comments			{xpath('Comments')};
		dataset(rCountryAKA_layout)		CountryAkaList		{xpath('AKA_List/AKA')};
		dataset(rLocation_layout)		LocationList		{xpath('Location_List/Location')};
	end;
	
end;
