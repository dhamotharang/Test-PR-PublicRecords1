import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := File_UCC_Party_Base;

dSlim		  := TABLE(dPartyBase(SSN>'0'), {SSN,tmsid,rmsid});
dDist         := distribute(dSlim,hash(SSN,tmsid,rmsid)); 
dSort         := sort(dDist, SSN,tmsid,rmsid,local);
dDedup        := dedup(DSort ,SSN,tmsid,rmsid,local);

export Key_SSN := INDEX(dDedup  ,{SSN},{tmsid,rmsid},KeyName +'SSN_' + Doxie.Version_SuperKey);