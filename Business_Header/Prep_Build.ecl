EXPORT Prep_Build := MODULE

	EXPORT applyBusinessGroupingInj(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessGroupingInj(base_ds);
	ENDMACRO;

	EXPORT applyBusinessRelativesInj(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessRelativesInj(base_ds);
	ENDMACRO;

	EXPORT applyBusinessBestInj(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessBestInj(base_ds);
	ENDMACRO;

	EXPORT applyBusinessContactInj(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessContactInj(base_ds);
	ENDMACRO;

	EXPORT applyBusinessContactInj_AtEnd(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessContactInj_AtEnd(base_ds);
	ENDMACRO;

	EXPORT applyDidAddressBusiness_sup(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyDidAddressBusiness_sup(base_ds);
	ENDMACRO;

	EXPORT applyDidAddressBusiness_sup2(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyDidAddressBusiness_sup2(base_ds);
	ENDMACRO;

	EXPORT applyBusinessHeaderInj(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessHeaderInj(base_ds);
	ENDMACRO;

	EXPORT applyBusinessHeaderInj_AtEnd(base_ds) := FUNCTIONMACRO
		import Business_Header;
		return Business_Header.Regulatory.applyBusinessHeaderInj_AtEnd(base_ds);
	ENDMACRO;

END;