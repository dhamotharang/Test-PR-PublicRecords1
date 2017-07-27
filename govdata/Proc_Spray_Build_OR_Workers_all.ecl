import ut, _control;

export Proc_Spray_Build_OR_Workers_all (string filedate) := function

// Spray Source File From Unix directory.
sprayfile := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/workmans_comp/or/or_workcomp_master.'+filedate+'.d00'
									,1238
									, 'thor400_92',
									'~thor_data400::in::or::'+filedate+'::workcomp',-1,,,true,true);
				
//Superfile Transactions - Updating superfile with newly sprayed file
superfile_transac := sequential(fileservices.addsuperfile('~thor_data400::in::or::sprayed::delete::workcomp','~thor_data400::in::or::sprayed::grandfather::workcomp',,true),
								fileservices.clearsuperfile('~thor_data400::in::or::sprayed::grandfather::workcomp'),
								fileservices.addsuperfile('~thor_data400::in::or::sprayed::grandfather::workcomp','~thor_data400::in::or::sprayed::father::workcomp',,true),
								fileservices.clearsuperfile('~thor_data400::in::or::sprayed::father::workcomp'),
								fileservices.addsuperfile('~thor_data400::in::or::sprayed::father::workcomp','~thor_data400::in::or::sprayed::workcomp',,true),
								fileservices.clearsuperfile('~thor_data400::in::or::sprayed::workcomp'),
								fileservices.addsuperfile('~thor_data400::in::or::sprayed::workcomp','~thor_data400::in::or::'+filedate+'::workcomp'),
								fileservices.clearsuperfile('~thor_data400::in::or::sprayed::delete::workcomp',true)																	
								);	

// Build OR Workers Compensation BDID's
doBuild := govdata.Make_OR_Workers_Comp_BDID;

// Strata
doStrata := govdata.Strata_Population_Stats.or_workers_pop;

retval := sequential(sprayfile
							,superfile_transac
							,doBuild
							,doStrata);

return retval;
end;	