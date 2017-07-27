import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       		:= cluster.cluster_out+'Key::ucc::';
dmainBase 	 		:= File_UCC_Main_Base;

dUCCJurisdiction 	:= TABLE(dMainBase(filing_jurisdiction>''), {Filing_Jurisdiction ,tmsid,rmsid});
dDist               := distribute(dedup(dUCCJurisdiction,all) ,hash(Filing_Jurisdiction,tmsid,rmsid)); 
dSort               := sort(dDist,Filing_Jurisdiction,tmsid,rmsid,local);

export Key_jurisdiction := INDEX(dSort ,{filing_jurisdiction},{tmsid,rmsid},KeyName +'jurisdiction_' + Doxie.Version_SuperKey);