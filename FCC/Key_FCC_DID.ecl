import doxie;

bfile := fcc.File_FCC_base;

export Key_FCC_DID := index(bfile(attention_did>0),{unsigned did := bfile.attention_did},{fcc_seq},'~thor_data400::key::fcc::'+doxie.Version_SuperKey+'::did');