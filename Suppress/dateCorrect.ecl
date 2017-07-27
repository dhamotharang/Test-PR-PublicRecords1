import misc2, codes;

export dateCorrect := module
	
	// check for date corrections
	export do(string9 in_val) := module
		shared in_hval	:= hashmd5(in_val);
		shared raw			:= CHOOSEN (misc2.key_dateCorrect_hval (hval=in_hval), 1);

		export boolean		needed	:= exists(raw);
		
		// dates are needed in a variety of formats
		export unsigned4	sdate_u4	:= raw[1].startDate;	// YYYYMMDD
		export unsigned4	edate_u4	:= raw[1].endDate;		// YYYYMMDD
		export string8		sdate_s8	:= (string8)sdate_u4;	// YYYYMMDD
		export string8		edate_s8	:= (string8)edate_u4;	// YYYYMMDD
		export unsigned3	sdate_u3	:= sdate_u4/100;			// YYYYMM
		export unsigned3	edate_u3	:= edate_u4/100;			// YYYYMM
		export string6		sdate_s6	:= (string6)sdate_u3;	// YYYYMM
		export string6		edate_s6	:= (string6)edate_u3;	// YYYYMM
		
		// and even states vary, e.g. FL/Florida
		export string2		st			:= raw[1].state;
		export string50		state		:= StringLib.StringToProperCase(StringLib.StringToLowerCase(codes.St2Name(st)));
	end;

  export GetSSNDates (string ssn, unsigned4 start_date, unsigned4 end_date, string2 state) := FUNCTION
    in_hval	:= hashmd5(ssn);
    raw	    := TOPN (misc2.key_dateCorrect_hval(hval=in_hval),1,-endDate,record);
		
    boolean needed := EXISTS (raw);

    state_corrected := StringLib.StringToProperCase(StringLib.StringToLowerCase(codes.St2Name(raw[1].state)));

    m := MODULE
      export unsigned4 start_date := IF (needed, raw[1].startDate, start_date);
      export unsigned4 end_date   := IF (needed, raw[1].endDate, end_date);
      export string state := IF (needed, state_corrected, state);
    END;
    RETURN m;
  END;


	// macros for applying corrections within transforms
	export sdate_u4(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).sdate_u4, passthrough)
	endmacro;
	export edate_u4(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).edate_u4, passthrough)
	endmacro;
	export sdate_u3(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).sdate_u3, passthrough)
	endmacro;
	export edate_u3(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).edate_u3, passthrough)
	endmacro;
	export sdate_s8(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).sdate_s8, passthrough)
	endmacro;
	export edate_s8(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).edate_s8, passthrough)
	endmacro;
	export sdate_s6(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).sdate_s6, passthrough)
	endmacro;
	export edate_s6(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).edate_s6, passthrough)
	endmacro;
	export st(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).st, passthrough)
	endmacro;
	export state(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, Suppress.dateCorrect.do(in_val).state, passthrough)
	endmacro;
	export valid(in_val, passthrough) := macro
		if(Suppress.dateCorrect.do(in_val).needed, true, passthrough)
	endmacro;

end;