import ut, _control;

export proc_build_all(string filedate) := function

// Spray fixed length file

sprayfile := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_13/eval_data/dca/out/all.clean.'+filedate+'.d00'
									,6523
									, 'thor400_92',
									'~thor_data400::in::ddca_all_'+filedate,-1,,,true,true);
									
// Superfile transaction - Move sprayed file to the dca_all base file and 
//						   retain the last 2 generations			
									
superfile_transac := sequential(
								fileservices.addsuperfile('~thor_data400::base::DDCA_All_delete','~thor_data400::base::DDCA_All_grandfather',,true),
								fileservices.clearsuperfile('~thor_data400::base::DDCA_All_grandfather'),
								fileservices.addsuperfile('~thor_data400::base::DDCA_All_grandfather','~thor_data400::base::DDCA_All_father',,true),
								fileservices.clearsuperfile('~thor_data400::base::DDCA_All_father'),
								fileservices.addsuperfile('~thor_data400::base::DDCA_All_father','~thor_data400::base::DDCA_All',,true),
								fileservices.clearsuperfile('~thor_data400::base::DDCA_All'),
								fileservices.addsuperfile('~thor_data400::base::DDCA_All','~thor_data400::in::ddca_all_'+filedate),
								fileservices.clearsuperfile('~thor_data400::base::DDCA_All_delete',true)																	
								);

// Build base file - BDID process

build_base := dca.proc_build_base;

// Build Roxie Keys

build_keys := dca.proc_build_dca_keys(filedate);

// Run STRATA stats

as_bh_stats	 := Out_Population_Stats(filedate).bh_out;

retval := sequential(
		 sprayfile
		,superfile_transac
		,build_base
		,build_keys
		,as_bh_stats
		,Strata_Population_Stats(filedate)
		,SampleRecs
) : success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);


return retval;
end;