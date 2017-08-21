EXPORT verify_keys(
										string pk
										,boolean isFCRA = false
										,boolean isBoolean = false
										) := function

pkg     := if(isFCRA,'fcra_'+pk, pk);
envment := map(isFCRA=>'F',isBoolean=>'B','N');
bool    := if(isBoolean,'Y','N');
gen     := 'qa';

d:=header.GetPackageKeys(pkg,,envment,bool)(lkeyname<>'');

step1 := table(d,{
							sfn:=trim(regexreplace('generation',superkeys,gen))
							,lfn:=if(fileservices.fileexists('~'+regexreplace('generation',superkeys,gen)),FileServices.GetSuperFileSubName('~'+regexreplace('generation',superkeys,gen),1),'')
							});

step2 := project(step1,transform(
															{step1.sfn,step1.lfn,unsigned8 fileSize :=0, unsigned8 recordCount :=0},
															SELF.fileSize  := if(length(LEFT.lfn)=0,0,(unsigned8)fileservices.GetLogicalFileAttribute('~'+LEFT.lfn,'size')),
															SELF.recordCount := if(length(LEFT.lfn)=0,0,(unsigned8)fileservices.GetLogicalFileAttribute('~'+LEFT.lfn,'recordCount')),
															SELF := LEFT
														)
								);


return step2;

end;

