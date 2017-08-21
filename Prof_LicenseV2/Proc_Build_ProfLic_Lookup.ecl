EXPORT Proc_Build_ProfLic_Lookup := FUNCTION

	UpdateFile					:= File_ProfLic_LicenseType_lookup.License_Type_Update;
	OrigBaseFile				:= File_ProfLic_LicenseType_lookup.License_Type_Base;
	
	Prof_LicenseV2.Layout_ProfLic_LicenseType_lookup MakeUpper(UpdateFile L)	:= TRANSFORM
		SELF.license_type			:=	TRIM(Stringlib.StringToUpperCase(Stringlib.StringFilterout(L.license_type,'"')),LEFT,RIGHT);	
		SELF.occupation				:=	TRIM(Stringlib.StringToUpperCase(L.occupation),LEFT,RIGHT);
		SELF.category					:=	TRIM(Stringlib.StringToUpperCase(L.category),LEFT,RIGHT);
		SELF									:=	L;
	END;

	NewFile := project(UpdateFile, MakeUpper(LEFT));
	
	NewAndOldFile			:=	OrigBaseFile + NewFile;
	
	preprocess	 	:= DISTRIBUTE(NewAndOldFile, HASH(license_type, category));
	preprocess2		:= SORT(preprocess, license_type, category, LOCAL);

	Prof_LicenseV2.Layout_ProfLic_LicenseType_lookup t_rollup (preprocess2 L, preprocess2 R)	:= TRANSFORM
		SELF											:= IF(L.occupation = '', R, L);
	END;

	NewBaseFile		:= ROLLUP(preprocess2,
												LEFT.license_type	=	RIGHT.license_type AND
												LEFT.category			=	RIGHT.category,
												t_rollup(LEFT, RIGHT),
												LOCAL);
																			
	RETURN NewBaseFile;
END;
