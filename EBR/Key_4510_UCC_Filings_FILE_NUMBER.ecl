import doxie;

f := File_4510_UCC_Filings_Base_bdid(FILE_NUMBER <> '');

export Key_4510_UCC_Filings_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4510_UCC_Filings_FILE_NUMBER + '_' + doxie.Version_SuperKey);
