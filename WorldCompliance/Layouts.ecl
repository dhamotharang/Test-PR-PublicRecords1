EXPORT Layouts := MODULE

export rEntity := RECORD
	unsigned8		Ent_ID;
	unicode			name {maxlength(255)};
	unicode			FirstName {maxlength(50)};
	unicode			LastName {maxlength(50)};
	string			Prefix {maxlength(30)};
	unicode			Suffix {maxlength(10)};
	unicode			Aka {maxlength(8192)};
	string			NameSource {maxlength(20)};
	unsigned8		ParentId;
	string			GovDesignation {maxlength(25)};
	string			EntryType {maxlength(20)};
	string			EntryCategory {maxlength(20)};
	string			EntrySubcategory {maxlength(20)};
	string			Organization {maxlength(100)};
	unicode			Positions {maxlength(8192)};
	unicode			Remarks {maxlength(32000)};
	string			Dob {maxlength(75)};
	string			Pob {maxlength(75)};
	unicode			Country {maxlength(100)};
	string			ExpirationDate {maxlength(20)};
	string			EffectiveDate {maxlength(20)};
	string			PictureFile {maxlength(200)};
	string			LinkedTo {maxlength(250)};
	unsigned8		Related_ID;
	string			SourceWebLink {maxlength(8192)};
	string			TouchDate {maxlength(16)};
	string			DirectId {maxlength(50)};
	string			PassportId {maxlength(20)};
	string			NationalId {maxlength(20)};
	string			OtherId {maxlength(20)};
	string			Dob2 {maxlength(20)};
	unicode			EntLevel {maxlength(30)};
	unsigned8		MasterId;
	boolean			Watch;
	boolean			Relationships;
	unicode			PrimaryName {maxlength(255)};
	unicode			OriginalName2  {maxlength(255)} := '';
	string			DateEntered 	{maxlength(16)} := '';
// fields added on 2013-11-01
	string			DobOriginal;
	boolean			PictureFileOnly;
	unicode			OriginalName3;
	string			OriginalLanguage;
	string			DateUpdated;
	string			EnteredBy;
	string			UpdatedBy;
	string			JurisdictionId;
	string			Relationships2;
	string			CriminalAmount;
	string			TermStartDate;
	string			TermEndDate;
	string			StatusEndDate;
	string			SpecialCollections;
	string			EntitiesLevelsId;
	integer			EntryCategoryID;
	integer			EntrySubCategoryID;
	integer			EntitiesSourceID;
	integer			EntryTypeId;
	integer			CountryId;
	integer			PepCode;
	string			Gender;
END;
/*
Ent_ID|Name|FirstName|LastName|Prefix|Suffix|Aka|NameSource|ParentID|GovDesignat
ion|EntryType|EntryCategory|EntrySubCategory|Organization|Positions|REMARKS|DOB|
POB|Country|ExpirationDate|EffectiveDate|PictureFile|LinkedTo|Related_ID|SourceW
ebLink|TouchDate|DirectID|PassportID|NationalID|OtherID|DOB2|EntLevel|MasterID|W
atch|Relationships|PrimaryName|OriginalName2|DateEntered|DobOriginal|PictureFile
Only|OriginalName3|OriginalLanguage|DateUpdated|EnteredBy|UpdatedBy|Jurisdiction
ID|Relationships|CriminalAmount|TermStartDate|TermEndDate|StatusEndDate|SpecialC
ollections|EntitiesLevelsId|EntryCategoryID|EntrySubCategoryID|EntitiesSourceID|
EntryTypeID|CountryId|PepCode|Gender
*/


export rAddress := RECORD
	unsigned8		Address_ID;
	unsigned8		Ent_ID;
	unicode			Address {maxlength(255)};
	unicode			City {maxlength(50)};
	unicode			StateProvince {maxlength(50)};
	unicode			Country {maxlength(100)};
	unicode			PostalCode {maxlength(15)};
	unicode			Remarks {maxlength(255)};
	string			NameSource {maxlength(20)};
END;

export rSanctionsDOB := RECORD
	unsigned8		SanctionsDobId;
	unsigned8		Ent_ID;
	string			Dob {maxlength(75)};
END;

export rWCOCategories := Record
	unsigned8		EntityID;
	string			SegmentType {maxlength(100)};
	string			SubCategoryLabel {maxlength(100)};
	string			SubCategoryDesc {maxlength(100)};
	string			LastUpdated;
	string			IsActivePEP;
	END;
export rRelationship := RECORD
	unsigned8		RID;
	unsigned8		Ent_IDParent;
	unsigned8		Ent_IDChild;
	unsigned8		RelationID;
END;

export rSource := RECORD
	unsigned8		SourceId;
	unicode			Country {maxlength(50)};
	unicode			SourceName {maxlength(200)};
	string			SourceAbbrev {maxlength(10)};
END;

export rCountry := RECORD
	unsigned8		CountryId;
	unicode			CountryName {maxlength(50)};
END;

export rCategories := RECORD
	unsigned8		CatId;
	string			CatName {maxlength(50)};
END;

END;