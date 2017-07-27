import uccd, ut, census_data;
rec := record
	string50  ucc_key;
	unsigned6 did;
	unsigned6	bdid;
	
	//from party
	uccd.layout_jfk_debtor;
	uccd.layout_jfk_secured;
	
	//from collateral
	string60 	 collateral_child;
	
	//from summary
	uccd.layout_jfk_summary;
	
	//from event
	uccd.layout_jfk_event;

end;

d := distribute(uccd.File_WithExpParty(ucc_key <> '', party_type in uccd.set_Debtor_std_type), hash(ucc_key));
	//distribute(uccd.File_Party_Base(ucc_key <> '', did > 0, std_type in uccd.set_Debtor_std_type), hash(ucc_key));
	
rec getdebtor(d r):= transform
	self.debtor_event_key := r.event_key;
	self.debtor_fname := r.p_name[6..25];
	self.debtor_mname := r.p_name[26..45];
	self.debtor_lname := r.p_name[46..65];
	self.debtor_name_suffix := r.p_name[66..70];
	self.debtor_status_desc := r.party_status_desc;
	self.debtor_name := r.name;
	self.debtor_prim_range := r.clean_address[1..10];
	self.debtor_predir := r.clean_address[11..12];
	self.debtor_prim_name := r.clean_address[13..40];
	self.debtor_addr_suffix := r.clean_address[41..44];
	self.debtor_postdir := r.clean_address[45..46];
	self.debtor_unit_desig := r.clean_address[47..56];
	self.debtor_sec_range := r.clean_address[57..64];
	self.debtor_city_name := r.clean_address[90..114];
	self.debtor_county_name := r.clean_address[141..145]; // needs translation
	self.debtor_st := r.clean_address[115..116];
	self.debtor_zip := r.clean_address[117..121];
	self.debtor_zip4 := r.clean_address[122..125];
	self.did := (integer)r.did;
	self.bdid := (integer)R.bdid;
	self.ucc_key := r.ucc_key;
	self.collateral_child := '';
	//self := l;
end;

withdebtor_fips := project(d, getdebtor(left));

census_data.MAC_Fips2County(withdebtor_fips,debtor_st,debtor_county_name[3..5],debtor_county_name,withdebtor)

//secured
s := distribute(uccd.File_withExpParty(ucc_key <> '', party_type in uccd.set_Secured_std_type), hash(ucc_key));

rec getsecured(rec l, s r):= transform
	self.secured_event_key := r.event_key;
	self.secured_status_desc := r.party_status_desc;
	self.secured_name := r.name;
	self.secured_prim_range := r.clean_address[1..10];
	self.secured_predir := r.clean_address[11..12];
	self.secured_prim_name := r.clean_address[13..40];
	self.secured_addr_suffix := r.clean_address[41..44];
	self.secured_postdir := r.clean_address[45..46];
	self.secured_unit_desig := r.clean_address[47..56];
	self.secured_sec_range := r.clean_address[57..64];
	self.secured_city_name := r.clean_address[90..114];
	self.secured_st := r.clean_address[115..116];
	self.secured_zip := r.clean_address[117..121];
	self.secured_zip4 := r.clean_address[122..125];
	self.did := L.did;
	self := l;
end;

withsecured := dedup(join(withdebtor, s, left.ucc_key = right.ucc_key, getsecured(left, right), left outer, local, atmost(50)), local, all);

//event
//uccd.File_Event_Base
e := distribute(uccd.File_WithExpEvent(ucc_key <> ''), hash(ucc_key));

rec getevent(rec l, e r):= transform
	self.event_key := r.event_key;
	self.filing_date := r.filing_date;
	self.orig_filing_date := r.orig_filing_date;
	self.orig_filing_num := r.orig_filing_num;
	self.event_document_num := r.document_num;
	self.filing_type_desc := r.filing_type_desc;
	self := l;
end;

withevent := dedup(join(withsecured, e, left.ucc_key = right.ucc_key, getevent(left, right), left outer, local, atmost(50)), local, all);

//collateral
c := distribute(uccd.File_WithExpCollateral_Patched(ucc_key <> ''), hash(ucc_key));

tempcrec := record
	string512 phrase;
	c.ucc_key;
end;

tempcrec pickcol(c l) := transform
	self.phrase := if(stringlib.stringtouppercase(l.collateral_type_desc) = uccd.string_SeeCollateralDescription, l.collateral_desc, l.collateral_type_desc);
	self.ucc_key := l.ucc_key;
end;

phrased := project(c, pickcol(left));

tempcrec norm(phrased le, INTEGER c) := TRANSFORM
	self.phrase := uccd.getCollateralWord(le.phrase,c);
	self.ucc_key := le.ucc_key;
END;

worded := NORMALIZE(phrased,LENGTH(StringLib.StringFilter(TRIM(LEFT.phrase),' ')),
		 norm(LEFT,COUNTER))(phrase <> '');

rec getcollateral(rec l, worded r):= transform
	self.collateral_child := r.phrase;
	self := l;
end;

withcollateral := dedup(join(withevent, worded, left.ucc_key = right.ucc_key, getcollateral(left, right), left outer, local, atmost(50)), local, all);

//summary
su := distribute(uccd.File_withExpSummary(ucc_key <> ''), hash(ucc_key));

rec getsummary(rec l, su r):= transform
	self.filing_state := r.file_state;
	self.filing_count := r.filing_count;
	self.document_count := r.document_count;
	self.debtor_count := r.debtor_count;
	self.secured_count := r.secured_count;
	self.ucc_exp_date := r.ucc_exp_date;
	self.ucc_filing_type_desc := stringlib.stringtouppercase(l.ucc_filing_type_desc);
	self := l;
end;

withsummary := dedup(join(withcollateral, su, left.ucc_key = right.ucc_key, getsummary(left, right), left outer, local, atmost(50)), local, all);

export joined_for_key := withsummary : independent;
