import ut, std;
FillEnt := RECORD
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

FillEnt	xForm(Layouts.rWCOCategories infile) := TRANSFORM
	self.Ent_ID := infile.EntityID;
	self.EntryType := if(infile.SegmentType='AdditionalSegments',
				if(infile.SubCategoryLabel = 'Associated Entity' or infile.SubCategoryLabel ='Ownership Or Control' or infile.SubCategoryLabel = 'SWIFT BIC Entity',
					'Associated Entity', 
						if(infile.SubCategoryLabel = 'IHS OFAC Vessels' or infile.SubCategoryLabel = 'Sanction List','Sanction List','Registrations')),
				infile.SegmentType);
	self.EntrySubcategory := if(infile.SubCategoryLabel = 'Primary PEP' or infile.SubCategoryLabel = 'Secondary PEP', infile.SubCategoryDesc, 
					if(infile.SegmentType='AdditionalSegments' AND (infile.SubCategoryLabel = 'Associated Entity' or infile.SubCategoryLabel = 'IHS OFAC Vessels'),
						'N/A', infile.SubCategoryLabel));

//	self.EntryType := infile.SegmentType;
//	self.EntrySubcategory := if(infile.SubCategoryLabel = 'Primary PEP' or infile.SubCategoryLabel = 'Secondary PEP', infile.SubCategoryDesc, infile.SubCategoryLabel);
	self := [];
END;	

EXPORT MakeMultEnt(dataset(Layouts.rWCOCategories) infile) := FUNCTION
//EXPORT MakeMultEnt:= FUNCTION		
      //MainEnt := (Files.dsMasters);
			newMult := (infile);
	return normalize(newMult,1, xForm(LEFT));
	
	/*MultFile RollRecs(MultFile L, MultFile R) := TRANSFORM
				self.Ent_Id := L.Ent_Id;
				//extra := DEDUP(R.cmts,Ent_ID,All);
				self:= [];
		END;
		*/		
		//ritems := ROLLUP(Mult1, RollRecs(LEFT,RIGHT), Ent_Id, local);
		
		
			
END;
