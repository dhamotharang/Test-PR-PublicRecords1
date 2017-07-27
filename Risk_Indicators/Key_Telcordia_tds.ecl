import doxie;
f := File_Telcordia_tds;

export Key_Telcordia_tds := INDEX(f,{npa,nxx},{f},'~thor_data400::key::telcordia_tds_' + doxie.Version_SuperKey);