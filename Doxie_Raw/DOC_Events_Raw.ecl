import corrections,ut,doxie_files,doxie;

export DOC_Events_Raw(
		dataset(doxie.layout_DOCSearch_Person) pre_persons,
		boolean report_reqd = false,
		boolean off_reqd_p = false,
		boolean par_reqd_p = false,
		boolean pt_reqd_p  = false,
		boolean acts_reqd_p = false,
		string25 doc_val = '',
		string60	ofk_val = '',
	unsigned8 maxResults_val = 2000,
	unsigned4 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0
) := FUNCTION

boolean off_reqd := off_reqd_p or report_reqd;
boolean par_reqd := par_reqd_p or report_reqd;
boolean pt_reqd := pt_reqd_p or report_reqd;
boolean acts_reqd := acts_reqd_p  or report_reqd;

persons := pre_persons(off_reqd OR par_reqd OR pt_reqd OR acts_reqd);
		
doxie.Layout_DOCSearch_Events into(persons L) := transform
	self.offender_key := L.offender_key;
	self.data_type := L.data_type;
	self.case_type_desc := L.case_type_desc;
	self.DOC_offenses := [];
	self.Court_offenses := [];
	self.paroles := [];
	self.prisonterms := [];
	self.activities := [];
end;

dbase := project(dedup(sort(persons,offender_key,data_type),offender_key,data_type),into(LEFT));



//----------------[ DOC Offenses ]----------------------

dfko := doxie_files.Key_Offenses();
		
doxie.layout_offense_seq get_case_type(dfko L, string ct) := transform
	self.case_type := ct;
	self := L;
end;


//-------------------[ Court Offenses ]-----------------

dfkco := doxie_files.Key_Court_Offenses ();

corrections.layout_CourtOffenses get_court_offenses(dfkco L) := transform
	self := L;
end;


//-------------------[ Paroles and Prison Terms ]----------------------

dfkp := doxie_files.Key_Punishment();

corrections.Layout_CrimPunishment get_puns(dfkp L) := transform
	self := L;
end;


//-----------------[ Activities ]------------------------

dfka := doxie_files.Key_Activity ();

corrections.Layout_Activity get_acts(dfka L) := transform
	self := L;
end;


//-----------------[ Combine ]------------------------

doxie.Layout_DOCSearch_Events addchildren(dbase l) := transform
	self.doc_offenses := 
		choosen(
			project(dfko(keyed(l.offender_key = ok) and l.data_type = '1' and off_reqd
												 and (dateVal = 0 OR (unsigned3)(off_date[1..6]) <= dateVal)),
						  get_case_type(LEFT,l.case_type_desc))
		
						, 50);
	self.court_offenses := 
		sort(
			choosen(
				project(dfkco(l.data_type in ['2','5'] and 
											keyed(L.offender_key = ofk) and off_reqd
											and (dateVal = 0 OR (unsigned3)(off_date[1..6]) <= dateVal)),
								get_court_offenses(LEFT))
			
							, 50)
				 , off_comp, -off_date);
	self.paroles := 
		choosen(
			project(dfkp(keyed(l.offender_key = ok) and
									 keyed(pt = 'P') and par_reqd
									 and (dateVal = 0 OR (unsigned3)(event_dt[1..6]) <= dateVal)),
							get_puns(LEFT))
				    , 50);
	self.prisonterms := 
		choosen(
			project(dfkp(keyed(l.offender_key = ok) and
									 keyed(pt = 'I') and pt_reqd
									 and (dateVal = 0 OR (unsigned3)(event_dt[1..6]) <= dateVal)),
							get_puns(LEFT))
				    , 50);	

  ds_act := LIMIT (dfka(keyed(l.offender_key = ok) and acts_reqd
								   and (dateVal = 0 OR (unsigned3)(event_date[1..6]) <= dateVal)),
            ut.limits. ACTIVITY_LIMIT, KEYED, SKIP);
  self.activities := 
	     choosen(
			         dedup(sort(project (ds_act, get_acts(LEFT)) ,-event_date, event_desc_1, -event_desc_2),
			               event_date, event_desc_1),
		           50);

	self := l;
end;

wchildren := project(dbase, addchildren(left));

//-----------------[ done ]----------------


doxie.Layout_DOCSearch_Events into_out(wchildren L,integer c) := transform
	self.seq := c;
	self := L;
end;

step5 := project(wchildren,into_out(LEFT,counter));

return IF(off_reqd OR par_reqd OR pt_reqd OR acts_reqd,
								step5,dataset([],doxie.Layout_DOCSearch_Events));




END;