import versioncontrol, _control, ut, std;
export Build_all(string pVersion, boolean pDelta = false, boolean pUseProd = false) := function

	pDate 	:= (string8)std.date.today():INDEPENDENT;
	version := if(pVersion = '', pDate, pVersion);		
	
	built := sequential(
					 // INQL_v2.Build_Strata(version,pUseProd).all
					INQL_v2.fSpray('accurint*.txt', 'accurint_sl', ,version)
					,INQL_v2.fSpray('custom*.txt', 'accurint_sl', ,version)
					,INQL_v2.fSpray('riskwise_accounting*.txt', 'accurint_sl', ,version)
					,INQL_v2.Build_Base(version,pDelta,pUseProd).all
					// ,INQL_v2.Build_Keys(version,pDelta,pUseProd).all
					// ,INQL_v2.Promote(version,pDelta,pUseProd).buildfiles.Built2QA
			    
					//Archive processed files in history					
					// ,FileServices.StartSuperFileTransaction()
					// ,FileServices.AddSuperFile(Filenames(version,pUseProd).lInputHistTemplate,  Filenames(version,pUseProd).lInputTemplate,,true)
					// ,FileServices.ClearSuperFile(Filenames(version,pUseProd).lInputTemplate)
					// ,FileServices.FinishSuperFileTransaction()
				);//: success(Send_Email(version,pUseProd).BuildSuccess), failure(send_email(version,pUseProd).BuildFailure

);


return built;
end;