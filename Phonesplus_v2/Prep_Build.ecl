EXPORT Prep_Build := module

		EXPORT applyRegulatoryPhonesPlusSup(baseIn) := functionmacro
						Import Phonesplus_v2, Suppress ;
						return(Phonesplus_v2.Regulatory.applyPhonesPlusSup_Phone(baseIn));				
				endmacro;
			
		EXPORT applyRegulatoryPhonesPlusInj(baseIn) := functionmacro
					Import Phonesplus_v2, Suppress ;
					return(Phonesplus_v2.Regulatory.applyPhonesPlusInj(baseIn));				
		endmacro;	
		
		EXPORT applyRegulatoryPhonesPlus(baseIn) := functionmacro
					Import Phonesplus_v2, Suppress ;
					return(Phonesplus_v2.Regulatory.applyPhonesPlusAll(baseIn));				
		endmacro;	
	
end;