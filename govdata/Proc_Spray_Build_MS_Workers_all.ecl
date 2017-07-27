import ut, _control;

export Proc_Spray_Build_MS_Workers_all(string filedate) := function

// Spray Source File From Unix directory.
sprayfile := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/workmans_comp/ms/ms_workcomp_master.'+filedate+'.d00'
									,1025
									, 'thor400_92',
									'~thor_data400::in::ms::'+filedate+'::workcomp',-1,,,true,true);
				
//Superfile Transactions - Updating superfile with newly sprayed file
superfile_transac := sequential(fileservices.clearsuperfile('~thor_data400::base::ms_workers'),
								fileservices.addsuperfile('~thor_data400::base::ms_workers','~thor_data400::in::ms::'+filedate+'::workcomp'));		

// Build MS Workers Compensation BDID's
doBuild := govdata.Make_MS_Workers_Comp_BDID;

retval := sequential(sprayfile, superfile_transac,doBuild);

return retval;
end;	