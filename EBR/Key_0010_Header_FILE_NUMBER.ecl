import doxie;

f := File_0010_Header_Base(FILE_NUMBER <> '');

export Key_0010_Header_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_0010_Header_FILE_NUMBER + '_' + doxie.Version_SuperKey);
