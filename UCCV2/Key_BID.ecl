import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := UCCV2.File_UCC_Party_Base_AID;

// project the base file mapping the BID value into the BDID field. This is being done to keep key layout
// the same as it is in the KEY_BDID key so that query changes are minimized.
dParty				:= PROJECT(dpartyBase,TRANSFORM(Layout_UCC_Common.Layout_Party,SELF.BDID	:=	LEFT.BID; SELF.BDID_SCORE := LEFT.BID_SCORE; SELF := LEFT;));

dSlim		  := TABLE(dParty(Bdid>0), {Bdid,tmsid,rmsid});
dDist			:= distribute(dSlim,hash(Bdid,tmsid,rmsid)); 
dSort			:= sort(dDist, Bdid,tmsid,rmsid,local);
dDedup		:= dedup(DSort ,Bdid,tmsid,rmsid,local);

export Key_BID := INDEX(dDedup  ,{Bdid},{tmsid,rmsid},KeyName +'Bid_' + Doxie.Version_SuperKey);