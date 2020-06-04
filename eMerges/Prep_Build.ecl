//
// eMerges.Prep_build
//

Export Prep_Build := Module
				
		Export ConCarry(dsn, dsn_rec_lo) := functionmacro
				ConCar_ds :=	dataset(dsn, dsn_rec_lo, thor);	
				return(emerges.Regulatory.applyCCW(ConCar_ds));
		Endmacro;
		
		Export Hunt_Fish(hf_dsn, hf_dsn_rec_lo) := functionmacro
				HuntFish_ds :=	dataset(hf_dsn, hf_dsn_rec_lo, thor);	
				return(emerges.Regulatory.applyHF(HuntFish_ds));				
		Endmacro;
				
End;