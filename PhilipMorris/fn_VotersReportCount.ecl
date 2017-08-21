import header, business_header, address, _control, VotersV2;


#workunit('name','Philip Morris Report Voters Count')
export fn_VotersReportCount() := FUNCTION 


//******************************   VALID States    ***************************//
r := {STRING2 state, unsigned cnt};
SetValidStates := DATASET([{'AK',0},{'AL',0},{'AR',0},{'AZ',0},{'CA',0},{'CO',0},{'CT',0},{'DC',0},{'DE',0},{'FL',0},{'GA',0},{'HI',0},{'IA',0},
				   {'ID',0},{'IL',0},{'IN',0},{'KS',0},{'KY',0},{'LA',0},{'MA',0},{'MD',0},{'ME',0},{'MI',0},{'MN',0},{'MO',0},{'MS',0},{'MT',0},
				   {'NC',0},{'ND',0},{'NE',0},{'NH',0},{'NJ',0},{'NM',0},{'NV',0},{'NY',0},{'OH',0},{'OK',0},{'OR',0},{'PA',0},{'RI',0},{'SC',0},
				   {'SD',0},{'TN',0},{'TX',0},{'UT',0},{'VA',0},{'VT',0},{'WA',0},{'WI',0},{'WV',0},{'WY',0}],r);

AllStates := SET(SetValidStates(),state);
Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new;

Voters_source := dataset('~thor_data400::base::Voters_Header_Building',Layout_in,flat);

//Header_source := dataset('~thor400_84::persist::header_pre_keybuild',PhilipMorris.Layout_Header,flat);
IsValidState := Voters_source.source_state IN AllStates;
ValRecsState := Voters_source(IsValidState);
					  
rec_StateCount := record
	string2 state;
	unsigned cnt := 1;
end;

rec_StateCount xfm(recordof(ValRecsState) L) := transform
	 

	self.state := L.source_state;
	//self.src := L.src;
	self.cnt := 1;
end;

f_StateCount := project(ValRecsState, xfm(left));


f_srt := sort(DISTRIBUTE(f_StateCount,hash32(state)),state,local);

rec_StateCount xfm_cnt(rec_StateCount L, rec_StateCount R) := transform
	

	self.state := L.state;
	self.cnt := L.cnt + 1;
end;

f_rlp := rollup(f_srt, 
				left.state = right.state,
				xfm_cnt(left, right));


/*
MyFormat := record

STRING2 state := f_rlp.state;
unsigned record_count := f_rlp.cnt;

end;


f_return := table(f_rlp,MyFormat);*/
/*
output(f_rlp, named('State_MVR_Count'));
output(COUNT(ValRecs),named('Total_MVR'));*/

/*
MyFormat := RECORD
STRING2 state := f_rlp.state;
unsigned cnt := f_rlp.cnt;
END;
*/

//f_table := table(f_rlp,r);

r doHalfJoin(r L,rec_StateCount R) := TRANSFORM
self.state := if(R.cnt <> 0, R.state,L.state);
self.cnt := if(R.cnt <> 0, R.cnt,L.cnt);
SELF := L;
END;

f_return := JOIN(SetValidStates,f_rlp, 
LEFT.state=RIGHT.state,doHalfJoin(LEFT,RIGHT),full outer);

RETURN f_return;
END;
// output(f_return, named('State_MVR_Count'));
// output(COUNT(ValRecsState),named('Total_MVR'));
// output(count(CHOOSEN(Voters_source(source_state = 'AZ'),200)),named('AK_COUNT'));