import doxie;
 
bfile := fcc.File_FCC_base;

export Key_FCC_seq := index(bfile,{fcc_seq},{bfile},'~thor_data400::key::fcc::'+doxie.Version_SuperKey+'::seq');