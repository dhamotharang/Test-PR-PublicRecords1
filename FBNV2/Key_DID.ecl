import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::FBNV2::';
dBase 	  := File_FBN_Contact_Base;

dSlim		  := TABLE(dBase(did>0), {did,tmsid,rmsid});
dDist         := distribute(dSlim,hash(did,tmsid,rmsid)); 
dSort         := sort(dDist, did,tmsid,rmsid,local);
dDedup        := dedup(DSort ,did,tmsid,rmsid,local);

export Key_DID := INDEX(dDedup  ,{did},{tmsid,rmsid},KeyName +doxie.Version_SuperKey+'::did');