import doxie;
f := File_6510_Government_Debarred_Contractor_Base_bdid(bdid <> 0);
export Key_6510_Government_Debarred_Contractor_BDID := index(f,{bdid},{f},KeyName_6510_Government_Debarred_Contractor_BDID + '_' + doxie.Version_SuperKey);
