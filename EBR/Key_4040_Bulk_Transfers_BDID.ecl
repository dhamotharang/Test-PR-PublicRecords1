import doxie;

f := File_4040_Bulk_Transfers_Base_bdid(bdid <> 0);

export Key_4040_Bulk_Transfers_BDID := index(f,{bdid},{f},KeyName_4040_Bulk_Transfers_BDID + '_' + doxie.Version_SuperKey);
