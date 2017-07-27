import doxie;

f := File_1000_Executive_Summary_Base_bdid(bdid <> 0);

export Key_1000_Executive_Summary_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_1000_Executive_Summary_FILE_NUMBER + '_' + doxie.Version_SuperKey);
