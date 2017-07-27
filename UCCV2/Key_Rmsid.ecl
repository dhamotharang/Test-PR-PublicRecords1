import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dmainBase 	  := DEDUP(File_UCC_Main_Base,all);
dSort         := sort(distribute(dmainBase,Hash(rmsid,rmsid)),Tmsid,RMSID,local);

export Key_RMSID  := INDEX(dSort ,{RMSID},{TMSID},KeyName +'Rmsid_' + Doxie.Version_SuperKey);