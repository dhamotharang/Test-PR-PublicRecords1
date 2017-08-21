import DEA, ut;
//export File_DEA := dataset(ut.foreign_prod + 'thor_data400::base::dea',layout_dea_out,flat);
export File_DEA := PROJECT(DEA.file_dea_modified,TRANSFORM(DEA.layout_DEA_Out,SELF := LEFT;));