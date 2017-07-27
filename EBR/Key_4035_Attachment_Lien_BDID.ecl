import doxie;

f := File_4035_Attachment_Lien_Base_bdid(bdid <> 0);

export Key_4035_Attachment_Lien_BDID := index(f,{bdid},{f},KeyName_4035_Attachment_Lien_BDID + '_' + doxie.Version_SuperKey);
