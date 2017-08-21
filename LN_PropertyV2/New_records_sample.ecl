import ln_propertyv2;

d01 := output(choosen(LN_PropertyV2.File_Assessment(max(LN_PropertyV2.File_Assessment,(unsigned4)process_date) -  (unsigned4)process_date < 7 and ln_fares_id[1..2] in ['OA','RA']), 1000),named('Assess_sample_QA'));
d02 := output(choosen(LN_PropertyV2.File_Deed( max(LN_PropertyV2.File_Deed,(unsigned4)process_date) - (unsigned4)process_date < 7 and ln_fares_id[1..2] in ['OD','RD']), 1000),named('Deeds_sample_QA'));
d03 := output(choosen(LN_PropertyV2.File_Search_DID(max(LN_PropertyV2.File_Search_DID,(unsigned4)process_date) -  (unsigned4)process_date < 7 and ln_fares_id[1] in ['O','R']), 1000),named('search_sample_QA'));

d04:=  output(choosen(sort(LN_PropertyV2.File_addl_fares_deed,-(integer)ln_fares_id[3..]), 1000),named('addl_fdeed_sample_QA'));
d05:=  output(choosen(sort(LN_PropertyV2.File_addl_Fares_tax,-(integer)ln_fares_id[3..]), 1000),named('addl_ftax_sample_QA'));
d06 := output(choosen(sort(LN_PropertyV2.File_ln_deed_addlnames,-(integer)ln_fares_id[3..]), 1000),named('addl_names_sample_QA'));

d07 := output(choosen(sort(LN_PropertyV2.File_addl_legal(ln_fares_id[1..2] = 'RA'),-(integer)ln_fares_id[3..]), 100),named('addl_flegal_sample_QA'));
d08 := output(choosen(sort(LN_PropertyV2.File_addl_legal(ln_fares_id[1..2] != 'RA'),-(integer)ln_fares_id[3..]), 100),named('addl_legal_sample_QA'));
 
export New_records_sample := parallel(d01, d02, d03, d04, d05, d06, d07,d08);
	