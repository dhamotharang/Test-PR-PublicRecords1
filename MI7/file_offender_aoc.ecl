
import Crim_Common, ut, hygenics_eval;;

//export file_offender_aoc := 
//dataset('~thor_data200::persist::crim::aoc::offender_mod_20110702c', hygenics_eval.Layout_Common_Crim_Offender, flat);
    
		
export file_offender_aoc := 
dataset('~thor_data200::persist::hygenics::crim::HD::county::offender', hygenics_eval.Layout_Common_Crim_Offender, flat);
    		


																   


