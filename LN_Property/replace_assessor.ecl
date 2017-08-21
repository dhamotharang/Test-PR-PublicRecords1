import LN_property;

irs_ln_fares_ids := ['OAx098980660',
                     'OAw098980660',
					 'OAv098980660',
					 'OAu098980660'
					];

areplAll := dataset(ln_property.filenames.inAssessorRepl, LN_Property.Layout_Property_Common_Model_BASE, thor); 
aAll     := dataset(ln_property.filenames.inAssessor, LN_Property.Layout_Property_Common_Model_BASE, thor); 
ds       := (aAll + aReplAll)(new_record_type_code[1]!='O');


ds1 := distribute(ds, hash(fips_code, apna_or_pin_number, duplicate_apn_multiple_address_id, tax_year));
ds2 := sort(ds1,           fips_code, apna_or_pin_number, duplicate_apn_multiple_address_id, tax_year, -process_date, ln_fares_id, local);
ds3 := dedup(ds2,          record, except ln_fares_id, process_date, local);

export replace_assessor := ds3(ln_fares_id not in irs_ln_fares_ids);			   