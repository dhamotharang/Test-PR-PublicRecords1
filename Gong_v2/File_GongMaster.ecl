import gong;
AidGongMaster := dataset(gong_v2.thor_cluster+'base::gongv2_master',Gong_v2.layout_gongMasterAid,thor);

//export File_GongMaster := project(AidGongMaster, transform(Gong_v2.layout_gongMaster, self := left));

prAidGongMaster := project(AidGongMaster, transform(Gong_v2.layout_gongMaster, self := left));
Gong.macRecordSuppression(prAidGongMaster, AidGongMasterFilt, phone10)
export File_GongMaster := AidGongMasterFilt;
