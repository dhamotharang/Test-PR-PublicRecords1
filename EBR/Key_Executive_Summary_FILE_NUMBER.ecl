import doxie;

f := File_Executive_Summary_Base(bdid <> 0);

export Key_Executive_Summary_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_Executive_Summary_FILE_NUMBER + '_' + doxie.Version_SuperKey);
