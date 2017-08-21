
import ut,crim_common;

export file_crim_punishment_doc := DATASET('~thor400_88_staging::persist::out::crim::hd::doc::punishment',Crim_Common.Layout_In_DOC_Punishment.previous,FLAT);


//export file_crim_punishment_doc := DATASET(ut.foreign_prod+'~thor_data400::base::crim_punishment_' + crim_common.Version_Development,Crim_Common.Layout_In_DOC_Punishment.previous,FLAT);

