import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := File_UCC_Party_Base;

dSlim		  := TABLE(dPartyBase(did>0), {did,tmsid,rmsid});
dDist         := distribute(dSlim,hash(did,tmsid,rmsid)); 
dSort         := sort(dDist, did,tmsid,rmsid,local);
dDedup        := dedup(DSort ,did,tmsid,rmsid,local);

export Key_DID := INDEX(dDedup  ,{did},{tmsid,rmsid},KeyName +'did_' + Doxie.Version_SuperKey);