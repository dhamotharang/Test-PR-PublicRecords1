
import crim_common, ut, hygenics_eval;

// export file_Court_Offenses_aoc := 
// dataset('~thor200_144::persist::hygenics::crim::aoc_offense_20110702c_ct_append', hygenics_eval.Layout_Common_Court_Offenses, flat);


export file_Court_Offenses_aoc := 
dataset('~thor200_144::persist::hygenics::crim::HD::county::offense', hygenics_eval.Layout_Common_Court_Offenses, flat);


