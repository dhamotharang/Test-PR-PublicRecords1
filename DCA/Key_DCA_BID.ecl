import doxie,ut;

f := DCA.File_DCA_Base_bid(bdid <> 0);

export Key_DCA_BID := index(f,{bdid},{f},'~thor_data400::key::dca_bid_'+doxie.Version_SuperKey);
