export Constants := module

	export Defaults := module
		export integer MaxResults := 2000;
		export integer MaxResultsPerAcctno := 20;
		export integer DLPENALTY := 2;
		export integer PLATEPENALTY := 2;
		export string HRIHOTELS :='2210';
		export string HRIELEMENTARY :='2345';
    export string HRICOLLEGE :='2270';
    export string HRIJUNIOR :='2350';
    export string HRICORRECTIONAL :='2225';
		export HRISET := [HRIHOTELS,HRIELEMENTARY,HRICOLLEGE,HRIJUNIOR,HRICORRECTIONAL];
	end;
	
	export Limits := module
	  export integer MAX_DL_JOIN_LIMIT := 1000;
	  export integer MAX_VEH_JOIN_KEEP := 1000;
		export integer MAX_JOIN_LIMIT := 10000;
		export integer DID_LIMIT := 30;  //input criteria results in a max of 30 subject matches prior to penalties or additional filters
	end;
	export SubjectMatch := module
	  export string1 ssnMatch := 'S';
	  export string1 firstMatch := 'F';
	  export string1 midMatch := 'I';
	  export string1 lastMatch := 'L';
	  export string1 dobMMMatch := 'M'; 
	  export string1 dobDDMatch := 'D';
	  export string1 dobYYYYMatch := 'Y';
		export string1 genderDifferent := 'D';
	end;
	export NameWords := module
	  export string1 BADSUFFIX := 'U';
		export string7 NONAME := 'NO NAME';
	end;
end;