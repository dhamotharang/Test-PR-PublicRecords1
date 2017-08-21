EXPORT Layouts := MODULE

		/*
export crCountries := RECORD
		string	code				{xpath('@code'),MAXLENGTH(13)};
		string	name				{xpath('@name'),MAXLENGTH(255)};
		string	IsTerritory	{xpath('@IsTerritory'),MAXLENGTH(5)};
		string	ProfileURL	{xpath('@ProfileURL'),MAXLENGTH(255)};
END;

export crOccupations := RECORD
		string	code				{xpath('@code'),MAXLENGTH(2)};
		string	name				{xpath('@name'),MAXLENGTH(255)};
END;
export crRelationships := RECORD
		string	code				{xpath('@code'),MAXLENGTH(2)};
		string	name				{xpath('@name'),MAXLENGTH(255)};
END;
export crSanctions := RECORD
		string	code				{xpath('@code'),MAXLENGTH(4)};
		string	name				{xpath('@name'),MAXLENGTH(255)};
		string	status			{xpath('@status'),MAXLENGTH(9)};
		string	Description2Id	{xpath('@Description2Id'),MAXLENGTH(4)};
END;
export crDescription1s := RECORD
		string	Description1Id		{xpath('@Description1Id'),MAXLENGTH(4)};
		string	RecordType				{xpath('@RecordType'),MAXLENGTH(6)};
		string	name							{xpath(''),MAXLENGTH(255)};
END;
export crDescription2s := RECORD
		string	Description2Id		{xpath('@Description2Id'),MAXLENGTH(4)};
		string	Description1Id		{xpath('@Description1Id'),MAXLENGTH(4)};
		string	name							{xpath(''),MAXLENGTH(255)};
END;
export crDescription3s := RECORD
		string	Description3Id		{xpath('@Description3Id'),MAXLENGTH(4)};
		string	Description2Id		{xpath('@Description2Id'),MAXLENGTH(4)};
		string	name							{xpath(''),MAXLENGTH(255)};
END;
export crDateTypes := RECORD
		string	RecordType				{xpath('@RecordType'),MAXLENGTH(6)};
		string	id								{xpath('@Id'),MAXLENGTH(4)};
		string	name							{xpath('@name'),MAXLENGTH(255)};
END;
export crNameTypes := RECORD
		string	NameTypeID				{xpath('@NameTypeID'),MAXLENGTH(4)};
		string	RecordType				{xpath('@RecordType'),MAXLENGTH(6)};
		string	name							{xpath(''),MAXLENGTH(255)};
END;
export crRoleTypes := RECORD
		string	RoleID						{xpath('@Id'),MAXLENGTH(4)};
		string	name							{xpath(''),MAXLENGTH(255)};
END;*/
export rNameValue :=
record
	string							TitleHonorific		{xpath('TitleHonorific'),MAXLENGTH(255)};
	unicode							FirstName					{xpath('FirstName'),MAXLENGTH(255)};
	unicode							MiddleName				{xpath('MiddleName'),MAXLENGTH(255)};
	unicode							SurName						{xpath('Surname'),MAXLENGTH(255)};
	unicode							MaidenName				{xpath('MaidenName'),MAXLENGTH(255)};
	unicode							Suffix						{xpath('Suffix'),MAXLENGTH(255)};
	set of unicode			OriginalScriptName {xpath('OriginalScriptName'),MAXLENGTH(255)};
	set of unicode			SingleStringName	{xpath('SingleStringName'),MAXLENGTH(255)};
	unicode							EntityName				{xpath('EntityName'),MAXLENGTH(255)};
end;
export rNameDetails :=
record
	string								NameType				{xpath('@NameType'),MAXLENGTH(255)};
	dataset(rNameValue)		NameValue				{xpath('NameValue')};
end;
export rDescriptions :=
record
	integer								Description1				{xpath('@Description1')};
	integer								Description2				{xpath('@Description2')};
	integer								Description3				{xpath('@Description3')};
end;
export rOccTitle := record
	string								SinceDay				{xpath('@SinceDay'),MAXLENGTH(2)};
	string								SinceMonth			{xpath('@SinceMonth'),MAXLENGTH(3)};
	string								SinceYear				{xpath('@SinceYear'),MAXLENGTH(4)};
	string								ToDay						{xpath('@ToDay'),MAXLENGTH(2)};
	string								ToMonth					{xpath('@ToMonth'),MAXLENGTH(3)};
	string								ToYear					{xpath('@ToYear'),MAXLENGTH(4)};
	string								OccCat					{xpath('@OccCat'),MAXLENGTH(2)};
	string								OccTitle				{xpath(''),MAXLENGTH(255)};
end;

export rRoleDetail := record
	string								RoleType				{xpath('@RoleType'),MAXLENGTH(255)};
	dataset(rOccTitle)		OccTitles				{xpath('OccTitle')};
end;

export rDateValues := record
	string								Day							{xpath('@Day'),MAXLENGTH(2)};
	string								Month						{xpath('@Month'),MAXLENGTH(3)};
	string								Year						{xpath('@Year'),MAXLENGTH(4)};
	string								Dnotes					{xpath('@Dnotes'),MAXLENGTH(255)};
end;

export rDateDetail := record
	string								DateType				{xpath('@DateType'),MAXLENGTH(255)};
	dataset(rDateValues)	DateValues			{xpath('DateValue')};
end;

export rPlaces := record
	string								name						{xpath('@name'),MAXLENGTH(100)};
end;

