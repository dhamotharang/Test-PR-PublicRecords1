import doxie;

f := File_Header_Base(bdid <> 0);

export Key_Header_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_Header_FILE_NUMBER + '_' + doxie.Version_SuperKey);
