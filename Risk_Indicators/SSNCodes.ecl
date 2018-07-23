import _Control, RiskWise, Risk_Indicators, header, doxie, ut, address, std;
onThor := _Control.Environment.OnThor;

/***************************************************/
/******************** CONSTANTS ********************/
/***************************************************/

// These SSN areas were found during reverse-engineering to never be issued
areas_not_issued := ['666','755'];

// These four groups (38-44) within the 574 (Alaska) group are not used
area_groups_not_used := ['57438','57440','57442','57444'];

// SSNs with areas falling between these two values (inclusive) are considered discontinued
discontinued_min := 700;
discontinued_max := 728;

// An SSN is unassigned if its area falls between the unassigned min and max (inclusive) or
// above the unassigned cap.
unassigned_min := 734;
unassigned_max := 749;
unassigned_cap := 772;

// Note: the term 'unassigned' refers to an area that the SSA has not assigned; knowing the
// most recent area is 772, we can determine a SSN of 773-xx-xxxx is unassigned. For more info:
//      http://www.ssa.gov/employer/ssnvhighgroup.htm
// The following code can be used to determine the highest group:
//      smax := doxie.Key_SSN_Map( keyed(ssn5[1..2] in ['77','78','79']) or keyed(ssn5[1]='8') );
//      smax2 := choosen( sort( smax, -ssn5 ), 1 );
//      maxssn := (integer)smax2[1].ssn5[1..3];

/***************************************************/

