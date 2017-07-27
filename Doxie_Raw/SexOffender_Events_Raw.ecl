import sexoffender_Services,doxie, ut, FCRA, FFD;

export SexOffender_Events_Raw(
		dataset(doxie.layout_sexoffender_searchperson) persons,
		string60	sid_value = '',
		unsigned4 dateVal = 0,
		unsigned1 dppa_purpose = 0,
		unsigned1 glb_purpose = 0,
		string32 application_type = '',
		boolean IsFCRA = false,
		DATASET (doxie.layout_best) ds_best  = DATASET ([], doxie.layout_best),
		dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
) := FUNCTION

in_sspks := project(persons, sexOffender_Services.Layouts.search);
ds_flags := if (IsFCRA, FCRA.GetFlagFile(ds_best), fcra.compliance.blank_flagfile);
raw_offenses := SexOffender_Services.Raw.GetRawOffenses(in_sspks, isFCRA, ds_flags, slim_pc_recs, inFFDOptionsMask);

dbase := project(persons, doxie.layout_sexoffender_searchevents);

doxie.layout_sexoffender_searchevents get_offenses(dbase l, raw_offenses r) := transform
  self.source := l.source;
	self.failurelocation := l.failurelocation;
	self.failurecode := l.failurecode;
	self.failuremessage := l.failuremessage;
	self := r;
end;

offs := join(dbase,raw_offenses, 
             left.seisint_primary_key = right.sspk
             and (dateVal=0 OR (unsigned3)(right.offense_date[1..6]) <= dateVal),
             get_offenses(left,right), LIMIT (ut.limits. SOFFENDER_MAX, SKIP));
			
doxie.MAC_Filter_SexOffender(application_type, offs, f_offs);

return f_offs;

END;