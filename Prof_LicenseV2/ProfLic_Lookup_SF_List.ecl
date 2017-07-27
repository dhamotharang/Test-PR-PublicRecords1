IMPORT ut;

EXPORT ProfLic_Lookup_SF_List :=  MODULE

		EXPORT License_Type_Load							:= '~thor_data400::in::prolicv2::professional_license_type_lookup_load';

		EXPORT License_Type_Load_Father				:= '~thor_data400::in::prolicv2::professional_license_type_lookup_load_father';
			
		EXPORT License_Type_Base							:= '~thor_data400::base::prolicv2::professional_license_type_lookup';

		EXPORT License_Type_Base_Prev					:= '~thor_data400::base::prolicv2::professional_license_type_lookup_father';
		
END;