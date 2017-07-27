export lookup_bit := MODULE

	export Corp := 'CORP';
	export Accurint := 'ACCURINT';
	export Not_Ra := 'NOT_RA';
	export Rep_Addr := 'REP_ADDR';


	export bit_num(string10 b) :=
									CASE(b, 	
									Corp                => 1,
									Accurint 					  => 2,
									Not_Ra 							=> 3,
									Rep_Addr            => 4,	
									0);


	
END;
