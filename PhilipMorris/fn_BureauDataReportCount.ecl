
import header, business_header, address, _control;

export fn_BureauDataReportCount(SET OF STRING SetValidValues) := FUNCTION 


//******************************   VALID States    ***************************//
r := {STRING2 state, unsigned cnt};
SetValidStates := DATASET([{'AK',0},{'AL',0},{'AR',0},{'AZ',0},{'CA',0},{'CO',0},{'CT',0},{'DC',0},{'DE',0},{'FL',0},{'GA',0},{'HI',0},{'IA',0},
				   {'ID',0},{'IL',0},{'IN',0},{'KS',0},{'KY',0},{'LA',0},{'MA',0},{'MD',0},{'ME',0},{'MI',0},{'MN',0},{'MO',0},{'MS',0},{'MT',0},
				   {'NC',0},{'ND',0},{'NE',0},{'NH',0},{'NJ',0},{'NM',0},{'NV',0},{'NY',0},{'OH',0},{'OK',0},{'OR',0},{'PA',0},{'RI',0},{'SC',0},
				   {'SD',0},{'TN',0},{'TX',0},{'UT',0},{'VA',0},{'VT',0},{'WA',0},{'WI',0},{'WV',0},{'WY',0}],r);

AllStates := SET(SetValidStates(),state);

Header_source := dataset('~thor400_92::persist::header_pre_keybuild',PhilipMorris.Layout_header_pre_keybuild,flat);
IsValidState := Header_source.st IN AllStates;
ValRecsState := Header_source(IsValidState);
					  
IsValidRec := ValRecsState.src IN SetValidValues;
ValRecs := ValRecsState(IsValidRec);

rec_StateCount := record
	string2 state;
	// string src;
	unsigned cnt := 1;
end;

rec_StateCount xfm(recordof(ValRecs) L) := transform
	self.state := L.st;
	// self.src := L.src;
	self.cnt := 1;
end;

f_StateCount := project(ValRecs, xfm(left));


f_srt := sort(DISTRIBUTE(f_StateCount,hash32(state)),state,local);

rec_StateCount xfm_cnt(rec_StateCount L, rec_StateCount R) := transform
	self.state := L.state;
	// self.src := L.src;
	self.cnt := L.cnt + 1;
end;

f_rlp := rollup(f_srt, 
				left.state = right.state, 
				xfm_cnt(left, right));

/*
output(f_rlp, named('State_MVR_Count'));
output(COUNT(ValRecs),named('Total_MVR'));*/


MyFormat := RECORD
STRING2 state := f_rlp.state;
unsigned cnt := f_rlp.cnt;
END;

f_table := table(f_rlp,MyFormat);

// f_table := table(f_rlp,r);
/*
r doHalfJoin(r L,rec_StateCount R) := TRANSFORM
self.state := if(R.cnt <> 0, R.state,L.state);
self.cnt := if(R.cnt <> 0, R.cnt,L.cnt);
SELF := L;
END;

f_return := JOIN(SetValidStates,f_rlp, 
LEFT.state=RIGHT.state,doHalfJoin(LEFT,RIGHT),full outer);

*/
return f_table;
// RETURN f_return;
END;