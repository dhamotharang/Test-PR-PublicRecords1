import doxie;

f := File_4035_Attachment_Lien_Base_bdid(FILE_NUMBER <> '');

export Key_4035_Attachment_Lien_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4035_Attachment_Lien_FILE_NUMBER + '_' + doxie.Version_SuperKey);
