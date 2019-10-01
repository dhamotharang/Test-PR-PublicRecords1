import  UCCV2,RoxieKeyBuild,ut,autokey,doxie; 

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := project(File_UCC_Party_Base,transform(Layout_UCC_Common.Layout_Party,
                                                       self.dt_vendor_last_reported  := (unsigned6)(string)left.dt_vendor_last_reported[1..6];
			                                                 self.dt_vendor_first_reported := (unsigned6)(string)left.dt_vendor_first_reported[1..6];
																											 self := left;
																											 self := [];
																											 ));

dSlim		  := TABLE(dPartyBase(did>0), {did,tmsid,rmsid});
dDist         := distribute(dSlim,hash(did,tmsid,rmsid)); 
dSort         := sort(dDist, did,tmsid,rmsid,local);
dDedup        := dedup(DSort ,did,tmsid,rmsid,local);

export Key_DID := INDEX(dDedup  ,{did},{tmsid,rmsid},KeyName +'did_' + Doxie.Version_SuperKey);