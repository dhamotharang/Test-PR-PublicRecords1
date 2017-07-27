import ut, _control;
export Proc_Spray_Build_SEC_Broker_Dealer(string filedate, string filename) := function

//Spray SEC Broker Dealer File
spray_files:= FileServices.SprayFixed(_control.IPAddress.edata11
									,filename
									,543
									,'thor400_20'
									,'~thor_data400::in::sec_bd_info_'+filedate,-1,,,true,true);
									
//Superfile Transactions.
superfile_transac := sequential(fileservices.clearsuperfile('~thor_data400::base::sec_bd_info'),
											fileservices.addsuperfile('~thor_data400::base::sec_bd_info','~thor_data400::in::sec_bd_info_'+filedate)
											);
//Make Base File.
mk_bdid := govdata.Make_SEC_Broker_Dealer_BDID;

//Strata
mk_strata := govdata.Strata_Population_Stats.sec_broker_dealer_pop;

bld := sequential(spray_files
						,superfile_transac
						,mk_bdid
						,mk_strata
						);
return bld;
end;