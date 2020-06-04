//
//  Hygenics_Crim.Prep_Build
//

Export Prep_Build := Module

		Export PB_File_Offenders(ds) := 
				functionmacro
						Import Hygenics_Crim;
					
						return(Hygenics_Crim.Regulatory.apply_CR_Offenders(ds));	
				endmacro;

	
		Export PB_File_Offenses(ds) := 
				functionmacro
						Import Hygenics_Crim;
						
						return(Hygenics_Crim.Regulatory.apply_CR_Offenses(ds));				
				endmacro;


		Export PB_File_Activity(ds) := 
				functionmacro
						Import Hygenics_Crim;
						
						return(Hygenics_Crim.Regulatory.apply_CR_Activity(ds));				
				endmacro;


		Export PB_File_CourtOffenses(ds) := 
				functionmacro
						Import Hygenics_Crim;

						return(Hygenics_Crim.Regulatory.apply_CR_CourtOffenses(ds));				
				endmacro;


		Export PB_File_Punishment(ds) := 
				functionmacro
						Import Hygenics_Crim;

						return(Hygenics_Crim.Regulatory.apply_CR_Punishment(ds));				
				endmacro;
end;