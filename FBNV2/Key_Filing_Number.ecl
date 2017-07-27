import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       		:= cluster.cluster_out+'Key::FBNV2::';
dBase 	 			:= File_FBN_Business_Base;


dfilingnum		    := TABLE(dBase(filing_number>''), {filing_number,tmsid,rmsid});

recordof(dfilingnum) tranFilingNumber(dBase pInput)
 := TRANSFORM
			    self.filing_number := pInput.orig_filing_number;
				self			   := pInput;
			 END;	
			 
dFiling		        :=dfilingnum +
						PROJECT(dBase(orig_filing_number>''), tranFilingNumber(left));
dDist                := distribute(dedup(dFiling,all) ,hash(filing_number,tmsid,rmsid)); 
dSort                := sort(dDist,filing_number,tmsid,rmsid,local);

export Key_filing_number
                    := INDEX(dSort  ,{filing_number},{tmsid,rmsid},KeyName +doxie.Version_SuperKey+'::filing_Number');



