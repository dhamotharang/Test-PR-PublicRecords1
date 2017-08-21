import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       		:= cluster.cluster_out+'Key::FBNV2::';
dBase 	 			:= File_FBN_Business_Base;


dfilingnum		    := TABLE(dBase(filing_number>''), {filing_number,tmsid,rmsid});

/*We are suppressing the filing_numbers from FBN_Business base that starts with ‘EXP' and all zeoros as filing numbers and one digit number as filing numbers and same numbers as filing number.
Because these filing numbers are not true filing numbers ,It’s an internal number that Experian/Cp_Historical has given to the record
when the filing number was blank. This would be misleading to our customers .
Below trasform "suppress_FilingNbr" will blank out the filing numbers when first 3 charecters  "EXP" in the filing number  form FBN_Business_Base file  "ex:(EXP564362,EXP8932761")
and it will blank out the filing numbers when only one digit number as filing number  form FBN_Business_Base file "ex:(1,2,4,0,5,9 ..etc")
and it wil blank out the filing numbers when samenumber as Filing number form FBN_Business_Base file "ex: (1111'22222,33333,44444,55555,6666,777,888,9999")
and it will blank out the filing numbers when all zeros as filing number form FBN_Business_Base file  "ex: (00000000000,000000,00000,000000,0000 etc")
else it will populate the filing number.
Bellow suppression only applies to sources for choice point historical data as well as Direct Experian data not any other sources.*/

recordof(dfilingnum) suppress_FilingNbr(dfilingnum pInput):= TRANSFORM
			    self.filing_number := if( pInput.tmsid[1..2]='CP' or pInput.tmsid[1..3]='EXP',if(pInput.filing_number[1..3]<>'EXP' and pInput.filing_number[2..]<>''and regexreplace('[1]{2,}',pInput.filing_number,'') <>'' 
				                        and  regexreplace('[2]{2,}',pInput.filing_number,'') <> ''and regexreplace('[3]{2,}',pInput.filing_number,'') <>'' 
										and  regexreplace('[4]{2,}',pInput.filing_number,'') <> ''and regexreplace('[5]{2,}',pInput.filing_number,'') <>''
										and  regexreplace('[6]{2,}',pInput.filing_number,'') <> ''and regexreplace('[7]{2,}',pInput.filing_number,'') <>''
										and  regexreplace('[8]{2,}',pInput.filing_number,'') <> ''and regexreplace('[9]{2,}',pInput.filing_number,'') <>''
										and  regexreplace('[0]{2,}',pInput.filing_number,'') <> '',pInput.filing_number,''),pInput.filing_number);
				self			   := pInput;
			 END;


sfilingnum:=PROJECT(dfilingnum, suppress_FilingNbr(left));

recordof(dfilingnum) tranFilingNumber(dBase pInput):= TRANSFORM
			    self.filing_number := pInput.orig_filing_number;
				self			   := pInput;
			 END;

dFiling		        :=sfilingnum +
						PROJECT(dBase(orig_filing_number>''), tranFilingNumber(left));
dDist                := distribute(dedup(dFiling,all) ,hash(filing_number,tmsid,rmsid)); 
dSort                := sort(dDist,filing_number,tmsid,rmsid,local);

export Key_filing_number
                    := INDEX(dSort  ,{filing_number},{tmsid,rmsid},KeyName +doxie.Version_SuperKey+'::filing_Number');



