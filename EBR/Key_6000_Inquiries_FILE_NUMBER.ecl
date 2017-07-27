import doxie;
f := File_6000_Inquiries_Base_bdid(FILE_NUMBER <> '');
export Key_6000_Inquiries_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_6000_Inquiries_FILE_NUMBER + '_' + doxie.Version_SuperKey);
