EXPORT Prep_Build := MODULE

	EXPORT applyAirmenCertificateInj(base_ds) := FUNCTIONMACRO
		import faa;
		return faa.Regulatory.applyAirmenCertificateInj(base_ds);
	ENDMACRO;

	
	EXPORT applyAirmenDataInj(base_ds) := FUNCTIONMACRO
		import faa;
		return faa.Regulatory.applyAirmenDataInj(base_ds);
	ENDMACRO;

END;