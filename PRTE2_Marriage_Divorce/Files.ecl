IMPORT PRTE2_Marriage_Divorce, marriage_divorce_v2, doxie, ut, standard;

EXPORT Files := MODULE

	EXPORT Main_in	:= DATASET(Constants.IN_PREFIX + 'main_base', Layouts.Main_in, 
														CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
										
	EXPORT Base_out 	:= DATASET(Constants.BASE_PREFIX + 'main', Layouts.Main_Base_out, THOR);
	EXPORT Base				:= PROJECT(Base_out, Layouts.Main_Base);
	EXPORT Search_ext	:= DATASET(Constants.BASE_PREFIX + 'search', Layouts.Search_Base_ext, THOR);
	EXPORT Search			:= PROJECT(Search_ext, Layouts.Search_Base);
	
	//Autokeyfile
	r00 := RECORD
		PRTE2_Marriage_Divorce.Layouts.Search_Base;
		STRING2  state_origin;
		STRING35 county_marriage;
		STRING35 county_divorce;
	END;

	r00 t_get_filing_st(Search le, Base ri) := TRANSFORM
		SELF                 := le;
		SELF.state_origin    := ri.state_origin;
		SELF.county_marriage := ri.marriage_county;
		SELF.county_divorce  := ri.divorce_county;
	END;

	j1 := join(Search, Base,
						left.RECORD_id=right.RECORD_id,
						t_get_filing_st(left,right));

	r0 := RECORD
		PRTE2_Marriage_Divorce.Layouts.Search_Base;
		STRING35 county2;
		STRING8  party_dob;
	END;


	r0 t_norm(j1 le, integer c) := TRANSFORM
		SELF.st        := choose(c,le.state_origin,   le.state_origin);
		SELF.county2   := choose(c,le.county_marriage,le.county_divorce);
		SELF.party_dob := if(le.which_party in ['P1','P2'],le.dob,'');
		SELF           := le;
	END;

	/*the normalize is creating RECORDs that are sub-sets of other RECORDs
		particularly cases where the only difference between 2 RECORDs is one having
		a county and the other does not*/

	p_norm0 := normalize(j1,IF(trim(left.county_divorce) = '',1,2),t_norm(left,counter));

	r1 := RECORD
		p_norm0.did;
		p_norm0.RECORD_id;
		p_norm0.party_type;
		p_norm0.which_party;
		UNSIGNED4 lookups;
		standard.addr addr;
		standard.name name;
		UNSIGNED1 zero := 0;
		STRING1   blank:='';
		p_norm0.party_dob;
	END;

	r1 t1(p_norm0 le) := TRANSFORM
		party_bits := (UNSIGNED4) ut.bit_set(1, doxie.lookup_bit( le.which_party ));
		SELF.did             := le.did;
		SELF.RECORD_id       := le.RECORD_id;
		SELF.party_type      := le.party_type;
		SELF.which_party     := le.which_party;
		SELF.lookups         := party_bits;
		SELF.addr.zip5       := le.zip;
		SELF.addr            := le;
		SELF.name            := le;
		SELF.name.name_score := '';
		SELF.party_dob       := le.party_dob;
		SELF.addr            := [];
	END;

	p1 := dedup(project(p_norm0,t1(left)),RECORD,ALL);

	EXPORT SearchAutokey := p1;

END;