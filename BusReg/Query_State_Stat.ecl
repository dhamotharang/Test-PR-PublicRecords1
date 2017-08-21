br := Files().Base.full.qa;

mylayout :=
record
	br.rawfields.STATE_CODE;
end;

br_state := table(br, mylayout, rawfields.STATE_CODE);

export Query_State_Stat := output(br_state, named('BusinessRegistrationsStateCoverage'));