EXPORT Prep_Build := MODULE


	EXPORT applyEmploymentSup(base_ds) := FUNCTIONMACRO
		import paw;
		return paw.Regulatory.applyEmploymentSup(base_ds);
	ENDMACRO;
	
	EXPORT applyEmploymentInj(base_ds) := FUNCTIONMACRO
		import paw;
		return paw.Regulatory.applyEmploymentInj(base_ds);
	ENDMACRO;

	EXPORT applyEmploymentInj_atEnd(base_ds) := FUNCTIONMACRO
		import paw;
		return paw.Regulatory.applyEmploymentInj_atEnd(base_ds);
	ENDMACRO;
	
END;