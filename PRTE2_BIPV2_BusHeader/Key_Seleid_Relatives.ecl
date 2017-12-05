import PRTE2_BIPV2_BusHeader;

RelKeyNameASSOC := PRTE2_BIPV2_BusHeader.keynames().assoc_seleid.qa;

dBH_Sele_rel := PRTE2_BIPV2_BusHeader.Files().base.Relatives.built;

export Key_Seleid_Relatives := INDEX(dBH_Sele_rel,{Seleid1,Seleid2},{dBH_Sele_rel},RelKeyNameASSOC);