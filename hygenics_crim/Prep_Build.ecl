//
//  Hygenics_Crim.Prep_Build
//

EXPORT Prep_Build := Module

		EXPORT PB_File_Offenders(ds) := functionmacro
				Import Suppress;
				//~thor_Data400::base::Corrections_Offenders_' + doxie_build.buildstate + '_BUILDING'		
				return(Suppress.applyRegulatory.apply_CR_Offenders(ds));				
		endmacro;
	
		EXPORT PB_File_Offenses(ds) := functionmacro
				Import Suppress;
				//'~thor_data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING'		
				return(Suppress.applyRegulatory.apply_CR_Offenses(ds));				
		endmacro;

		EXPORT PB_File_Activity(ds) := functionmacro
				Import Suppress;
				//~thor_data400::base:: corrections_Activity_' + doxie_build.buildstate + '_BUILDING'		
				return(Suppress.applyRegulatory.apply_CR_Activity(ds));				
		endmacro;

		EXPORT PB_File_CourtOffenses(ds) := functionmacro
				Import Suppress;
				//~thor_data400::base::corrections_CourtOffenses_' + doxie_build.buildstate + '_BUILDING'		
				return(Suppress.applyRegulatory.apply_CR_CourtOffenses(ds));				
		endmacro;

		EXPORT PB_File_Punishment(ds) := functionmacro
				Import Suppress;
				//~thor_data400::base::corrections_Punishment_' + doxie_build.buildstate + '_BUILDING'		
				return(Suppress.applyRegulatory.apply_CR_Punishment(ds));				
		endmacro;
end;