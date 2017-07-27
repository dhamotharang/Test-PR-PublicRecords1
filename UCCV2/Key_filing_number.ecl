import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       		:= cluster.cluster_out+'Key::ucc::';
dmainBase 	 		:= File_UCC_Main_Base;


dfilingnum		    := TABLE(dMainBase(filing_number>''), {filing_number,tmsid,rmsid});

recordof(dfilingnum) tranFilingNumber(dMainBase pInput)
 := TRANSFORM
			    self.filing_number := pInput.orig_filing_number;
				self			   := pInput;
			 END;	
			 
dFiling		        :=dfilingnum +
						PROJECT(dMainBase(orig_filing_number>''), tranFilingNumber(left));
dDist                := distribute(dedup(dFiling,all) ,hash(filing_number,tmsid,rmsid)); 
dSort                := sort(dDist,filing_number,tmsid,rmsid,local);

export Key_filing_number
                    := INDEX(dSort  ,{filing_number},{tmsid,rmsid},KeyName +'filing_Number_' + Doxie.Version_SuperKey);

