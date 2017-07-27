import doxie;

f := File_5000_Bank_Details_Base_bdid(bdid <> 0);

export Key_5000_Bank_Details_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_5000_Bank_Details_FILE_NUMBER + '_' + doxie.Version_SuperKey);
