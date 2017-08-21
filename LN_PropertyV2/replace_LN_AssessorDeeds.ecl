import LN_property, LN_mortgage;

export replace_LN_assessorDeeds := module 
// Bug 153098- Remove records and replaced with most current records found in REPL file
// Bug 165284- Duplicate Property Records

//******************** replace assessor ********************************************************
export replace_assessor(dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessorRepl,dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessor) := function

irs_ln_fares_ids := ['OAx098980660',
                     'OAw098980660',
										 'OAv098980660',
										 'OAu098980660'
										];


ds1 := distribute(inAssessor, hash(state_code, county_name, apna_or_pin_number, assessed_value_year, recording_date, edition_number));

ds_repl1 := distribute(inAssessorRepl, hash(state_code, county_name, apna_or_pin_number, assessed_value_year, recording_date, edition_number));
ds_repl2 := dedup(sort(ds_repl1, state_code, county_name, apna_or_pin_number,assessed_value_year, recording_date, edition_number, -process_date, ln_fares_id, local),
												state_code, county_name, apna_or_pin_number,assessed_value_year, recording_date, edition_number,local);



assessor_join :=  JOIN(ds1, ds_repl2,
									  LEFT.fips_code							=	RIGHT.fips_code 						AND 
										LEFT.state_code				  		=	RIGHT.state_code						AND 
										LEFT.county_name						=	RIGHT.county_name						AND 
										LEFT.recording_date					=	RIGHT.recording_date				AND 
										LEFT.assessed_value_year		=	RIGHT.assessed_value_year		AND 
										LEFT.edition_number					=	RIGHT.edition_number				AND 														
										LEFT.apna_or_pin_number			=	RIGHT.apna_or_pin_number		AND
										LEFT.process_date < RIGHT.process_date,
										TRANSFORM(LN_PropertyV2.layout_property_common_model_base, SELF := LEFT; SELF := []), left only);
										
										
repl_assessor := assessor_join + ds_repl2;

repl_assesor_irs := repl_assessor(ln_fares_id not in irs_ln_fares_ids);	

repl_assessor_good := LN_PropertyV2.Mac_junk_tax.ln_asses(repl_assesor_irs); 		   

return repl_assessor_good;
end;

//******************** replace deeds ********************************************************

export Replace_Deeds(dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl ,dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds) := function

										 
ds1 := distribute(inDeeds, hash(fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number));
ds2 := dedup(sort(ds1, RECORD,local), except process_date, ln_fares_id ,all, local);

ds1_repl := distribute(inDeedsRepl, hash(fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number));
ds2_repl := dedup(sort(ds1_repl, fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number, -process_date, ln_fares_id, local),
										fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number,local);

deed_join :=  JOIN(ds2, ds2_repl,
									  LEFT.fips_code							=	RIGHT.fips_code 						AND 
										LEFT.state									=	RIGHT.state									AND 
										LEFT.county_name						=	RIGHT.county_name						AND 
										LEFT.recording_date					=	RIGHT.recording_date				AND 
										LEFT.recorder_book_number		=	RIGHT.recorder_book_number	AND 
										LEFT.recorder_page_number		=	RIGHT.recorder_page_number	AND 														
										LEFT.document_number				=	RIGHT.document_number				AND 
										LEFT.apnt_or_pin_number			=	RIGHT.apnt_or_pin_number		AND
										LEFT.process_date < RIGHT.process_date ,
												TRANSFORM(LN_PropertyV2.layout_deed_mortgage_common_model_base, SELF := LEFT; SELF := []), LEft ONLY);

Repl_Deeds := deed_join + ds2_repl;

Repl_Deeds_good := LN_PropertyV2.fn_junk_deed.ln_deeds(Repl_Deeds); 

return Repl_Deeds_good;

end;

end;