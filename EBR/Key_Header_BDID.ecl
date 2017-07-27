import doxie;

f := File_Header_Base(bdid <> 0);

export Key_Header_BDID := index(f,{bdid},{f},KeyName_Header_BDID + '_' + doxie.Version_SuperKey);
