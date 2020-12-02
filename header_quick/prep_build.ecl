
EXPORT Prep_Build := Module

	 	EXPORT applyQH() := FUNCTIONMACRO
				import Header_Quick;
				return Header_Quick.Regulatory.applyQH();
		ENDMACRO;

end; 
