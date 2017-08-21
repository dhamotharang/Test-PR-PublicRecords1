import ut, _control;

export proc_Spray_DNB_FEIN(string filedate) := function

// Spray source file
sprayfile := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/fein/build/'+filedate+'/raw.clean.'+filedate+'.d00'
									,637
									, 'thor400_92',
									'~thor_data400::in::dnb_fein_'+filedate,-1,,,true,true);

// Superfile Transactions
superfile_transac := sequential(fileservices.addsuperfile('~thor_data400::base::dnb_fein_delete','~thor_data400::base::dnb_fein_grandfather',,true),
								fileservices.clearsuperfile('~thor_data400::base::dnb_fein_grandfather'),
								fileservices.addsuperfile('~thor_data400::base::dnb_fein_grandfather','~thor_data400::base::dnb_fein_father',,true),
								fileservices.clearsuperfile('~thor_data400::base::dnb_fein_father'),
								fileservices.addsuperfile('~thor_data400::base::dnb_fein_father','~thor_data400::base::dnb_fein',,true),
								fileservices.clearsuperfile('~thor_data400::base::dnb_fein'),
								fileservices.addsuperfile('~thor_data400::base::dnb_fein','~thor_data400::in::dnb_fein_'+filedate),
								fileservices.clearsuperfile('~thor_data400::base::dnb_fein_delete',true)																	
								);

retval := sequential(sprayfile,superfile_transac);

return retval;
end;