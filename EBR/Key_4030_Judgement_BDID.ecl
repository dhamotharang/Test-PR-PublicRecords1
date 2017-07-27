import doxie;

f := File_4030_Judgement_Base_bdid(bdid <> 0);

export Key_4030_Judgement_BDID := index(f,{bdid},{f},KeyName_4030_Judgement_BDID + '_' + doxie.Version_SuperKey);
