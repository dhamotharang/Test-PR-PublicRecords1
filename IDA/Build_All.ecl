import std;

export Build_all(string pversion='', boolean pUseProd = false) := module

version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;


export built := sequential(
					                 IDA._BWR_Spray(version,pUseProd)
					                ,IDA._BWR_Bases(version,pUseProd)
					                ,IDA._BWR_Despray(version,pUseProd)
			                    ,IDA.Build_Strata(version,pUseProd).all
													// ,SCRUBS //To be added
			                    ): success(IDA.Send_Email(version,pUseProd).BuildSuccess), failure(IDA.send_email(version,pUseProd).BuildFailure

);

end;