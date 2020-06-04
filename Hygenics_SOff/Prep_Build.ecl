//
//  Hygenics_SOff.Prep_Build
//

EXPORT Prep_Build := Module

		EXPORT PB_Sex_Offender_Main(ds) := functionmacro
				import Hygenics_SOff;
				
				return(Hygenics_SOff.Regulatory.apply_SO_Offender_Main(ds));				
		endmacro;

		EXPORT PB_Sex_Offender_Offense(ds) := functionmacro
				import Hygenics_SOff;

				return(Hygenics_SOff.Regulatory.apply_SO_Offender_Offense(ds));				
		endmacro;

// not sure how this will be used
		EXPORT PB_sex_offender_enh_fdid(ds) := functionmacro
				import Hygenics_SOff;
				// 'persist::SexOffender_Temp'
				// 'persist::sex_offender_enh_fdids'
				return(Hygenics_SOff.Regulatory.apply_SO_enh_fdid(ds));				
		endmacro;

end;