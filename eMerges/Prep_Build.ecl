//
// eMerges.Prep_build
//

EXPORT Prep_Build := Module
				
		EXPORT ConCarry(dsn, dsn_rec_lo) := functionmacro
				Import Suppress;
				// ccw_dsn2 := '~thor_data400::base::emerges_CCW_building'; // note - during unit testing you may need to use '~thor_data400::base::emerges_CCW_built'
				ConCar_ds :=	dataset(dsn, dsn_rec_lo, thor);	
				return(Suppress.applyRegulatory.applyCCW(ConCar_ds));			
		endmacro;
		
		EXPORT Hunt_Fish(hf_dsn, hf_dsn_rec_lo) := functionmacro
				Import Suppress;
				//'~thor_data400::base::emerges_hunt_building'  						// note - during unit testing you may need to use '~thor_data400::base::emerges_hunt_built' 
				HuntFish_ds :=	dataset(hf_dsn, hf_dsn_rec_lo, thor);	
				return(Suppress.applyRegulatory.applyHF(HuntFish_ds));				
		endmacro;
				
end;