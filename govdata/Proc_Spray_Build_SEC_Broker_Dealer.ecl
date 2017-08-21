
export Proc_Spray_Build_SEC_Broker_Dealer(string filedate) := function


//Spray and build prep File.
spray_build_prep := Proc_Prep_SEC_Broker_Dealer(filedate).buildall;

mk_bdid := govdata.Make_SEC_Broker_Dealer_BDID;



bld := sequential(
						spray_build_prep
						,mk_bdid
					
						);
return bld;
end;