

import ut,Crim_Common;

//export file_offender_doc := DATASET(ut.foreign_prod+'~thor400_92::persist::crim::doc::offender' ,Crim_Common.Layout_Moxie_Crim_Offender2.previous ,FLAT);

//export file_offender_doc := DATASET(ut.foreign_prod+'~thor_data400::base::crim_offender2_did_'+ crim_common.version_development,Crim_Common.Layout_Moxie_Crim_Offender2.previous ,FLAT);

export file_offender_doc := DATASET('~thor400_88_staging::persist::out::crim::hd::doc::offender' ,Crim_Common.Layout_Moxie_Crim_Offender2.previous ,FLAT);



                        
