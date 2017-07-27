import doxie,ut;

f := DCA.File_DCA_Base_bdid;

export Key_DCA_Root_Sub := index(f,{root, sub},{f},'~thor_data400::key::dca_root_sub_'+doxie.Version_SuperKey);
