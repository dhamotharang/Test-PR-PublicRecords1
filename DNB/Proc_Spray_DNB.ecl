import ut, _control;

export Proc_Spray_DNB(string filedate) := function

//Spray DnB Companies File
spray_companies:= FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/dnb/out/dnb_companies.'+filedate+'.d00'
									,3258
									,'thor400_92'
									,'~thor_data400::in::dnb::'+filedate+'::base',-1,,,true,true,true);

//Spray DnB Contacts File
spray_contacts:= FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/dnb/out/dnb_contacts.'+filedate+'.d00'
									,284
									,'thor400_92'
									,'~thor_data400::in::dnb::'+filedate+'::names',-1,,,true,true,true);

//Superfile Transactions for DnB Base
transac_base := sequential(fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::delete::base','~thor_data400::in::dnb::sprayed::grandfather::base',,true),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::grandfather::base'),
								fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::grandfather::base','~thor_data400::in::dnb::sprayed::father::base',,true),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::father::base'),
								fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::father::base','~thor_data400::in::dnb::sprayed::base',,true),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::base'),
								fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::base','~thor_data400::in::dnb::'+filedate+'::base'),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::delete::base',true)																	
								);

//Superfile Transactions for DnB Names								
transac_names := sequential(fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::delete::names','~thor_data400::in::dnb::sprayed::grandfather::names',,true),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::grandfather::names'),
								fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::grandfather::names','~thor_data400::in::dnb::sprayed::father::names',,true),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::father::names'),
								fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::father::names','~thor_data400::in::dnb::sprayed::names',,true),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::names'),
								fileservices.addsuperfile('~thor_data400::in::dnb::sprayed::names','~thor_data400::in::dnb::'+filedate+'::names'),
								fileservices.clearsuperfile('~thor_data400::in::dnb::sprayed::delete::names',true)																	
								);
								
retval := sequential(spray_companies, spray_contacts, transac_base,transac_names);

return retval;
end;