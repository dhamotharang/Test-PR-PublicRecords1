
EXPORT Prep_Build := Module

		EXPORT Prep_FCRA_Header(ds) := functionmacro	
				import header;

				return(Header.Regulatory.apply_FCRA_Header(ds));	
		endmacro;

end;