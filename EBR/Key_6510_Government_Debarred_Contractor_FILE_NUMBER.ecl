import doxie;
f := File_6510_Government_Debarred_Contractor_Base_bdid(FILE_NUMBER <> '');
export Key_6510_Government_Debarred_Contractor_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER + '_' + doxie.Version_SuperKey);
