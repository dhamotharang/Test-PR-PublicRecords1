import doxie;

doxie.MAC_Header_Field_Declare()
boolean 	report_reqd := false : stored('ReportReq');

boolean acts_reqd := report_reqd;

//--------[ Fetch People and Events ]------------------

F_person := doxie.DOC_Search_People_Records
    (dateVal = 0 OR (unsigned3)(case_date[1..6]) <= dateVal);

F_events := doxie.DOC_Search_Events_Records(F_person);

//--------[ put into output layout ]--------------
doxie.Layout_DOCSearch_raw into_out(f_person L) := transform
	self.akas := dataset([{L.fname,L.mname,L.lname,L.name_suffix}],doxie.layout_aka);
	self.doc_offenses := [];
	self.court_offenses := [];
	self.paroles := [];
	self.prisonterms := [];
	self.activities := [];
	self.seq := 0;
	self := l;
end;

f_person roller(f_person le, f_person ri) :=
TRANSFORM
	SELF.did := IF(le.did='', ri.did, le.did);
	SELF := le;
END;

f1 := rollup(sort(f_person,offender_key,-lname,-fname,-mname,-name_suffix),roller(LEFT,RIGHT),offender_key,lname,fname,mname,name_suffix);
f1b  := project(f1,into_out(LEFT));

doxie.Layout_DOCSearch_raw roll_Akas(f1b L, f1b R) := transform
	self.akas := L.akas + dataset([{r.fname,r.mname,r.lname,r.name_suffix}],doxie.Layout_AKA);
	SELF.did := IF(L.did='',R.did,L.did);
	self := l
end;

f2 := rollup(f1b,left.offender_key = right.offender_key,roll_akas(LEFT,RIGHT));

f2 add_events(f2 L, f_events R) := transform
	self.doc_offenses := R.doc_offenses;
	self.court_offenses := R.court_offenses;
	self.activities := R.activities;
	self.paroles := R.paroles;
	self.prisonterms := R.prisonterms;
	self := L;
end;

f3 := join(f2,f_events,
				left.offender_key = right.offender_key,
				add_events(LEFT,RIGHT), left outer);

f4 := choosen(f3,MaxResults_val);

emptyOut := DATASET([], Doxie.layout_DOCSearch_raw);

export doc_search_records := if (is_A_Neighbor,emptyOut,F4);