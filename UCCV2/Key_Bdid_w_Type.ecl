import  UCCV2,RoxieKeyBuild,ut,autokey,doxie; 

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := project(File_UCC_Party_Base,transform(Layout_UCC_Common.Layout_Party,
                                                       self.dt_vendor_last_reported  := (unsigned6)(string)left.dt_vendor_last_reported[1..6];
			                                                 self.dt_vendor_first_reported := (unsigned6)(string)left.dt_vendor_first_reported[1..6];
																											 self := left;
																											 self := [];
																											 ));

dSlim		  := TABLE(dPartyBase(Bdid>0), {Bdid,tmsid,rmsid,party_type});
dDist         := distribute(dSlim,hash(Bdid,tmsid,rmsid)); 
dSort         := sort(dDist, Bdid,tmsid,rmsid,party_type, local);
dDedup        := dedup(DSort ,Bdid,tmsid,rmsid,party_type,local);

export Key_BDID_w_type := INDEX(dDedup  ,{Bdid,party_type},{tmsid,rmsid},KeyName +'Bdid_w_Type_' + Doxie.Version_SuperKey);