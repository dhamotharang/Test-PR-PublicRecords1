import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::FBNV2::';
dBase 	      := File_FBN_Business_Base(Bdid>0);
                
dSlim		  := TABLE(dBase, {Bdid,tmsid,rmsid})+Table(File_FBN_contact_Base(Bdid>0),{Bdid,tmsid,rmsid});
dDist         := distribute(dSlim,hash(Bdid,tmsid,rmsid)); 
dSort         := sort(dDist, Bdid,tmsid,rmsid,local);
dDedup        := dedup(DSort ,Bdid,tmsid,rmsid,local);

export Key_BDID := INDEX(dDedup  ,{Bdid},{tmsid,rmsid},KeyName+doxie.Version_SuperKey+'::Bdid');