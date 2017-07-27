import doxie;

f := File_0010_Header_Base(bdid <> 0);

export Key_0010_Header_BDID := index(f,{bdid},{f},KeyName_0010_Header_BDID + '_' + doxie.Version_SuperKey);
