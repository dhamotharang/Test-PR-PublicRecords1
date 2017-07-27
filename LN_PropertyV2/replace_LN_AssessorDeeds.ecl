import LN_property, LN_mortgage;

export replace_LN_assessorDeeds := module 

//******************** replace assessor ********************************************************
export replace_assessor(dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessorRepl,dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessor) := function

irs_ln_fares_ids := ['OAx098980660',
                     'OAw098980660',
					 'OAv098980660',
					 'OAu098980660'
					];

//areplAll := dataset(ln_property.filenames.inAssessorRepl, LN_Property.Layout_Property_Common_Model_BASE, thor); 
//aAll     := dataset(ln_property.filenames.inAssessor, LN_Property.Layout_Property_Common_Model_BASE, thor); 
ds       := inAssessorRepl + inAssessor;


ds1 := distribute(ds, hash(fips_code, apna_or_pin_number, duplicate_apn_multiple_address_id, tax_year));
ds2 := sort(ds1,           fips_code, apna_or_pin_number, duplicate_apn_multiple_address_id, tax_year, -process_date, ln_fares_id, local);
ds3 := dedup(ds2,          record, except ln_fares_id, process_date, local);

repl_assessor := ds3(ln_fares_id not in irs_ln_fares_ids);	

repl_assessor_good := LN_PropertyV2.Mac_junk_tax.ln_asses(repl_assessor); 		   

return repl_assessor_good;
end;

//******************** replace deeds ********************************************************

export Replace_Deeds(dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl ,dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds) := function

//dreplAll := dataset(ln_property.filenames.inDeedsRepl, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor); 
//dAll     := dataset(ln_property.filenames.inDeeds, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor); 

canUseDeedRepl := if(FileServices.GetSuperFileSubCount(ln_propertyV2.filenames.inDeedsRepl) > 0, 
										 true, false);
										 
ds := if(canUseDeedRepl = true, inDeeds + inDeedsRepl(from_file = 'M'), inDeeds);
										 
ds1 := distribute(ds, hash(fips_code, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number, name1));
ds2 := sort(ds1,           fips_code, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number, name1, -process_date, ln_fares_id, local);
ds3 := dedup(ds2,          record, except ln_fares_id, process_date, local);

Repl_Deeds := ds3;

Repl_Deeds_good := LN_PropertyV2.fn_junk_deed.ln_deeds(Repl_Deeds); 

return Repl_Deeds_good;

end;

end;