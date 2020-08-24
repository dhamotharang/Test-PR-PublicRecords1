EXPORT Prep_Build := module

		EXPORT applyGongNeustarSup(baseIn) := functionmacro
						Import Gong_Neustar, Suppress ;
						return(Gong_Neustar.Regulatory.applyGongNeustarSup(baseIn));				
				endmacro;
			
		EXPORT applyGongNeustar(baseIn) := functionmacro
					Import Gong_Neustar, Suppress ;
					return(Gong_Neustar.Regulatory.applyGongNeustar(baseIn));				
		endmacro;
		
		EXPORT applyGong(baseIn) := functionmacro
					Import Gong_Neustar, Suppress, Gong ;
					return(Gong_Neustar.Regulatory.applyGong(baseIn));				
		endmacro;
		
			
end ;