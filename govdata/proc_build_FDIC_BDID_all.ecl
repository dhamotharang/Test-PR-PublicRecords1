import ut, _control;

export proc_build_FDIC_BDID_all(string filedate) := function

//Spray source file
sprayfile := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/fdic/in/'+filedate+'/'+filedate+'.INSTITUTIONS.d00'
									//,1226
									,1036
									, 'thor400_20',  // running on prod
									//,'thor400_88',   // running on dataland
									'~thor_data400::in::govdata::fdic_'+filedate,-1,,,true,true);

//Superfile Transactions
superfile_transac := sequential(fileservices.addsuperfile('~thor_data400::in::govdata::fdic_delete','~thor_data400::in::govdata::fdic_grandfather',,true),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic_grandfather'),
								fileservices.addsuperfile('~thor_data400::in::govdata::fdic_grandfather','~thor_data400::in::govdata::fdic_father',,true),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic_father'),
								fileservices.addsuperfile('~thor_data400::in::govdata::fdic_father','~thor_data400::in::govdata::fdic',,true),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic'),
								fileservices.addsuperfile('~thor_data400::in::govdata::fdic','~thor_data400::in::govdata::fdic_'+filedate),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic_delete',true)																	
								);
//Build BDID
make_BDID := govdata.make_FDIC_BDID(filedate);

retval := sequential(sprayfile
					  ,superfile_transac
					  ,make_BDID
					  ,govdata.Strata_Population_Stats.FDIC_pop);


return retval;
end;