export SSNCodes( dataset(riskwise.layouts.layout_ssn_in) indata, boolean isFCRA=false ) := FUNCTION
	layout_temp := record
		RiskWise.layouts.layout_ssn_out;
		boolean decs;
		integer4 start_serial;
		integer4 end_serial;
		string5  prev_group;
		string8  prev_end;
		boolean  mapDataAvailable;
		string50 mapState;
		unsigned3 historydate;
	END;

	STRING2 PrevGroup( INTEGER x ) := MAP(
		(x BETWEEN 3 AND 9) or (x BETWEEN 12 AND 99) => INTFORMAT( x-2, 2, 1 ),
		x = 10 => '09',
		x = 2  => '98',
		x = 11 => '08',
		'' // 1 has no previous group, and other numbers are invalid
	);

	withDecs := project( indata, 
	transform( layout_temp,
			self.decs := left.deceased,
			self.seq := left.seq,
			self.inssn := left.ssn,
			self.indob := (string8)left.dob,
			self.prev_group := self.inssn[1..3]+prevgroup((integer)self.inssn[4..5]),
			self := left,
			self := []
		)
	);
	SSNMapKey := if(IsFCRA, doxie.Key_SSN_FCRA_Map, doxie.Key_SSN_Map);
	
	layout_Temp getCurrentInfo(withDecs le, SSNMapKey ri) := transform
		self.start_serial  		:= (integer)ri.start_serial;
		self.end_serial    		:= (integer)ri.end_serial;
		self.mapState      		:= ri.state;
		self.lowissue      		:= ri.start_date;
		self.highissue     		:= ri.end_date;
		self.mapDataAvailable := ( ri.ssn5 != '' );
		self := le;
	end;
	
	withCurrentInfo_roxie := join(withDecs, SSNMapKey, 
																			keyed(left.inssn[1..5]=right.ssn5) and
																			// pretend we don't know about this ssn if start date is greater than history date
																			(unsigned3)(RIGHT.start_date[1..6]) < left.historydate, 
																			getCurrentInfo(LEFT,RIGHT),
																			left outer, atmost(riskwise.max_atmost));
																			
	withCurrentInfo_thor := join(distribute(withDecs, hash64(inssn[1..5])), 
																			distribute(pull(SSNMapKey), hash64(ssn5)), 
																			(left.inssn[1..5]=right.ssn5) and
																			// pretend we don't know about this ssn if start date is greater than history date
																			(unsigned3)(RIGHT.start_date[1..6]) < left.historydate, 
																			getCurrentInfo(LEFT,RIGHT),
																			left outer, atmost(left.inssn[1..5]=right.ssn5, riskwise.max_atmost), LOCAL);

	#IF(onThor)
    withCurrentInfo := withCurrentInfo_thor;
  #ELSE
    withCurrentInfo := withCurrentInfo_roxie;
  #END

	layout_temp AreaGroupRoll( layout_temp le, layout_temp ri ) := TRANSFORM
		self := if( (integer)le.inssn[6..9] between le.start_serial and le.end_serial, le, ri );
	END;
	
	withCurrentRolled := rollup( sort(withCurrentInfo,seq),
		AreaGroupRoll(LEFT,RIGHT),
		seq
	);

	layout_temp getPrevInfo(withCurrentRolled le, SSNMapKey ri) := transform
		self.prev_end := ri.end_date;
		self := le;
	end;
	
	withPrevInfo_roxie := join( withCurrentRolled, SSNMapKey, keyed(left.prev_group=right.ssn5) and 
																		// pretend we don't know about this ssn if start date is greater than history date
																		(unsigned3)(RIGHT.start_date[1..6]) < left.historydate,
																		getPrevInfo(LEFT,RIGHT),
																		left outer, atmost(riskwise.max_atmost));
																		
	withPrevInfo_thor := join(distribute(withCurrentRolled, hash64(prev_group)), 
																		distribute(pull(SSNMapKey), hash64(ssn5)), 
																		(left.prev_group=right.ssn5) and 
																		// pretend we don't know about this ssn if start date is greater than history date
																		(unsigned3)(RIGHT.start_date[1..6]) < left.historydate,
																		getPrevInfo(LEFT,RIGHT),
																		left outer, atmost(left.prev_group=right.ssn5, riskwise.max_atmost), LOCAL);																	

	#IF(onThor)
		withPrevInfo := withPrevInfo_thor;
	#ELSE
		withPrevInfo := withPrevInfo_roxie;
	#END

	layout_temp PrevGroupRoll( layout_temp le, layout_temp ri ) := TRANSFORM
		self := if( (integer)le.prev_end > (integer)ri.prev_end, le, ri ); // take the later of the two end dates
	END;
	
	withPrevRolled := rollup( sort(withPrevInfo,seq),
		PrevGroupRoll(LEFT,RIGHT),
		seq
	);


	riskwise.layouts.layout_ssn_out doCodes( layout_temp le ) := TRANSFORM

		cleanDOB := RiskWise.cleanDOB( le.indob );
		cleanSSN := RiskWise.cleanSSN( le.inSSN );
		
		ssn_area := cleanSSN[1..3];
		ssn_grp  := cleanSSN[4..5];
		ssn_ser  := cleanSSN[6..9];
		
		// helper functions
		// Does ssn group x come before group y?
		// This is a somewhat ugly piece of logic that returns -1 when x occurs
		// before y in SSA Group ordering,	0 when x=y, and 1 when x occurs after y
		GroupBefore( integer x, integer y ) := MAP
		(
			// SSN groups are assigned in the following order:
			// odds  from  1- 9
			// evens from 10-98
			// evens from  2- 8
			// odds  from 11-99
			x = y => 0,
			MAP(
				x%2=0 AND y%2=1 => y > 10, // when X is even and Y is odd,  X will occur before Y when Y>=11
				x%2=1 AND y%2=0 => x < 10, // when X is odd  and Y is even, X will occur before Y when x<10
				x%2=1           => x <  y, // when X and Y are odd, it's a simple numeric comparison
				MAP(                       // when X and Y are even, the order is 10-98,2-8
					x BETWEEN 2 AND 8 => y BETWEEN 2 AND 8 AND y > x, // when X is 2-8, Y must, and Y must be > X
					y BETWEEN 2 AND 8 OR x < y // when X is 10-98, it occurs before Y when Y is 2-8 or when Y > X
				)
			) => -1, // X comes before Y
			1
		);
		
		// Given a group number, what group did the SSA previously use?
		STRING2 PrevGroup( INTEGER x ) := MAP(
			(x BETWEEN 3 AND 9) or (x BETWEEN 12 AND 99) => INTFORMAT( x-2, 2, 1 ),
			x = 10 => '09',
			x = 2  => '98',
			x = 11 => '08',
			'' // 1 has no previous group, and other numbers are invalid
		);

		// dob properties
		dobZero := (integer)le.indob = 0; // Veris returns a dob code of zero when passed a zero dob (eg, 00000000, 0000000, etc.)

		dobInvalidChars := LENGTH(StringLib.StringFilter( le.indob, '0123456789' )) != 8
			OR le.indob[7..8] = '00'
			OR (integer)le.indob < 18000101; // Veris indicated a date prior to Jan 1, 1800 as having invalid chars

		notCalendarDate := (le.indob[5..8] = '0000');
		
		isInvalidDate := NOT( (INTEGER)cleanDOB[1..4] BETWEEN 1800 AND 2100 )
			OR NOT( (INTEGER)cleanDOB[5..6] BETWEEN 1 AND 12 )
			OR ( (INTEGER)cleanDOB[7..8] > ut.Month_Days( (UNSIGNED)cleanDOB[1..6] ) );

		isIssuedPriorToDOB := le.highissue != '' AND (
			ut.DaysSince1900( cleanDOB[1..4], cleanDOB[5..6], cleanDOB[7..8] )
			>
			ut.DaysSince1900( le.highissue[1..4], le.highissue[5..6], le.highissue[7..8] )
		);
		isIssuedAfterAge18 := le.lowissue != '' AND ( 
			ut.DaysSince1900( le.lowissue[1..4], le.lowissue[5..6], le.lowissue[7..8] ) /* earliest possible date the SSN was issued */
			>
			ut.DaysSince1900( (STRING)((INTEGER)(cleanDOB[1..4])+18), cleanDOB[5..6], cleanDOB[7..8] )    /* date the person turned 18 */
		);

		futureDate := (integer)cleanDOB > (integer)(STRING8)Std.Date.Today();

		vssn := Risk_indicators.Validate_SSN(cleanSSN,'');

		/* CODE 180 */
		ssnInvalidChars := vssn.invalid;

		/* CODE 109 */
		starts9 := vssn.begin_invalid;
		
		/* CODE 12 */
		isPocketBookSSN := vssn.pocketbook_ssn;

		/* CODE 105 */
		hasLastFourZero  := vssn.last_invalid;
		/* CODE 106 */
		hasMiddleTwoZero := vssn.middle_invalid;

		/* CODE 100 */
		isOutOfRange := NOT( (INTEGER)cleanSSN[6..9] BETWEEN le.start_serial AND le.end_serial );

		/* CODE 10 */
		seriesCurrent := le.highissue='20991231';

		/* CODE 14 */
		possibleRecent := le.prev_end='20991231';


		/* CODE 103 */
		first3notassign := (INTEGER)ssn_area = 0;
						// OR (INTEGER)ssn_area BETWEEN unassigned_min AND unassigned_max
						// OR (INTEGER)ssn_area > unassigned_cap;

		/* CODE 104 */
		first3assignedNoIssue := ssn_area in areas_not_issued;

		/* CODE 107 */
		middleTwoUnassigned := not le.mapDataAvailable;
		
		/* CODE 108 */
		discontinued := ((INTEGER)ssn_area BETWEEN discontinued_min AND discontinued_max )
						// AND -1 = GroupBefore( unassigned_cap, (INTEGER)ssn_grp)
						// AND NOT le.mapDataAvailable
						;


		/* CODE 111 */
		second2notused := ssn_area+ssn_grp in area_groups_not_used;

		//

		/* Due to SSN Randomization - many of these code no longer can be accurately calculated */
		ssncode := map(
			ssnInvalidChars       => 180, // too few or illegal character(s) in SSN
			starts9               => 109, // ssns do not begin with a 9 (never been issued)
			isPocketBookSSN       =>  12, // ssn is a 'pocketbook' number
			// first3assignedNoIssue => 104,
			first3notassign       => 103, // ssn area = 0
			hasLastFourZero       => 105,
			// middleTwoUnassigned   => 107,
			hasMiddleTwoZero      => 106,
			le.decs               => 110, // ssn belonged to a person reported deceased
			// discontinued          => 108, // outside bounds of discontinued series
			// second2notused        => 111,
			// seriesCurrent         =>  10,
			// possibleRecent        =>  14,
			// isOutOfRange          => 100,
			0
		);
		
		dobcode := map(
			// under certain circumstances, we won't return a dob code:
			dobZero               =>   0, // input dob is empty
			ssnInvalidChars       =>   0, // SSN has invalid chars
			hasMiddleTwoZero      =>   0, // middle two are zero
			// second2notused        =>   0, // middle two not used
			
			notCalendarDate       =>  21, // Birthdate is not a valid calendar date
			dobInvalidChars       =>  81, // too few or illegal character(s) in DOB
			futureDate            =>  22, // 
			isInvalidDate         => 201, // Birthdate is not a valid date
			isIssuedPriorToDOB    => 200,
			isIssuedAfterAge18    =>  60,
			0
		);
		
		
		ssninfo := case( ssncode,
			  0 => 'SSN is presumed to be valid',
			 // 10 => 'Series current; number may not be issued',
			 12 => 'SSN is a pocketbook number',
			 // 14 => 'SSN out of range but a possible recent issue',
			// 100 => 'SSN \'out of range\'; never been assigned',
			103 => 'SSN first three digits not assigned (never been issued)',
			// 104 => 'SSN first three digits assigned but not been issued',
			105 => 'SSN last 4 digits cannot be all zeros',
			106 => 'SSN middle 2 digits cannot both be zeros',
			// 107 => 'SSN middle 2 digits unassigned',
			// 108 => 'SSN outside bounds of discontinued series',
			109 => 'SSNs do not begin with a 9 (Never been issued)',
			110 => 'SSN belogned to a person reported deceased',
			// 111 => 'SSN second 2 digits not used for given area (Never issued)',
			180 => 'Too few or illegal characters(s) in SSN.',
			''
		);
		
		dobinfo := case( dobcode,
			  0 => '',
			 21 => 'Birthdate is not a valid calendar date',
			 22 => 'Birthdate is a future date',
			 60 => 'SSN assigned when person was over 18',
			 81 => 'Too few or illegal character(s) in DOB',
			200 => 'SSN assigned before person was born',
			201 => 'Birthdate is not a valid date',
			''
		);

		self.seq   := le.seq;
		self.inssn := le.inssn;
		self.indob := le.indob;
		self.state := Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(le.mapState));
		self.lowissue := le.lowissue;
		self.highissue := le.highissue;
		
		self.ssncode := ssncode;
		self.dobcode := dobcode;
		
		// As these are not currently used, they are not available to the products -- AES, 24MAR08
		// self.ssninfo := ssninfo;
		// self.dobinfo := dobinfo;
		
	END;

	final := project( withPrevRolled, doCodes(left) );
	
	return final;

END;
