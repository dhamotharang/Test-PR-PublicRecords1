import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := File_UCC_Party_Base;

dSlim		  := TABLE(dPartyBase(Bdid>0), {Bdid,tmsid,rmsid,party_type});
dDist         := distribute(dSlim,hash(Bdid,tmsid,rmsid)); 
dSort         := sort(dDist, Bdid,tmsid,rmsid,party_type, local);
dDedup        := dedup(DSort ,Bdid,tmsid,rmsid,party_type,local);

export Key_BDID_w_type := INDEX(dDedup  ,{Bdid,party_type},{tmsid,rmsid},KeyName +'Bdid_w_Type_' + Doxie.Version_SuperKey);