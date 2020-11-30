
EXPORT Prep_Build := Module

		EXPORT Prep_FCRA_Header(ds) := functionmacro	
				import header;

				return(Header.Regulatory.apply_FCRA_Header(ds));	
		endmacro;

		EXPORT Prep_Header(ds) := functionmacro	
				import header;

				return(Header.Regulatory.apply_Header(ds));	
		endmacro;

	 	EXPORT applySsnCorrectionSup(base_ds) := FUNCTIONMACRO
			import Header;
			return Header.Regulatory.applySsnCorrectionSup(base_ds);
		ENDMACRO;
		
	 	EXPORT applySsnFilterSup(base_ds) := FUNCTIONMACRO
			import Header;
			return Header.Regulatory.applySsnFilterSup(base_ds);
		ENDMACRO;
		
	 	EXPORT applyRidRecSup(base_ds) := FUNCTIONMACRO
			import Header;
			return Header.Regulatory.applyRidRecSup(base_ds);
		ENDMACRO;
		
	 	EXPORT applyDidAddressSup(base_ds) := FUNCTIONMACRO
			import Header;
			return Header.Regulatory.applyDidAddressSup(base_ds);
		ENDMACRO;
		
	 	EXPORT applyDidAddressSup2(base_ds) := FUNCTIONMACRO
			import Header;
			return Header.Regulatory.applyDidAddressSup2(base_ds);
		ENDMACRO;

end;