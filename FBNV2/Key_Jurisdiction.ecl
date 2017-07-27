import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       		:= cluster.cluster_out+'Key::FBNV2::';
dBase 	 			:= File_FBN_Business_Base;

dFBNJurisdiction 	:= TABLE(dBase(filing_jurisdiction>''), {Filing_Jurisdiction ,tmsid,rmsid});
dDist               := distribute(dedup(dFBNJurisdiction,all) ,hash(Filing_Jurisdiction,tmsid,rmsid)); 
dSort               := sort(dDist,Filing_Jurisdiction,tmsid,rmsid,local);

export Key_jurisdiction := INDEX(dSort ,{filing_jurisdiction},{tmsid,rmsid},KeyName +doxie.Version_SuperKey+'::jurisdiction');