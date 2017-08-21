import ut, _control, tools;

export Proc_Spray_FCC(string filedate) := function

//Spray FCC File
spray_fcc := FileServices.SprayFixed(_control.IPAddress.bctlpedata11
									,'/data/prod_data_build_13/eval_data/fcc/data/fcc_'+filedate+'.txt'
									,806
									,tools.fun_Groupname()
									,'~thor_data400::in::fcc::'+filedate+'::licenses',-1,,,true,true);

//Superfile Transactions for FCC File
transac_fcc := sequential(fileservices.addsuperfile('~thor_data400::in::fcc::sprayed::delete::licenses','~thor_data400::in::fcc::sprayed::grandfather::licenses',,true),
								fileservices.clearsuperfile('~thor_data400::in::fcc::sprayed::grandfather::licenses'),
								fileservices.addsuperfile('~thor_data400::in::fcc::sprayed::grandfather::licenses','~thor_data400::in::fcc::sprayed::father::licenses',,true),
								fileservices.clearsuperfile('~thor_data400::in::fcc::sprayed::father::licenses'),
								fileservices.addsuperfile('~thor_data400::in::fcc::sprayed::father::licenses','~thor_data400::in::fcc::sprayed::licenses',,true),
								fileservices.clearsuperfile('~thor_data400::in::fcc::sprayed::licenses'),
								fileservices.addsuperfile('~thor_data400::in::fcc::sprayed::licenses','~thor_data400::in::fcc::'+filedate+'::licenses'),
								fileservices.clearsuperfile('~thor_data400::in::fcc::sprayed::delete::licenses',true)																	
								);
								
retval := sequential(spray_fcc, transac_fcc);

return retval;
end;