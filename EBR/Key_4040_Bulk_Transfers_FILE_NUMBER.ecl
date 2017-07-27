import doxie;

f := File_4040_Bulk_Transfers_Base_bdid(FILE_NUMBER <> '');

export Key_4040_Bulk_Transfers_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4040_Bulk_Transfers_FILE_NUMBER + '_' + doxie.Version_SuperKey);
