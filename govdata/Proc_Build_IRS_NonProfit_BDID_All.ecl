import ut, _control, Orbit3;

export Proc_Build_IRS_NonProfit_BDID_All(string filedate) := function

//Spray File
sprayfile := FileServices.SprayVariable('uspr-edata11.risk.regn.net'
							,'/data/prod_data_build_10/production_data/business_headers/irs/non-profit/in/'+filedate+'/eo*.csv'
							,
							,','
							,'\\n,\\r\\n'     
							,'\''
							,'thor400_44' 
							,'~thor_data400::in::irs::'+filedate+'::non_profit_in'
							,-1
							,
							,
							,true
							,true
							);							
									
//Superfile Transactions
superfile_transac := sequential(fileservices.addsuperfile('~thor_data400::in::irs::sprayed::delete::non_profit','~thor_data400::in::irs::sprayed::grandfather::non_profit',,true),
								fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::grandfather::non_profit'),
								fileservices.addsuperfile('~thor_data400::in::irs::sprayed::grandfather::non_profit','~thor_data400::in::irs::sprayed::father::non_profit',,true),
								fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::father::non_profit'),
								fileservices.addsuperfile('~thor_data400::in::irs::sprayed::father::non_profit','~thor_data400::in::irs::sprayed::non_profit',,true),
								fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::non_profit'),
								fileservices.addsuperfile('~thor_data400::in::irs::sprayed::non_profit','~thor_data400::in::irs::'+filedate+'::non_profit_in'),
								fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::delete::non_profit',true)																	
								);

// Make BDID 
make_bdid := govdata.Make_IRS_NonProfit_BDID(filedate);

//STRATA
strata_counts := govdata.Strata_Population_Stats.IRS_Non_profit_pop;

orbit_update := sequential(Orbit3.proc_Orbit3_CreateBuild_npf('IRS Non-profit Charitable Organizations',(filedate),'BUILD_AVAILABLE_FOR_USE',true),Orbit3.proc_Orbit3_CreateBuild_AddItem('IRS Non-profit Charitable Organizations',(filedate),'N'));

retval := sequential(sprayfile
					  ,superfile_transac
						,make_bdid
					  ,strata_counts
						,orbit_update);
return retval;
end;