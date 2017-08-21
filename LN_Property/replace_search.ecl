import LN_property, LN_mortgage;

//retrieve base, add and replacement files
concat_search_base := dataset(ln_property.filenames.inSearch, LN_Property.Layout_Deed_Mortgage_Property_Search, thor); 
concat_search_repl := dataset(ln_property.filenames.inSearchRepl, LN_Property.Layout_Deed_Mortgage_Property_Search, thor); 

// concatenate search base, add and replace files
concat_search := concat_search_base + concat_search_repl;

//distribute the files

concat_search_dist    := distribute(concat_search, hash(ln_fares_id));
//concat_search_sort    := sort(concat_search_dist, ln_fares_id, local);

replace_assessor_dist := distribute(LN_property.Replace_Assessor, hash(ln_fares_id));
//replace_assessor_sort := sort(replace_assessor_dist, ln_fares_id, local);

temp_deeds            := dataset(LN_property.filenames.inDeeds, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor);
replace_deeds_dist    := distribute(temp_deeds, hash(ln_fares_id));
//replace_deeds_sort    := sort(replace_deeds_dist, ln_fares_id, local);

//get the good records from assessor replace file
LN_Property.Layout_Deed_Mortgage_Property_Search tjoinassessor(concat_search_dist L, replace_assessor_dist R) := transform
  self := L;
end;

search_assessor_joined := join(concat_search_dist, replace_assessor_dist, left.ln_fares_id = right.ln_fares_id, tjoinassessor(left, right), local);

//get the good records from deed replace file
LN_Property.Layout_Deed_Mortgage_Property_Search tjoindeeds(concat_search_dist L, replace_deeds_dist R) := transform
  self := L;
end;

search_deeds_joined := join(concat_search_dist, replace_deeds_dist, left.ln_fares_id = right.ln_fares_id, tjoindeeds(left, right), local);

//concatenate search replace file
concat_search_replace := search_assessor_joined + search_deeds_joined;

// canUseSearchRepl := if(FileServices.GetSuperFileSubCount(ln_property.filenames.inSearchRepl) > 0 and
                       // FileServices.GetSuperFileSubCount(ln_property.filenames.inDeedsRepl) > 0, 
											 // true, false);
											 											 

irs_ln_fares_ids := ['ODx014318179',
                     'OAx098980660',
                     'OAw098980660',
                     'OAv098980660',
                     'OAu098980660'
					];


export Replace_Search := concat_search_replace(ln_fares_id not in irs_ln_fares_ids);
