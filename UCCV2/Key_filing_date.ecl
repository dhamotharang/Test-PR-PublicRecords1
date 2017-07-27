import  UCCV2,RoxieKeyBuild,ut,autokey,doxie ;

KeyName       		:= cluster.cluster_out+'Key::ucc::';
dmainBase 	 		:= File_UCC_Main_Base;


dfiling_date 		:= TABLE(dMainBase(filing_date>''), {Filing_date ,tmsid,rmsid});

recordof(dfiling_date) tranFilingdate(dMainBase pInput)
 := TRANSFORM
			 self.filing_date      := pInput.orig_filing_date;
				self 			   := pInput;
			 END; 
			 
ducc_date 		     :=dfiling_date +
						PROJECT(dMainBase(orig_filing_date>''), tranFilingdate(left)); 
				
dDist                := distribute(dedup(ducc_date,all) ,hash(Filing_date,tmsid,rmsid)); 
dSort                := sort(dDist,Filing_date,tmsid,rmsid,local);
export Key_filing_date := INDEX(dSort  ,{filing_date},{tmsid,rmsid},KeyName +'filing_date_' + Doxie.Version_SuperKey);

