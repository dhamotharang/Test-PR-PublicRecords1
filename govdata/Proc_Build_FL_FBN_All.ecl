import ut, _control;

export Proc_Build_FL_FBN_All(string filedate) := function

//Spray Fl FBN File
spray_fbn := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/fl_fbn/out/fl_fbn.'+filedate+'.d00'
									,5382
									,'thor400_92'
									,'~thor_data400::in::fl::'+filedate+'::fbn_in',-1,,,true,true);

//Spray Fl FBN Events File
spray_fbn_events := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/fl_fbn/out/fl_fbn_events.'+filedate+'.d00'
									,1438
									,'thor400_92'
									,'~thor_data400::in::fl::'+filedate+'::fbn_events_in',-1,,,true,true);

//Superfile Transactions for FBN File
transac_fbn := sequential(fileservices.addsuperfile('~thor_data400::in::fl::sprayed::delete::fbn','~thor_data400::in::fl::sprayed::grandfather::fbn',,true),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::grandfather::fbn'),
								fileservices.addsuperfile('~thor_data400::in::fl::sprayed::grandfather::fbn','~thor_data400::in::fl::sprayed::father::fbn',,true),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::father::fbn'),
								fileservices.addsuperfile('~thor_data400::in::fl::sprayed::father::fbn','~thor_data400::in::fl::sprayed::fbn',,true),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::fbn'),
								fileservices.addsuperfile('~thor_data400::in::fl::sprayed::fbn','~thor_data400::in::fl::'+filedate+'::fbn_in'),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::delete::fbn',true)																	
								);
								
//Superfile Transactions for FBN Events File
transac_fbn_events := sequential(fileservices.addsuperfile('~thor_data400::in::fl::sprayed::delete::fbn_events','~thor_data400::in::fl::sprayed::grandfather::fbn_events',,true),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::grandfather::fbn_events'),
								fileservices.addsuperfile('~thor_data400::in::fl::sprayed::grandfather::fbn_events','~thor_data400::in::fl::sprayed::father::fbn_events',,true),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::father::fbn_events'),
								fileservices.addsuperfile('~thor_data400::in::fl::sprayed::father::fbn_events','~thor_data400::in::fl::sprayed::fbn_events',,true),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::fbn_events'),
								fileservices.addsuperfile('~thor_data400::in::fl::sprayed::fbn_events','~thor_data400::in::fl::'+filedate+'::fbn_events_in'),
								fileservices.clearsuperfile('~thor_data400::in::fl::sprayed::delete::fbn_events',true)																	
								);
//Make Base File
mk_base := govdata.Make_fl_FBN_Base;

retval := sequential(spray_fbn, spray_fbn_events, transac_fbn, transac_fbn_events, mk_base);

return retval;
end;