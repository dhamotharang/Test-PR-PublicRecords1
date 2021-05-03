

Export Prep_Build := Module

		Export Reflection(ds) :=
				functionmacro
						Import Infutor;
					
						return(Infutor.Regulatory.Reflection(ds));	
				endmacro;

		Export Reflection_header(ds) :=
				functionmacro
						Import Infutor;
					
						return(Infutor.Regulatory.Reflection_header(ds));	
				endmacro;

end;