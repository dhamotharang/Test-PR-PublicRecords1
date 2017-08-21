import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
dpartyBase 	  := UCCV2.File_UCC_Party_Base_AID;

// project the base file mapping the BID value into the BDID field. This is being done to keep key layout
// the same as it is in the KEY_BDID key so that query changes are minimized.
dParty				:= PROJECT(dpartyBase,TRANSFORM(Layout_UCC_Common.Layout_Party,SELF.BDID	:=	LEFT.BID; SELF.BDID_SCORE := LEFT.BID_SCORE; SELF := LEFT;));

dSlim		  := TABLE(dPartyBase(Bdid>0), {Bdid,tmsid,rmsid,party_type});
dDist			:= distribute(dSlim,hash(Bdid,tmsid,rmsid)); 
dSort			:= sort(dDist, Bdid,tmsid,rmsid,party_type, local);
dDedup		:= dedup(DSort ,Bdid,tmsid,rmsid,party_type,local);

export Key_BID_w_Type := INDEX(dDedup  ,{Bdid,party_type},{tmsid,rmsid},KeyName +'Bid_w_Type_' + Doxie.Version_SuperKey);