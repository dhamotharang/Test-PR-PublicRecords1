
import ut, crim_common;

export file_crim_Offenses_doc := DATASET('~thor_data400::base::crim_offenses_'+ crim_common.version_development,Crim_Common.Layout_In_DOC_Offenses.previous ,FLAT);

//export file_crim_Offenses_doc := DATASET(ut.foreign_prod+'~thor_data400::base::crim_offenses_'+ crim_common.version_development,Crim_Common.Layout_In_DOC_Offenses.previous ,FLAT);

