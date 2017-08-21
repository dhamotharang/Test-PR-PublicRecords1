#workunit('name', 'BDID Vickers files ');
do1 := vickers.Make_13d13g_BDID : success(output('13d13g finished BDID'));
do2 := vickers.make_insider_filing_bdid : success(output('Insider Filing finished BDID'));
do3 := vickers.proc_build_13d13g_key : success(output('13d13g key finished'));
do4 := vickers.Proc_Build_Insider_filing_Key : success(output('Insider Filing Key finished'));

export make_all := sequential(do1,do2,do3,do4);