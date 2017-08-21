
// *********Append attribute crim_common.version_production to base files ********///////////
import crim_common;

//export File_Court_Offenses :=DATASET('base::court_offenses_20090227',Crim_Common.Layout_Moxie_Court_Offenses ,FLAT);

//export File_Court_Offenses :=DATASET('~thor_data400::base::court_offenses_'+ crim_common.version_production,Crim_Common.Layout_Moxie_Court_Offenses ,FLAT);

//change TPatel:10/13/2009
//export File_Court_Offenses :=DATASET('~thor_data400::base::court_offenses_'+ crim_common.version_development,Crim_Common.Layout_Moxie_Court_Offenses ,FLAT);
export File_Court_Offenses := Files_IN_for_build_aoc.court_offenses;


