rec := deathv2_services.layouts.report_external;

export fn_DedupSearch(
	dataset(rec) recs) := 
FUNCTION

//if all this the same, get rid of one
dup(rec r) := r.penalt + r.fname + r.lname + r.mname[1] + r.ssn + r.dob8 + r.dod8 + r.zip_lastres;

//how we pick
srt := sort(recs, dup(recs), -state_death_flag, -filedate, state_death_id);
ddp := dedup(srt, dup(srt));

return ddp;

END;