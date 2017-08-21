
// *********Append attribute crim_common.version_production to base files ********///////////

import crim_common;

//export File_Offender :=DATASET('base::crim_offender2_did_20090227',Crim_Common.Layout_Moxie_Crim_Offender2 ,FLAT);

//export File_Offender :=DATASET('~thor_data400::base::crim_offender2_did_'+ crim_common.version_production,Crim_Common.Layout_Moxie_Crim_Offender2.previous ,FLAT);

//change TPatel:10/13/2009
//export File_Offender :=DATASET('~thor_data400::base::crim_offender2_did_'+ crim_common.version_development,Crim_Common.Layout_Moxie_Crim_Offender2.previous ,FLAT);
export File_Offender := Files_IN_for_build_aoc.offender;
