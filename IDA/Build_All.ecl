import std;

export Build_all(string pversion='',boolean pUseProd = false) := module

version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);

export built := sequential(
					                 IDA._BWR_Spray(pUseProd)
					                ,IDA._BWR_Bases(version,pUseProd)
					                ,IDA._BWR_Despray(version,pUseProd)
									,IDA._BWR_MoveToDone(pUseProd)
			                        // ,IDA.Build_Strata(pversion,pUseProd).all
								    // ,SCRUBS //To be added
			                    ): success(IDA.Send_Email(version,pUseProd).BuildSuccess), failure(IDA.send_email(version,pUseProd).BuildFailure

);

end;