import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := File_UCC_Party_Base;

dSlim		  := TABLE(dPartyBase(fein>''), {Fein,tmsid,rmsid});
dDist         := distribute(dSlim,hash(Fein,tmsid,rmsid)); 
dSort         := sort(dDist, Fein,tmsid,rmsid,local);
dDedup        := dedup(DSort,Fein,tmsid,rmsid,local);

export Key_fein := INDEX(dDedup  ,{fein},{tmsid,rmsid},KeyName +'fein_' + Doxie.Version_SuperKey);