export rReferences := record
	string								SinceDay				{xpath('@SinceDay'),MAXLENGTH(2)};
	string								SinceMonth			{xpath('@SinceMonth'),MAXLENGTH(3)};
	string								SinceYear				{xpath('@SinceYear'),MAXLENGTH(4)};
	string								ToDay						{xpath('@ToDay'),MAXLENGTH(2)};
	string								ToMonth					{xpath('@ToMonth'),MAXLENGTH(3)};
	string								ToYear					{xpath('@ToYear'),MAXLENGTH(4)};
	string								Reference				{xpath(''),MAXLENGTH(4)};
end;

export rAddresses := record
	string								AddressLine			{xpath('AddressLine'),MAXLENGTH(100)};
	string								AddressCity			{xpath('AddressCity'),MAXLENGTH(255)};
	string								AddressCountry	{xpath('AddressCountry'),MAXLENGTH(13)};
	unicode								URL							{xpath('URL'),MAXLENGTH(255)};
end;

export rCountryValues := record
	string								CountryCode			{xpath('@Code'),MAXLENGTH(13)};
end;
export rCountries := record
	string								CountryType			{xpath('@CountryType'),MAXLENGTH(255)};
	dataset(rCountryValues) CountryValues	{xpath('CountryValue')};
end;

export rIdValues := record
	string							IDnotes						{xpath('@IDnotes'),MAXLENGTH(1000)};
	string							IDvalue						{xpath(''),MAXLENGTH(255)};
end;
export rIdTypes := record
	string							IDType						{xpath('@IDType'),MAXLENGTH(255)};
	dataset(rIdValues)	IDValues					{xpath('IDValue')};
end;

export rSources := record
	unicode							name						{xpath('@name'),MAXLENGTH(255)};
end;

export rImages := record
	unicode							URL							{xpath('@URL'),MAXLENGTH(255)};
end;

export rPersons := RECORD
		string	id								{xpath('@id'),MAXLENGTH(8)};
		string3	action						{xpath('@action')};
		string	date							{xpath('@date'),MAXLENGTH(12)};
		string	Gender						{xpath('Gender'),MAXLENGTH(6)};
		string	ActiveStatus			{xpath('ActiveStatus'),MAXLENGTH(8)};
		string	Deceased					{xpath('Deceased'),MAXLENGTH(3)};
		dataset(rNameDetails)			NameDetails			{xpath('NameDetails/Name')};
		dataset(rDescriptions)		Descriptions		{xpath('Descriptions/Description')};
		dataset(rRoleDetail)			RoleDetail			{xpath('RoleDetail/Roles')};
		dataset(rDateDetail)			DateDetail			{xpath('DateDetails/Date')};
		dataset(rPlaces)					BirthPlace			{xpath('BirthPlace/Place')};
		dataset(rReferences)			Sanctions				{xpath('SanctionsReferences/Reference')};
		dataset(rAddresses)				Addresses				{xpath('Address')};
		dataset(rCountries)				Countries				{xpath('CountryDetails/Country')};
		dataset(rIdTypes)					IdTypes					{xpath('IDNumberTypes/ID')};
		unicode										ProfileNotes		{xpath('ProfileNotes'),MAXLENGTH(100000)};
		dataset(rSources)					Sources					{xpath('SourceDescription/Source')};
		dataset(rImages)					Images					{xpath('Images/Image')};
END;

export rVesselDetails := RECORD
	string								VesselCallSign			{xpath('VesselCallSign'),MAXLENGTH(255)};
	string								VesselType					{xpath('VesselType'),MAXLENGTH(255)};
	string								VesselTonnage				{xpath('VesselTonnage'),MAXLENGTH(255)};
	string								VesselGRT						{xpath('VesselGRT'),MAXLENGTH(255)};
	string								VesselOwner					{xpath('VesselOwner'),MAXLENGTH(255)};
	string								VesselFlag					{xpath('VesselFlag'),MAXLENGTH(13)};
END;

export rEntities := RECORD
		string	id								{xpath('@id'),MAXLENGTH(8)};
		string3	action						{xpath('@action')};
		string	date							{xpath('@date'),MAXLENGTH(12)};
		string	ActiveStatus			{xpath('ActiveStatus'),MAXLENGTH(8)};
		dataset(rNameDetails)			NameDetails			{xpath('NameDetails/Name')};
		dataset(rDescriptions)		Descriptions		{xpath('Descriptions/Description')};
		dataset(rDateDetail)			DateDetail			{xpath('DateDetails/Date')};
		dataset(rReferences)			Sanctions				{xpath('SanctionsReferences/Reference')};
		dataset(rAddresses)				CompanyDetails	{xpath('CompanyDetails')};
		dataset(rVesselDetails)		VesselDetails		{xpath('VesselDetails')};
		dataset(rCountries)				Countries				{xpath('CountryDetails/Country')};
		dataset(rIdTypes)					IdTypes					{xpath('IDNumberTypes/ID')};
		unicode										ProfileNotes		{xpath('ProfileNotes'),MAXLENGTH(100000)};
		dataset(rSources)					Sources					{xpath('SourceDescription/Source')};
END;

export rAssociate := RECORD
		string	associateId							{xpath('@id'),MAXLENGTH(8)};
		string	code										{xpath('@code'),MAXLENGTH(255)};
		string	ex											{xpath('@ex'),MAXLENGTH(3)};
END;

export rPublicFigure := RECORD
		string	id												{xpath('@id'),MAXLENGTH(8)};
		dataset(rAssociate)		Associates	{xpath('Associate')};
END;

export rAssociations := RECORD
		dataset(rPublicFigure)		publicFigures		{xpath('Associations/PublicFigure')};
		dataset(rPublicFigure)		SpecialEntities	{xpath('Associations/SpecialEntity')};
END;


END;