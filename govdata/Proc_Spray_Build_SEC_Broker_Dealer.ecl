import Orbit3;
export Proc_Spray_Build_SEC_Broker_Dealer(string filedate) := function


//Spray and build prep File.
spray_build_prep := Proc_Prep_SEC_Broker_Dealer(filedate).buildall;

mk_bdid := govdata.Make_SEC_Broker_Dealer_BDID;

//orbit instance and item addition (jira DOPS-462)
orbit_update := sequential(Orbit3.proc_Orbit3_CreateBuild_npf('SEC Broker Dealer',(filedate),'BUILD_AVAILABLE_FOR_USE',true),Orbit3.proc_Orbit3_CreateBuild_AddItem('SEC Broker Dealer',(filedate),'N'));

bld := sequential(
						spray_build_prep
						,mk_bdid
						,orbit_update
					
						);
return bld;
end;