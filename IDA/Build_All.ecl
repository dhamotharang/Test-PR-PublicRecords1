﻿import std,Scrubs_IDA,IDA;

export Build_all(string pversion='',boolean pUseProd = false) := module

version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);

export built := sequential(
					                 IDA._BWR_Spray(pUseProd)
									,Scrubs_IDA.Fn_RunScrubs_RawInput(version,'vlad.petrokas@lexisnexisrisk.com')
					                ,IDA._BWR_Bases(version,pUseProd)
			                        ,IDA.Build_Strata(version,pUseProd).all
									,Scrubs_IDA.Fn_RunScrubs_Base(version,'vlad.petrokas@lexisnexisrisk.com')
					                ,IDA._BWR_Despray(version,pUseProd)
									,IDA._BWR_MoveToDone(pUseProd)
									,IDA._BWR_MoveToIncoming(pUseProd);
			                    ): success(IDA.Send_Email(version,pUseProd).BuildSuccess), failure(IDA.send_email(version,pUseProd).BuildFailure

);

end;