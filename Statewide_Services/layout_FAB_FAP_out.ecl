
IMPORT FAB_StateWide,doxie;

EXPORT layout_FAB_FAP_out := MODULE

	EXPORT rec_name := RECORD
		STRING30 fname := '';
		STRING30 mname := '';
		STRING30 lname := '';
		STRING120 name := '';			
  END;
	
	EXPORT rec_address := RECORD
		STRING10  prim_range    := '';
		STRING2   predir        := '';
		STRING28  prim_name     := '';
		STRING4   addr_suffix   := '';
		STRING2   postdir       := '';
		STRING8   unit_desig    := ''; 
		STRING8   sec_range     := '';
		STRING25  v_city_name   := '';
		STRING25  p_city_name   := '';
		STRING2   st            := '';
		STRING5   zip5          := '';
		STRING4   zip4          := '';	
	END;
	
	EXPORT out_layout := RECORD
			STRING20  source_doc_type := '';
			unsigned2	penalt          := 0 ;  
			boolean   isDeepDive      := false;
			STRING3   jurisdiction    := '';
			STRING62  record_id       := '';
			unsigned6 id              := 0;
			STRING120 company_name    := '';		
			rec_name                  name;
			rec_address               address;
			STRING10  phone           := '';
			STRING9   ssn             := '';
			STRING9   fein            := '';
			STRING8   dob             := '';	
			BOOLEAN   is_bdid         := FALSE;	
			// Hunting-Fishing license info specific fields
		  STRING15  hf_lic_num      := '';
		  STRING8   hf_lic_date     := '';
		  STRING20  hf_lic_type     := '';
		  STRING20  hf_lic_st       := '';
 		  STRING20  hf_home_st      := '';
	END;

	EXPORT out_layout_FAB := RECORD
			out_layout AND NOT [hf_lic_num, hf_lic_date, hf_lic_type, hf_lic_st, hf_home_st];
  END;
	
	EXPORT out_layout xfm_OutLayout(FAB_StateWide.layout_FAB_Statewide_out l) := TRANSFORM
		SELF.name      := l;
		SELF.name.name := l.full_name;
		SELF.address   := l;
		SELF           := l;
	END;

	EXPORT out_layout_FAB xfm_OutLayout_FAB(FAB_StateWide.layout_FAB_Statewide_out l) := TRANSFORM
		SELF.name      := l;
		SELF.name.name := l.full_name;
		SELF.address   := l;
		SELF := l;
	END;
	
	 EXPORT output_set := INTERFACE
		Export Boolean SelectIndividually          := false  : STORED('SelectIndividually');
		Export Boolean NewStyle                    := false  : STORED('NewStyle');
		Export Boolean IncludeVoters               := false  : STORED('IncludeVoters');
		Export Boolean IncludeUCC                  := false  : STORED('IncludeUCC');
		Export Boolean IncludeProperty             := false  : STORED('IncludeProperty');
		Export Boolean IncludeHunting              := false  : STORED('IncludeHunting');
		Export Boolean IncludeHFLicenses           := false  : STORED('IncludeHuntingFishingLicenses');
		Export Boolean IncludeProfessionalLicenses := false  : STORED('IncludeProfessionalLicenses');
		Export Boolean IncludeSanctions            := false  : STORED('IncludeSanctions');
		Export Boolean IncludeProviders            := false  : STORED('IncludeProviders');
		Export Boolean IncludeBankruptcy           := false  : STORED('IncludeBankruptcy');
		Export Boolean IncludeLiens                := false  : STORED('IncludeLiens');
		Export Boolean IncludeMarriageDivorce      := false  : STORED('IncludeMarriageDivorce');
		Export Boolean IncludeDeath                := false  : STORED('IncludeDeath');
		Export Boolean IncludeDriverLicenses       := false  : STORED('IncludeDriverLicenses');
		Export Boolean IncludeWatercraft           := false  : STORED('IncludeWatercraft');
		Export Boolean IncludeVehicles             := false  : STORED('IncludeVehicles');
		Export Boolean IncludeEquifax              := false  : STORED('IncludeEquifax');
		Export Boolean IncludePersonLocator1       := false  : STORED('IncludePersonLocator1');
		Export Boolean IncludePersonLocator5       := false  : STORED('IncludePersonLocator5');
		Export Boolean IncludePersonLocator6       := false  : STORED('IncludePersonLocator6');
		Export Boolean IncludeCriminalRecords      := false  : STORED('IncludeCriminalRecords');
		Export Boolean IncludeWhitePages           := false  : STORED('IncludeWhitePages');		
		Export Boolean IncludeTargus               := false  : STORED('IncludeTargus');		
		Export Boolean IncludeCorp                 := false  : STORED('IncludeCorp');		
		Export Boolean IncludeFBN                  := false  : STORED('IncludeFBN');		
		Export Boolean IncludeCalBus               := false  : STORED('IncludeCalBus');		
		Export Boolean IncludeTxBus                := false  : STORED('IncludeTxBus');		
  END;	
	
	
	
END;	