EXPORT Prep_Build := MODULE

	EXPORT prepBase_Did(base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2;
		return Prof_LicenseV2.Regulatory.prepBase_Did(base_ds);

	ENDMACRO;

	EXPORT prepBase_Id(base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2;
		return Prof_LicenseV2.Regulatory.prepBase_Id(base_ds);

	ENDMACRO;


END;