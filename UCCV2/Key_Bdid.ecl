import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := File_UCC_Party_Base;

dSlim		  := TABLE(dPartyBase(Bdid>0), {Bdid,tmsid,rmsid});
dDist         := distribute(dSlim,hash(Bdid,tmsid,rmsid)); 
dSort         := sort(dDist, Bdid,tmsid,rmsid,local);
dDedup        := dedup(DSort ,Bdid,tmsid,rmsid,local);

export Key_BDID := INDEX(dDedup  ,{Bdid},{tmsid,rmsid},KeyName +'Bdid_' + Doxie.Version_SuperKey);