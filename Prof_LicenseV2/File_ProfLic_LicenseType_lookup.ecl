IMPORT Prof_LicenseV2, ut;

EXPORT File_ProfLic_LicenseType_lookup := MODULE
			
			EXPORT License_Type_Update		:= dataset(Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Load,
																			Layout_ProfLic_LicenseType_lookup, csv(quote('"'), heading(single)) );
			
			EXPORT License_Type_Base			:= dataset(Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Base,
																			Layout_ProfLic_LicenseType_lookup, flat, opt);
																		
			EXPORT License_Type_Base_Prev	:= dataset(Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Base_Prev,
																			Layout_ProfLic_LicenseType_lookup, flat, opt);
END;
