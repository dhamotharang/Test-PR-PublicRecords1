import LN_property, LN_mortgage;


irs_ln_fares_ids := ['ODx014318179'];

dreplAll := dataset(ln_property.filenames.inDeedsRepl, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor); 
dAll     := dataset(ln_property.filenames.inDeeds, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor); 

canUseDeedRepl := if(FileServices.GetSuperFileSubCount(ln_property.filenames.inDeedsRepl) > 0, 
										 true, false);
										 
ds := if(canUseDeedRepl = true, dAll + dReplAll(from_file = 'M'), dAll);
										 
ds1 := distribute(ds, hash(fips_code, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number, borrower1));
ds2 := sort(ds1,           fips_code, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number, borrower1, -process_date, ln_fares_id, local);
ds3 := dedup(ds2,          record, except ln_fares_id, process_date, local);


export Replace_Deeds := ds3(ln_fares_id not in irs_ln_fares_ids);