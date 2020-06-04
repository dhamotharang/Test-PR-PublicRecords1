import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;  

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := project(File_UCC_Party_Base,transform(Layout_UCC_Common.Layout_Party,
                                                       self.dt_vendor_last_reported  := (unsigned6)(string)left.dt_vendor_last_reported[1..6];
			                                                 self.dt_vendor_first_reported := (unsigned6)(string)left.dt_vendor_first_reported[1..6];
																											 self := left;
																											 self := [];
																											 ));

dSlim		  := TABLE(dPartyBase(SSN>'0'), {SSN,tmsid,rmsid});
dDist         := distribute(dSlim,hash(SSN,tmsid,rmsid)); 
dSort         := sort(dDist, SSN,tmsid,rmsid,local);
dDedup        := dedup(DSort ,SSN,tmsid,rmsid,local);

export Key_SSN := INDEX(dDedup  ,{SSN},{tmsid,rmsid},KeyName +'SSN_' + Doxie.Version_SuperKey);