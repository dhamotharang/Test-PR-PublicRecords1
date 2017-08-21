import doxie,ut;

f := DCA.File_DCA_Base_bid;

export Key_DCA_Root_Sub_bid := index(f,{root, sub},{f},'~thor_data400::key::dca_root_sub_bid_'+doxie.Version_SuperKey);
