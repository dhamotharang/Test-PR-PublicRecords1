//
//  Hygenics_SOff.Prep_Build
//

EXPORT Prep_Build := Module

		EXPORT PB_Sex_Offender_Main(ds) := functionmacro
				Import Suppress;
				// thor_data400::base::sex_offender_main'+ doxie_build.buildstate + '_BUILDING'
				return(Suppress.applyRegulatory.apply_SO_Offender_Main(ds));				
		endmacro;

		EXPORT PB_Sex_Offender_Offense(ds) := functionmacro
				Import Suppress;
				// thor_data400::base::sex_offender_main'+ doxie_build.buildstate + '_BUILDING'
				return(Suppress.applyRegulatory.apply_SO_Offender_Offense(ds));				
		endmacro;

// not sure how this will be used
		EXPORT PB_sex_offender_enh_fdid(ds) := functionmacro
				Import Suppress;
				// 'persist::SexOffender_Temp'
				// 'persist::sex_offender_enh_fdids'
				return(Suppress.applyRegulatory.apply_SO_enh_fdid(ds));				
		endmacro;

end;