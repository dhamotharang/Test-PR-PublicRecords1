EXPORT Prep_Build := module

		EXPORT applyGongNeustarSup(baseIn) := functionmacro
						Import Gong_Neustar, Suppress ;
						return(Gong_Neustar.Regulatory.applyGongNeustarSup(baseIn));				
				endmacro;
			
		EXPORT applyGongNeustar(baseIn) := functionmacro
					Import Gong_Neustar, Suppress ;
					return(Gong_Neustar.Regulatory.applyGongNeustar(baseIn));				
		endmacro;
		
		
		EXPORT applyGongNeustarInj(baseIn) := functionmacro
					Import Gong_Neustar, Suppress ;
					return(Gong_Neustar.Regulatory.applyGongNeustarInj(baseIn));				
		endmacro;
		
	
end ;