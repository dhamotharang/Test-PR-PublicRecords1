EXPORT Prep_Build := module

		EXPORT applyRegulatoryPhoneMartSup(baseIn) := functionmacro
						Import PhoneMart, Suppress ;
						return(PhoneMart.Regulatory.applyPhoneMartSup(baseIn));				
				endmacro;
			
		EXPORT applyRegulatoryPhoneMart(baseIn) := functionmacro
					Import PhoneMart, Suppress ;
					return(PhoneMart.Regulatory.applyPhoneMart(baseIn));				
		endmacro;	
	
end;