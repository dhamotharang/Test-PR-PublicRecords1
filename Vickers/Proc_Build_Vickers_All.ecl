import ut, _control;

export Proc_Build_Vickers_All(string filedate) := function


// Make Vickers BDID 
do1 := vickers.Make_13d13g_BDID : success(output('13d13g finished BDID'));
do2 := vickers.make_insider_filing_bdid : success(output('Insider Filing finished BDID'));
do3 := vickers.proc_build_13d13g_key(filedate) : success(output('13d13g key finished'));
do4 := vickers.Proc_Build_Insider_filing_Key(filedate) : success(output('Insider Filing Key finished'));

make_bdid := sequential(parallel(do1,do2), parallel(do3,do4), Vickers.Strata_Grid_Stats);

retval 		:= sequential(proc_prep_all(filedate).build_all
												 ,make_bdid) : success(Send_Email(filedate,'build').BuildSuccess) , failure(Send_Email(filedate,'build').BuildFailure);
return retval;

end;